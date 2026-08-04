/datum/tgui_say/delegate_speech(entry, channel)
	. = ..()
	if(.)
		return .
	switch(channel)
		if(MENTOR_CHANNEL)
			client.cmd_mentor_say(entry)
			return TRUE
	return .
