/atom/movable/screen/cinematic/monster
	icon = 'fulp_modules/features/antagonists/infiltrators/icons/mooncry.dmi'
	icon_state = "bloodmoon"

/datum/cinematic/monster


/datum/cinematic/monster/New(watcher, datum/callback/special_callback)
	var/atom/movable/screen/cinematic/monster/monst = new
	screen = monst
	if(watcher == world)
		is_global = TRUE

	src.special_callback = special_callback

/datum/cinematic/monster/play_cinematic()
	screen.icon_state = null
	flick("bloodmoon", screen)
	stoplag(2.5 SECONDS)
	special_callback?.Invoke()
