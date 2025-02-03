//////////////////////////////////////
//////// Alert level deltaww  ////////
//////////////////////////////////////

//Station silliness is imminent.

/datum/security_level/Deltaww
	name = "deltaww"
	announcement_color = "yellow"
	sound = 'fulp_modules/sounds/misc/cat_raid_siren.ogg' //>:3
	number_level = SEC_LEVEL_DELTAWW
	status_display_icon_state = "deltaalert"
	fire_alarm_light_color = LIGHT_COLOR_DIM_YELLOW
	elevating_to_configuration_key = /datum/config_entry/string/alert_deltaww
	shuttle_call_time_mod = ALERT_COEFF_DELTAWW

/datum/config_entry/string/alert_deltaww
	default = "HTTP/13.1 307 Temporary Redirect... ER*@$)!#_oWO-- of the station is imminent. Awl crew awe instwucted to obey awl instwuctions given by heads of staff. Any viowations of these owders can be punished by deawth. This is not a dwill."
