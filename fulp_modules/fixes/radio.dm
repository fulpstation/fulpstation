// Fix for universal recorder being used to fuck up the server
/obj/item/radio/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods = list(), message_range)
	if(istype(speaker, /obj/item/taperecorder))
		return
	return ..()
