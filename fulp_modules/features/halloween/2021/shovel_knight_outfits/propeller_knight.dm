/**
 * Propeller Knight
 * From: Shovel knight
 * By: Sheets
 */

///Suit (Toggled)
/obj/item/clothing/suit/hooded/costume_2021/propeller_suit
	name = "propeller knight's suit"
	desc = "A tight, yet comfortable green suit."
	icon_state = "propeller_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	hoodtype = /obj/item/clothing/head/hooded/costume_2021/propeller_head

///Hood
/obj/item/clothing/head/hooded/costume_2021/propeller_head
	name = "propeller knight's helmet"
	desc = "A reflective gold helmet with a makeshift propeller device fastened ontop."
	icon_state = "propeller_head"
	body_parts_covered = HEAD
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR

///Gloves
/obj/item/clothing/gloves/tackler/propeller_gloves
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	name = "propeller gloves"
	desc = "A tight yet comfortable pair of gloves, can be used for very, very bad tackles."
	icon_state = "propeller_gloves"
	tackle_stam_cost = 35
	base_knockdown = 1.75 SECONDS
	min_distance = 2
	skill_mod = -1.2

/obj/item/storage/box/halloween/edition_21/propeller_knight
	theme_name = "2021's Propeller Knight"
	costume_contents = list(
		/obj/item/clothing/gloves/tackler/propeller_gloves,
		/obj/item/clothing/suit/hooded/costume_2021/propeller_suit,
	)
