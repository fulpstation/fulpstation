/**
 * Spectre Knight
 * From: Shovel knight
 * By: Sheets
 */

///suit

/obj/item/clothing/suit/costume_2021/spectre_suit
	name = "spectre knight's robes"
	desc = "A darkened blood red robe with little armour."
	icon_state = "spectre_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

///helmet

/obj/item/clothing/head/costume_2021/spectre_head
	name = "spectre knight's helmet"
	desc = "A blood red hood, obscuring reflective golden helmet."
	icon_state = "spectre_head"
	body_parts_covered = HEAD
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR

/obj/item/storage/box/halloween/edition_21/spectre_knight
	theme_name = "2021's spectre knight"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2021/spectre_suit,
		/obj/item/clothing/head/costume_2021/spectre_head,
	)
