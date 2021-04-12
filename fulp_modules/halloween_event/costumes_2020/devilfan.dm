/obj/item/clothing/under/devilfan
	name = "devil's body"
	desc = "This is just red paint all over your body. And somehow it sticks well even after washing!"
	icon = 'fulp_modules/halloween_event/costumes_2020/devilfan_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/devilfan_worn.dmi'
	icon_state = "body"
	fitted = FEMALE_UNIFORM_FULL
	has_sensor = HAS_SENSORS
	random_sensor = TRUE
	can_adjust = FALSE

/obj/item/clothing/head/devilfan
	name = "devil's mask"
	desc = "Are you finally revealing your true evil?"
	icon = 'fulp_modules/halloween_event/costumes_2020/devilfan_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/devilfan_worn.dmi'
	icon_state = "mask"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEFACIALHAIR
	dynamic_hair_suffix = "+generic"

/obj/item/clothing/shoes/devilfan
	name = "devil's hooves"
	desc = "It never skipped leg day! Look at those sturdy legs!"
	icon = 'fulp_modules/halloween_event/costumes_2020/devilfan_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/devilfan_worn.dmi'
	icon_state = "hooves"

/obj/item/clothing/gloves/devilfan
	name = "devil's hands"
	desc = "Red paint to go with your hands. Why it isn't part of the suit is a mystery."
	icon = 'fulp_modules/halloween_event/costumes_2020/devilfan_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/devilfan_worn.dmi'
	icon_state = "hands"

/obj/item/storage/box/halloween/edition_20/devilfan
	theme_name = "2020's Devilfan"
	illustration = "mask"

/obj/item/storage/box/halloween/edition_20/devilfan/PopulateContents()
	new /obj/item/clothing/under/devilfan(src)
	new /obj/item/clothing/head/devilfan(src)
	new /obj/item/clothing/shoes/devilfan(src)
	new /obj/item/clothing/gloves/devilfan(src)
