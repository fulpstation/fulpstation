/mob/dead/observer/check_emote(message, forced)
	return emote(copytext(message, length(message[1]) + 1), intentional = !forced, force_silence = TRUE)

//Modified version of get_message_mods, removes the trimming, the only thing we care about here is admin channels
/mob/dead/observer/get_message_mods(message, list/mods)
	var/key = message[1]
	if((key in GLOB.department_radio_prefixes) && length(message) > length(key) + 1 && !mods[RADIO_EXTENSION])
		mods[RADIO_KEY] = lowertext(message[1 + length(key)])
		mods[RADIO_EXTENSION] = GLOB.department_radio_keys[mods[RADIO_KEY]]
	return message

/mob/dead/observer/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null, filterproof = null)
	message = trim(message) //trim now and sanitize after checking for special admin radio keys

	var/list/filter_result = is_ooc_filtered(message)
	if (filter_result)
		REPORT_CHAT_FILTER_TO_USER(usr, filter_result)
		return

	var/list/soft_filter_result = is_soft_ooc_filtered(message)
	if (soft_filter_result)
		if(tgui_alert(usr,"Your message contains \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\". \"[soft_filter_result[CHAT_FILTER_INDEX_REASON]]\", Are you sure you want to say it?", "Soft Blocked Word", list("Yes", "No")) != "Yes")
			return
		message_admins("[ADMIN_LOOKUPFLW(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Message: \"[message]\"")
		log_admin_private("[key_name(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Message: \"[message]\"")

	if(!message)
		return
	var/list/message_mods = list()
	message = get_message_mods(message, message_mods)
	if(client?.holder && (message_mods[RADIO_EXTENSION] == MODE_ADMIN || message_mods[RADIO_EXTENSION] == MODE_DEADMIN || (message_mods[RADIO_EXTENSION] == MODE_PUPPET && mind?.current)))
		message = trim_left(copytext_char(message, length(message_mods[RADIO_KEY]) + 2))
		switch(message_mods[RADIO_EXTENSION])
			if(MODE_ADMIN)
				client.cmd_admin_say(message)
			if(MODE_DEADMIN)
				client.dsay(message)
			if(MODE_PUPPET)
				if(!mind.current.say(message))
					to_chat(src, span_warning("Your linked body was unable to speak!"))
		return

	message = copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN)
	if(check_emote(message, forced))
		return

	. = say_dead(message)

/mob/dead/observer/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods = list())
	. = ..()
	var/atom/movable/to_follow = speaker
	if(radio_freq)
		var/atom/movable/virtualspeaker/V = speaker

		if(isAI(V.source))
			var/mob/living/silicon/ai/S = V.source
			to_follow = S.eyeobj
		else
			to_follow = V.source
	var/link = FOLLOW_LINK(src, to_follow)
	// Create map text prior to modifying message for goonchat
	if (client?.prefs.read_preference(/datum/preference/toggle/enable_runechat) && (client.prefs.read_preference(/datum/preference/toggle/enable_runechat_non_mobs) || ismob(speaker)))
		create_chat_message(speaker, message_language, raw_message, spans)
	// Recompose the message, because it's scrambled by default
	message = compose_message(speaker, message_language, raw_message, radio_freq, spans, message_mods)
	to_chat(src,
		html = "[link] [message]",
		avoid_highlighting = speaker == src)
