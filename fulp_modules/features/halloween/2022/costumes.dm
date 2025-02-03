/**
 * Setting all costumes to use our .dmi file so we dont have to repeat each time
 * We're only setting the most commonly used items to use it.
 */
/obj/item/clothing/under/costume_2022
	icon = 'fulp_modules/icons/halloween/2022_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2022_icons_worn.dmi'
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/suit/costume_2022
	icon = 'fulp_modules/icons/halloween/2022_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2022_icons_worn.dmi'

/obj/item/clothing/suit/hooded/costume_2022
	icon = 'fulp_modules/icons/halloween/2022_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2022_icons_worn.dmi'

/obj/item/clothing/head/costume_2022
	icon = 'fulp_modules/icons/halloween/2022_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2022_icons_worn.dmi'

/obj/item/clothing/head/hooded/costume_2022
	icon = 'fulp_modules/icons/halloween/2022_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2022_icons_worn.dmi'

/obj/item/clothing/neck/costume_2022
	icon = 'fulp_modules/icons/halloween/2022_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2022_icons_worn.dmi'

/obj/item/clothing/shoes/costume_2022
	icon = 'fulp_modules/icons/halloween/2022_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2022_icons_worn.dmi'

/obj/item/clothing/gloves/costume_2022
	icon = 'fulp_modules/icons/halloween/2022_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2022_icons_worn.dmi'

/obj/item/clothing/mask/costume_2022
	icon = 'fulp_modules/icons/halloween/2022_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2022_icons_worn.dmi'

/obj/item/clothing/glasses/costume_2022
	icon = 'fulp_modules/icons/halloween/2022_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2022_icons_worn.dmi'

/**
 * Jack-O
 * From: Guilty Gear
 * By: Sheets
 */

/obj/item/clothing/head/costume_2022/jacko_head
	name = "Jack-o's halo"
	desc = ""
	icon_state = "jacko_head"
	worn_y_offset = 2
	clothing_flags = HIDEHAIR

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
	name = "Jack-o's necklace"
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

/**
 * Oogey
 * By: BalkyGoat
 */

/obj/item/clothing/head/costume_2022/oogey
	name = "Oogey"
	desc = "Oogey :)"
	icon_state = "oogey"
	clothing_flags = HIDEHAIR

/obj/item/storage/box/halloween/edition_22/oogey
	theme_name = "2022's Oogey"
	costume_contents = list(
		/obj/item/clothing/head/costume_2022/oogey,
	)

/**
 * MT Foxtrot
 * From: Cruelty Squad
 * By: boltonshead
 */


/obj/item/clothing/under/costume_2022/crueltysquad_under
	name = "CSIJ level I body armor"
	desc = "armor used by assassins working for Cruelty Squad, stripped of all of its functions for kids to play with."
	icon_state = "icon_crueltysquad_under"

/obj/item/clothing/shoes/costume_2022/crueltysquad_shoes
	name = "CSIJ level I combat boots"
	desc = "boots specifically designed to fit into the CSIJ level I body armor."
	icon_state = "icon_crueltysquad_shoes"

/obj/item/clothing/glasses/costume_2022/crueltysquad_glasses
	name = "CS inactive vision augmenter"
	desc = "a pair of glasses usually designed to identify targets for execution, although this mechanic has been removed for civilian casual use."
	icon_state = "icon_crueltysquad_glasses"

/obj/item/clothing/gloves/costume_2022/crueltysquad_gloves
	name = "CSIJ level I gloves"
	desc = "armor used by assassins working for Cruelty Squad, stripped of all of its functions for kids to play with."
	icon_state = "icon_crueltysquad_gloves"

/obj/item/storage/box/halloween/edition_22/crueltysquad
	theme_name = "2022's MT Foxtrot"
	costume_contents = list(
		/obj/item/clothing/gloves/costume_2022/crueltysquad_gloves,
		/obj/item/clothing/glasses/costume_2022/crueltysquad_glasses,
		/obj/item/clothing/under/costume_2022/crueltysquad_under,
		/obj/item/clothing/shoes/costume_2022/crueltysquad_shoes,
    )

/**
 * Madotsuki
 * By: Reina
 */


/obj/item/clothing/under/costume_2022/madotsuki_under
	name = "Madotsuki's sweater"
	desc = ""
	icon_state = "madotsuki_under"

/obj/item/clothing/shoes/costume_2022/madotsuki_shoes
	name = "Madotsuki's shoes"
	desc = ""
	icon_state = "madotsuki_shoes"

/obj/item/storage/box/halloween/edition_22/madotsuki
	theme_name = "2022's Madotsuki"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/under/costume_2022/madotsuki_under,
		/obj/item/clothing/shoes/costume_2022/madotsuki_shoes,
		/obj/item/knife/plastic,
    )

/**
 * Heather
 * By: Reina
 */


/obj/item/clothing/under/costume_2022/heather_under
	name = "Vest and turtleneck"
	desc = "Its a vest with a turtleneck under it"
	icon_state = "heather_under"

/obj/item/clothing/shoes/costume_2022/heather_shoes
	name = "Brown boots"
	desc = "It's a pair of boots"
	icon_state = "heather_shoes"

/obj/item/storage/box/halloween/edition_22/heather
	theme_name = "2022's Heather"
	illustration = "reina_box"
	costume_contents = list(
		/obj/item/clothing/under/costume_2022/heather_under,
		/obj/item/clothing/shoes/costume_2022/heather_shoes,
    )
