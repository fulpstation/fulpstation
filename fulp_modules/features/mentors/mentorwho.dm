/client/verb/mentorwho()
	set category = "Mentor"
	set name = "Mentorwho"

	var/msg = "<b>Current Mentors:</b>\n"
	//Admin version
	if(holder)
		for(var/client/mentor_clients in GLOB.mentors)
			msg += "\t[mentor_clients] is a [mentor_clients.holder && mentor_clients.holder.deadmined ? "Deadmin" : "Mentor"]"

			if(isobserver(mentor_clients.mob))
				msg += " - Observing"
			else if(isnewplayer(mentor_clients.mob))
				msg += " - Lobby"
			else
				msg += " - Playing"

			if(mentor_clients.is_afk())
				msg += " (AFK)"

			msg += "\n"

	//Regular version
	else
		for(var/client/mentor_clients in GLOB.mentors)
			if(mentor_clients.is_afk())
				continue
			if(mentor_clients.holder && mentor_clients.holder.deadmined)
				continue

			if(mentor_clients.mentor_datum.is_contributor)
				msg += "\t[mentor_clients] is a Contributor\n"
			else
				msg += "\t[mentor_clients] is a Mentor\n"

	to_chat(src, msg)
