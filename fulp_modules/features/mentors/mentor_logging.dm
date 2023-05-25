#define LOG_CATEGORY_MENTOR "mentor"

/proc/log_mentor(text, list/data)
	GLOB.mentorlog.Add(text)
	logger.Log(LOG_CATEGORY_MENTOR, text, data)
	logger.Log(LOG_CATEGORY_COMPAT_GAME, "MENTOR: [text]")
