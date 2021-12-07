// SPRITE PARTS //
/datum/sprite_accessory/beef
	icon = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'

// Eyes //
//Currently only used by mutantparts so don't worry about hair and stuff.
//This is the source that this accessory will get its color from. Default is MUTCOLOR, but can also be HAIR, FACEHAIR, EYECOLOR and 0 if none.
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

// Mouth //

/datum/sprite_accessory/beef/mouth
	use_static = TRUE
	color_src = 0

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
