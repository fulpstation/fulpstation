/obj/effect/landmark/start/brigdoc
	name = "Brig Physician"
	icon_state = "Medical Doctor"

/obj/effect/landmark/start/deputy
	name = "Deputy"
	icon_state = "Security Officer"

/obj/effect/landmark/start/security_officer/Initialize()
	. = ..()
	var/turf/T = get_turf(src)
	// They'll use the same spawns as Security Officers, but a different landmark.
	new /obj/effect/landmark/start/deputy(T)

/obj/effect/landmark/start/medical_doctor
	. = ..()
	var/turf/T = get_turf(src)
	// They'll use the same spawns as Medical Doctors, but a different landmark.
	new /obj/effect/landmark/start/brigdoc(T)
