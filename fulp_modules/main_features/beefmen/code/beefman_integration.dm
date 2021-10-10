		//  ATOMS  //

/atom
	var/use_without_hands = FALSE // Now you can use something regardless of having a hand. EX: Beefman Phobetor Tears

/// We're making Beefmen load their accessories
/world/proc/make_fulp_datum_references_lists()
	init_sprite_accessory_subtypes(/datum/sprite_accessory/beef/eyes, GLOB.eyes_beefman)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/beef/mouth, GLOB.mouths_beefman)

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
