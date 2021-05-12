// Overwrites martial arts granters (granters.dm) to prevent South Star users from getting other martial arts
// while they are wearing the gloves.

/obj/item/book/granter/martial/on_reading_finished(mob/user)
	// FULP: Adds a check before applying martial arts from granters to ensure they aren't wearing South Star gloves
	if(user.mind.has_martialart("south star"))
		to_chat(user, "<span class='danger'>The martial arts chip in your gloves prevents you from internalizing the art!</span>")
		return FALSE
	// FULPCODE END
	to_chat(user, "[greet]")
	var/datum/martial_art/MA = new martial
	MA.teach(user)
	user.log_message("learned the martial art [martialname] ([MA])", LOG_ATTACK, color="orange")
	onlearned(user)
