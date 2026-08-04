//Include mentors in the list of players.
/datum/escape_menu/send_init()
	. = ..()
	send_update(list(
		"isMentor" = !!client.mentor_datum,
		"mentors" = build_mentor_list(),
	))

/datum/escape_menu/proc/build_mentor_list()
	var/list/result = list()
	for(var/client/mentor as anything in GLOB.mentors - GLOB.admins)
		result += list(list(
			"ckey" = mentor.ckey,
			"displayName" = mentor.ckey,
			"ping" = round(mentor.avgping, 1),
			"ignored" = (mentor.ckey in client?.prefs?.ignoring),
			"isSelf" = (mentor.ckey == client?.ckey),
		))
	return result

//We're overwriting parent to also remove mentors from the player list. Keep this otherwise 1:1 with parent please.
/datum/escape_menu/build_player_list()
	var/list/result = list()
	for(var/client/player as anything in GLOB.clients - GLOB.admins - GLOB.mentors)
		result += list(list(
			"ckey" = player.ckey,
			"displayName" = player.ckey,
			"ping" = round(player.avgping, 1),
			"ignored" = (player.ckey in client?.prefs?.ignoring),
			"isSelf" = (player.ckey == client?.ckey),
		))
	return result
