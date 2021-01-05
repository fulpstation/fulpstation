// Overwrites sec_hud_set_ID to make fulp jobs get their HUD icons.

/mob/living/carbon/human/sec_hud_set_ID()
	var/image/holder = hud_list[ID_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	holder.icon_state = "hudno_id"
	holder.icon =  'icons/mob/hud.dmi'  					// FULP: Reset to default icon, in case you swapped to a FULP .dmi but we need to restore it.  **THIS IS TEMPORARY**
	if(wear_id?.GetID())
		var/obj/item/card/id/our_id = wear_id.GetID()
		holder.icon = our_id.return_icon_hud()   	// FULP ADDITION - This asks the ID to ask its associated Job what icon to use.
		holder.icon_state = "hud[ckey(wear_id.GetJobName())]"
	sec_hud_set_security_status()
