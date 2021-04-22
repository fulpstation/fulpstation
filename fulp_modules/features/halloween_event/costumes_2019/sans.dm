/obj/item/clothing/under/costume/sans
	name = "a skeleton\'s hoodie"
	desc = "A baggy, comfortable combination of a hoodie, tee and shorts. You can tell if you wear this you're gonna have a good time."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/sans_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/sans_worn.dmi'
	icon_state = "sans"
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/head/hardhat/sans
	name = "massive foam skull"
	desc = "What's this guy's name again? Sand? Sailsbury?"
	icon = 'fulp_modules/features/halloween_event/costumes_2019/sans_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/sans_worn.dmi'
	icon_state = "hardhat0_sans"
	on = FALSE
	hat_type = "sans"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0) //just dodge, duh
	resistance_flags = null
	flags_inv = HIDEHAIR|HIDEFACIALHAIR
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES
	dynamic_hair_suffix = ""

/obj/item/storage/box/halloween/edition_19/sans
	theme_name = "2019's Sans"

/obj/item/storage/box/halloween/edition_19/sans/PopulateContents()
	new /obj/item/clothing/under/costume/sans(src)
	new /obj/item/clothing/head/hardhat/sans(src)
