//-- Cecily's costume
/obj/item/clothing/under/frog_suit
	name = "frog onesie"
	desc = "A comfortable and snuggly animal onesie."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/frog_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/frog_worn.dmi'
	icon_state = "frog_suit"
	fitted = FEMALE_UNIFORM_FULL
	has_sensor = HAS_SENSORS
	random_sensor = TRUE
	can_adjust = FALSE

/obj/item/clothing/head/frog_head
	name = "frog hood"
	desc = "A comfortable and snuggly animal hoodie"
	icon = 'fulp_modules/features/halloween_event/costumes_2020/frog_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/frog_worn.dmi'
	icon_state = "frog_head"

/obj/item/clothing/gloves/frog_gloves
	name = "frog gloves"
	desc = "A tight yet comfortable pair of gloves."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/frog_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/frog_worn.dmi'
	icon_state = "frog_gloves"

/obj/item/clothing/shoes/frog_shoe
	name = "frog shoes"
	desc = "A pair of comfortable shoes recolored green."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/frog_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/frog_worn.dmi'
	icon_state = "frog_shoes"

//--Box that contains the costumes
/obj/item/storage/box/halloween/edition_20/frog
	theme_name = "2020's Frog"

/obj/item/storage/box/halloween/edition_20/frog/PopulateContents()
	new /obj/item/clothing/under/frog_suit(src)
	new /obj/item/clothing/head/frog_head(src)
	new /obj/item/clothing/gloves/frog_gloves(src)
	new /obj/item/clothing/shoes/frog_shoe(src)
