GLOBAL_LIST_INIT(mentor_verbs, list(
	/client/proc/cmd_mentor_say,
	/client/proc/cmd_mentor_pm_panel,
	/client/proc/mentor_unfollow,
	/client/proc/cmd_mentor_pm_context
	))
GLOBAL_PROTECT(mentor_verbs)

/client/proc/add_mentor_verbs()
	if(mentor_datum || holder) //Both mentors and admins will get those verbs.
		verbs += GLOB.mentor_verbs

/client/proc/remove_mentor_verbs()
	verbs -= GLOB.mentor_verbs
