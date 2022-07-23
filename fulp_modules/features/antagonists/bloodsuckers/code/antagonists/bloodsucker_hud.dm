/// 1 tile down
#define UI_BLOOD_DISPLAY "WEST:6,CENTER-1:0"
/// 2 tiles down
#define UI_VAMPRANK_DISPLAY "WEST:6,CENTER-2:-5"
/// 6 pixels to the right, zero tiles & 5 pixels DOWN.
#define UI_SUNLIGHT_DISPLAY "WEST:6,CENTER-0:0"

///Maptext define for Bloodsucker HUDs
#define FORMAT_BLOODSUCKER_HUD_TEXT(valuecolor, value) MAPTEXT("<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='[valuecolor]'>[round(value,1)]</font></div>")
///Maptext define for Bloodsucker Sunlight HUDs
#define FORMAT_BLOODSUCKER_SUNLIGHT_TEXT(valuecolor, value) MAPTEXT("<div align='center' valign='bottom' style='position:relative; top:0px; left:6px'><font color='[valuecolor]'>[value]</font></div>")


/atom/movable/screen/bloodsucker
	icon = 'fulp_modules/features/antagonists/bloodsuckers/icons/actions_bloodsucker.dmi'

/atom/movable/screen/bloodsucker/blood_counter
	name = "Blood Consumed"
	icon_state = "blood_display"
	screen_loc = UI_BLOOD_DISPLAY

/atom/movable/screen/bloodsucker/rank_counter
	name = "Bloodsucker Rank"
	icon_state = "rank"
	screen_loc = UI_VAMPRANK_DISPLAY

/atom/movable/screen/bloodsucker/sunlight_counter
	name = "Solar Flare Timer"
	icon_state = "sunlight_night"
	screen_loc = UI_SUNLIGHT_DISPLAY

/// Update Blood Counter + Rank Counter
/datum/antagonist/bloodsucker/proc/update_hud()
	var/valuecolor
	if(bloodsucker_blood_volume > BLOOD_VOLUME_SAFE)
		valuecolor = "#FFDDDD"
	else if(bloodsucker_blood_volume > BLOOD_VOLUME_BAD)
		valuecolor = "#FFAAAA"

	if(blood_display)
		blood_display.maptext = FORMAT_BLOODSUCKER_HUD_TEXT(valuecolor, bloodsucker_blood_volume)

	if(vamprank_display)
		if(bloodsucker_level_unspent > 0)
			vamprank_display.icon_state = "rank_up"
		else
			vamprank_display.icon_state = "rank"
		vamprank_display.maptext = FORMAT_BLOODSUCKER_HUD_TEXT(valuecolor, bloodsucker_level)

/// Update Sun Time
/datum/antagonist/bloodsucker/proc/update_sunlight(value, amDay = FALSE)
	if(!sunlight_display)
		return
	var/valuecolor
	var/sunlight_display_icon = "sunlight_"
	if(amDay)
		sunlight_display_icon += "day"
		valuecolor = "#FF5555"
	else
		switch(round(value, 1))
			if(0 to 30)
				sunlight_display_icon += "30"
				valuecolor = "#FFCCCC"
			if(31 to 60)
				sunlight_display_icon += "60"
				valuecolor = "#FFE6CC"
			if(61 to 90)
				sunlight_display_icon += "90"
				valuecolor = "#FFFFCC"
			else
				sunlight_display_icon += "night"
				valuecolor = "#FFFFFF"

	var/value_string = (value >= 60) ? "[round(value / 60, 1)] m" : "[round(value, 1)] s"
	sunlight_display.maptext = FORMAT_BLOODSUCKER_SUNLIGHT_TEXT(valuecolor, value_string)
	sunlight_display.icon_state = sunlight_display_icon

/// 1 tile down
#undef UI_BLOOD_DISPLAY
/// 2 tiles down
#undef UI_VAMPRANK_DISPLAY
/// 6 pixels to the right, zero tiles & 5 pixels DOWN.
#undef UI_SUNLIGHT_DISPLAY

///Maptext define for Bloodsucker HUDs
#undef FORMAT_BLOODSUCKER_HUD_TEXT
///Maptext define for Bloodsucker Sunlight HUDs
#undef FORMAT_BLOODSUCKER_SUNLIGHT_TEXT
