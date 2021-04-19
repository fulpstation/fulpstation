/// Midround nightmare spawns are stupid.
/datum/antagonist/nightmare/on_gain()
	. = ..()
	REMOVE_TRAIT(owner.current, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
