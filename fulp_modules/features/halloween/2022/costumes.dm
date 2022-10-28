/**
 * Setting all costumes to use our .dmi file so we dont have to repeat each time
 * We're only setting the most commonly used items to use it.
 */
/obj/item/clothing/under/costume_2022
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/suit/costume_2022
	icon = 'fulp_modules/features/halloween/2022/2022_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2022/2022_icons_worn.dmi'

/obj/item/clothing/suit/hooded/costume_2022
	icon = 'fulp_modules/features/halloween/2022/2022_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2022/2022_icons_worn.dmi'

/obj/item/clothing/head/costume_2022
	icon = 'fulp_modules/features/halloween/2022/2022_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'

/obj/item/clothing/head/hooded/costume_2022
	icon = 'fulp_modules/features/halloween/2022/2022_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2022/2022_icons_worn.dmi'

/obj/item/clothing/neck/costume_2022
	icon = 'fulp_modules/features/halloween/2022/2022_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2022/2022_icons_worn.dmi'

/obj/item/clothing/shoes/costume_2022
	icon = 'fulp_modules/features/halloween/2022/2022_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2022/2022_icons_worn.dmi'

/obj/item/clothing/gloves/costume_2022
	icon = 'fulp_modules/features/halloween/2022/2022_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2022/2022_icons_worn.dmi'

/obj/item/clothing/mask/costume_2022
	icon = 'fulp_modules/features/halloween/2022/2022_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2022/2022_icons_worn.dmi'

/obj/item/clothing/glasses/costume_2022
	icon = 'fulp_modules/features/halloween/2022/2022_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2022/2022_icons_worn.dmi'

/**
 * Jack-O
 * By: Sheets
 */

/obj/item/clothing/head/costume_2022/jacko_head
	name = "Jack-o's halo"
	desc = ""
	icon_state = "jacko_head"

/obj/item/clothing/mask/costume_2022/jacko_mask
	name = "Jack-o's mask"
	desc = ""
	icon_state = "jacko_mask"

/obj/item/clothing/under/costume_2022/jacko_under
	name = "Jack-o's jumpsuit"
	desc = ""
	icon_state = "jacko_under"
	female_sprite_flags = FEMALE_UNIFORM_FULL

/obj/item/clothing/gloves/costume_2022/jacko_gloves
	name = "Jack-o's halo"
	desc = ""
	icon_state = "jacko_gloves"

/obj/item/clothing/shoes/costume_2022/jacko_shoes
	name = "Jack-o's halo"
	desc = ""
	icon_state = "jacko_shoes"

/obj/item/clothing/neck/costume_2022/jacko_neck
	name = "Ankh necklace"
	desc = ""
	icon_state = "jacko_neck"

/obj/item/storage/box/halloween/edition_22/jacko
	theme_name = "2022's Jack-o"
	costume_contents = list(
		/obj/item/clothing/neck/costume_2022/jacko_neck,
		/obj/item/clothing/shoes/costume_2022/jacko_shoes,
		/obj/item/clothing/gloves/costume_2022/jacko_gloves,
		/obj/item/clothing/under/costume_2022/jacko_under,
		/obj/item/clothing/mask/costume_2022/jacko_mask,
		/obj/item/clothing/head/costume_2022/jacko_head,
	)

