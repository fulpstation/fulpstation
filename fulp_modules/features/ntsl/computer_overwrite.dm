/obj/machinery/computer/telecomms/monitor/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	if(mapload && is_station_level(z))
		var/obj/machinery/computer/telecomms/traffic/new_computer = new /obj/machinery/computer/telecomms/traffic(loc)
		new_computer.setDir(dir)
		return INITIALIZE_HINT_QDEL
