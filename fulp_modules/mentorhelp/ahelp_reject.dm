/datum/admin_help/ClosureLinks(ref_src)
	. = ..()
	. += " (<A HREF='?_src_=holder;[HrefToken(TRUE)];ahelp=[ref_src];ahelp_action=mhelp'>MHELP</A>)"

/datum/admin_help/proc/MHelpThis(key_name = key_name_admin(usr))
	if(state != AHELP_ACTIVE)
		return

	if(initiator)
		initiator.giveadminhelpverb()

		SEND_SOUND(initiator, sound('sound/effects/adminhelp.ogg'))

		to_chat(initiator, "<font color='red' size='4'><b>- AdminHelp Rejected! -</b></font>")
		to_chat(initiator, "<font color='red'>This question may regard <b>game mechanics or how-tos</b>. Such questions should be asked with <b>Contributorhelp</b>.</font>")

	SSblackbox.record_feedback("tally", "ahelp_stats", 1, "mhelp this")
	var/msg = "Ticket [TicketHref("#[id]")] told to contributorhelp by [key_name]"
	message_admins(msg)
	log_admin_private(msg)
	AddInteraction("Told to contributorhelp by [key_name].")
	Close(silent = TRUE)
