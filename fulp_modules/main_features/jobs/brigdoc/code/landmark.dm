/obj/effect/landmark/start/brigdoc
	name = "Brig Physician"
	icon_state = "Medical Doctor"

/obj/effect/landmark/start/medical_doctor/Initialize()
	. = ..()
	var/turf/T = get_turf(src)
	// They'll use the same spawns as Medical Doctors, but a different landmark.
	new /obj/effect/landmark/start/brigdoc(T)
