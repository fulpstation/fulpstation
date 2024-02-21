/datum/action/cooldown/spell/shapeshift/werewolf_transform
	name = "Transform"
	desc = "Transform into werewolf form"
	button_icon_state = "power_human"
	spell_requirements = NONE
	shapeshift_type = /mob/living/carbon/human/werewolf
	possible_shapes = list(/mob/living/carbon/human/werewolf)
	var/show_to_player = TRUE
	var/datum/antagonist/werewolf/werewolf_datum
	cooldown_time = 2 SECONDS


/datum/action/cooldown/spell/shapeshift/werewolf_transform/New(datum/antagonist/werewolf/antag_datum)
	werewolf_datum = antag_datum
	return ..()


/datum/action/cooldown/spell/shapeshift/werewolf_transform/proc/enable_button()
	show_to_player = TRUE
	ShowTo(owner)


/datum/action/cooldown/spell/shapeshift/werewolf_transform/proc/disable_button()
	show_to_player = FALSE
	HideFrom(owner)


/datum/action/cooldown/spell/shapeshift/werewolf_transform/ShowTo(mob/viewer)
	if(!show_to_player)
		return
	return ..()

/datum/action/cooldown/spell/shapeshift/werewolf_transform/cast(mob/living/caster)
	if(!werewolf_datum.transformed && HAS_TRAIT(caster, TRAIT_WOLFSBANE_AFFLICTED))
		to_chat(caster, span_bolddanger("Something inside you has halted your transformation!"))
		return
	return ..()

/datum/action/cooldown/spell/shapeshift/werewolf_transform/do_shapeshift(mob/living/carbon/caster)
	if(caster.handcuffed || caster.legcuffed)
		caster.uncuff()
		caster.visible_message( \
			span_danger("[caster] breaks free of their restraints as they transform!"), \
			span_danger("You break free of your restraints as you transform"), \
		)

	var/mob/living/shifted_mob = ..()
	werewolf_datum.werewolf_tackler = shifted_mob.AddComponent( \
		/datum/component/tackler/werewolf, \
		stamina_cost = WP_TACKLE_STAM_COST, \
		base_knockdown = WP_TACKLE_BASE_KNOCKDOWN, \
		range = WP_TACKLE_RANGE, \
		speed = WP_TACKLE_SPEED, \
		skill_mod = WP_TACKLE_SKILL_MOD, \
		min_distance = WP_TACKLE_MIN_DIST \
	)
	shifted_mob.add_movespeed_modifier(/datum/movespeed_modifier/werewolf_base)
	shifted_mob.add_traits(werewolf_datum.transformed_traits, WEREWOLF_TRAIT)
	shifted_mob.set_species(/datum/species/werewolf)

	for(var/datum/action/cooldown/spell/power as anything in werewolf_datum.transformed_powers)
		power.Grant(shifted_mob)

	werewolf_datum.transformed = TRUE
	SEND_SIGNAL(shifted_mob, WEREWOLF_TRANSFORMED)
	return shifted_mob

/datum/action/cooldown/spell/shapeshift/werewolf_transform/do_unshapeshift(mob/living/carbon/human/werewolf/caster)
	if(caster.handcuffed || caster.legcuffed)
		caster.uncuff()
		caster.visible_message( \
			span_notice("[caster] breaks free of their restraints as they transform!"), \
			span_notice("You break free of your restraints as you transform"), \
		)

	qdel(werewolf_datum.werewolf_tackler)

	for(var/datum/action/cooldown/spell/power as anything in werewolf_datum.transformed_powers)
		power.Remove(werewolf_datum.owner.current)

	caster.remove_movespeed_modifier(/datum/movespeed_modifier/werewolf_base)
	werewolf_datum.transformed = FALSE
	werewolf_datum.werewolf_hunger += WEREWOLF_HUNGER_PER_TRANSFORM

	. = ..()

	var/severity = 1 + werewolf_datum.werewolf_hunger
	if(get_area(werewolf_datum.owner.current) == werewolf_datum.werewolf_den_area)
		severity += WEREWOLF_SICKNESS_DEN_MODIFIER
		to_chat(werewolf_datum.owner.current, span_notice("Reverting while inside your den lessens the toll on your body..."))

	werewolf_datum.post_transform_effects(severity)
	SEND_SIGNAL(werewolf_datum.owner.current, WEREWOLF_REVERTED)
	return .
