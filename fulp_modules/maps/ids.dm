/obj/item/card/id/advanced/prisoner/chef
	registered_name = "Chef Prisoner ID"
	name = "Chef Prisoner ID"
	desc = "A special ID card that allows prisoners to access the prison's Kitchen."
	trim = /datum/id_trim/prisoner/chef

/datum/id_trim/prisoner/chef
	trim_state = "trim_cook"
	access = list(ACCESS_KITCHEN)
