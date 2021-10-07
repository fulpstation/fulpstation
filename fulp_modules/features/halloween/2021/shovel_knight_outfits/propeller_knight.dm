/**
 * Propeller Knight
 * From: Shovel knight
 * By: Sheets
 */

///suit (uses hood to toggle helmet)

/obj/item/clothing/suit/hooded/costume_2021/propeller_suit
	name = "propeller knight's suit"
	desc = "A tight, yet comfortable green suit."
	icon_state = "propeller_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	hoodtype = /obj/item/clothing/head/hooded/costume_2021/propeller_head

///hood (doesnt spawn in box)

/obj/item/clothing/head/hooded/costume_2021/propeller_head
	name = "propeller knight's helmet"
	desc = "A reflective gold helmet with a makeshift propeller device fastened ontop."
	icon_state = "propeller_head"
	body_parts_covered = HEAD
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR

///gloves

/obj/item/clothing/gloves/costume_2021/propeller_gloves
	name = "propeller gloves"
	desc = "A tight yet comfortable pair of gloves."
	icon_state = "propeller_gloves"

/obj/item/storage/box/halloween/edition_21/propeller_knight
	theme_name = "2021's propeller knight"
	costume_contents = list(
		/obj/item/clothing/gloves/costume_2021/propeller_gloves,
		/obj/item/clothing/suit/hooded/costume_2021/propeller_suit,
	)
