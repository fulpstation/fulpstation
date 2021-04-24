/datum/species/shadow/nightmare/spec_life(mob/living/carbon/human/H)
	. = ..()
	if(TRAIT_ADVANCEDTOOLUSER in inherent_traits)
		REMOVE_TRAIT(H, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
