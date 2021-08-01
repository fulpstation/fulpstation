/obj/item/clothing/under/costume/trooper_jumpsuit
	name = "trooper jumpsuit"
	desc = "Another snazzy number courtesy of fashionistas Heinlein & Verhoeven."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "starship_jumpsuit"
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/head/trooper_helmet
	name = "starship helmet"
	desc = "Protects your precious brains from bugs, but more importantly from critical thinking."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "starship_helmet"

/*
/obj/item/storage/belt/trooper_belt
	name = "mobile infantry belt"
	desc = "Mostly useful for carrying propaganda leaflets."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "starship_belt"
*/

/obj/item/clothing/shoes/trooper_shoes
	name = "bug stomping boots"
	desc = "Perfect for licking."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "starship_boots"

/obj/item/clothing/gloves/trooper_gloves
	name = "roughneck gloves"
	desc = "Keep your hands clean even when you're elbow-deep in bug guts and fascism."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "starship_gloves"

/obj/item/clothing/suit/trooper_armor
	name = "terran body armor"
	desc = "Designed to ensure your heart doesn't falter. Your liver, lungs and intestines, too."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "starship_suit"

/obj/item/storage/box/halloween/edition_19/trooper
	theme_name = "2019's Starship trooper"

/obj/item/storage/box/halloween/edition_19/trooper/PopulateContents()
	new /obj/item/clothing/under/costume/trooper_jumpsuit(src)
	new /obj/item/clothing/head/trooper_helmet(src)
	new /obj/item/clothing/shoes/trooper_shoes(src)
	new /obj/item/clothing/gloves/trooper_gloves(src)
	new /obj/item/clothing/suit/trooper_armor(src)
