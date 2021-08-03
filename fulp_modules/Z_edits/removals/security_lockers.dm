/obj/structure/closet/secure_closet/security/cargo/Initialize(mapload)
	. = ..()
	var/turf/T = get_turf(src)
	new /obj/structure/table(T)
	new /obj/item/book/manual/wiki/security_space_law(T)
	return INITIALIZE_HINT_QDEL

/obj/structure/closet/secure_closet/security/engine/Initialize(mapload)
	. = ..()
	var/turf/T = get_turf(src)
	new /obj/structure/table(T)
	new /obj/item/book/manual/wiki/security_space_law(T)
	return INITIALIZE_HINT_QDEL

/obj/structure/closet/secure_closet/security/science/Initialize(mapload)
	. = ..()
	var/turf/T = get_turf(src)
	new /obj/structure/table(T)
	new /obj/item/book/manual/wiki/security_space_law(T)
	return INITIALIZE_HINT_QDEL

/obj/structure/closet/secure_closet/security/med/Initialize(mapload)
	. = ..()
	var/turf/T = get_turf(src)
	new /obj/structure/table(T)
	new /obj/item/book/manual/wiki/security_space_law(T)
	return INITIALIZE_HINT_QDEL
