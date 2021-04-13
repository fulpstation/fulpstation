//Joyce's Woody costume
/obj/item/clothing/under/forbidden_cowboy
	name = "forbidden cowboy suit"
	desc = "Just looking at this suit makes you hear a quiet bwoink at the back of you mind."
	icon = 'fulp_modules/halloween_event/costumes_2020/forbiddencowboy_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/forbiddencowboy_worn.dmi'
	icon_state = "forbiddencowboy_suit"
	fitted = FEMALE_UNIFORM_FULL
	has_sensor = HAS_SENSORS
	random_sensor = TRUE
	can_adjust = FALSE

/obj/item/clothing/head/forbidden_cowboy
	name = "forbidden cowboy hat"
	desc = "Just looking at this hat makes you hear a quiet bwoink at the back of you mind."
	icon = 'fulp_modules/halloween_event/costumes_2020/forbiddencowboy_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/forbiddencowboy_worn.dmi'
	icon_state = "forbiddencowboy_hat"

/obj/item/storage/box/halloween/edition_20/forbidden_cowboy
	theme_name = "2020's Forbidden Cowboy"

/obj/item/storage/box/halloween/edition_20/forbidden_cowboy/PopulateContents()
	new /obj/item/clothing/head/forbidden_cowboy(src)
	new /obj/item/clothing/under/forbidden_cowboy(src)
	new /obj/item/clothing/shoes/cowboy(src)
	new /obj/item/stack/sheet/mineral/wood(src)
