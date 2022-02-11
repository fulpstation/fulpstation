/datum/preference/toggle/fast_mc_refresh
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "fast_mc_refresh"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = FALSE

/datum/preference/toggle/fast_mc_refresh/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return is_admin(preferences.parent)
