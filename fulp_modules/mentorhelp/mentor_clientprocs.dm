/client/New()
	. = ..()
	mentor_datum_set()

/client/proc/mentor_client_procs(href_list)
	if(href_list["mentor_msg"])
		cmd_mentor_pm(href_list["mentor_msg"],null)
		return TRUE

	//Mentor Follow
	if(href_list["mentor_follow"])
		var/mob/living/M = locate(href_list["mentor_follow"])

		if(istype(M))
			mentor_follow(M)
		return TRUE


/client/proc/mentor_datum_set(admin)
	mentor_datum = GLOB.mentor_datums[ckey]
	if(!mentor_datum && check_rights_for(src, R_ADMIN,0)) // Admin with no mentor datum? let's fix that
		new /datum/mentors(ckey)
	if(mentor_datum)
		if(!check_rights_for(src, R_ADMIN,0) && !admin)
			GLOB.mentors |= src // Don't add admins too.
		mentor_datum.owner = src
		add_mentor_verbs()

/// Admins are Mentors, too
/client/proc/is_mentor()
	if(mentor_datum || check_rights_for(src, R_ADMIN,0))
		return TRUE
