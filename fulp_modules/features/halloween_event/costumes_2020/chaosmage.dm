/obj/item/clothing/under/chaosmage
	name = "chaos mage tabard"
	desc = "An old outfit which has lost its magical power. It is said that this belonged to a powerful mage."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/chaosmage_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/chaosmage_worn.dmi'
	icon_state = "tabard"
	fitted = FEMALE_UNIFORM_TOP
	has_sensor = HAS_SENSORS
	random_sensor = TRUE
	can_adjust = FALSE

/obj/item/clothing/suit/hooded/wintercoat/chaosmage
	name = "chaos mage cloak"
	desc = "A fancy purplish cloak with golden finitions. It keeps a bit warm for cold travels."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/chaosmage_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/chaosmage_worn.dmi'
	icon_state = "cloak"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/chaosmage

/obj/item/clothing/head/hooded/winterhood/chaosmage
	name = "chaos mage hood"
	desc = "A comfy purplish hood with golden trim. Wear it to be more mysterious."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/chaosmage_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/chaosmage_worn.dmi'
	icon_state = "hood"

/obj/item/clothing/shoes/chaosmage
	name = "chaos mage boots"
	desc = "A pair of warm boots made of synthetic wool. Sadly, dashes are not included."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/chaosmage_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/chaosmage_worn.dmi'
	icon_state = "boots"

/obj/item/storage/box/halloween/edition_20/chaosmage
	theme_name = "2020's Chaos mage outfit"
	illustration = "mask"

/obj/item/storage/box/halloween/edition_20/chaosmage/PopulateContents()
	new /obj/item/clothing/under/chaosmage(src)
	new /obj/item/clothing/suit/hooded/wintercoat/chaosmage(src)
	new /obj/item/clothing/shoes/chaosmage(src)
