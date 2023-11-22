

// Fix for universal recorder/holopads being used to fuck up the server
/obj/item/radio
	var/static/list/ignore_types = typecacheof(list(
		/obj/item/taperecorder,
		/atom/movable/virtualspeaker,
		/obj/effect/overlay/holo_pad_hologram,
	))

/obj/item/radio/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods = list(), message_range)
	if(is_type_in_typecache(speaker, ignore_types))
		return
	return ..()
