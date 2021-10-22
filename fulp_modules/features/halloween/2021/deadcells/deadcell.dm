/**
 * The Beheaded
 * From: Dead Cells
 * By: Helianthus
 */

/obj/item/clothing/under/costume_2021/deadcells_suit
	name = "prisoner's carapace"
	desc = "An old set of armor with some dusty cloth wrapped around it. Smells of smoke and rot."
	icon_state = "deadcells_suit"

/obj/item/clothing/shoes/costume_2021/deadcells_shoes
	name = "blue sandals"
	desc = "A pair of dark blue sandals, fit with light socks. The leather is falling apart."
	icon_state = "deadcells_feet"

/obj/item/clothing/head/hardhat/costume_2021/deadcells_head
	name = "homonculus mask"
	desc = "May possess you if you aren't careful."
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	icon_state = "hardhat0_deadcells"
	on = FALSE
	hat_type = "deadcells"
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT|HIDENECK

/obj/item/storage/box/halloween/edition_21/deadcells
	theme_name = "2021's The Beheaded"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/deadcells_suit,
		/obj/item/clothing/shoes/costume_2021/deadcells_shoes,
		/obj/item/clothing/head/hardhat/costume_2021/deadcells_head,
	)
