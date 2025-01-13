//Organ
/obj/item/organ/tail/protogen
	name = "protogen tail"
	desc = "A severed protogen tail. Surprisingly sturdy."
	preference = "feature_protogen_tail"

	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/protogen

	wag_flags = WAG_ABLE
	dna_block = DNA_LIZARD_TAIL_BLOCK

//Overlay
/datum/bodypart_overlay/mutant/tail/protogen
	feature_key = "tail_protogen"
	color_source = ORGAN_COLOR_INHERIT

/datum/bodypart_overlay/mutant/tail/protogen/get_global_feature_list()
	return SSaccessories.tails_list_protogen

//Sprites
/datum/sprite_accessory/tails/protogen
	icon = 'fulp_modules/icons/species/mob/protogen_tails.dmi'
	spine_key = "proto"

/datum/sprite_accessory/tails/protogen/shark
	name = "Shark"
	icon_state = "shark"

/datum/sprite_accessory/tails/protogen/wolf
	name = "Wolf"
	icon_state = "wolf"

/datum/sprite_accessory/tails/protogen/synthliz
	name = "Synthliz"
	icon_state = "synthliz"
