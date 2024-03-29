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
	init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/protogen, GLOB.tails_list_protogen)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/protogen/antennae, GLOB.antennae_list_protogen, add_blank = TRUE)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/protogen/snout, GLOB.snouts_list_protogen)

/**
 * CARBON INTEGRATION
 *
 * All overrides of mob/living and mob/living/carbon
 */
/// Brute
/mob/living/proc/getBruteLoss_nonProsthetic()
	return getBruteLoss()

/mob/living/carbon/getBruteLoss_nonProsthetic()
	var/amount = 0
	for(var/obj/item/bodypart/chosen_bodypart as anything in bodyparts)
		if(!IS_ORGANIC_LIMB(chosen_bodypart))
			continue
		amount += chosen_bodypart.brute_dam
	return amount

/// Burn
/mob/living/proc/getFireLoss_nonProsthetic()
	return getFireLoss()

/mob/living/carbon/getFireLoss_nonProsthetic()
	var/amount = 0
	for(var/obj/item/bodypart/chosen_bodypart as anything in bodyparts)
		if(!IS_ORGANIC_LIMB(chosen_bodypart))
			continue
		amount += chosen_bodypart.burn_dam
	return amount

/**
 * Adds our species' prefs to consistent dummies for unit tests
 */
/mob/living/carbon/human/dummy/consistent/setup_human_dna()
	. = ..()
	dna.features["beef_color"] = "#e73f4e"
	dna.features["beef_eyes"] = BEEF_EYES_OLIVES
	dna.features["beef_mouth"] = BEEF_MOUTH_SMILE
	dna.features["tail_protogen"] = "Synthliz"
	dna.features["snout_protogen"] = "Regular"
	dna.features["antennae_protogen"] = "Default"
