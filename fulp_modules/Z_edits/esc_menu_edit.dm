/atom/movable/screen/escape_menu/text/clickable/mentorhelp/enabled()
	. = ..()
	if (!.)
		return FALSE

	return !(escape_menu.client?.prefs.muted & MUTE_ADMINHELP)

/datum/escape_menu/proc/home_open_mentorhelp()
	INVOKE_ASYNC(client, TYPE_PROC_REF(/client, get_mentor_help))
	qdel(src)
