/**
 * tgui state: mentor_state
 *
 * Checks that the user is a mentor, end-of-story.
 */

GLOBAL_DATUM_INIT(mentor_state, /datum/ui_state/mentor_state, new)

/datum/ui_state/mentor_state/can_use_topic(src_object, mob/user)
	if(user.client.is_mentor())
		return UI_INTERACTIVE
	return UI_CLOSE
