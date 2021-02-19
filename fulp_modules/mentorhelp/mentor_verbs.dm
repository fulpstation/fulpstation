GLOBAL_LIST_INIT(mentor_verbs, list(
	/client/proc/cmd_mentor_say // Add /client/proc/cmd_mentor_pm_panel + /client/proc/cmd_mentor_pm_context for MentorPM
	))
GLOBAL_PROTECT(mentor_verbs)

/client/proc/add_mentor_verbs()
	if(mentor_datum || holder) //Both mentors and admins will get those verbs.
		remove_verb(src, GLOB.mentor_verbs)

/client/proc/remove_mentor_verbs()
	add_verb(src, GLOB.mentor_verbs)
