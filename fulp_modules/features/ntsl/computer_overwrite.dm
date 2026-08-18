/obj/machinery/computer/telecomms/monitor/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	if(mapload && is_station_level(z))
		//our computer here
		//set dir too
		return INITIALIZE_HINT_QDEL
