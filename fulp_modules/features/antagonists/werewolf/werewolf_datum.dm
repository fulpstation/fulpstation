/datum/antagonist/werewolf
	name = "\improper Werewolf"
	show_in_antagpanel = TRUE
	roundend_category = "werewolves"
	antagpanel_category = "Werewolf"
	job_rank = ROLE_WEREWOLF
	antag_hud_name = "werewolf"
	show_name_in_check_antagonists = TRUE
	ui_name = "AntagInfoWerewolf"
	// Doesn't look like this is actually used anywhere but you never know
	can_coexist_with_others = FALSE
	tip_theme = "spookyconsole"
	antag_tips = list(
		"You're a werewolf, nuff said.",
		"This will be replaced with actual real tips later on."
	)

	/// Score, gained by eating bodies. Does not decrease
	var/score = 0
	/// Points, gained primarily by eating bodies. Can be used on powers
	var/points = 0
	/// Whether or not we're transformed
	var/transformed = FALSE

	/// All the powers we have available always
	var/list/datum/action/cooldown/spell/powers = list()
	/// All the powers we have available when transformed
	var/list/datum/action/cooldown/spell/transformed_powers = list()
	/// Traits the werewolf has while transformed
	var/list/transformed_traits = list(
		TRAIT_WEREWOLF_TRANSFORMED,
		TRAIT_BATON_RESISTANCE,
		TRAIT_ILLITERATE,
		TRAIT_CHUNKYFINGERS,
		TRAIT_DISCOORDINATED_TOOL_USER,
		TRAIT_FEARLESS,
		TRAIT_SLEEPIMMUNE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_PUSHIMMUNE,
		TRAIT_NODISMEMBER,
		TRAIT_NO_ZOMBIFY,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_SLIP_WATER,
		TRAIT_GOOD_HEARING,
		TRAIT_NOFLASH,
		TRAIT_DISFIGURED,
		TRAIT_SNOWSTORM_IMMUNE,
		TRAIT_GIANT,
		TRAIT_STUNIMMUNE,
		TRAIT_PIERCEIMMUNE,
		TRAIT_STRONG_SNIFFER
	)
	/// Werewolf's transform spell, kept seperate from their other powers
	var/datum/action/cooldown/spell/shapeshift/werewolf_transform/transform_spell
	/// Tackler component for the transformed werewolf
	var/datum/component/tackler/werewolf/werewolf_tackler
	/// List of mobs consumed by the werewolf's bite spell. Mobs are removed after they are revived
	var/list/consumed_mobs = list()
	/// Werewolf's den
	var/area/werewolf_den_area
	var/obj/effect/decal/werewolf_mark/den_mark
	/// Increases after reverting, decreased by consuming corpses. Affects severity of post-transform effects
	var/werewolf_hunger = 0
	var/atom/movable/screen/werewolf/bite_button/bite_display

/datum/antagonist/werewolf/on_gain()
	. = ..()
	var/datum/hud/werewolf_hud = owner.current.hud_used
	bite_display = new /atom/movable/screen/werewolf/bite_button(null, werewolf_hud)
	werewolf_hud.infodisplay += bite_display
	ADD_TRAIT(owner.current, TRAIT_STRONG_SNIFFER, WEREWOLF_TRAIT)

	RegisterSignal(SSsunlight, COMSIG_LUN_WARNING, PROC_REF(handle_lun_warnings))
	RegisterSignal(SSsunlight, COMSIG_LUN_START, PROC_REF(handle_lun_start))
	RegisterSignal(SSsunlight, COMSIG_LUN_END, PROC_REF(handle_lun_end))
	RegisterSignal(owner.current, COMSIG_WEREWOLF_TRANSFORM_CAST, PROC_REF(handle_transform_cast))
	RegisterSignal(owner.current, COMSIG_ATOM_EXAMINE, PROC_REF(pre_transform_examine))

	transform_spell = new /datum/action/cooldown/spell/shapeshift/werewolf_transform(src)
	transform_spell.Grant(owner.current)

	learn_transformed_power(new /datum/action/cooldown/spell/touch/werewolf_bite(src))
	learn_transformed_power(new /datum/action/cooldown/spell/werewolf_freedom)
	learn_transformed_power(new /datum/action/cooldown/spell/werewolf_claws)
	learn_transformed_power(new /datum/action/cooldown/spell/werewolf_mark(src))
	learn_transformed_power(new /datum/action/cooldown/spell/werewolf_rush)

	werewolf_hud.show_hud(werewolf_hud.hud_version)

	check_start_sol()

