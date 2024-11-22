#define MARTIALART_MIKE_BOXING "mike_boxing"
#define MIKE_BOXING_TRAIT "mike_boxing"
#define EAR_STRIKE "ear_strike"


// Actual item, the boxing gloves
/obj/item/clothintg/gloves/boxing/evil/mike
	name = "Champion's boxing gloves"
	desc = "The top choice for brawlers across the sector. Their interior is lined with neuronal clamps and shunts,\
			designed to boost the wearer's strength and grant them extensive boxing knowledge. Made of real leather!"
	greyscale_colors = "#a6171e"
	style_to_give = /datum/martial_art/boxing/evil/mike

/obj/item/clothing/gloves/boxing/evil/mike/examine_more(mob/user)
	. = ..()
	. += span_notice("The tag does say it's leather, but it also says they genuinely belonged to an \
					  earth boxer from two centuries ago, so it's probably just neoprene.")

/obj/item/clothing/gloves/boxing/evil/mike/Initialize(mapload)
	. = ..()

	RegisterSignal(src, COMSIG_ITEM_POST_EQUIPPED, PROC_REF(add_effects))
	ADD_TRAIT(src, TRAIT_NODROP, MIKE_BOXING_TRAIT)

/obj/item/clothing/gloves/boxing/evil/mike/proc/add_effects(obj/item/source, mob/living/user, slot)
	SIGNAL_HANDLER

	if(slot & ITEM_SLOT_GLOVES)
		to_chat(user, span_warning("Knowledge about the art of boxing surges through your mind!"))
		user.mind?.set_level(/datum/skill/athletics, SKILL_LEVEL_LEGENDARY)


// The martial art granted to us by the gloves
/datum/martial_art/boxing/evil/mike
	name = "Mike Boxing"
	id = MARTIALART_MIKE_BOXING
	VAR_PRIVATE/datum/action/ear_strike/earstrike

/datum/martial_art/boxing/evil/mike/New()
	. = ..()
	earstrike = new(src)

/datum/martial_art/boxing/evil/mike/Destroy()
	earstrike = null
	return ..()

/datum/martial_art/boxing/evil/mike/on_teach(mob/living/new_holder)
	. = ..()
	to_chat(new_holder, span_userdanger("You're ready to crack some heads!"))
	earstrike.Grant(new_holder)

/datum/martial_art/boxing/evil/mike/harm_act(mob/living/attacker, mob/living/defender)
	if(streak == EAR_STRIKE)
		streak = ""
		ear_strike(attacker, defender)
		return MARTIAL_ATTACK_SUCCESS
	..()

// The Attack
/datum/martial_art/boxing/evil/mike/proc/ear_strike(mob/living/attacker, mob/living/defender)
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
