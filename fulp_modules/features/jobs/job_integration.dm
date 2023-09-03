/// We're overwriting TG's Chain of Command with our own via /New()
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
