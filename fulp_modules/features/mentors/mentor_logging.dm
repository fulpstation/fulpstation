#define LOG_CATEGORY_MENTOR "mentor"

/proc/log_mentor(text, list/data)
	GLOB.mentorlog.Add(text)
	logger.Log(LOG_CATEGORY_MENTOR, text, data)
	logger.Log(LOG_CATEGORY_COMPAT_GAME, "MENTOR: [text]")

/datum/log_category/mentorhelp
	category = LOG_CATEGORY_MENTOR
	master_category = /datum/log_category/admin
	config_flag = /datum/config_entry/flag/log_admin
