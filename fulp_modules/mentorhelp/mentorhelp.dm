/client/var/mhelptimer = 0 // Timer for returning the Mhelp verb

/client/verb/mentorhelp(msg as text)
	set category = "Contributor"
	set name = "Contributorhelp"

	// Cleans the input message
	if(!msg)
		return

	remove_verb(usr.client, /client/verb/mentorhelp) // 30 second cool-down for mentorhelp
	usr.client.mhelptimer = addtimer(CALLBACK(usr.client, /client/proc/givemhelpverb), 300, TIMER_STOPPABLE)

	if(usr.client)
		if(usr.client.prefs.muted & MUTE_MENTORHELP)
			to_chat(src,
				type = MESSAGE_TYPE_MODCHAT,
				html = "<span class='danger'>Error: ContributorPM: You are muted from Contributorhelps. (muted).</span>",
				confidential = TRUE)
			return

	msg = sanitize(copytext(msg,1,MAX_MESSAGE_LEN))
	if(!msg)
		return
	if(!mob)
		return // This doesn't happen

	var/mentor_msg = "<span class='mentornotice'><b><font color='purple'>CONTRIBUTORHELP:</b> <b>[key_name_mentor(src, 1, 0)]</b>: [msg]</font></span>"
	log_mentor("CONTRIBUTORHELP: [key_name_mentor(src, 0, 0)]: [msg]")

	// Send the Mhelp to all Mentors/Admins
	for(var/client/X in GLOB.mentors | GLOB.admins)
		X << 'sound/items/bikehorn.ogg'
		to_chat(X,
			type = MESSAGE_TYPE_MODCHAT,
			html = mentor_msg,
			confidential = TRUE)

	// Also show it to person Mhelping
	to_chat(usr,
		type = MESSAGE_TYPE_MODCHAT,
		html = "<span class='mentornotice'><font color='purple'>PM to-<b>Contributors</b>: [msg]</font></span>",
		confidential = TRUE)

	return

/proc/get_mentor_counts()
	. = list("total" = 0, "afk" = 0, "present" = 0)
	for(var/X in GLOB.mentors)
		var/client/C = X
		.["total"]++
		if(C.is_afk())
			.["afk"]++
		else
			.["present"]++

/proc/key_name_mentor(whom, include_link = null, include_name = TRUE, include_follow = TRUE, char_name_only = TRUE)
	var/mob/M
	var/client/C
	var/key
	var/ckey

	if(!whom)	return "*null*"
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

/// Used for the 30 second Mhelp cooldown timer
/client/proc/givemhelpverb()
	add_verb(src, /client/verb/mentorhelp)
	deltimer(mhelptimer)
	mhelptimer = 0
