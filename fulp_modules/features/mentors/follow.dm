/client/proc/mentor_follow(mob/living/followed_guy)
	if(!is_mentor())
		return
	if(isnull(followed_guy))
		return
	if(!ismob(usr))
		return
	mentor_datum.following = followed_guy
	usr.reset_perspective(followed_guy)
	add_verb(src, /client/proc/mentor_unfollow)
	to_chat(GLOB.admins, span_adminooc("<span class='prefix'>MENTOR:</span> <EM>[key_name(usr)]</EM> is now following <EM>[key_name(followed_guy)]</span>"))
	to_chat(usr, span_info("Click the \"Stop Following\" button in the Mentor tab to stop following [key_name(followed_guy)]."))
	log_mentor("[key_name(usr)] began following [key_name(followed_guy)]")
	//Remove mentor's blindness/color blindness
	usr.hide_fullscreens()
	for(var/datum/client_colour/colour in usr.client_colours)
		mentor_datum.mentors_client_colours += colour.type
		usr.remove_client_colour(colour.type)

/client/proc/mentor_unfollow()
	set category = "Mentor"
	set name = "Stop Following"
	set desc = "Stop following the followed."

	remove_verb(src, /client/proc/mentor_unfollow)
	usr.reset_perspective()
	to_chat(GLOB.admins, span_adminooc("<span class='prefix'>MENTOR:</span> <EM>[key_name(usr)]</EM> is no longer following <EM>[key_name(mentor_datum.following)]</span>"))
	log_mentor("[key_name(usr)] stopped following [key_name(mentor_datum.following)]")
	mentor_datum.following = null
	//Add back mentor's blindness/color blindness
	usr.reload_fullscreen()
	for(var/client_colour_type in mentor_datum.mentors_client_colours)
		usr.add_client_colour(client_colour_type)
	mentor_datum.mentors_client_colours = list()
