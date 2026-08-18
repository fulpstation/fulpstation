/*
 *	# Fulp Job HUDs
 *
 *	Overwrites sec_hud_set_ID [code/games/data_huds.dm] to make Fulp jobs use their own HUD icons.
 */
/*
/mob/living/carbon/human/update_ID_card()
	. = ..()
	var/image/user = hud_list[ID_HUD]
	var/obj/item/card/id/id_card = wear_id?.GetID()
	var/id_codebase = id_card?.trim?.assignment
	if(id_codebase in GLOB.fulp_job_trims)
		user.icon = 'fulp_modules/icons/jobs/huds.dmi'
	else
		user.icon = 'icons/mob/huds/hud.dmi'
*/

/atom/set_hud_image_state(hud_type, hud_state, x_offset = 0, y_offset = 0)
	if (!hud_list) // Still initializing
		return
	var/image/holder = hud_list[hud_type]
	if (!holder)
		return
	if (!istype(holder)) // Can contain lists for HUD_LIST_LIST hinted HUDs, if someone fucks up and passes this here we wanna know about it
		CRASH("[src] ([type]) had a HUD_LIST_LIST hud_type [hud_type] passed into set_hud_image_state!")
	. = ..() //setting icon state n such.
	if(hud_state in GLOB.fulp_job_trims)
		holder.icon = 'fulp_modules/icons/jobs/huds.dmi'
	else
		holder.icon = 'icons/mob/huds/hud.dmi'

