/mob/living/carbon/human/become_husk(source)
	if(!HAS_TRAIT(src, TRAIT_NO_HUSK))
		. = ..()

/datum/species/proc/spec_revival(mob/living/carbon/human/H)
	return

/mob/living/carbon/human/revive(full_heal = 0, admin_revive = 0)
	if(..())
		if(dna && dna.species)
			dna.species.spec_revival(src)
