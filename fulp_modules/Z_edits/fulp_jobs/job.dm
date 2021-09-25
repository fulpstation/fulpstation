/// We're overwriting TG's Chain of Command with our own via /New()
/datum/controller/subsystem/job/New()
	. = ..()
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
