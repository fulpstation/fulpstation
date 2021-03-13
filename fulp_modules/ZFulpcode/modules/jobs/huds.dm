// Overwrites sec_hud_set_ID [code/games/data_huds.dm] to make fulp jobs get their HUD icons.

/mob/living/carbon/human/sec_hud_set_ID()
	var/image/holder = hud_list[ID_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.icon = wear_id?.return_hud_icon() // FULP - We make a proc to return the icon we want the code to take from.
	holder.pixel_y = I.Height() - world.icon_size
	var/sechud_icon_state = wear_id?.get_sechud_job_icon_state()
	if(!sechud_icon_state)
		sechud_icon_state = "hudno_id"
	holder.icon_state = sechud_icon_state
	sec_hud_set_security_status()
