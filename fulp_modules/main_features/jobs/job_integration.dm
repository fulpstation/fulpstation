/*
 *	This file is for any additions related to jobs to make fulp-only jobs
 *	functional with little conflict.
 */

		//	JOBS	//

/datum/job/fulp
	var/fulp_spawn = null //give it a room's type path to spawn there

/datum/job/fulp/after_spawn(mob/living/user, mob/player, latejoin)
	. = ..()
	if(!latejoin && fulp_spawn)
		var/turf/spawn_turf = get_fulp_spawn(fulp_spawn)
		user.Move(spawn_turf)

/proc/get_fulp_spawn(area/room) // Reworked to find any empty tile
	for(var/turf/spawn_turf in shuffle(get_area_turfs(room)))
		if(!spawn_turf.is_blocked_turf(TRUE))
			return spawn_turf

/// We're overwriting TG's Chain of Command with our own via /New()
/datum/controller/subsystem/job
	chain_of_command = list(
		"Captain" = 1,
		"Head of Personnel" = 2,
		"Head of Security" = 3,
		"Research Director" = 4,
		"Chief Medical Officer" = 5,
		"Chief Engineer" = 6,
		"Quartermaster" = 7,
		"Warden" = 8,
	)


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
