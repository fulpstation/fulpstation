
//--Under are jumpsuits and others things that go in its slot
/obj/item/clothing/under/midsommer
	name = "midsommer dress"
	desc = "Write something here to show up when examined."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/midsommer_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/midsommer_worn.dmi'
	icon_state = "midsommar_dress"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	fitted = FEMALE_UNIFORM_TOP
	has_sensor = HAS_SENSORS
	random_sensor = TRUE
	can_adjust = FALSE

//Small crown
/obj/item/clothing/head/midsommer
	name = "flower crown"
	desc = "Write something here to show up when examined."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/midsommer_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/midsommer_worn.dmi'
	icon_state = "flower_crown"

//Big crown
/obj/item/clothing/head/midsommer_queen
	name = "May Queen crown"
	desc = "Write something here to show up when examined."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/midsommer_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/midsommer_64.dmi'
	icon_state = "flower_crown_tall"
	worn_x_dimension = 64
	worn_y_dimension = 64
	//clothing_flags = LARGE_WORN_ICON //--This is on updated versions but not needed here for now

//The flower dress
/obj/item/clothing/suit/midsommer_queen
	name = "May Queen"
	desc = "Write something here to show up when examined."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/midsommer_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/midsommer_worn.dmi'
	icon_state = "may_queen"
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)

//--Box that contains the costumes
/obj/item/storage/box/halloween/edition_20/midsommer
	theme_name = "2020's Midsommer"

/obj/item/storage/box/halloween/edition_20/midsommer/PopulateContents()
	new /obj/item/clothing/under/midsommer(src)
	new /obj/item/clothing/head/midsommer(src)
	new /obj/item/clothing/head/midsommer_queen(src)
	new /obj/item/clothing/suit/midsommer_queen(src)
	new /obj/item/food/grown/mushroom/libertycap(src)
