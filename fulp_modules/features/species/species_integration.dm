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
 * SPECIES OVERWRITE
 *
 * We add our own vars to Species for certain things, so it's done here.
 */

/datum/species
	var/bruising_desc = "bruising"
	var/burns_desc = "burns"
	var/cellulardamage_desc = "cellular damage"


/**
 * CARBON INTEGRATION
 *
 * All overrides of mob/living and mob/living/carbon
 */

// PROSTHETICS //
/mob/living/proc/getBruteLoss_nonProsthetic()
	return getBruteLoss()

/mob/living/proc/getFireLoss_nonProsthetic()
	return getFireLoss()

/mob/living/carbon/getBruteLoss_nonProsthetic()
	var/amount = 0
	for(var/obj/item/bodypart/chosen_bodypart in bodyparts)
		if(chosen_bodypart.status < BODYPART_ROBOTIC)
			amount += chosen_bodypart.brute_dam
	return amount

/mob/living/carbon/getFireLoss_nonProsthetic()
	var/amount = 0
	for(var/obj/item/bodypart/chosen_bodypart in bodyparts)
		if(chosen_bodypart.status < BODYPART_ROBOTIC)
			amount += chosen_bodypart.burn_dam
	return amount
