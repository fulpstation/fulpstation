/// Preferences overwrites
/datum/preferences
	max_save_slots = 5
/* // Example of modular preferences, if we will ever need them.
	var/antag_tips = TRUE

/datum/preferences/save_preferences()
	. = ..()
	if(!.)
		return FALSE
	var/savefile/new_savefile = new /savefile(path)
	if(!new_savefile)
		return FALSE
	WRITE_FILE(new_savefile["antag_tips"], antag_tips)
	return TRUE

/datum/preferences/load_preferences()
	. = ..()
	if(!.)
		return FALSE
	var/savefile/new_savefile = new /savefile(path)
	if(!new_savefile)
		return FALSE
	READ_FILE(new_savefile["antag_tips"], antag_tips)
	antag_tips = sanitize_integer(antag_tips, FALSE, TRUE, initial(antag_tips))
	return TRUE
*/

/// Antag tip preferences
/datum/preference/toggle/antag_tips
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_identifier = PREFERENCE_PLAYER
	savefile_key = "antag_tips"
	default_value = TRUE
