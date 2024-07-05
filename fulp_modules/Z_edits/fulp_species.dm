// Adds lists for our Fulp-species sprite accessories.
/datum/controller/subsystem/accessories
	var/list/eyes_beefman
	var/list/mouths_beefman
	var/list/tails_list_protogen
	var/list/antennae_list_protogen
	var/list/snouts_list_protogen

// // Initializes the sprite accessories from our Fulp-only species.
/datum/controller/subsystem/accessories/setup_lists()
	eyes_beefman = init_sprite_accessory_subtypes(/datum/sprite_accessory/beef/eyes)
	mouths_beefman = init_sprite_accessory_subtypes(/datum/sprite_accessory/beef/mouth)
	tails_list_protogen = init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/protogen, add_blank = TRUE)
	antennae_list_protogen = init_sprite_accessory_subtypes(/datum/sprite_accessory/protogen/antennae, add_blank = TRUE)
	snouts_list_protogen = init_sprite_accessory_subtypes(/datum/sprite_accessory/protogen/snout)
	..()
