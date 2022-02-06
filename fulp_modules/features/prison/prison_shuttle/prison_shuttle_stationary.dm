/obj/docking_port/stationary/prison
	name = "Prison Shuttle Bay"
	id = "prison_xeno"
	hidden = TRUE
	width = 12
	height = 7
	dwidth = 5
	dir = EAST

/obj/docking_port/stationary/prison/register(replace)
	. = ..()
	SSshuttle.prison_stationary_shuttle = src

/obj/docking_port/stationary/prison/unregister()
	SSshuttle.prison_stationary_shuttle -= src
	return ..()
