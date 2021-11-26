/client/verb/mentorwho()
	set category = "Mentor"
	set name = "Mentorwho"

	var/msg = "<b>Current Mentors:</b>\n"
	if(holder)
		for(var/client/mentor_clients in GLOB.mentors)
			if(mentor_clients.mentor_datum)
				msg += "\t[mentor_clients] is a mentor"
				if(isobserver(mentor_clients.mob))
					msg += " - Observing"
				else if(isnewplayer(mentor_clients.mob))
					msg += " - Lobby"
				else
					msg += " - Playing"

				if(mentor_clients.is_afk())
					msg += " (AFK)"
				msg += "\n"
	else
		for(var/client/mentor_clients in GLOB.mentors)
			if(mentor_clients.is_afk())
				continue
			if(check_rights_for(mentor_clients, R_ADMIN,0))
				continue
			// Dont show deadmined folk
			if(GLOB.deadmins[ckey])
				continue
			if(mentor_clients.mentor_datum?.is_contributor)
				msg += "\t[mentor_clients] is a Contributor\n"
			else if(mentor_clients.mentor_datum)
				msg += "\t[mentor_clients] is a Mentor\n"

	to_chat(src, msg)
