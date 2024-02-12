/datum/reagent/toxin/aconitine
	name = "Aconitine"
	description = "Also known as wolfsbane or monkshood, aconitine is a strong toxin derived from the Wolf's bane plant."
	taste_description = "foul bitterness"
	taste_mult = 3
	toxpwr = 2.5
	mass = 646
	ph = 13
	reagent_state = SOLID
	var/datum/antagonist/werewolf/werewolf_datum

/datum/reagent/toxin/aconitine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	// This chem is purged by atropine
	if(holder.has_reagent(/datum/reagent/medicine/atropine))
		holder.remove_reagent(/datum/reagent/toxin/aconitine, REM * seconds_per_tick)

	// Has special interactions with werewolves
	if(IS_WEREWOLF_ANTAG(affected_mob))
		if(istype(affected_mob, /mob/living/carbon/werewolf))
			if(current_cycle == 5)
				to_chat(affected_mob, span_danger("Your body feels like it's about to collapse in on itself!"))
				affected_mob.set_jitter_if_lower(5 SECONDS)
			if(current_cycle >= 10)
				to_chat(affected_mob, span_bolddanger("Something has forcefully reverted your transformation!"))
				werewolf_datum.revert_transformation()

	return ..()

/datum/reagent/toxin/aconitine/on_mob_metabolize(mob/living/target)
	ADD_TRAIT(target, TRAIT_WOLFSBANE_AFFLICTED, WEREWOLF_TRAIT)
	if(IS_WEREWOLF_ANTAG(target))
		for(var/datum/antagonist/werewolf/antag in target.mind.antag_datums)
			werewolf_datum = antag
		to_chat(target, span_warning("Something inside you feels very wrong..."))
	return ..()

/datum/reagent/toxin/aconitine/on_mob_end_metabolize(mob/living/target)
	REMOVE_TRAIT(target, TRAIT_WOLFSBANE_AFFLICTED, WEREWOLF_TRAIT)
	return ..()

