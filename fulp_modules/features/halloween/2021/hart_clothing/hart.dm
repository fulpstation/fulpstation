/**
 * Hart
 * From: Lisa: the Hopeful
 * By: Sheets
 */

///Jumpsuit
/obj/item/clothing/under/costume_2021/hart_body
	name = "Hart's suit"
	desc = "A well worn suit made from various animal furs and bones."
	icon_state = "hart_body"
	body_parts_covered = GROIN|LEGS|ARMS

///Hat
/obj/item/clothing/head/costume_2021/hart_head
	name = "Hart's hood"
	desc = "A hood made from tattered black cloth."
	icon_state = "hart_head"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR

///Mask
/obj/item/clothing/mask/costume_2021/lovely_mask
	name = "lovely Mask"
	desc = "A porcelain disk with a crudely drawn on heart."
	icon_state = "lovely_mask"
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR

/obj/item/storage/box/halloween/edition_21/hart
	theme_name = "2021's Hart's lovelies"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/hart_body,
		/obj/item/clothing/head/costume_2021/hart_head,
		/obj/item/clothing/mask/costume_2021/lovely_mask,
		/obj/item/clothing/mask/costume_2021/lovely_mask,
		/obj/item/clothing/mask/costume_2021/lovely_mask,
	)
