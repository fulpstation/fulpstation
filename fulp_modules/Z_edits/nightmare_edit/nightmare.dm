/// Set a timer of 5 seconds to ensure everything is set up by the time we check
/datum/species/shadow/nightmare/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	addtimer(CALLBACK(C, .proc/check_advancedtooluser), 10 SECONDS)
	. = ..()

/// Check if they're a real Nightmare, and if so, remove advancedtooluser from them
/datum/species/shadow/nightmare/proc/check_advancedtooluser(mob/living/carbon/human/H)
	if((TRAIT_ADVANCEDTOOLUSER in inherent_traits) && H.mind.has_antag_datum(/datum/antagonist/nightmare))
		REMOVE_TRAIT(H, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
		ADD_TRAIT(H, TRAIT_PRIMITIVE, SPECIES_TRAIT)
