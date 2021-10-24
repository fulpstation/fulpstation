/**
 * Chef knight
 * By: DaJanitor
 */

///Suit (Toggled)
/obj/item/clothing/suit/hooded/costume_2021/chef_knight_body
	name = "chef knight's suit"
	desc = "A hulking suit of armour fit with gauntlets, a pair of boots and a pretty apron with a bow."
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn_64.dmi'
	icon_state = "chef_knight_body"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDENECK|HIDEFACIALHAIR
	hoodtype = /obj/item/clothing/head/hooded/costume_2021/chef_knight_head

///Hood
/obj/item/clothing/head/hooded/costume_2021/chef_knight_head
	name = "chef knight's helmet"
	desc = "A steel helmet with a tall chef's hat ontop."
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn_64.dmi'
	icon_state = "chef_knight_head"
	body_parts_covered = HEAD
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEHAIR

/obj/item/storage/box/halloween/edition_21/chef_knight
	theme_name = "2021's Chef Knight"
	costume_contents = list(
		/obj/item/clothing/suit/hooded/costume_2021/chef_knight_body,
	)
