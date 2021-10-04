/**
 * Centaur costume
 */
/obj/item/clothing/suit/centaur
	name = "centaur costume"
	desc = "The prototypes required two or more participants to pilot the suit, but this advanced version only requires one."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/centaur_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/centaur_worn.dmi'
	icon_state = "centaur"

/obj/item/storage/box/halloween/edition_19/centaur
	theme_name = "2019's Centaur"

/obj/item/storage/box/halloween/edition_19/centaur/PopulateContents()
	new /obj/item/clothing/suit/centaur(src)

/**
 * Hot Dog costume
 */
/obj/item/clothing/suit/hotdog
	name = "Hotdog"
	desc = "Hot Dawg."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "hotdog"

/obj/item/clothing/head/hot_head
	name = "Hotdog hood"
	desc = "Hot Dawg."
	icon_state = "hotdog_top"
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/storage/box/halloween/edition_19/hotdog
	theme_name = "2019's Hotdog"

/obj/item/storage/box/halloween/edition_19/hotdog/PopulateContents()
	new /obj/item/clothing/suit/hotdog(src)
	new /obj/item/clothing/head/hot_head(src)

/**
 * Ketchup & Mustard costumes
 */
/obj/item/clothing/suit/ketchup
	name = "Ketchup"
	desc = "A soft plush ketchup bottle."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "ketchup"

/obj/item/clothing/head/ketchup_head
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	desc = "A soft plush ketchup bottle."
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "ketchup_top"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/storage/box/halloween/edition_19/ketchup
	theme_name = "2019's Ketchup"

/obj/item/storage/box/halloween/edition_19/ketchup/PopulateContents()
	new /obj/item/clothing/suit/ketchup(src)
	new /obj/item/clothing/head/ketchup_head(src)

/obj/item/clothing/suit/mustard
	name = "Mustard"
	desc = "A soft plush mustard bottle."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "mustard"

/obj/item/clothing/head/mustard_head
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	desc = "A soft plush mustard bottle."
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "mustard_top"
	dynamic_hair_suffix = ""
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/storage/box/halloween/edition_19/mustard
	theme_name = "2019's Mustard"

/obj/item/storage/box/halloween/edition_19/mustard/PopulateContents()
	new /obj/item/clothing/suit/mustard(src)
	new /obj/item/clothing/head/mustard_head(src)

/**
 * Angel & Devil Costume
 */
/obj/item/clothing/suit/angel
	name = "angel"
	desc = "Heavenly Dress."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "angel"

/obj/item/clothing/head/angel_halo
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	desc = "Heavenly Halo."
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "angel_halo"

/obj/item/storage/box/halloween/edition_19/angel
	theme_name = "2019's Angel"

/obj/item/storage/box/halloween/edition_19/angel/PopulateContents()
	new /obj/item/clothing/suit/angel(src)
	new /obj/item/clothing/head/angel_halo(src)

/obj/item/clothing/suit/devil
	name = "Devil"
	desc = "The one the only Devil."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "devil"

/obj/item/clothing/head/devil_horns
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	desc = "The one the only Devil."
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "devil_horns"
	dynamic_hair_suffix = ""

/obj/item/storage/box/halloween/edition_19/devil
	theme_name = "2019's Devil"

/obj/item/storage/box/halloween/edition_19/devil/PopulateContents()
	new /obj/item/clothing/suit/devil(src)
	new /obj/item/clothing/head/devil_horns(src)

/**
 * Cat costume (back when felinids werent a thing)
 */
/obj/item/clothing/suit/cat
	name = "Cat suit"
	desc = "You feel like you can slink everywhere now."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "cat"

/obj/item/clothing/head/cat_head
	icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_icon.dmi'
	desc = "You feel like you can slink everywhere now."
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2019/jo_costumes.dmi'
	icon_state = "cat_ears"

/obj/item/storage/box/halloween/edition_19/cat
	theme_name = "2019's Cat"

/obj/item/storage/box/halloween/edition_19/cat/PopulateContents()
	new /obj/item/clothing/suit/cat(src)
	new /obj/item/clothing/head/cat_head(src)
