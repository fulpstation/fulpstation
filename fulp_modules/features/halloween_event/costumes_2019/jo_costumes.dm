//Hotdog
/obj/item/clothing/suit/hotdog
	name = "Hotdog"
	desc = "Hot Dawg."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "hotdog"

/obj/item/clothing/head/hot_head
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	desc = "Hot Dawg."
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "hotdog_top"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/storage/box/halloween/edition_19/hotdog
	theme_name = "2019's Hotdog"

/obj/item/storage/box/halloween/edition_19/hotdog/PopulateContents()
	new /obj/item/clothing/suit/hotdog(src)
	new /obj/item/clothing/head/hot_head(src)

//---Ketchup
/obj/item/clothing/suit/ketchup
	name = "Ketchup"
	desc = "A soft plush ketchup bottle."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "ketchup"

/obj/item/clothing/head/ketchup_head
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	desc = "A soft plush ketchup bottle."
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "ketchup_top"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/storage/box/halloween/edition_19/ketchup
	theme_name = "2019's Ketchup"

/obj/item/storage/box/halloween/edition_19/ketchup/PopulateContents()
	new /obj/item/clothing/suit/ketchup(src)
	new /obj/item/clothing/head/ketchup_head(src)

//--Mustard
/obj/item/clothing/suit/mustard
	name = "Mustard"
	desc = "A soft plush mustard bottle."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "mustard"

/obj/item/clothing/head/mustard_head
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	desc = "A soft plush mustard bottle."
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "mustard_top"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/storage/box/halloween/edition_19/mustard
	theme_name = "2019's Mustard"

/obj/item/storage/box/halloween/edition_19/mustard/PopulateContents()
	new /obj/item/clothing/suit/mustard(src)
	new /obj/item/clothing/head/mustard_head(src)

//Angel
/obj/item/clothing/suit/angel
	name = "angel"
	desc = "Heavenly Dress."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "angel"

/obj/item/clothing/head/angel_halo
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	desc = "Heavenly Halo."
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "angel_halo"

/obj/item/storage/box/halloween/edition_19/angel
	theme_name = "2019's Angel"

/obj/item/storage/box/halloween/edition_19/angel/PopulateContents()
	new /obj/item/clothing/suit/angel(src)
	new /obj/item/clothing/head/angel_halo(src)

//--Devil
/obj/item/clothing/suit/devil
	name = "Devil"
	desc = "The one the only Devil."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "devil"

/obj/item/clothing/head/devil_horns
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	desc = "The one the only Devil."
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "devil_horns"
	dynamic_hair_suffix = ""

/obj/item/storage/box/halloween/edition_19/devil
	theme_name = "2019's Devil"

/obj/item/storage/box/halloween/edition_19/devil/PopulateContents()
	new /obj/item/clothing/suit/devil(src)
	new /obj/item/clothing/head/devil_horns(src)

//Cats
/obj/item/clothing/suit/cat
	name = "Cat suit"
	desc = "You feel like you can slink everywhere now."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "cat"

/obj/item/clothing/head/cat_head
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	desc = "You feel like you can slink everywhere now."
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "cat_ears"

/obj/item/storage/box/halloween/edition_19/cat
	theme_name = "2019's Cat"

/obj/item/storage/box/halloween/edition_19/cat/PopulateContents()
	new /obj/item/clothing/suit/cat(src)
	new /obj/item/clothing/head/cat_head(src)

//Pumpkin
/obj/item/clothing/suit/space/hardsuit/toy/pumpkin
	name = "Pumpkin"
	desc = "The insides of a pumpkin a awkwardly warm and slimy."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "pumpkin"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/toy/pumpkin_top

/obj/item/clothing/head/helmet/space/hardsuit/toy/pumpkin_top
	name = "Pumpkin top"
	desc = "The top of a pumpkin on the top of your head."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "pumpkin_top"

/obj/item/storage/box/halloween/edition_19/pumpkin
	theme_name = "2019's Pumpkin"

/obj/item/storage/box/halloween/edition_19/pumpkin/PopulateContents()
	new /obj/item/clothing/suit/space/hardsuit/toy/pumpkin(src)

//Skeleton
/obj/item/clothing/suit/skeleton
	name = "Skeleton"
	desc = "You are now Mr.Bones."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "skeleton"

/obj/item/clothing/head/skull
	name = "Skull"
	desc = "A skull on your face."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
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
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "spider"

/obj/item/storage/box/halloween/edition_19/spider
	theme_name = "2019's Spider"


/obj/item/storage/box/halloween/edition_19/spider/PopulateContents()
	new /obj/item/clothing/suit/spider(src)

//Witch
/obj/item/clothing/suit/witch
	name = "witch"
	desc = "You've become the Wicked Witch of the West."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "witch"

/obj/item/clothing/head/witch_hat
	name = "Witch Head"
	desc = "A green face and a pointy hat."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
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
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "sailormoon_suit"

/obj/item/clothing/head/hat/moon_wig
	name = "Sailor moon wig"
	desc = "Hair that looks like a pair of meatballs and spaghetti."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "sailormoon_hair"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/gloves/moon_gloves
	name = "Sailor moon golves"
	desc = "In the name I will Punish you!"
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "sailormoon_gloves"

/obj/item/clothing/shoes/moon_boots
	name = "Sailor moon boots"
	desc = "Boots for fighting evil by moonlight."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
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
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "tuxedomask_suit"

/obj/item/clothing/head/hat/tuxedo_hat
	name = "Top hat"
	desc = "A dapper top hat."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "tuxedomask_hat"

/obj/item/clothing/gloves/tuxedo_gloves
	name = "Tuxedo gloves"
	desc = "Don't prick your finger on that rose"
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "tuxedomask_gloves"

/obj/item/clothing/shoes/tuxedo_shoes
	name = "Dress shoes"
	desc = "Dress shoes for a dapper tux."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "tuxedomask_shoes"

/obj/item/clothing/mask/tuxedo_mask
	name = "Dress shoes"
	desc = "Dress shoes for a dapper tux."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/jo_costumes.dmi'
	icon_state = "tuxedomask_mask"

/obj/item/storage/box/halloween/edition_19/tuxedo
	theme_name = "2019's Tuxedo Mask"

/obj/item/storage/box/halloween/edition_19/tuxedo/PopulateContents()
	new /obj/item/clothing/suit/tuxedo(src)
	new /obj/item/clothing/head/hat/tuxedo_hat(src)
	new /obj/item/clothing/gloves/tuxedo_gloves(src)
	new /obj/item/clothing/shoes/tuxedo_shoes(src)
	new /obj/item/clothing/mask/tuxedo_mask(src)
