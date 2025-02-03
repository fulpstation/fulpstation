// Adds lists for our Fulp-species sprite accessories to the Accessory Subsystem.
/datum/controller/subsystem/accessories
	var/list/datum/sprite_accessory/beef/eyes/eyes_beefman_list
	var/list/datum/sprite_accessory/beef/mouth/mouths_beefman_list
	var/list/tails_list_protogen
	var/list/antennae_list_protogen
	var/list/snouts_list_protogen

//This is from 'code\controllers\subsystem\sprite_accessories.dm' - please keep it on par.
//They undefine it there making it unusable in this file, we have to re-define it.
#define DEFAULT_SPRITE_LIST "default_sprites"

//Initializes the sprite accessories from our Fulp-only species.
/datum/controller/subsystem/accessories/setup_lists()
	eyes_beefman_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/beef/eyes)[DEFAULT_SPRITE_LIST]
	mouths_beefman_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/beef/mouth)[DEFAULT_SPRITE_LIST]
	tails_list_protogen = init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/protogen, add_blank = TRUE)[DEFAULT_SPRITE_LIST]
	antennae_list_protogen = init_sprite_accessory_subtypes(/datum/sprite_accessory/protogen/antennae, add_blank = TRUE)[DEFAULT_SPRITE_LIST]
	snouts_list_protogen = init_sprite_accessory_subtypes(/datum/sprite_accessory/protogen/snout)[DEFAULT_SPRITE_LIST]
	..()

#undef DEFAULT_SPRITE_LIST
