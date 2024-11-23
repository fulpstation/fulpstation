#define MARTIALART_MIKE_BOXING "mike_boxing"
#define EAR_STRIKE "ear_strike"

// The martial art granted to us by the gloves
/datum/martial_art/boxing/mike
	name = "Mike Boxing"
	id = MARTIALART_MIKE_BOXING
	honorable_boxer = FALSE
	VAR_PRIVATE/datum/action/ear_strike/earstrike

/datum/martial_art/boxing/mike/New()
	. = ..()
	earstrike = new(src)

/datum/martial_art/boxing/mike/Destroy()
	earstrike = null
	return ..()

/datum/martial_art/boxing/mike/on_teach(mob/living/new_holder)
	. = ..()
	to_chat(new_holder, span_userdanger("You're ready to crack some heads!"))
	earstrike.Grant(new_holder)

/datum/martial_art/boxing/mike/harm_act(mob/living/attacker, mob/living/defender)
	if(streak == EAR_STRIKE)
		streak = ""
		ear_strike(attacker, defender)
		return MARTIAL_ATTACK_SUCCESS
	..()

/datum/martial_art/boxing/mike/crit_effect(mob/living/attacker, mob/living/defender, armor_block, damage_type, damage)
	for (var/obj/item/implant in defender.implants)
		if(istype(implant, /obj/item/implant/sad_trombone/knockout_bell))
			return ..()

	var/obj/item/implant/sad_trombone/knockout_bell/knockout = new
	if(knockout.can_be_implanted_in(defender))
		knockout.implant(defender, silent = TRUE)
	else
		qdel(knockout)

	return ..()


// The Attack
/datum/martial_art/boxing/mike/proc/ear_strike(mob/living/attacker, mob/living/defender)
	if(HAS_TRAIT(attacker, TRAIT_PACIFISM))
		return MARTIAL_ATTACK_INVALID

	var/obj/item/organ/internal/ears/ears = defender.get_organ_slot(ORGAN_SLOT_EARS)
	if(!ears)
		to_chat(attacker, span_warning("They have no ears to strike!"))
		return MARTIAL_ATTACK_INVALID
	defender.visible_message(
		span_warning("[attacker] jabs at [defender]'s ears and rips them out!"),
		span_userdanger("Your ears are punched off by [attacker]!"),
		span_hear("You hear the sickening sound of cartilage ripping apart!"),
		null,
		attacker,
	)
	to_chat(attacker, span_danger("You rip [defender]'s ears off!"))
	playsound(attacker, 'sound/effects/wounds/blood3.ogg', 50, TRUE, -1)

	defender.apply_damage(5, BRUTE, BODY_ZONE_HEAD)

	ears.Remove(defender)
	ears.forceMove(get_turf(defender))
	var/turf/destination = get_ranged_target_turf(attacker, attacker.dir, 2)
	ears.throw_at(destination, 2, 2, attacker, spin = TRUE)

	var/datum/wound/pierce/bleed/severe/ripped_ear = new
	ripped_ear.apply_wound(defender.get_bodypart(BODY_ZONE_HEAD), wound_source = "ear strike")

	log_combat(attacker, defender, "ear struck")
	return MARTIAL_ATTACK_SUCCESS

/datum/action/ear_strike
	name = "Deafening strike - Aim for the ears, and rip them clean off."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "berserk_mode"
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS

/datum/action/ear_strike/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	if (owner.mind.martial_art.streak == EAR_STRIKE)
		owner.visible_message(span_danger("[owner]'s posture relaxes."), "<b><i>Your next attack is cleared.</i></b>")
		owner.mind.martial_art.streak = ""
	else
		owner.visible_message(span_danger("[owner] stiffens up suddenly!"), "<b><i>Your next attack will be a Deafening Strike.</i></b>")
		owner.mind.martial_art.streak = EAR_STRIKE

#undef EAR_STRIKE
