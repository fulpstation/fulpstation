/client/New()
	. = ..()
	mentor_datum_set()

/client/proc/mentor_client_procs(href_list)
	if(href_list["mentor_msg"])
		cmd_mentor_pm(href_list["mentor_msg"],null)
		return TRUE

	/// Mentor Follow
	if(href_list["mentor_follow"])
		var/mob/living/M = locate(href_list["mentor_follow"])

		if(istype(M))
			mentor_follow(M)
		return TRUE


/client/proc/mentor_datum_set(admin)
	mentor_datum = GLOB.mentor_datums[ckey]
	/// Admin with no mentor datum? let's fix that
	if(!mentor_datum && check_rights_for(src, R_ADMIN,0))
		new /datum/mentors(ckey)
	if(mentor_datum)
		if(!check_rights_for(src, R_ADMIN,0) && !admin)
			/// Don't add admins too.
			GLOB.mentors |= src
		mentor_datum.owner = src
		add_mentor_verbs()

/// Admins are Mentors, too
/client/proc/is_mentor()
	if(mentor_datum || check_rights_for(src, R_ADMIN,0))
		return TRUE
