/obj/item/card/id/advanced/prisoner/chef
	registered_name = "Chef Prisoner ID"
	name = "Chef Prisoner ID"
	desc = "A special ID card that allows prisoners to access the prison's Kitchen."
	trim = /datum/id_trim/prisoner/chef

/datum/id_trim/prisoner/chef
	trim_state = "trim_cook"
	access = list(ACCESS_KITCHEN)

/datum/venue/restaurant/prison
	name = "prison restaurant"
	req_access = ACCESS_KITCHEN

/obj/machinery/restaurant_portal/restaurant/prison
	linked_venue = /datum/venue/restaurant/prison

/obj/item/holosign_creator/robot_seat/restaurant/prisoner
	name = "prison restaurant seating indicator placer"
	holosign_type = /obj/structure/holosign/robot_seat/restaurant/prison

/obj/structure/holosign/robot_seat/restaurant/prison
	name = "restaurant seating"
	linked_venue = /datum/venue/restaurant/prison
