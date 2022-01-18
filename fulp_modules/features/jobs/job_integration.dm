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

///Add Fulp jobs to the list of station jobs
/datum/controller/subsystem/job/setup_job_lists()
	. = ..()
	station_jobs += list(
		JOB_BRIG_PHYSICIAN,
		JOB_DEPUTY,
		JOB_DEPUTY_SUP,
		JOB_DEPUTY_ENG,
		JOB_DEPUTY_MED,
		JOB_DEPUTY_SCI,
		JOB_DEPUTY_SRV,
	)

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

// Add Fulp jobs to the Crew monitor, at their assigned position (/datum/crewmonitor/var/list/jobs)
/datum/crewmonitor/New()
	. = ..()
	jobs += list(
		JOB_BRIG_PHYSICIAN = 18,
		JOB_DEPUTY = 17,
		JOB_DEPUTY_SUP = 54,
		JOB_DEPUTY_ENG = 43,
		JOB_DEPUTY_MED = 25,
		JOB_DEPUTY_SCI = 34,
		JOB_DEPUTY_SRV = 72,
	)