/datum/antagonist/werewolf/on_removal()
	var/datum/hud/werewolf_hud = owner.current.hud_used
	werewolf_hud.infodisplay -= bite_display
	werewolf_hud.show_hud(werewolf_hud.hud_version)
	revert_transformation()
	remove_powers()
	check_cancel_sol()
	REMOVE_TRAIT(owner.current, TRAIT_STRONG_SNIFFER, WEREWOLF_TRAIT)

	transform_spell.Remove(owner.current)
	qdel(transform_spell)

	REMOVE_TRAIT(owner.current, TRAIT_STRONG_SNIFFER, WEREWOLF_TRAIT)

	UnregisterSignal(SSsunlight, COMSIG_LUN_WARNING)
	UnregisterSignal(SSsunlight, COMSIG_LUN_START)
	UnregisterSignal(SSsunlight, COMSIG_LUN_END)
	UnregisterSignal(owner.current, COMSIG_ATOM_EXAMINE)

	UnregisterSignal(owner.current, COMSIG_WEREWOLF_TRANSFORM_CAST)

	return ..()


/datum/antagonist/werewolf/proc/learn_power(datum/action/cooldown/spell/power)
	powers += power
	power.Grant(owner.current)


/datum/antagonist/werewolf/proc/unlearn_power(datum/action/cooldown/spell/power)
	powers -= power
	power.Remove(owner.current)


/datum/antagonist/werewolf/proc/learn_transformed_power(datum/action/cooldown/spell/power)
	transformed_powers += power
	if(transformed)
		power.Grant(owner.current)


/datum/antagonist/werewolf/proc/unlearn_transformed_power(datum/action/cooldown/spell/power)
	transformed_powers -= power
	power.Remove(owner.current)


/datum/antagonist/werewolf/proc/remove_powers()
	for(var/datum/action/cooldown/spell/power as anything in powers)
		unlearn_power(power)
	for(var/datum/action/cooldown/spell/power as anything in transformed_powers)
		unlearn_transformed_power(power)


/datum/antagonist/werewolf/proc/handle_transform_cast(atom/owner)
	SIGNAL_HANDLER
	toggle_transformation()


/datum/antagonist/werewolf/proc/apply_transformation()
	if(!owner?.current)
		return FALSE

	if(transformed)
		return TRUE

	// Don't try to transform if we're already shapeshifted
	if(owner.current.has_status_effect(/datum/status_effect/shapechange_mob))
		return FALSE

	transform_spell.cast(owner.current)
	return TRUE


/datum/antagonist/werewolf/proc/revert_transformation()
	if(!owner?.current)
		return FALSE

	if(!transformed)
		return TRUE

	// Don't try to revert if we're not shapeshifted
	if(!owner.current.has_status_effect(/datum/status_effect/shapechange_mob/from_spell))
		return FALSE

	transform_spell.cast(owner.current)
	return TRUE


/datum/antagonist/werewolf/proc/toggle_transformation()
	if(!owner?.current)
		return FALSE
	if(transformed)
		revert_transformation()
	else
		apply_transformation()
	return TRUE


/datum/antagonist/werewolf/proc/pre_transform_examine(mob/living/carbon/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	var/obj/item/potential_cloth = source.get_item_by_slot(ITEM_SLOT_OCLOTHING)
	if(potential_cloth?.body_parts_covered & CHEST)
		return

	potential_cloth = source.get_item_by_slot(ITEM_SLOT_ICLOTHING)
	if(potential_cloth?.body_parts_covered & CHEST)
		return

	examine_list += span_boldwarning("Strange fur is growing rapidly on [source.p_their()] body!")


/datum/antagonist/werewolf/proc/post_transform_effects(severity)
	var/mob/living/carbon/target = owner.current
	var/duration = WEREWOLF_SICKNESS_BASE_TIME + rand(0, severity*WEREWOLF_SICKNESS_SEVERITY_MULT SECONDS)
	var/message = span_notice("Luckily, transformation only took a minimal toll on your body")

	if(severity >= 1)
		target.set_eye_blur_if_lower(duration)
	if(severity >= 2)
		target.set_dizzy_if_lower(duration)
	if(severity >= 4)
		target.set_confusion_if_lower(duration)
	if(severity >= 5)
		target.vomit()
		message = span_warning("The transformation had a noticable toll on your body, and has left you feeling unwell")
	if(severity >= 10)
		target.adjust_timed_status_effect(10 SECONDS, /datum/status_effect/incapacitating/unconscious)
		message = span_boldwarning("The transformation had a significant toll on your body, and the pain is too much to bear!")

	to_chat(target, message)
	return duration
