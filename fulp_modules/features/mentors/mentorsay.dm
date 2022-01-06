/client/proc/cmd_mentor_say(msg as text)
	set category = "Mentor"
	set name = "Mentorsay"

	if(!is_mentor())
		to_chat(src, span_danger("Error: Only mentors and administrators may use this command."), confidential = TRUE)
		return

	msg = emoji_parse(copytext(sanitize(msg), 1, MAX_MESSAGE_LEN))
	if(!msg)
		return

	var/list/pinged_mentor_clients = check_mentor_pings(msg)
	if(length(pinged_mentor_clients) && pinged_mentor_clients[ADMINSAY_PING_UNDERLINE_NAME_INDEX])
		msg = pinged_mentor_clients[ADMINSAY_PING_UNDERLINE_NAME_INDEX]
		pinged_mentor_clients -= ADMINSAY_PING_UNDERLINE_NAME_INDEX

	for(var/iter_ckey in pinged_mentor_clients)
		var/client/iter_mentor_client = pinged_mentor_clients[iter_ckey]
		if(!iter_mentor_client?.holder)
			continue
		window_flash(iter_mentor_client)
		SEND_SOUND(iter_mentor_client.mob, sound('sound/misc/bloop.ogg'))

	log_mentor("MSAY: [key_name(src)] : [msg]")
	msg = keywords_lookup(msg)
	if(src.key == "[CONFIG_GET(string/headofpseudostaff)]")
		msg = "<b><font color = #A097FE><span class='prefix'>HOP:</span> <EM>[key_name(src, 0, 0)]</EM>: <span class='message'>[msg]</span></font></b>"
	else if(mentor_datum?.is_contributor)
		msg = "<b><font color = #16abf9><span class='prefix'>CONTRIB:</span> <EM>[key_name(src, 0, 0)]</EM>: <span class='message'>[msg]</span></font></b>"
	else if(check_rights_for(src, R_ADMIN, 0))
		msg = "<b><font color = #8A2BE2><span class='prefix'>STAFF:</span> <EM>[key_name(src, 0, 0)]</EM>: <span class='message'>[msg]</span></font></b>"
	else
		msg = "<b><font color = #E236D8><span class='prefix'>MENTOR:</span> <EM>[key_name(src, 0, 0)]</EM>: <span class='message'>[msg]</span></font></b>"
	to_chat(GLOB.admins | GLOB.mentors,
		type = MESSAGE_TYPE_MODCHAT,
		html = msg,
		confidential = TRUE)

	SSblackbox.record_feedback("tally", "mentor_verb", 1, "Msay") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/get_mentor_say()
	var/msg = input(src, null, "msay \"text\"") as text|null
	cmd_mentor_say(msg)

/proc/check_mentor_pings(msg) /// see /proc/check_admin_pings(msg) we just check for mentor_datum instead of holder
	var/list/msglist = splittext(msg, " ")
	var/list/mentors_to_ping = list()

	var/i = 0
	for(var/word in msglist)
		i++
		if(!length(word))
			continue
		if(word[1] != "@")
			continue
		var/ckey_check = lowertext(copytext(word, 2))
		var/client/client_check = GLOB.directory[ckey_check]
		if(client_check?.mentor_datum)
			msglist[i] = "<u>[word]</u>"
			mentors_to_ping[ckey_check] = client_check

	if(length(mentors_to_ping))
		mentors_to_ping[ADMINSAY_PING_UNDERLINE_NAME_INDEX] = jointext(msglist, " ")
		return mentors_to_ping

/// Gives Mentors/Admins the MSAY verb
/client/proc/add_mentor_verbs()
	///Both mentors and admins will get those verbs.
	if(mentor_datum || holder)
		add_verb(src, GLOB.mentor_verbs)

/client/proc/remove_mentor_verbs()
	remove_verb(src, GLOB.mentor_verbs)
