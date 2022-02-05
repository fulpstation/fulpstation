/obj/structure/bed/double/Initialize(mapload)
	. = ..()
	var/turf/locker_turf = get_turf(src)
	var/obj/structure/bed/new_bed = new /obj/structure/bed(locker_turf)
	new_bed.balloon_alert_to_viewers("ERP is not allowed", vision_distance = 2)
	return INITIALIZE_HINT_QDEL
