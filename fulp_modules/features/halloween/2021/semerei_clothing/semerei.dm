//--Anil Gedik Costumes
/obj/item/clothing/glasses/cp2077glasses
	name = "Hackerman glasses"
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	desc = "Oh! Shiny!"
	icon_state = "cp2077hackerglasses"

/obj/item/clothing/suit/toggle/cp2077rockerboy
	name = "Samurai's jacket"
	icon = 'fulp_modules/features/halloween/2021/2021_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2021/2021_icons_worn.dmi'
	desc = "Never fade away."
	icon_state = "cp2077jshjacket"
	body_parts_covered = CHEST|ARMS
	togglename = "mantis blades"

/obj/item/clothing/under/costume_2021/cp2077rockerboy
	name = "Rockerboy's suit"
	desc = "One last gig."
	icon_state = "cp2077jshsuit"
	has_sensor = HAS_SENSORS

/obj/item/storage/box/halloween/edition_21/cp2077_box
	theme_name = "2077 relics"
	illustration = "cp2077"

/obj/item/storage/box/halloween/edition_21/cp2077_box/PopulateContents()
	new /obj/item/clothing/glasses/cp2077glasses(src)
	new /obj/item/clothing/suit/toggle/cp2077rockerboy(src)
	new /obj/item/clothing/under/costume_2021/cp2077rockerboy(src)