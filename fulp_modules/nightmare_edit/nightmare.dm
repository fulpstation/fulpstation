/// Midround nightmare spawns are stupid.
/datum/species/shadow/nightmare/spec_life(mob/living/carbon/human/H)
	if(!H.mind.has_antag_datum(/datum/antagonist/nightmare))
		return /// Only midround nightmares.
	if(TRAIT_ADVANCEDTOOLUSER in inherent_traits)
		REMOVE_TRAIT(H, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
	. = ..()
