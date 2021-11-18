// Cryopod Console
/obj/machinery/computer/cryopod/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_QDEL

// Cryopods themselves, replaced with punching bags.
/obj/machinery/cryopod/Initialize(mapload)
	. = ..()
	var/turf/cryopod_turf = get_turf(src)
	new /obj/structure/punching_bag(cryopod_turf)
	return INITIALIZE_HINT_QDEL

// TODO: Delete this when we remove cryopods.
