/**
 * # If you're looking to improve this:
 *
 * Request a change at the upstream to change
 * /proc/make_datum_references_lists()
 * to
 * /world/proc/make_datum_references_lists()
 *
 * This one line change will allow us to use that proc directly, rather than make our own off of /world/New()
 */

/// We're making Beefmen load their accessories
/world/proc/make_fulp_datum_references_lists()
	init_sprite_accessory_subtypes(/datum/sprite_accessory/beef/eyes, GLOB.eyes_beefman)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/beef/mouth, GLOB.mouths_beefman)

/**
 * Adds our species' prefs to consistent dummies for unit tests
 */
/mob/living/carbon/human/dummy/consistent/setup_human_dna()
	. = ..()
	add_fulp_dna(src)

/mob/living/carbon/human/consistent/setup_human_dna()
	. = ..()
	add_fulp_dna(src)

/proc/add_fulp_dna(mob/living/carbon/human/target)
	target.dna.features["beef_color"] = "#e73f4e"
	target.dna.features["beef_eyes"] = BEEF_EYES_OLIVES
	target.dna.features["beef_mouth"] = BEEF_MOUTH_SMILE

