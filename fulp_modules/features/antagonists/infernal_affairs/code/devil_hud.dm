#define UI_DEVIL_SOUL_DISPLAY "WEST:6,CENTER-1:15"
///Uses MAPTEXT to format antag points into a more appealing format
#define ANTAG_MAPTEXT(value, color) MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='[color]'>[round(value)]</font></div>")

/atom/movable/screen/devil_soul_counter
	icon = 'fulp_modules/features/antagonists/infernal_affairs/icons/devil_hud.dmi'
	name = "souls owned"
	icon_state = "devil-6"
	screen_loc = UI_DEVIL_SOUL_DISPLAY

/atom/movable/screen/devil_soul_counter/proc/update_counter(souls)
	maptext = ANTAG_MAPTEXT(souls, COLOR_RED)
	switch(souls)
		if(0)
			icon_state = "devil-1"
		if(1, 2)
			icon_state = "devil-2"
		if(3 to 5)
			icon_state = "devil-3"
		if(6, 7)
			icon_state = "devil-4"
		if(8 to 10)
			icon_state = "devil-5"
		else
			icon_state = "devil-6"

/atom/movable/screen/devil_soul_counter/Click()
	var/datum/antagonist/devil/devil_antag = hud.mymob.mind.has_antag_datum(/datum/antagonist/devil)
	if(!devil_antag)
		return
	hud.mymob.balloon_alert(usr, "souls owned: [devil_antag.souls]")


#undef UI_DEVIL_SOUL_DISPLAY
#undef ANTAG_MAPTEXT
