/// Midround nightmare spawns are stupid.
/datum/species/shadow/nightmare/spec_life(mob/living/carbon/human/H)
	. = ..()
	if((TRAIT_ADVANCEDTOOLUSER in inherent_traits) && !H.mind.has_antag_datum(/datum/antagonist/nightmare))
		REMOVE_TRAIT(H, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
