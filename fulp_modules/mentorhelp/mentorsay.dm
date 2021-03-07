/client/proc/cmd_mentor_say(msg as text)
	set category = "Mentor"
	set name = "Mentorsay"

	if(!is_mentor())
		to_chat(src, "<span class='danger'>Error: Only mentors and administrators may use this command.</span>", confidential = TRUE)
		return

	msg = emoji_parse(copytext(sanitize(msg), 1, MAX_MESSAGE_LEN))
	if(!msg)
		return

	log_mentor("MSAY: [key_name(src)] : [msg]")
	msg = keywords_lookup(msg)
	if(check_rights_for(src, R_ADMIN,0))
		msg = "<b><font color = #8A2BE2><span class='prefix'>MENTOR:</span> <EM>[key_name(src, 0, 0)]</EM>: <span class='message'>[msg]</span></font></b>"
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

/// Gives Mentors/Admins the MSAY verb
GLOBAL_LIST_INIT(mentor_verbs, list(
	/client/proc/cmd_mentor_say
	))
GLOBAL_PROTECT(mentor_verbs)

/client/proc/add_mentor_verbs()
	if(mentor_datum || holder) //Both mentors and admins will get those verbs.
		add_verb(src, GLOB.mentor_verbs)

/client/proc/remove_mentor_verbs()
	remove_verb(src, GLOB.mentor_verbs)
