/datum/species/ethereal/spec_life(mob/living/carbon/human/H)
	if(is_banned_from(H.ckey, RACE_ETHEREAL))
		if(prob(50))
			H.set_species(/datum/species/beefman)
		else
			H.set_species(/datum/species/human)
	. = ..()

/datum/species/human/felinid/spec_life(mob/living/carbon/human/H)
	if(is_banned_from(H.ckey, RACE_FELINID))
		if(prob(50))
			H.set_species(/datum/species/beefman)
		else
			H.set_species(/datum/species/human)
	. = ..()
