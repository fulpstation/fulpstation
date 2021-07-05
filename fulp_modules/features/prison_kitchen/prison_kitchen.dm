// Prisoner Chef ID, put in Perma so prisoners can operate the prison restaurant venue, since they have 0 access to use as alternative.
/obj/item/card/id/advanced/prisoner/chef
	registered_name = "Chef Prisoner ID"
	name = "Chef Prisoner ID"
	desc = "A special ID card that allows prisoners to access the Prison's Kitchen supplies and Restaurant."
	trim = /datum/id_trim/prisoner/chef

/datum/id_trim/prisoner/chef
	trim_state = "trim_cook"
	access = list(ACCESS_KITCHEN)

// The Restaurant venue itself
/datum/venue/restaurant/prison
	name = "prison restaurant"
	req_access = ACCESS_KITCHEN
	venue_type = VENUE_RESTAURANT
	max_guests = 4
	customer_types = list(
		/datum/customer_data/warden = 50,
		/datum/customer_data/prisoner = 50,
//		/datum/customer_data/american = 20,
//		/datum/customer_data/italian = 20,
//		/datum/customer_data/french = 20,
//		/datum/customer_data/mexican = 20,
//		/datum/customer_data/japanese = 20,
//		/datum/customer_data/japanese/salaryman = 15,
//		/datum/customer_data/british/bobby = 15,
//		/datum/customer_data/british/gent = 15,
	)

/obj/machinery/restaurant_portal/restaurant/prison
	linked_venue = /datum/venue/restaurant/prison

// Holosign projector
/obj/item/holosign_creator/robot_seat/restaurant/prison
	name = "prison restaurant seating indicator placer"
	holosign_type = /obj/structure/holosign/robot_seat/restaurant/prison

/obj/structure/holosign/robot_seat/restaurant/prison
	name = "restaurant seating"
	linked_venue = /datum/venue/restaurant/prison

/*
 *	# Designs to print projector and portal machine
 *	These are all printable at the Security techfab.
 */
/datum/design/holosign/restaurant/prison
	name = "Prison Restaurant Seating Projector"
	desc = "A holographic projector that creates seating designation for prison restaurants."
	id = "holosignprisonrestaurant"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 2000, /datum/material/glass = 1000)
	build_path = /obj/item/holosign_creator/robot_seat/restaurant/prison
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/board/restaurant_portal/prison
	name = "Machine Design (Prison Restaurant Portal)"
	desc = "The circuit board for a restaurant portal"
	id = "prison_restaurant_portal"
	build_path = /obj/item/circuitboard/machine/restaurant_portal/prison
	category = list ("Misc. Machinery")

// Circuit board
/obj/item/circuitboard/machine/restaurant_portal/prison
	name = "Prison Restaurant Portal"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/restaurant_portal/restaurant/prison
	needs_anchored = TRUE
