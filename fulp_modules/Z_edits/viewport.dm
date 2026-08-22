#define FULP_WIDESCREEN_VIEWPORT_SIZE "23x15"

/datum/view_data/getScreenSize()
	if(chief.prefs.read_preference(/datum/preference/toggle/widescreen))
		return FULP_WIDESCREEN_VIEWPORT_SIZE
	return ..()

#undef FULP_WIDESCREEN_VIEWPORT_SIZE
