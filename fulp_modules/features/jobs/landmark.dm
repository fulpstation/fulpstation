/obj/effect/landmark/start/deputy
	name = "Deputy"
	icon_state = "Security Officer"

/// Departmental deputies and their spawn points
/obj/effect/landmark/start/deputy/engineering
	name = "Engineering Deputy"
	icon_state = "Security Officer"

/obj/effect/landmark/start/deputy/medical
	name = "Medical Deputy"
	icon_state = "Security Officer"

/obj/effect/landmark/start/deputy/science
	name = "Science Deputy"
	icon_state = "Security Officer"

/obj/effect/landmark/start/deputy/supply
	name = "Supply Deputy"
	icon_state = "Security Officer"

/obj/effect/landmark/start/depsec/engineering/Initialize()
	. = ..()
	var/turf/landmark_turf = get_turf(src)
	new /obj/effect/landmark/start/deputy/engineering(landmark_turf)

/obj/effect/landmark/start/depsec/medical/Initialize()
	. = ..()
	var/turf/landmark_turf = get_turf(src)
	new /obj/effect/landmark/start/deputy/medical(landmark_turf)

/obj/effect/landmark/start/depsec/science/Initialize()
	. = ..()
	var/turf/landmark_turf = get_turf(src)
	new /obj/effect/landmark/start/deputy/science(landmark_turf)

/obj/effect/landmark/start/depsec/supply/Initialize()
	. = ..()
	var/turf/landmark_turf = get_turf(src)
	new /obj/effect/landmark/start/deputy/supply(landmark_turf)
