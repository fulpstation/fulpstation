//shows a list of clients we could send PMs to, then forwards our choice to cmd_Mentor_pm
/client/proc/cmd_mentor_pm_panel()
	set category = "Contributor"
	set name = "Contributor PM"
	if(!is_mentor())
		to_chat(src, "<font color='red'>Error: Mentor-PM-Panel: Only Mentors and Admins may use this command.</font>")
		return
	var/list/client/targets[0]
	for(var/client/T)
		targets["[T]"] = T

	var/list/sorted = sortList(targets)
	var/target = input(src,"To whom shall we send a message?","Contributor PM",null) in sorted|null
	cmd_mentor_pm(targets[target],null)
	SSblackbox.record_feedback("tally", "Mentor_verb", 1, "MentorPM") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/// Takes input from cmd_Mentor_pm_panel or /client/Topic and sends them a PM, fetching messages if needed. src is the sender and C is the target client
/client/proc/cmd_mentor_pm(whom, msg)
	var/client/C
	if(ismob(whom))
		var/mob/M = whom
		C = M.client
	else if(istext(whom))
		C = GLOB.directory[whom]
	else if(istype(whom,/client))
		C = whom
	if(!C)
		if(is_mentor())
			to_chat(src,
				type = MESSAGE_TYPE_MODCHAT,
				html = "<font color='red'>Error: Mentor-PM: Client not found.</font>",
				confidential = TRUE)
		else
			mentorhelp(msg)	// Mentor we are replying to left. Mentorhelp instead(check below)
		return

	// Get message text, limit it's length.and clean/escape html
	if(!msg)
		msg = input(src,"Message:", "Private message") as text|null

		if(!msg)
			return

		if(!C)
			if(is_mentor())
				to_chat(src,
					type = MESSAGE_TYPE_MODCHAT,
					html = "<font color='red'>Error: Mentor-PM: Client not found.</font>",
					confidential = TRUE)
			else // Mentor we are replying to has vanished, Mentorhelp instead
				mentorhelp(msg)
				return

		if(!C.is_mentor() && !is_mentor()) // Neither party is a mentor, they shouldn't be PMing!
			return

	msg = sanitize(copytext(msg,1,MAX_MESSAGE_LEN))
	if(!msg)	return

	log_mentor("Contributor PM: [key_name(src)]->[key_name(C)]: [msg]")

	msg = emoji_parse(msg)
	C << 'sound/items/bikehorn.ogg'
	if(C.is_mentor())
		if(is_mentor()) // Both are Mentors
			to_chat(C,
				type = MESSAGE_TYPE_MODCHAT,
				html = "<font color='purple'>Contributor PM from-<b>[key_name_mentor(src, C, 1, 0)]</b>: [msg]</font>",
				confidential = TRUE)
			to_chat(src,
				type = MESSAGE_TYPE_MODCHAT,
				html = "<font color='green'>Contributor PM to-<b>[key_name_mentor(C, C, 1, 0)]</b>: [msg]</font>",
				confidential = TRUE)
		else // Sender is a Non-Mentor
			to_chat(C,
				type = MESSAGE_TYPE_MODCHAT,
				html = "<font color='purple'>Reply PM from-<b>[key_name_mentor(src, C, 1, 0)]</b>: [msg]</font>",
				confidential = TRUE)
			to_chat(src,
				type = MESSAGE_TYPE_MODCHAT,
				html = "<font color='green'>Contributor PM to-<b>[key_name_mentor(C, C, 1, 0)]</b>: [msg]</font>",
				confidential = TRUE)
	else // Reciever is a Non-Mentor
		if(is_mentor())
			// Left unsorted so people dont Mhelp with Mod chat off, you signed up for this!
			to_chat(C, "<font color='purple'>Contributor PM from-<b>[key_name_mentor(src, C, 1, 0, 0)]</b>: [msg]</font>")
			to_chat(src,
				type = MESSAGE_TYPE_MODCHAT,
				html = "<font color='green'>Contributor PM to-<b>[key_name_mentor(C, C, 1, 0)]</b>: [msg]</font>",
				confidential = TRUE)

	// We don't use message_Mentors here because the sender/receiver might get it too
	for(var/client/X in GLOB.mentors | GLOB.admins)
		if(X.key!=key && X.key!=C.key) // Check client/X is an Mentor and isn't the Sender/Recipient
			to_chat(X,
				type = MESSAGE_TYPE_MODCHAT,
				html = "<B><font color='green'>Contributor PM: [key_name_mentor(src, X, 0, 0)]-&gt;[key_name_mentor(C, X, 0, 0)]:</B> <font color = #5c00e6> [msg]</font>",
				confidential = TRUE)
