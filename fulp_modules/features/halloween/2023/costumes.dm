/**
 * Setting all costumes to use our .dmi file so we dont have to repeat each time
 * We're only setting the most commonly used items to use it.
 */
/obj/item/clothing/under/costume_2023
	icon = 'fulp_modules/icons/halloween/2023_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2023_icons_worn.dmi'
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/suit/costume_2023
	icon = 'fulp_modules/icons/halloween/2023_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2023_icons_worn.dmi'

/obj/item/clothing/suit/hooded/costume_2023
	icon = 'fulp_modules/icons/halloween/2023_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2023_icons_worn.dmi'

/obj/item/clothing/head/costume_2023
	icon = 'fulp_modules/icons/halloween/2023_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2023_icons_worn.dmi'

/obj/item/clothing/head/hooded/costume_2023
	icon = 'fulp_modules/icons/halloween/2023_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2023_icons_worn.dmi'

/obj/item/clothing/neck/costume_2023
	icon = 'fulp_modules/icons/halloween/2023_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2023_icons_worn.dmi'

/obj/item/clothing/shoes/costume_2023
	icon = 'fulp_modules/icons/halloween/2023_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2023_icons_worn.dmi'

/obj/item/clothing/gloves/costume_2023
	icon = 'fulp_modules/icons/halloween/2023_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2023_icons_worn.dmi'

/obj/item/clothing/mask/costume_2023
	icon = 'fulp_modules/icons/halloween/2023_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2023_icons_worn.dmi'

/obj/item/clothing/glasses/costume_2023
	icon = 'fulp_modules/icons/halloween/2023_icons.dmi'
	worn_icon = 'fulp_modules/icons/halloween/2023_icons_worn.dmi'

/**
 * Chai
 * From: Hi-Fi Rush
 * By: Nush
 */


/obj/item/clothing/under/costume_2023/chai_under
	name = "Chai's Tshirt and Jeans"
	desc = "A Tshirt and Jeans worn by a Rockstar the sleeve seems like it was torn off"
	icon_state = "chai_under"
	has_sensor = HAS_SENSORS
	can_adjust = FALSE

/obj/item/clothing/gloves/costume_2023/chai_gloves
	name = "Chai's Bracer"
	desc = "Worn by a Rockstar to help them keep to the beat"
	icon_state = "chai_gloves"

/obj/item/clothing/shoes/costume_2023/chai_shoes
	name = "Chai's Shoes"
	desc = "These shoes seem to always let the wearer walk to the Beat"
	icon_state = "chai_shoes"

/obj/item/clothing/neck/costume_2023/chai_neck
	name = "Chai's Scarf"
	desc = "A beatup scarf atleast the buttons look cool"
	icon_state = "chai_neck"

/obj/item/clothing/suit/costume_2023/chai_suit
	name = "Chai's Jacket"
	desc = "A Yellow and Orange jacket worn by a Rockstar the sleeve seems like it was torn off"
	icon_state = "chai_suit"
	allowed = list(
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/toy/plush
		)

/obj/item/storage/box/halloween/edition_23/rockstar_box
	theme_name = "2023's Rockstar"
	illustration = "Rockstar"
	costume_contents = list(
		/obj/item/clothing/neck/costume_2023/chai_neck,
		/obj/item/clothing/shoes/costume_2023/chai_shoes,
		/obj/item/clothing/gloves/costume_2023/chai_gloves,
		/obj/item/clothing/under/costume_2023/chai_under,
		/obj/item/clothing/suit/costume_2023/chai_suit,
		/obj/item/instrument/eguitar,
		/obj/item/toy/plush/EightZeroEight,
	)
