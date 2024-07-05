// Adds lists for our Fulp-species sprite accessories to the Accessory Subsystem.
/datum/controller/subsystem/accessories
	var/list/eyes_beefman
	var/list/mouths_beefman
	var/list/tails_list_protogen
	var/list/antennae_list_protogen
	var/list/snouts_list_protogen

// // Initializes the sprite accessories from our Fulp-only species.
/datum/controller/subsystem/accessories/setup_lists()
	// Note: The index being used here must match the value of DEFAULT_SPRITE_LIST, currently found code\controllers\subsystem\sprite_accessories.dm
	// It is, unfortunately, undefined at the end of the file, so we can't use the define directly here.
	eyes_beefman = init_sprite_accessory_subtypes(/datum/sprite_accessory/beef/eyes)["default_sprites"]
	mouths_beefman = init_sprite_accessory_subtypes(/datum/sprite_accessory/beef/mouth)["default_sprites"]
	tails_list_protogen = init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/protogen, add_blank = TRUE)["default_sprites"]
	antennae_list_protogen = init_sprite_accessory_subtypes(/datum/sprite_accessory/protogen/antennae, add_blank = TRUE)["default_sprites"]
	snouts_list_protogen = init_sprite_accessory_subtypes(/datum/sprite_accessory/protogen/snout)["default_sprites"]
	..()
