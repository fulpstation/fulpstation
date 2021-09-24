/*
 *	This file is for any additions related to jobs to make fulp-only jobs
 *	functional with little conflict.
 */

		//	JOBS	//

/datum/job/fulp
	var/fulp_spawn = null //give it a room's type path to spawn there

/datum/job/fulp/after_spawn(mob/living/H, mob/M, latejoin)
	. = ..()
	if(!latejoin && fulp_spawn)
		var/turf/T = get_fulp_spawn(fulp_spawn)
		H.Move(T)

/proc/get_fulp_spawn(area/room) // Reworked to find any empty tile
	for(var/turf/T in shuffle(get_area_turfs(room)))
		if(!T.is_blocked_turf(TRUE))
			return T

// Add Fulp jobs to the list of station jobs
/datum/controller/subsystem/job/setup_job_lists()
	. = ..()
	station_jobs += list(
		"Brig Physician",
		"Deputy",
		"Supply Deputy",
		"Engineering Deputy",
		"Medical Deputy",
		"Science Deputy",
		"Service Deputy",
	)

// Add Fulp jobs to the Crew monitor, at their assigned position (/datum/crewmonitor/var/list/jobs)
/datum/crewmonitor/New()
	. = ..()
	jobs += list(
		"Brig Physician" = 18,
		"Deputy" = 17,
		"Supply Deputy" = 54,
		"Engineering Deputy" = 43,
		"Medical Deputy" = 25,
		"Science Deputy" = 34,
		"Service Deputy" = 72,
	)
