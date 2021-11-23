/*
 *	# Fulp Job HUDs
 *
 *	Overwrites sec_hud_set_ID [code/games/data_huds.dm] to make Fulp jobs use their own HUD icons.
 */

/mob/living/carbon/human/sec_hud_set_ID()
	. = ..()
	var/image/user = hud_list[ID_HUD]
	var/obj/item/card/id/id_card = wear_id?.GetID()
	var/id_codebase = id_card?.trim?.assignment
	if(id_codebase in GLOB.fulp_job_assignments)
		user.icon = 'fulp_modules/features/jobs/icons/huds.dmi'
	else
		user.icon = 'icons/mob/huds/hud.dmi'
