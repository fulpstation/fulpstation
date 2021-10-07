/**
 * CP 2077 costume
 * From: Cyberpunk 2077
 * By: BalkyGoat
 */

///Jumpsuit
/obj/item/clothing/under/costume_2021/cp2077_rockerboy
	name = "rockerboy's suit"
	desc = "One last gig."
	icon_state = "cp2077jsh_suit"
	has_sensor = HAS_SENSORS

///Toggled suit
/obj/item/clothing/suit/toggle/cp2077_rockerboy
	name = "samurai's jacket"
	desc = "Never fade away."
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	icon_state = "cp2077jsh_jacket"
	body_parts_covered = CHEST|ARMS
	togglename = "mantis blades"

///Glasses
/obj/item/clothing/glasses/costume_2021/cp2077_glasses
	name = "hackerman glasses"
	desc = "Oh! Shiny!"
	icon_state = "cp2077hacker_glasses"

/obj/item/storage/box/halloween/edition_21/cp2077_box
	theme_name = "2021's CP 2077 Relics"
	illustration = "cp2077"
	costume_contents = list(
		/obj/item/clothing/under/costume_2021/cp2077_rockerboy,
		/obj/item/clothing/suit/toggle/cp2077_rockerboy,
		/obj/item/clothing/glasses/cp2077_glasses,
	)

