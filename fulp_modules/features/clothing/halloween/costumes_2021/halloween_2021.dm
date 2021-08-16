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
	theme_name = "2021's Old Hunter's Set"
	illustration = "Mask"

/obj/item/storage/box/halloween/edition_21/oldhunter/PopulateContents()
	new /obj/item/clothing/suit/oldhunter(src)
	new /obj/item/clothing/head/oldhunter(src)

// SHOVEL KNIGHT

/obj/item/clothing/suit/spectre_suit
	name = "Spectre Knight's robes"
	desc = "A darkened blood red robe with little armour."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2021/shovelknight_item.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2021/shovelknight_worn.dmi'
	icon_state = "spectre_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/head/spectre_head
	name = "Spectre Knight's helmet"
	desc = "A blood red hood, attatched to a reflective gold visor."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2021/shovelknight_item.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2021/shovelknight_worn.dmi'
	icon_state = "spectre_head"
	body_parts_covered = HEAD
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR

/obj/item/clothing/suit/hooded/propeller_suit
	name = "Propeller suit"
	desc = "A tight, yet comfortable green suit."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2021/shovelknight_item.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2021/shovelknight_worn.dmi'
	icon_state = "propeller_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	hoodtype = /obj/item/clothing/head/hooded/propeller_head

/obj/item/clothing/head/hooded/propeller_head
	name = "Propeller head"
	desc = "A reflective gold helmet with a makeshift propeller device fastened ontop."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2021/shovelknight_item.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2021/shovelknight_worn.dmi'
	icon_state = "propeller_head"
	body_parts_covered = HEAD
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR

/obj/item/clothing/gloves/propeller_gloves
	name = "Propeller gloves"
	desc = "A tight, yet comfortable pair of gloves."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2021/shovelknight_item.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2021/shovelknight_worn.dmi'
	icon_state = "propeller_gloves"

/obj/item/storage/box/halloween/edition_21/spectreknight
	theme_name = "2021's Spectre Knight"

/obj/item/storage/box/halloween/edition_21/spectreknight/PopulateContents()
	new /obj/item/clothing/suit/spectre_suit(src)
	new /obj/item/clothing/head/spectre_head(src)

/obj/item/storage/box/halloween/edition_21/propellerknight
	theme_name = "2021's Propeller Knight"

/obj/item/storage/box/halloween/edition_21/propellerknight/PopulateContents()
	new /obj/item/clothing/suit/hooded/propeller_suit(src)
	new /obj/item/clothing/gloves/propeller_gloves(src)

// HART

/obj/item/clothing/under/hart_body
	name = "Hart body"
	desc = "A well worn suit made from various animal furs and bones."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2021/hart_item.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2021/hart_worn.dmi'
	icon_state = "hart_body"
	body_parts_covered = GROIN|LEGS|ARMS

/obj/item/clothing/head/hart_head
	name = "Hart hood"
	desc = "A hood made from tattered black cloth."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2021/hart_item.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2021/hart_worn.dmi'
	icon_state = "hart_head"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR

/obj/item/clothing/mask/lovely_mask
	name = "Lovely Mask"
	desc = "A porcelain disk with a crudely drawn on heart."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2021/hart_item.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2021/hart_worn.dmi'
	icon_state = "lovely_mask"
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR

/obj/item/storage/box/halloween/edition_21/hartcostume
	theme_name = "2021 - Hart's lovelies"

/obj/item/storage/box/halloween/edition_21/hartcostume/PopulateContents()
	new /obj/item/clothing/under/hart_body(src)
	new /obj/item/clothing/head/hart_head(src)
	new /obj/item/clothing/mask/lovely_mask(src)
	new /obj/item/clothing/mask/lovely_mask(src)
	new /obj/item/clothing/mask/lovely_mask(src)

// Sagi's breather boys mask

/obj/item/clothing/mask/breather_mask
	name = "Breather mask"
	desc = "A tight green balaclava with a breathing apparatus strapped to the front."
	icon = 'fulp_modules/features/clothing/halloween/costumes_2021/breather_mask_item.dmi'
	worn_icon = 'fulp_modules/features/clothing/halloween/costumes_2021/breather_mask_worn.dmi'
	icon_state = "breathermask"
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR
	clothing_flags = MASKINTERNALS

/obj/item/storage/box/halloween/edition_21/hartcostume
	theme_name = "2021's Breathers"

/obj/item/storage/box/halloween/edition_21/hartcostume/PopulateContents()
	new /obj/item/clothing/mask/breather_mask(src)
