/obj/item/storage/box/halloween/edition_21
	year = 2021

/obj/item/storage/box/halloween/edition_21/PopulateContents()
	new	/obj/item/choice_beacon/halloween/edition_21(src)

/obj/item/choice_beacon/halloween/edition_21
	year = 2021
	target = /obj/item/storage/box/halloween/edition_21

// OLD HUNTER

/obj/item/clothing/suit/oldhunter
	name = "Old Hunter's Garb"
	desc = "A fanciful victorian suit with bafflingly irremovable shoes."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2021/lady_maria_item.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2021/lady_maria_worn.dmi'
	icon_state = "lady_maria_suit"

/obj/item/clothing/head/oldhunter
	name = "Old Hunter's Cap"
	desc = "Under no circumstances does this remind you of any copyrighted characters."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2021/lady_maria_item.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2021/lady_maria_worn.dmi'
	icon_state = "lady_maria_hat"

/obj/item/storage/box/halloween/edition_21/oldhunter
	theme_name = "Old Hunter's Set"
	illustration = "Mask"

/obj/item/storage/box/halloween/edition_21/oldhunter/PopulateContents()
	new /obj/item/clothing/suit/oldhunter(src)
	new /obj/item/clothing/head/oldhunter(src)
