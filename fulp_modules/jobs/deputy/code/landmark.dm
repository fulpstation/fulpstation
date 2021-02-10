// Shamelessly stealing this from Brig Doctor until we can get a permanent solution without the need to edit TG files.
/*
/obj/effect/landmark/start/deputy
	name = "Deputy"
	icon_state = "Security Officer"

/obj/effect/landmark/start/security_officer/Initialize()
	. = ..()
	var/turf/T = get_turf(src)
	new /obj/effect/landmark/start/deputy(T) // They'll use the same spawns as Security Officers, but a different landmark.
*/
