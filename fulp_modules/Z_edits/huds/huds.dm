/*
 *	# Fulp Job HUDs
 *
 *	Overwrites sec_hud_set_ID [code/games/data_huds.dm] to make Fulp jobs use their own HUD icons.
 */

/mob/living/carbon/human/sec_hud_set_ID()
	var/image/holder = hud_list[ID_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.icon = wear_id?.return_hud_icon() /// FULP - JOBS - We make a proc to return the icon we want the code to take from.
	holder.pixel_y = I.Height() - world.icon_size
	var/sechud_icon_state = wear_id?.get_sechud_job_icon_state()
	if(!sechud_icon_state)
		holder.icon = 'icons/mob/hud.dmi' /// FULP - JOBS - Make sure we're drawing from an icon in the case that we do not have an ID anyways.
		sechud_icon_state = "hudno_id"
	holder.icon_state = sechud_icon_state
	sec_hud_set_security_status()
