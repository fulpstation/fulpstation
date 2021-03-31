/client/verb/mentorwho()
	set category = "Contributor"
	set name = "Contributorwho"

	var/msg = "<b>Current Contributors:</b>\n"
	if(holder)
		for(var/client/C in GLOB.mentors)
			if(C.mentor_datum && !check_rights_for(C, R_ADMIN,0))
				msg += "\t[C] is a Contributor"
				if(isobserver(C.mob))
					msg += " - Observing"
				else if(isnewplayer(C.mob))
					msg += " - Lobby"
				else
					msg += " - Playing"

				if(C.is_afk())
					msg += " (AFK)"
				msg += "\n"
	else
		for(var/client/C in GLOB.mentors)
			if(C.is_afk())
				continue
			if(C.mentor_datum && !check_rights_for(C, R_ADMIN,0))
				msg += "\t[C] is a Contributor\n"
	to_chat(src, msg)
