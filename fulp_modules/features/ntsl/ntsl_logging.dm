#define LOG_CATEGORY_NTSL "ntsl"

/proc/log_ntsl(text, list/data)
	logger.Log(LOG_CATEGORY_NTSL, text, data)

/datum/log_category/ntsl
	category = LOG_CATEGORY_NTSL
	config_flag = /datum/config_entry/flag/log_ntsl

/datum/config_entry/flag/log_ntsl

#undef LOG_CATEGORY_NTSL
