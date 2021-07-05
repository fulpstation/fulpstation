/datum/sprite_accessory/beef
	icon = 'fulp_modules/main_features/species/beefman/icons/mob/beefman_bodyparts.dmi'

	// please make sure they're sorted alphabetically and, where needed, categorized
	// try to capitalize the names please~
	// try to spell
	// you do not need to define _s or _l sub-states, game automatically does this for you

///Currently only used by mutantparts so don't worry about hair and stuff. This is the source that this accessory will get its color from. Default is MUTCOLOR, but can also be HAIR, FACEHAIR, EYECOLOR and 0 if none.

// Eyes

/datum/sprite_accessory/beef/eyes
	color_src = EYECOLOR

/datum/sprite_accessory/beef/eyes/capers
	name = "Capers"
	icon_state = "capers"

/datum/sprite_accessory/beef/eyes/cloves
	name = "Cloves"
	icon_state = "cloves"

/datum/sprite_accessory/beef/eyes/peppercorns
	name = "Peppercorns"
	icon_state = "peppercorns"

/datum/sprite_accessory/beef/eyes/olives
	name = "Olives"
	icon_state = "olives"

// Mouth

/datum/sprite_accessory/beef/mouth
	use_static = TRUE
	color_src = FALSE

/datum/sprite_accessory/beef/mouth/frown1
	name = "Frown1"
	icon_state = "frown1"

/datum/sprite_accessory/beef/mouth/frown2
	name = "Frown2"
	icon_state = "frown2"

/datum/sprite_accessory/beef/mouth/grit1
	name = "Grit1"
	icon_state = "grit1"

/datum/sprite_accessory/beef/mouth/grit2
	name = "Grit2"
	icon_state = "grit2"

/datum/sprite_accessory/beef/mouth/smile1
	name = "Smile1"
	icon_state = "smile1"

/datum/sprite_accessory/beef/mouth/smile2
	name = "Smile2"
	icon_state = "smile2"
