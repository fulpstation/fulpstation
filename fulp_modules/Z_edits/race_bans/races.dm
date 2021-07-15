/datum/species/human/felinid/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	if(is_banned_from(C.ckey, RACE_FELINID))
		if(prob(50))
			C.set_species(/datum/species/beefman)
		else
			C.set_species(/datum/species/human)

/datum/species/ethereal/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	if(is_banned_from(C.ckey, RACE_ETHEREAL))
		if(prob(50))
			C.set_species(/datum/species/beefman)
		else
			C.set_species(/datum/species/human)
