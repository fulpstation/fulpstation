//Organ
/obj/item/organ/snout/protogen
	name = "protogen snout"
	desc = "Take a closer look at that snout!"
	icon_state = "snout"

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_SNOUT

	preference = "feature_protogen_snout"
	external_bodyshapes = BODYSHAPE_SNOUTED

	dna_block = DNA_SNOUT_BLOCK
	restyle_flags = EXTERNAL_RESTYLE_FLESH

	bodypart_overlay = /datum/bodypart_overlay/mutant/snout/protogen

//Overlay
/datum/bodypart_overlay/mutant/snout/protogen
	feature_key = "snout_protogen"

/datum/bodypart_overlay/mutant/snout/protogen/get_global_feature_list()
	return SSaccessories.snouts_list_protogen

//Sprites
/datum/sprite_accessory/protogen

/datum/sprite_accessory/protogen/snout
	icon = 'fulp_modules/icons/species/mob/protogen_snouts.dmi'
	em_block = TRUE

/datum/sprite_accessory/protogen/snout/regular
	name = "Regular"
	icon_state = "regular"

/datum/sprite_accessory/protogen/snout/bolted
	name = "Bolted"
	icon_state = "withbolt"
