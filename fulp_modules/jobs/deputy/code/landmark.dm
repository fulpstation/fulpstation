// THIS WAS PUT INTO landmark.dm IN BRIGDOC CODE

/*
/obj/effect/landmark/start/deputy
	name = "Deputy"
	icon_state = "Security Officer"

/obj/effect/landmark/start/security_officer/Initialize()
	. = ..()
	var/turf/T = get_turf(src)
	new /obj/effect/landmark/start/deputy(T) // They'll use the same spawns as Security Officers, but a different landmark.
*/

/*
I want this to eventually be used if possible, but I am not a mapper and do not have much experience in it.
	new /obj/effect/landmark/start/deputy/supply(T)
	new /obj/effect/landmark/start/deputy/engineering(T)
	new /obj/effect/landmark/start/deputy/medical(T)
	new /obj/effect/landmark/start/deputy/science(T)
*/
