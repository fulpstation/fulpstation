///Adding our own chain of command over TG's.
/datum/controller/subsystem/job
	chain_of_command = list(
		JOB_CAPTAIN = 1,
		JOB_HEAD_OF_PERSONNEL = 2,
		JOB_HEAD_OF_SECURITY = 3,
		JOB_RESEARCH_DIRECTOR = 4,
		JOB_CHIEF_MEDICAL_OFFICER = 5,
		JOB_CHIEF_ENGINEER = 6,
		JOB_QUARTERMASTER = 7,
		JOB_WARDEN = 8,
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
