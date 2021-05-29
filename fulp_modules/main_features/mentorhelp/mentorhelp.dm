/client/verb/mentorhelp(msg as text)
	set category = "Mentor"
	set name = "Mentorhelp"

	msg = sanitize(copytext(msg,1,MAX_MESSAGE_LEN))
	/// Cleans the input message
	if(!msg)
		return
	/// This shouldn't happen, but just in case.
	if(!mob)
		return

	var/mentor_msg = "<span class='mentornotice'><b><font color='purple'>MENTORHELP:</b> <b>[key_name_mentor(src, 1, 0)]</b>: [msg]</font></span>"
	log_mentor("MENTORHELP: [key_name_mentor(usr, 0, 0)]: [msg]")

	/// Send the Mhelp to all Mentors/Admins
	for(var/client/X in GLOB.mentors | GLOB.admins)
		X << 'sound/items/bikehorn.ogg'
		to_chat(X,
			type = MESSAGE_TYPE_MODCHAT,
			html = mentor_msg,
			confidential = TRUE)

	/// Also show it to person Mhelping
	to_chat(usr,
		type = MESSAGE_TYPE_MODCHAT,
		html = "<span class='mentornotice'><font color='purple'>PM to-<b>Mentors</b>: [msg]</font></span>",
		confidential = TRUE)

	return

/proc/key_name_mentor(whom, include_link = null, include_name = TRUE, include_follow = TRUE, char_name_only = TRUE)
	var/mob/M
	var/client/C
	var/key
	var/ckey

	if(!whom)
		return "*null*"

	if(istype(whom, /client))
		C = whom
		M = C.mob
		key = C.key
		ckey = C.ckey
	else if(ismob(whom))
		M = whom
		C = M.client
		key = M.key
		ckey = M.ckey
	else if(istext(whom))
		key = whom
		ckey = ckey(whom)
		C = GLOB.directory[ckey]
		if(C)
			M = C.mob
	else
		return "*invalid*"

	. = ""

	if(!ckey)
		include_link = 0

	if(key)
		if(include_link)
			. += "<a href='?_src_=mentor;mentor_msg=[ckey];[MentorHrefToken(TRUE)]'>"

		if(C && C.holder && C.holder.fakekey)
			. += "Administrator"
		else
			. += key
		if(!C)
			. += "\[DC\]"

		if(include_link)
			. += "</a>"
	else
		. += "*no key*"

	if(include_follow)
		. += " (<a href='?_src_=mentor;mentor_follow=[REF(M)];[MentorHrefToken(TRUE)]'>F</a>)"

	return .
