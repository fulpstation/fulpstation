///Engineering
/obj/structure/closet/secure_closet/security/engine/Initialize(mapload)
	. = ..()
	for(var/atom/movable/all_contents in contents)
		qdel(all_contents)
	var/turf/locker_turf = get_turf(src)
	new /obj/structure/closet/secure_closet/deputy/engineering(locker_turf)
	return INITIALIZE_HINT_QDEL

///Medical
/obj/structure/closet/secure_closet/security/med/Initialize(mapload)
	. = ..()
	for(var/atom/movable/all_contents in contents)
		qdel(all_contents)
	var/turf/locker_turf = get_turf(src)
	new /obj/structure/closet/secure_closet/deputy/medical(locker_turf)
	return INITIALIZE_HINT_QDEL

///Science
/obj/structure/closet/secure_closet/security/science/Initialize(mapload)
	. = ..()
	for(var/atom/movable/all_contents in contents)
		qdel(all_contents)
	var/turf/locker_turf = get_turf(src)
	new /obj/structure/closet/secure_closet/deputy/science(locker_turf)
	return INITIALIZE_HINT_QDEL

///Supply
/obj/structure/closet/secure_closet/security/cargo/Initialize(mapload)
	. = ..()
	for(var/atom/movable/all_contents in contents)
		qdel(all_contents)
	var/turf/locker_turf = get_turf(src)
	new /obj/structure/closet/secure_closet/deputy/supply(locker_turf)
	return INITIALIZE_HINT_QDEL
