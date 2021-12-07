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

/proc/proof_beefman_features(list/inFeatures)
	// Missing Defaults in DNA? Randomize!
	if(inFeatures["beefcolor"] == null || inFeatures["beefcolor"] == "")
		inFeatures["beefcolor"] = GLOB.color_list_beefman[pick(GLOB.color_list_beefman)]
	if(inFeatures["beefeyes"] == null || inFeatures["beefeyes"] == "")
		inFeatures["beefeyes"] = pick(GLOB.eyes_beefman)
	if(inFeatures["beefmouth"] == null || inFeatures["beefmouth"] == "")
		inFeatures["beefmouth"] = pick(GLOB.mouths_beefman)

/**
 * CARBON INTEGRATION
 *
 * All overrides of mob/living and mob/living/carbon
 */

/mob/living/carbon
	// Type References for Bodyparts
	var/obj/item/bodypart/head/part_default_head = /obj/item/bodypart/head
	var/obj/item/bodypart/chest/part_default_chest = /obj/item/bodypart/chest
	var/obj/item/bodypart/l_arm/part_default_l_arm = /obj/item/bodypart/l_arm
	var/obj/item/bodypart/r_arm/part_default_r_arm = /obj/item/bodypart/r_arm
	var/obj/item/bodypart/l_leg/part_default_l_leg = /obj/item/bodypart/l_leg
	var/obj/item/bodypart/r_leg/part_default_r_leg = /obj/item/bodypart/r_leg

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

/**
 * SPECIES OVERWRITE
 *
 * We add our own vars to Species for certain things, so it's done here.
 */

/datum/species
	var/bruising_desc = "bruising"
	var/burns_desc = "burns"
	var/cellulardamage_desc = "cellular damage"
