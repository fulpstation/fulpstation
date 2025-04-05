/datum/action/cooldown/bloodsucker/hecata/communion
	name = "Deathly Communion"
	desc = "Send a message to all your vassals."
	button_icon_state = "power_communion"
	power_explanation = "Deathly Communion:\n\
		Send a message directly to all vassals under your control, temporary or permanent.\n\
		They will not be able to respond to you through any supernatural means in the way you can.\n\
		Note, nearby humans can hear you talk when using this.\n\
		The cooldown of Communion will decrease as it levels up."
	check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY
	power_flags = NONE
	bloodcost = 8
	cooldown_time = 30 SECONDS

/datum/action/cooldown/bloodsucker/hecata/communion/ActivatePower()
	. = ..()
	var/input = sanitize(tgui_input_text(usr, "Enter a message to tell your vassals.", "Voice of Blood"))
	if(!input || !IsAvailable())
		return FALSE
	deathly_commune(usr, input)

/datum/action/cooldown/bloodsucker/hecata/communion/proc/deathly_commune(mob/living/user, message) //code from Fulpstation
	var/rendered = span_cult_large("<b>Master [user.real_name] announces:</b> [message]")
	user.log_talk(message, LOG_SAY, tag=ROLE_BLOODSUCKER)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	for(var/datum/antagonist/vassal/receiver as anything in bloodsuckerdatum.vassals)
		if(!receiver.owner.current)
			continue
		var/mob/receiver_mob = receiver.owner.current
		to_chat(receiver_mob, rendered)
	to_chat(user, rendered) // tell yourself, too.
	for(var/mob/dead_mob in GLOB.dead_mob_list)
		var/link = FOLLOW_LINK(dead_mob, user)
		to_chat(dead_mob, "[link] [rendered]")
	DeactivatePower()
