/obj/item/clothing/under/costume/sneaking_suit
	name = "sneaking suit"
	desc = "The bleeding edge in military textile tech, with woven nanof- Oh wait no, it's a cheap costume."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "sneaking_jumpsuit"
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/head/sneaking_bandanna
	name = "sneaking bandanna"
	desc = "Tactical, stylish, does not provide infinite ammo."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "sneaking_bandanna"

/*
/obj/item/clothing/accessory/sneaking_rig
	name = "sneaking suit rig"
	desc = "Do you think ergonomical storage solutions can bloom? Even on the battlefield? Notice: This item is a toy and not capable of ergonomic storage."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "sneaking_rig"
	minimize_when_attached = FALSE
*/

/obj/item/clothing/suit/sneaking_jacket
	name = "sneaking suit tactical flak jacket"
	desc = "Seems comfortable enough to wear for maybe one mission."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "sneaking_jacket"

/obj/item/clothing/shoes/sneaking_boots
	name = "sneaking boots"
	desc = "Tactical espionage footwear."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "sneaking_boots"

/*
/obj/item/storage/belt/sneaking_belt
	name = "sneaking belt"
	desc = "Probably intended for tactically sneaking drinks and snacks into movie theatres."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "sneaking_belt"
*/

/obj/item/storage/box/halloween/edition_19/solid
	theme_name = "2019's Solid Snake"

/obj/item/storage/box/halloween/edition_19/solid/PopulateContents()
	new /obj/item/clothing/under/costume/sneaking_suit(src)
	new /obj/item/clothing/head/sneaking_bandanna(src)
	new /obj/item/clothing/suit/sneaking_jacket(src)
	new /obj/item/clothing/shoes/sneaking_boots(src)
