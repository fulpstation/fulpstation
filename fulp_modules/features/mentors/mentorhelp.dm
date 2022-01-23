/client/verb/mentorhelp(msg as text)
	set category = "Mentor"
	set name = "Mentorhelp"

	if(usr?.client?.prefs.muted & MUTE_ADMINHELP)
		to_chat(src,
			type = MESSAGE_TYPE_MODCHAT,
			html = "<span class='danger'>Error: MentorPM: You are muted from Mentorhelps. (muted).</span>",
			confidential = TRUE)
		return
	/// Cleans the input message
	if(!msg)
		return
	/// This shouldn't happen, but just in case.
	if(!mob)
		return

	msg = sanitize(copytext(msg,1,MAX_MESSAGE_LEN))
	var/mentor_msg = "<font color='purple'><span class='mentornotice'><b>MENTORHELP:</b> <b>[key_name_mentor(src, TRUE, FALSE)]</b>: </span><span class='message linkify'>[msg]</span></font>"
	log_mentor("MENTORHELP: [key_name_mentor(src, null, FALSE, FALSE)]: [msg]")

	/// Send the Mhelp to all Mentors/Admins
	for(var/client/honked_clients in GLOB.mentors | GLOB.admins)
		honked_clients << 'sound/items/bikehorn.ogg'
		to_chat(honked_clients,
			type = MESSAGE_TYPE_MODCHAT,
			html = mentor_msg,
			confidential = TRUE)

	/// Also show it to person Mhelping
	to_chat(usr,
		type = MESSAGE_TYPE_MODCHAT,
		html = "<font color='purple'><span class='mentornotice'>PM to-<b>Mentors</b>:</span> <span class='message linkify'>[msg]</span></font>",
		confidential = TRUE)

	return

/proc/key_name_mentor(whom, include_link = null, include_name = TRUE, include_follow = TRUE, char_name_only = TRUE)
	var/mob/user
	var/client/chosen_client
	var/key
	var/ckey

	if(!whom)
		return "*null*"

	if(istype(whom, /client))
		chosen_client = whom
		user = chosen_client.mob
		key = chosen_client.key
		ckey = chosen_client.ckey
	else if(ismob(whom))
		user = whom
		chosen_client = user.client
		key = user.key
		ckey = user.ckey
	else if(istext(whom))
		key = whom
		ckey = ckey(whom)
		chosen_client = GLOB.directory[ckey]
		if(chosen_client)
			user = chosen_client.mob
	else
		return "*invalid*"

	. = ""

	if(!ckey)
		include_link = null

	if(key)
		if(include_link != null)
			. += "<a href='?_src_=mentor;mentor_msg=[ckey];[MentorHrefToken(TRUE)]'>"

		if(chosen_client && chosen_client.holder && chosen_client.holder.fakekey)
			. += "Administrator"
		else
			. += key
		if(!chosen_client)
			. += "\[DC\]"

		if(include_link != null)
			. += "</a>"
	else
		. += "*no key*"

	if(include_follow)
		. += " (<a href='?_src_=mentor;mentor_follow=[REF(user)];[MentorHrefToken(TRUE)]'>F</a>)"

	return .
