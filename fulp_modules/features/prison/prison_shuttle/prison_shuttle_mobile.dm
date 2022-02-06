/obj/docking_port/mobile/prison
	name = "prison shuttle"
	id = "prisonshuttle"
	//Shouldn't take long, just time needed so it can nicely arrive at its destination.
	callTime = 10 SECONDS

	dir = WEST
	port_direction = EAST
	width = 12
	dwidth = 5
	height = 7
	movement_force = list("KNOCKDOWN" = 0, "THROW" = 0)

/obj/docking_port/mobile/prison/register()
	. = ..()
	SSshuttle.prison_shuttle = src

/obj/docking_port/mobile/prison/unregister()
	SSshuttle.prison_shuttle -= src
	return ..()

/area/shuttle/prison_shuttle
	name = "Prison Shuttle"
	area_flags = NOTELEPORT
