/client
	///If this is set, this person is a Mentor.
	var/datum/mentors/mentor_datum

/client/New()
	. = ..()
	mentor_datum_set()

// Overwrites /client/Topic to return for mentor client procs
/client/Topic(href, href_list, hsrc)
	//Replying to a mentorhelp
	if(href_list["mentor_msg"])
		cmd_mentor_pm(href_list["mentor_msg"], null)
		return TRUE
	//Following someone through a mentorhelp.
	if(href_list["mentor_follow"])
		var/mob/living/followed_guy = locate(href_list["mentor_follow"])
		if(istype(followed_guy))
			mentor_follow(followed_guy)
		return TRUE
	return ..()

///Sets the person to a mentor datum, linking if it exists, otherwise we'll create a new one if it's an admin.
///Anyone that isn't set to be a mentor will get nothing from this.
/client/proc/mentor_datum_set()
	mentor_datum = GLOB.mentor_datums[ckey]
	if(mentor_datum)
		mentor_datum.link_mentor_datum(ckey)
	else if(holder)
		new /datum/mentors(ckey)

///Returns whether or not this client is a Mentor (Or Admin, cause they are also Mentors).
/client/proc/is_mentor()
	if(mentor_datum || holder)
		return TRUE
	return FALSE
