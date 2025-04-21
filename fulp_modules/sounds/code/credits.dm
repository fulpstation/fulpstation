// This is triggered in roundend.dm, so that we have some round-end music instead of just playing lobby music again.
/client/playtitlemusic(volume_multiplier = 85)
	if(SSticker.current_state == GAME_STATE_FINISHED)
		return playcreditsmusic(volume_multiplier)
	return ..()

/client/proc/playcreditsmusic(volume_multiplier = 85)
	set waitfor = FALSE

	var/volume_modifier = prefs.read_preference(/datum/preference/numeric/volume/sound_lobby_volume) * volume_multiplier
	if((prefs && volume_modifier) && !CONFIG_GET(flag/disallow_title_music))
		SEND_SOUND(src, sound(returncreditsmusic(), repeat = 0, wait = 0, volume = volume_modifier, channel = CHANNEL_LOBBYMUSIC)) // MAD JAMS

// The proc that decides which track to play for the credits, from the G.credits_music global list
// This allows for a much easier time adding some more credits music.
/client/proc/returncreditsmusic()
	return pick_weight(GLOB.credits_music)
