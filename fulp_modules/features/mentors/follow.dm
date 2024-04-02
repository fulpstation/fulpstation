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
	// usr.clear_fullscreens()
	// for(var/category in usr.screens)
	// 	if(!isnull(category))
	// 		to_chat(world, category)
	// 		mentor_datum.screens[category] = usr.screens[category]
			//usr.screens -= usr.screens[category]

	usr.hide_fullscreens()
	//  = usr.client_colours
	// usr.client_colours = list()
	for(var/datum/client_colour/colour in usr.client_colours)
		mentor_datum.mentors_client_colours += colour
		qdel(colour)

	// usr.reload_fullscreen()
	// if(!isnull(usr.screens["blindness"]))
	// 	mentor_datum.screens["blindness"] += usr.screens["blindness"]
	// 	usr.screens -= usr.screens["blindness"]
	// 	usr.screens.rem

/client/proc/mentor_unfollow()
	set category = "Mentor"
	set name = "Stop Following"
	set desc = "Stop following the followed."

	remove_verb(src, /client/proc/mentor_unfollow)
	usr.reset_perspective()
	to_chat(GLOB.admins, span_adminooc("<span class='prefix'>MENTOR:</span> <EM>[key_name(usr)]</EM> is no longer following <EM>[key_name(mentor_datum.following)]</span>"))
	log_mentor("[key_name(usr)] stopped following [key_name(mentor_datum.following)]")
	mentor_datum.following = null

	// for(var/category in mentor_datum.screens)
	// 	usr.screens += mentor_datum.screens[category]
	// mentor_datum.screens = list()

	usr.reload_fullscreen()
	for(var/color in mentor_datum.mentors_client_colours)
		usr.add_client_colour(color)
	// usr.client_colours = mentor_datum.mentors_client_colours



	// HAS_CLIENT_COLOR(usr, /datum/client_colour/monochrome/blind)
	// HAS_SCREEN_OVERLAY(usr, /atom/movable/screen/fullscreen/blind)
	// HAS_SCREEN_OVERLAY(usr, /atom/movable/screen/fullscreen/impaired)\
	///atom/movable/screen/fullscreen/color_vision
