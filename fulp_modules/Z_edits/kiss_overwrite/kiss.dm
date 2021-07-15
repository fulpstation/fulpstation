/*
 *	# Kiss Emote overwrite
 *
 *	This is removing the ability to use the *kiss command.
 *	--This also removes Kiss of Death--
 */

/datum/emote/living/kiss/run_emote(mob/living/user, params, type_override, intentional)
	return

/datum/species/human/felinid/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	if(is_banned_from(C.ckey, RACE_FELINID))
		C.set_species(/datum/species/human)
