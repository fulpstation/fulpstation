///Supply
/obj/structure/closet/secure_closet/security/cargo/Initialize(mapload)
	. = ..()
	for(var/atom/movable/A in contents)
		qdel(A)
	var/turf/T = get_turf(src)
	new /obj/structure/table(T)
	new /obj/item/book/manual/wiki/security_space_law(T)
	return INITIALIZE_HINT_QDEL

///Engineering
/obj/structure/closet/secure_closet/security/engine/Initialize(mapload)
	. = ..()
	for(var/atom/movable/A in contents)
		qdel(A)
	var/turf/T = get_turf(src)
	new /obj/structure/table(T)
	new /obj/item/book/manual/wiki/security_space_law(T)
	return INITIALIZE_HINT_QDEL

///Science
/obj/structure/closet/secure_closet/security/science/Initialize(mapload)
	. = ..()
	for(var/atom/movable/A in contents)
		qdel(A)
	var/turf/T = get_turf(src)
	new /obj/structure/table(T)
	new /obj/item/book/manual/wiki/security_space_law(T)
	return INITIALIZE_HINT_QDEL

///Medical
/obj/structure/closet/secure_closet/security/med/Initialize(mapload)
	. = ..()
	for(var/atom/movable/A in contents)
		qdel(A)
	var/turf/T = get_turf(src)
	new /obj/structure/table(T)
	new /obj/item/book/manual/wiki/security_space_law(T)
	return INITIALIZE_HINT_QDEL
