/obj/item/clothing/suit/centaur
	name = "centaur costume"
	desc = "The prototypes required two or more participants to pilot the suit, but this advanced version only requires one."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/centaur_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/centaur_worn.dmi'
	icon_state = "centaur"

/obj/item/storage/box/halloween/edition_19/centaur
	theme_name = "2019's Centaur"

/obj/item/storage/box/halloween/edition_19/centaur/PopulateContents()
	new /obj/item/clothing/suit/centaur(src)
