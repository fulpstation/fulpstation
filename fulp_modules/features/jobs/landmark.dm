/obj/effect/landmark/start/network_admin
	name = JOB_NETWORK_ADMIN
	icon_state = JOB_NETWORK_ADMIN
	icon = 'fulp_modules/icons/jobs/landmarks.dmi'

//STATION ENGINEER OVERWRITE: If no Network Admin spawns exist, spawn over an Engineer's instead.
/obj/effect/landmark/start/station_engineer/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/landmark/start/station_engineer/LateInitialize()
	var/obj/effect/landmark/start/network_admin/admin_start = locate() in GLOB.start_landmarks_list
	if(!admin_start)
		admin_start = new(loc)
