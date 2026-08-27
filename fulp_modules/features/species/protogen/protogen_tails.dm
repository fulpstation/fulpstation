//Organ
/obj/item/organ/tail/protogen
	name = "protogen tail"
	desc = "A severed protogen tail. Surprisingly sturdy."

	bodypart_overlay = /datum/bodypart_overlay/mutant/tail/protogen

	wag_flags = WAG_ABLE
	dna_block = /datum/dna_block/feature/accessory/tail_protogen

/datum/dna_block/feature/accessory/tail_protogen
	feature_key = FEATURE_PROTOGEN_TAIL

//Overlay
/datum/bodypart_overlay/mutant/tail/protogen
	feature_key = FEATURE_PROTOGEN_TAIL
	color_source = ORGAN_COLOR_INHERIT

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
