//Pumpkin
/obj/item/clothing/suit/space/hardsuit/toy/pumpkin
	name = "Pumpkin"
	desc = "The insides of a pumpkin a awkwardly warm and slimy."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "pumpkin"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/toy/pumpkin_top

/obj/item/clothing/head/helmet/space/hardsuit/toy/pumpkin_top
	name = "Pumpkin top"
	desc = "The top of a pumpkin on the top of your head."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "pumpkin_top"

/obj/item/storage/box/halloween/edition_19/pumpkin
	theme_name = "2019's Pumpkin"

/obj/item/storage/box/halloween/edition_19/pumpkin/PopulateContents()
	new /obj/item/clothing/suit/space/hardsuit/toy/pumpkin(src)

//Skeleton
/obj/item/clothing/suit/skeleton
	name = "Skeleton"
	desc = "You are now Mr.Bones."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "skeleton"

/obj/item/clothing/head/skull
	name = "Skull"
	desc = "A skull on your face."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "skull"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR

/obj/item/storage/box/halloween/edition_19/skeleton
	theme_name = "2019's Skeleton"


/obj/item/storage/box/halloween/edition_19/skeleton/PopulateContents()
	new /obj/item/clothing/suit/skeleton(src)
	new /obj/item/clothing/head/skull(src)

//Spider
/obj/item/clothing/suit/spider
	name = "Spider"
	desc = "An unwieldy set of 8 limbs"
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "spider"

/obj/item/storage/box/halloween/edition_19/spider
	theme_name = "2019's Spider"


/obj/item/storage/box/halloween/edition_19/spider/PopulateContents()
	new /obj/item/clothing/suit/spider(src)

//Witch
/obj/item/clothing/suit/witch
	name = "witch"
	desc = "You've become the Wicked Witch of the West."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "witch"

/obj/item/clothing/head/witch_hat
	name = "Witch Head"
	desc = "A green face and a pointy hat."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "witch_hat"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR

/obj/item/storage/box/halloween/edition_19/witch
	theme_name = "2019's Witch"


/obj/item/storage/box/halloween/edition_19/witch/PopulateContents()
	new /obj/item/clothing/suit/witch(src)
	new /obj/item/clothing/head/witch_hat(src)

//Sailor Moon
/obj/item/clothing/suit/sailor_moon
	name = "Sailor moon leotard"
	desc = "A magical girl leotard."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "sailormoon_suit"

/obj/item/clothing/head/hat/moon_wig
	name = "Sailor moon wig"
	desc = "Hair that looks like a pair of meatballs and spaghetti."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "sailormoon_hair"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/gloves/moon_gloves
	name = "Sailor moon golves"
	desc = "In the name I will Punish you!"
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "sailormoon_gloves"

/obj/item/clothing/shoes/moon_boots
	name = "Sailor moon boots"
	desc = "Boots for fighting evil by moonlight."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "sailormoon_boots"

/obj/item/storage/box/halloween/edition_19/sailor_moon
	theme_name = "2019's Sailor Moon"

/obj/item/storage/box/halloween/edition_19/sailor_moon/PopulateContents()
	new /obj/item/clothing/suit/sailor_moon(src)
	new /obj/item/clothing/head/hat/moon_wig(src)
	new /obj/item/clothing/gloves/moon_gloves(src)
	new /obj/item/clothing/shoes/moon_boots(src)

//--Tuxedomask
/obj/item/clothing/suit/tuxedo
	name = "Tuxedo"
	desc = "A dapper tux."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "tuxedomask_suit"

/obj/item/clothing/head/hat/tuxedo_hat
	name = "Top hat"
	desc = "A dapper top hat."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "tuxedomask_hat"

/obj/item/clothing/gloves/tuxedo_gloves
	name = "Tuxedo gloves"
	desc = "Don't prick your finger on that rose"
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "tuxedomask_gloves"

/obj/item/clothing/shoes/tuxedo_shoes
	name = "Dress shoes"
	desc = "Dress shoes for a dapper tux."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "tuxedomask_shoes"

/obj/item/clothing/mask/tuxedo_mask
	name = "Dress shoes"
	desc = "Dress shoes for a dapper tux."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "tuxedomask_mask"

/obj/item/storage/box/halloween/edition_19/tuxedo
	theme_name = "2019's Tuxedo Mask"

/obj/item/storage/box/halloween/edition_19/tuxedo/PopulateContents()
	new /obj/item/clothing/suit/tuxedo(src)
	new /obj/item/clothing/head/hat/tuxedo_hat(src)
	new /obj/item/clothing/gloves/tuxedo_gloves(src)
	new /obj/item/clothing/shoes/tuxedo_shoes(src)
	new /obj/item/clothing/mask/tuxedo_mask(src)
