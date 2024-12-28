/**
 * Setting all costumes to use our .dmi file so we dont have to repeat each time
 * We're only setting the most commonly used items to use it.
 */
/obj/item/clothing/under/costume_2024
	icon = 'fulp_modules/icons/halloween/2024_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2024_icons_worn.dmi'
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/suit/costume_2024
	icon = 'fulp_modules/icons/halloween/2024_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2024_icons_worn.dmi'

/obj/item/clothing/suit/hooded/costume_2024
	icon = 'fulp_modules/icons/halloween/2024_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2024_icons_worn.dmi'

/obj/item/clothing/head/costume_2024
	icon = 'fulp_modules/icons/halloween/2024_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2024_icons_worn.dmi'

/obj/item/clothing/head/hooded/costume_2024
	icon = 'fulp_modules/icons/halloween/2024_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2024_icons_worn.dmi'

/obj/item/clothing/neck/costume_2024
	icon = 'fulp_modules/icons/halloween/2024_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2024_icons_worn.dmi'

/obj/item/clothing/shoes/costume_2024
	icon = 'fulp_modules/icons/halloween/2024_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2024_icons_worn.dmi'

/obj/item/clothing/gloves/costume_2024
	icon = 'fulp_modules/icons/halloween/2024_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2024_icons_worn.dmi'

/obj/item/clothing/mask/costume_2024
	icon = 'fulp_modules/icons/halloween/2024_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2024_icons_worn.dmi'

/obj/item/clothing/glasses/costume_2024
	icon = 'fulp_modules/icons/halloween/2024_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2024_icons_worn.dmi'

/**
 * Ame-chan
 * From: Needy Streamer Overload
 * By: Kian
 */

/obj/item/clothing/under/costume_2024/ame_under
	name = "needy streamer's dress"
	desc = "Dress up like everyone's favorite live streamer!"
	icon_state = "ame_under"
	female_sprite_flags = FEMALE_UNIFORM_FULL

/obj/item/clothing/head/costume_2024/ame_head
	name = "needy streamer's wig"
	desc = "Like and subscribe!"
	icon_state = "ame_head"
	flags_inv = HIDEHAIR

/obj/item/storage/box/halloween/edition_24/ame
	theme_name = "2024's Needy Streamer"
	illustration = "ame"
	costume_contents = list(
		/obj/item/clothing/under/costume_2024/ame_under,
		/obj/item/clothing/head/costume_2024/ame_head,
		/obj/item/storage/fancy/cigarettes/cigpack_shadyjims
	)
