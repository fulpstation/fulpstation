/*
/obj/effect/turf_decal
	icon = sign.fulplogo ? 'fulp_modules/edits/fulp_logo/decals.dmi' : 'icons/turf/decals.dmi'
	icon_state = "warningline"
	layer = TURF_DECAL_LAYER

/obj/effect/turf_decal/Initialize()
	..()
	return INITIALIZE_HINT_QDEL

/obj/effect/turf_decal/ComponentInitialize()
	. = ..()
	var/turf/T = loc
	if(!istype(T)) //you know this will happen somehow
		CRASH("Turf decal initialized in an object/nullspace")
	T.AddElement(/datum/element/decal, icon, icon_state, dir, FALSE, color, null, null, alpha)
*/

/obj/effect/turf_decal/Initialize(mapload)
	. = ..()
	if(icon_state = list(
		"L1",
		"L2",
		"L3",
		"L4",
		"L5",
		"L6",
		"L7",
		"L8",
		"L9",
		"L10",
		"L11",
		"L12",
		))
		icon = 'fulp_modules/edits/fulp_logo/decals.dmi'
