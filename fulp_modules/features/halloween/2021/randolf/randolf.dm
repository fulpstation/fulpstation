/**
* Randolf
* By: Twox
*/


/obj/item/clothing/head/costume_2021/randolf_head
	name = "randolf's hat"
	desc = "Comfy and can fit two."
	icon_state = "randolf_hat"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEFACIALHAIR|HIDEFACE|HIDEEYES|HIDEMASK|HIDEEARS
	worn_y_offset = 6

/obj/item/clothing/shoes/costume_2021/randolf_shoes
	name = "randolf's shoes"
	desc = "There is more than one way to skin a dog."
	icon_state = "randolf_shoes"
	body_parts_covered = FEET

/obj/item/clothing/suit/costume_2021/randolf_suit
	name = "randolf's suit"
	desc = "All in one suit, tail not included."
	icon_state = "randolf_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT|HIDEGLOVES

/obj/item/storage/box/halloween/edition_21/randolf
	theme_name = "2021's Randolf the Fox"
	illustration = "randolf_box"
	costume_contents = list(
		/obj/item/clothing/head/costume_2021/randolf_head,
		/obj/item/clothing/shoes/costume_2021/randolf_shoes,
		/obj/item/clothing/suit/costume_2021/randolf_suit,
 )
