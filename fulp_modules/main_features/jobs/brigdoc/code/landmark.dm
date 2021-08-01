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

/obj/effect/landmark/start/medical_doctor/Initialize()
	. = ..()
	var/turf/T = get_turf(src)
	// They'll use the same spawns as Medical Doctors, but a different landmark.
	new /obj/effect/landmark/start/brigdoc(T)

/// Departmental deputies and their spawn points
/obj/effect/landmark/start/deputy/engineering
	name = "Deputy (Engineering)"
	icon_state = "Security Officer"
/obj/effect/landmark/start/deputy/medical
	name = "Deputy (Medical)"
	icon_state = "Security Officer"
/obj/effect/landmark/start/deputy/science
	name = "Deputy (Science)"
	icon_state = "Security Officer"
/obj/effect/landmark/start/deputy/supply
	name = "Deputy (Supply)"
	icon_state = "Security Officer"

/obj/effect/landmark/start/depsec/engineering/Initialize()
	. = ..()
	var/turf/T = get_turf(src)
	new /obj/effect/landmark/start/deputy/engineering(T)
/obj/effect/landmark/start/depsec/medical/Initialize()
	. = ..()
	var/turf/T = get_turf(src)
	new /obj/effect/landmark/start/deputy/medical(T)
/obj/effect/landmark/start/depsec/science/Initialize()
	. = ..()
	var/turf/T = get_turf(src)
	new /obj/effect/landmark/start/deputy/science(T)
/obj/effect/landmark/start/depsec/supply/Initialize()
	. = ..()
	var/turf/T = get_turf(src)
	new /obj/effect/landmark/start/deputy/supply(T)
