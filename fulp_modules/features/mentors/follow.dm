/client/proc/mentor_follow(mob/living/followed_guy)
	if(!is_mentor())
		return
	if(isnull(followed_guy))
		return
	if(!ismob(usr))
		return
	mentor_datum.following = followed_guy
	usr.reset_perspective(followed_guy)
	ASSIGN_GAME_VERB(src, /client, mentor_unfollow)
	to_chat(GLOB.admins, span_adminooc("<span class='prefix'>MENTOR:</span> <EM>[key_name(usr)]</EM> is now following <EM>[key_name(followed_guy)]</span>"))
	to_chat(usr, span_info("Click the \"Stop Following\" button in the Mentor tab to stop following [key_name(followed_guy)]."))
	log_mentor("[key_name(usr)] began following [key_name(followed_guy)]")

GAME_VERB_PROC(/client, mentor_unfollow, "Stop Following", "Mentor")
	UNASSIGN_GAME_VERB(src, /client, mentor_unfollow)
	usr.reset_perspective()
	to_chat(GLOB.admins, span_adminooc("<span class='prefix'>MENTOR:</span> <EM>[key_name(usr)]</EM> is no longer following <EM>[key_name(mentor_datum.following)]</span>"))
	log_mentor("[key_name(usr)] stopped following [key_name(mentor_datum.following)]")
	mentor_datum.following = null
