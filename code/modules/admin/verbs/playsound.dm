//world/proc/shelleo
#define SHELLEO_ERRORLEVEL 1
#define SHELLEO_STDOUT 2
#define SHELLEO_STDERR 3

/client/proc/play_sound(S as sound)
	set category = "Admin.Fun"
	set name = "Play Global Sound"
	if(!check_rights(R_SOUND))
		return

	var/freq = 1
	var/vol = input(usr, "What volume would you like the sound to play at?",, 100) as null|num
	if(!vol)
		return
	vol = clamp(vol, 1, 100)

	var/sound/admin_sound = new()
	admin_sound.file = S
	admin_sound.priority = 250
	admin_sound.channel = CHANNEL_ADMIN
	admin_sound.frequency = freq
	admin_sound.wait = 1
	admin_sound.repeat = FALSE
	admin_sound.status = SOUND_STREAM
	admin_sound.volume = vol

	var/res = tgui_alert(usr, "Show the title of this song to the players?",, list("Yes","No", "Cancel"))
	switch(res)
		if("Yes")
			to_chat(world, span_boldannounce("An admin played: [S]"), confidential = TRUE)
		if("Cancel")
			return

	log_admin("[key_name(src)] played sound [S]")
	message_admins("[key_name_admin(src)] played sound [S]")

	for(var/mob/M in GLOB.player_list)
		if(M.client.prefs.read_preference(/datum/preference/toggle/sound_midi))
			admin_sound.volume = vol * M.client.admin_music_volume
			SEND_SOUND(M, admin_sound)
			admin_sound.volume = vol

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Play Global Sound") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/client/proc/play_local_sound(S as sound)
	set category = "Admin.Fun"
	set name = "Play Local Sound"
	if(!check_rights(R_SOUND))
		return

	log_admin("[key_name(src)] played a local sound [S]")
	message_admins("[key_name_admin(src)] played a local sound [S]")
	playsound(get_turf(src.mob), S, 50, FALSE, FALSE)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Play Local Sound") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/play_direct_mob_sound(S as sound, mob/M)
	set category = "Admin.Fun"
	set name = "Play Direct Mob Sound"
	if(!check_rights(R_SOUND))
		return

	if(!M)
		M = input(usr, "Choose a mob to play the sound to. Only they will hear it.", "Play Mob Sound") as null|anything in sort_names(GLOB.player_list)
	if(!M || QDELETED(M))
		return
	log_admin("[key_name(src)] played a direct mob sound [S] to [M].")
	message_admins("[key_name_admin(src)] played a direct mob sound [S] to [ADMIN_LOOKUPFLW(M)].")
	SEND_SOUND(M, S)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Play Direct Mob Sound") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/play_web_sound()
	set category = "Admin.Fun"
	set name = "Play Internet Sound"
	if(!check_rights(R_SOUND))
		return

	var/ytdl = CONFIG_GET(string/invoke_youtubedl)
	if(!ytdl)
		to_chat(src, span_boldwarning("Youtube-dl was not configured, action unavailable"), confidential = TRUE) //Check config.txt for the INVOKE_YOUTUBEDL value
		return

	var/web_sound_input = input("Enter content URL (supported sites only, leave blank to stop playing)", "Play Internet Sound via youtube-dl") as text|null
	if(istext(web_sound_input))
		var/web_sound_url = ""
		var/stop_web_sounds = FALSE
		var/list/music_extra_data = list()
		if(length(web_sound_input))

			web_sound_input = trim(web_sound_input)
			if(findtext(web_sound_input, ":") && !findtext(web_sound_input, GLOB.is_http_protocol))
				to_chat(src, span_boldwarning("Non-http(s) URIs are not allowed."), confidential = TRUE)
				to_chat(src, span_warning("For youtube-dl shortcuts like ytsearch: please use the appropriate full url from the website."), confidential = TRUE)
				return
			var/shell_scrubbed_input = shell_url_scrub(web_sound_input)
			var/list/output = world.shelleo("[ytdl] --geo-bypass --format \"bestaudio\[ext=mp3]/best\[ext=mp4]\[height <= 360]/bestaudio\[ext=m4a]/bestaudio\[ext=aac]\" --dump-single-json --no-playlist -- \"[shell_scrubbed_input]\"")
			var/errorlevel = output[SHELLEO_ERRORLEVEL]
			var/stdout = output[SHELLEO_STDOUT]
			var/stderr = output[SHELLEO_STDERR]
			if(!errorlevel)
				var/list/data
				try
					data = json_decode(stdout)
				catch(var/exception/e)
					to_chat(src, span_boldwarning("Youtube-dl JSON parsing FAILED:"), confidential = TRUE)
					to_chat(src, span_warning("[e]: [stdout]"), confidential = TRUE)
					return

				if (data["url"])
					web_sound_url = data["url"]
					var/title = "[data["title"]]"
					var/webpage_url = title
					if (data["webpage_url"])
						webpage_url = "<a href=\"[data["webpage_url"]]\">[title]</a>"
					music_extra_data["duration"] = DisplayTimeText(data["duration"] * 1 SECONDS)
					music_extra_data["link"] = data["webpage_url"]
					music_extra_data["artist"] = data["artist"]
					music_extra_data["upload_date"] = data["upload_date"]
					music_extra_data["album"] = data["album"]

					var/res = tgui_alert(usr, "Show the title of and link to this song to the players?\n[title]",, list("No", "Yes", "Cancel"))
					switch(res)
						if("Yes")
							music_extra_data["title"] = data["title"]
						if("No")
							music_extra_data["link"] = "Song Link Hidden"
							music_extra_data["title"] = "Song Title Hidden"
							music_extra_data["artist"] = "Song Artist Hidden"
							music_extra_data["upload_date"] = "Song Upload Date Hidden"
							music_extra_data["album"] = "Song Album Hidden"
						if("Cancel")
							return

					var/anon = tgui_alert(usr, "Display who played the song?", "Credit Yourself?", list("No", "Yes", "Cancel"))
					switch(anon)
						if("Yes")
							if(res == "Yes")
								to_chat(world, span_boldannounce("[src] played: [webpage_url]"), confidential = TRUE)
							else
								to_chat(world, span_boldannounce("[src] played some music"), confidential = TRUE)
						if("No")
							if(res == "Yes")
								to_chat(world, span_boldannounce("An admin played: [webpage_url]"), confidential = TRUE)
						if("Cancel")
							return

					SSblackbox.record_feedback("nested tally", "played_url", 1, list("[ckey]", "[web_sound_input]"))
					log_admin("[key_name(src)] played web sound: [web_sound_input]")
					message_admins("[key_name(src)] played web sound: [web_sound_input]")
			else
				to_chat(src, span_boldwarning("Youtube-dl URL retrieval FAILED:"), confidential = TRUE)
				to_chat(src, span_warning("[stderr]"), confidential = TRUE)

		else //pressed ok with blank
			log_admin("[key_name(src)] stopped web sound")
			message_admins("[key_name(src)] stopped web sound")
			web_sound_url = null
			stop_web_sounds = TRUE

		if(web_sound_url && !findtext(web_sound_url, GLOB.is_http_protocol))
			to_chat(src, span_boldwarning("BLOCKED: Content URL not using http(s) protocol"), confidential = TRUE)
			to_chat(src, span_warning("The media provider returned a content URL that isn't using the HTTP or HTTPS protocol"), confidential = TRUE)
			return
		if(web_sound_url || stop_web_sounds)
			for(var/m in GLOB.player_list)
				var/mob/M = m
				var/client/C = M.client
				if(C.prefs.read_preference(/datum/preference/toggle/sound_midi))
					if(!stop_web_sounds)
						C.tgui_panel?.play_music(web_sound_url, music_extra_data)
					else
						C.tgui_panel?.stop_music()

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Play Internet Sound")

/client/proc/set_round_end_sound(S as sound)
	set category = "Admin.Fun"
	set name = "Set Round End Sound"
	if(!check_rights(R_SOUND))
		return

	SSticker.SetRoundEndSound(S)

	log_admin("[key_name(src)] set the round end sound to [S]")
	message_admins("[key_name_admin(src)] set the round end sound to [S]")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Set Round End Sound") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/stop_sounds()
	set category = "Debug"
	set name = "Stop All Playing Sounds"
	if(!src.holder)
		return

	log_admin("[key_name(src)] stopped all currently playing sounds.")
	message_admins("[key_name_admin(src)] stopped all currently playing sounds.")
	for(var/mob/M in GLOB.player_list)
		SEND_SOUND(M, sound(null))
		var/client/C = M.client
		C?.tgui_panel?.stop_music()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Stop All Playing Sounds") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

//world/proc/shelleo
#undef SHELLEO_ERRORLEVEL
#undef SHELLEO_STDOUT
#undef SHELLEO_STDERR
