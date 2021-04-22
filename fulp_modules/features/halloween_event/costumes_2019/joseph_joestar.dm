/obj/item/clothing/under/costume/tricksters_outfit
	name = "trickster's vest and jeans"
	desc = "Someone's ruined this vest by cutting slots in it."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "joseph_outfit"
	body_parts_covered = CHEST|GROIN|LEGS
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/head/tricksters_headband
	name = "trickster's headband"
	desc = "Smells like expired ceasar dressing."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "joseph_headband"
	dynamic_hair_suffix = ""

/obj/item/clothing/neck/scarf/tricksters_scarf
	name = "trickster's scarf"
	desc = "The real trick is that it's held in place with a stiff wire."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "joseph_scarf"

/obj/item/clothing/shoes/tricksters_boots
	name = "trickster's boots"
	desc = "These help you Stand."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "joseph_boots"

/obj/item/clothing/gloves/tricksters_gloves
	name = "trickster's gloves"
	desc = "Fingerless, to let you better pull tricks out of nowhere."
	icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_icon.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2019/costumes_worn.dmi'
	icon_state = "joseph_gloves"

/obj/item/storage/box/halloween/edition_19/tricksters
	theme_name = "2019's Tricksters"

/obj/item/storage/box/halloween/edition_19/tricksters/PopulateContents()
	new /obj/item/clothing/under/costume/tricksters_outfit(src)
	new /obj/item/clothing/head/tricksters_headband(src)
	new /obj/item/clothing/neck/scarf/tricksters_scarf(src)
	new /obj/item/clothing/shoes/tricksters_boots(src)
	new /obj/item/clothing/gloves/tricksters_gloves(src)
