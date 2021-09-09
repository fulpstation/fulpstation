// Cryopod Console
/obj/machinery/computer/cryopod/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_QDEL

// Cryopods themselves, replaced with punching bags.
/obj/machinery/cryopod/Initialize(mapload)
	. = ..()
	var/turf/T = get_turf(src)
	new /obj/structure/punching_bag(T)
	return INITIALIZE_HINT_QDEL
