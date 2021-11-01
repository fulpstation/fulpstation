
/**
 * Setting all costumes to use our .dmi file so we dont have to repeat each time
 * We're only setting the most commonly used items to use it.
 */

/obj/item/clothing/under/costume_2021/pucci
	name = "dancing man suit"
	desc = "A suit worn by a man who loves to dance."
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	icon_state = "pucci"

/obj/item/clothing/suit/costume_2021/pucci
	name = "dancing man overcoat"
	desc = "An overcoat worn by a man who loves to dance."
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	icon_state = "pucci_suit"

/obj/item/clothing/head/costume_2021/pucci
	name = "dancing man wig"
	desc = "A wig designed to resemble the hair of a man who loves to dance."
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	icon_state = "pucci_wig"

/obj/item/clothing/under/costume_2021/willard
	name = "male witch's suit"
	desc = "A suit worn by a male witch."
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	icon_state = "male_witch"

/obj/item/clothing/suit/costume_2021/willard
	name = "male witch's overcoat"
	desc = "An overcoat worn by a male witch."
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	icon_state = "male_witch_suit"

/obj/item/clothing/head/costume_2021/willard
	name = "male witch's hat"
	desc = "A hat worn by a male witch."
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	icon_state = "male_witch_hat"

/obj/item/clothing/shoes/costume_2021/willard
	name = "male witch's shoes"
	desc = "Shoes worn by a male witch."
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	icon_state = "buckleshoe"

/obj/item/clothing/head/costume_2021/thirsty
    name = "thirst flower hat"
    desc = "A hat for a thirsty little flower."
    icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
    worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
    icon_state = "thirsty"

/obj/item/clothing/under/color/thirsty
    name = "thirsy flower jumpsuit"
    desc = "A dark green jumpsuit that represents a thirty flower's stem."
    greyscale_colors = "#128512"

/obj/item/storage/box/halloween/edition_21/thirsty
	theme_name = "2021's thirsty flower"
	costume_contents = list(
		/obj/item/clothing/head/costume_2021/thirsty,
		/obj/item/clothing/under/color/thirsty
    )

/obj/item/storage/box/halloween/edition_21/willard
    theme_name = "2021's male witch"
    costume_contents = list(
		/obj/item/clothing/under/costume_2021/willard,
		/obj/item/clothing/suit/costume_2021/willard,
		/obj/item/clothing/head/costume_2021/willard,
		/obj/item/clothing/shoes/costume_2021/willard
    )

/obj/item/storage/box/halloween/edition_21/pucci
    theme_name = "2021's dancing man"
    costume_contents = list(
        /obj/item/clothing/under/costume_2021/pucci,
		/obj/item/clothing/suit/costume_2021/pucci,
		/obj/item/clothing/head/costume_2021/pucci
    )
