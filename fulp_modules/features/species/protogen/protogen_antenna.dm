//Organ
/obj/item/organ/protogen_antennae
	name = "protogen antennae"
	desc = "A protogen's metallic antennae."
	icon_state = "antennae"

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_ANTENNAE

	preference = "feature_protogen_antennae"
	dna_block = DNA_MOTH_ANTENNAE_BLOCK

	bodypart_overlay = /datum/bodypart_overlay/mutant/protogen_antennae

//Overlay
/datum/bodypart_overlay/mutant/protogen_antennae
	feature_key = "antennae_protogen"
	layers = EXTERNAL_ADJACENT
	color_source = ORGAN_COLOR_INHERIT

/datum/bodypart_overlay/mutant/protogen_antennae/get_global_feature_list()
	return SSaccessories.antennae_list_protogen

//Sprites
/datum/sprite_accessory/protogen/antennae
	icon = 'fulp_modules/icons/species/mob/protogen_antennas.dmi'

/datum/sprite_accessory/protogen/antennae/default
	name = "Default"
	icon_state = "default"

/datum/sprite_accessory/protogen/antennae/curled
	name = "Curled"
	icon_state = "curled"

/datum/sprite_accessory/protogen/antennae/thick
	name = "Thick"
	icon_state = "thick"

/datum/sprite_accessory/protogen/antennae/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/protogen/antennae/sharp
	name = "Sharp"
	icon_state = "sharp"

/datum/sprite_accessory/protogen/antennae/horns
	name = "Horns"
	icon_state = "horns"
