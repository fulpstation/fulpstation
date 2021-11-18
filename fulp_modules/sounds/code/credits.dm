// This is triggered in roundend.dm, so that we have some round-end music instead of just playing lobby music again.
/client/proc/playcreditsmusic(vol = 85)
	set waitfor = FALSE
	if(prefs && (prefs.toggles & SOUND_LOBBY))
		SEND_SOUND(src, sound(returncreditsmusic(), repeat = 0, wait = 0, volume = vol, channel = CHANNEL_LOBBYMUSIC))

// The proc that decides which track to play for the credits, from the G.credits_music global list
// This allows for a much easier time adding some more credits music.
/client/proc/returncreditsmusic()
	return pick_weight(GLOB.credits_music)
