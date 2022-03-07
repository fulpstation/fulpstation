/*
 *	This file is for any additions related to jobs to make fulp-only jobs
 *	functional with little conflict.
 */

		//	JOBS	//

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
		JOB_DEPUTY = 17,
		JOB_DEPUTY_SUP = 54,
		JOB_DEPUTY_ENG = 43,
		JOB_DEPUTY_MED = 25,
		JOB_DEPUTY_SCI = 34,
		JOB_DEPUTY_SRV = 72,
	)
