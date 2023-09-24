/obj/item/melee/touch_attack/werewolf_bite
	name = "\improper Werewolf bite"
	desc = "Deals significant damage. Use it on a corpse to consume it."
	var/old_effect = NONE

/datum/action/cooldown/spell/touch/werewolf_bite
	name = "Bite"
	desc = "Bite the target"
	check_flags = AB_CHECK_HANDS_BLOCKED | AB_CHECK_CONSCIOUS
	spell_requirements = NONE
	invocation = ""
	hand_path = /obj/item/melee/touch_attack/werewolf_bite
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	var/datum/antagonist/werewolf/werewolf_datum

/datum/action/cooldown/spell/touch/werewolf_bite/New(antag_datum)
	werewolf_datum = antag_datum
	return ..()

/datum/action/cooldown/spell/touch/werewolf_bite/is_valid_target(atom/cast_on)
	. = ..()
	var/mob/living/target = cast_on
	return ismob(target)


/datum/action/cooldown/spell/touch/werewolf_bite/cast_on_hand_hit(obj/item/melee/touch_attack/hand, atom/victim, mob/living/carbon/caster)
	caster.do_attack_animation(target, ATTACK_EFFECT_BITE)
	if(isliving(victim))
		var/mob/living/target = victim
		target.apply_damage( \
			WP_BITE_DAMAGE, \
			damagetype = BRUTE, \
			def_zone = caster.zone_selected, \
			wound_bonus = WP_BITE_WOUND_BONUS, \
			bare_wound_bonus = WP_BITE_BARE_WOUND_BONUS, \
			blocked = target.run_armor_check(caster.zone_selected), \
			sharpness = SHARP_POINTY \
		)

		if(target in werewolf_datum.consumed_mobs)
			to_chat(caster, span_warning("There's nothing left in this body for you to consume!"))
			return TRUE

		if(target.stat == DEAD)
			if(iscarbon(target))
				var/mob/living/carbon/carbon_target = target
				qdel(target.get_organ_slot(ORGAN_SLOT_LUNGS))
				qdel(target.get_organ_slot(ORGAN_SLOT_HEART))
				qdel(target.get_organ_slot(ORGAN_SLOT_LIVER))
				caster.visible_message( \
					span_danger("[caster] devours [carbon_target]!"), \
					span_danger("You devour [carbon_target]!"), \
				)

				var/new_points = 2
				if(get_area(caster) == werewolf_datum.werewolf_den_area)
					to_chat(caster, span_notice("Meals are so much more enjoyable in the saftey of your den!"))
					new_points += 1

				if(!target.ckey)
					to_chat(caster, span_notice("[target] would've tasted better if they had a soul..."))
					new_points -= 1

				if(IS_BLOODSUCKER(target))
					to_chat(caster, span_notice("[target]'s vampiric blood tastes delicious!"))
					new_points += 1
					werewolf_datum.werewolf_hunger -= 1

				to_chat(caster, span_bold("Gained [new_points] point[new_points > 1 ? "s" : ""]"))
				werewolf_datum.werewolf_hunger -= new_points
				if(werewolf_datum.werewolf_hunger < 0)
					werewolf_datum.werewolf_hunger = 0

				werewolf_datum.consumed_mobs += target
				RegisterSignal(target, COMSIG_LIVING_LIFE, PROC_REF(unregister_consumed_mob))

	return TRUE

/datum/action/cooldown/spell/touch/werewolf_bite/proc/unregister_consumed_mob(mob/target, deltatime, times_fired)
	SIGNAL_HANDLER
	if(target.stat <= UNCONSCIOUS)
		werewolf_datum.consumed_mobs -= target
		UnregisterSignal(target, COMSIG_LIVING_LIFE)

/datum/action/cooldown/spell/touch/werewolf_bite/Destroy()
	for(var/mob/target in werewolf_datum.consumed_mobs)
		werewolf_datum.consumed_mobs -= target
		UnregisterSignal(target, COMSIG_LIVING_LIFE)

	return ..()
