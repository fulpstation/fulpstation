/**
 * Original Food export file got eaten somewhere along the line and I have no idea when or where it got completely deleted.
 * Foods given a venue value are exportable to cargo as a backup to selling from venues, however at the expense of elasticity.
 */
/datum/export/food
	cost = 10
	unit_name = "serving"
	message = "of food"
	export_types = list(/obj/item/food)
	include_subtypes = TRUE
	exclude_types = list(/obj/item/food/grown)

/datum/export/food/get_cost(obj/object, allowed_categories, apply_elastic)
	var/obj/item/food/sold_food = object
	if(sold_food.food_flags & FOOD_SILVER_SPAWNED)
		return FOOD_PRICE_WORTHLESS
	return sold_food.venue_value
