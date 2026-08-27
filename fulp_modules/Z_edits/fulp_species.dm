//This is from 'code\controllers\subsystem\sprite_accessories.dm' - please keep it on par.
//They undefine it there making it unusable in this file, we have to re-define it.
#define DEFAULT_SPRITE_LIST "default_sprites"
/// Use this to init a sprite accessory list for a feature where mobs are required to have one selected
#define INIT_ACCESSORY(sprite_accessory) init_sprite_accessory_subtypes(sprite_accessory, add_blank = FALSE)[DEFAULT_SPRITE_LIST]
/// Use this to init a sprite accessory list for a feature where mobs can opt to not have one selected
#define INIT_OPTIONAL_ACCESSORY(sprite_accessory) init_sprite_accessory_subtypes(sprite_accessory, add_blank = TRUE)[DEFAULT_SPRITE_LIST]

//Initializes the sprite accessories from our Fulp-only species.
/datum/controller/subsystem/accessories/setup_lists()
	. = ..()
//	feature_list[FEATURE_BEEF_COLOR] = INIT_ACCESSORY
	feature_list[FEATURE_BEEF_EYES] = INIT_ACCESSORY(/datum/sprite_accessory/beef/eyes)
	feature_list[FEATURE_BEEF_MOUTH] = INIT_ACCESSORY(/datum/sprite_accessory/beef/mouth)
	feature_list[FEATURE_PROTOGEN_TAIL] = INIT_OPTIONAL_ACCESSORY(/datum/sprite_accessory/tails/protogen)
	feature_list[FEATURE_PROTOGEN_SNOUT] = INIT_ACCESSORY(/datum/sprite_accessory/protogen/snout)
	feature_list[FEATURE_PROTOGEN_ANTENNAE] = INIT_OPTIONAL_ACCESSORY(/datum/sprite_accessory/protogen/antennae)

#undef INIT_ACCESSORY
#undef INIT_OPTIONAL_ACCESSORY
#undef DEFAULT_SPRITE_LIST
