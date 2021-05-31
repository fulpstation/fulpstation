/*  This is where the sound edits are made.
*	There might be changes that had to be made in /tg/ files, but those will be listed in this file.
*/

// For the credits music, the number associated is its relative weight,
// values can be tweaked as much as needed and don't need to equal to a hundred.
GLOBAL_LIST_INIT(credits_music,list(
	'fulp_modules/fulp_configs/sound/Fulp_Piano.ogg' = 80,
	'fulp_modules/fulp_configs/sound/Fulp_Piano_Old.ogg' = 20,
	))

// This is for when the server restarts. Not weighted because it wasn't weighted to begin with.
GLOBAL_LIST_INIT(round_end_tracks,list(
	'sound/roundend/newroundsexy.ogg', 'sound/roundend/apcdestroyed.ogg',
	'sound/roundend/bangindonk.ogg', 'fulp_modules/fulp_configs/sound/imaghoul.ogg',
	'sound/roundend/petersondisappointed.ogg', 'sound/roundend/its_only_game.ogg',
	'fulp_modules/fulp_configs/sound/i_got_banned_on_fulpstation.ogg'))

// This is triggered in roundend.dm, so that we have some round-end music instead of just playing lobby music again.
/client/proc/playcreditsmusic(vol = 85)
	set waitfor = FALSE
	if(prefs && (prefs.toggles & SOUND_LOBBY))
		SEND_SOUND(src, sound(returncreditsmusic(), repeat = 0, wait = 0, volume = vol, channel = CHANNEL_LOBBYMUSIC))

// The proc that decides which track to play for the credits, from the G.credits_music global list
// This allows for a much easier time adding some more credits music.
/client/proc/returncreditsmusic()
	return pickweight(GLOB.credits_music)

/datum/controller/subsystem/ticker/proc/pick_round_end_sound()
	return pick(GLOB.round_end_tracks)
