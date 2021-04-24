/obj/effect/landmark/start/brigdoc
	name = "Brig Physician"
	icon_state = "Medical Doctor"

/obj/effect/landmark/start/deputy /// Hijacking this file for Deputies as well.
	name = "Deputy"
	icon_state = "Security Officer"

/obj/effect/landmark/start/security_officer/Initialize()
	. = ..()
	var/turf/T = get_turf(src)
	new /obj/effect/landmark/start/brigdoc(T) /// They'll use the same spawns as Security Officers, but a different landmark.
	new /obj/effect/landmark/start/deputy(T)
