/*
 *	This file is for any additions related to jobs to make fulp-only jobs
 *	functional with little conflict.
 */


		//	ID CARDS	//

// Used to assign the HUD icon linked to the job's trim.
/obj/item/proc/return_hud_icon()
	var/obj/item/card/id/id_card = GetID()

	if(!id_card)
		return 'icons/mob/hud.dmi'

	var/card_assignment = id_card.trim?.assignment
	if (card_assignment in GLOB.fulp_job_assignments)
		return 'fulp_modules/main_features/jobs/huds.dmi'
	else
		return 'icons/mob/hud.dmi'


		//	JOBS	//

/datum/job/fulp
	var/fulp_spawn = null //give it a room's type path to spawn there

/datum/job/fulp/after_spawn(mob/living/H, mob/M, latejoin)
	if(!latejoin && fulp_spawn)
		var/turf/T = get_fulp_spawn(fulp_spawn)
		H.Move(T)

/proc/get_fulp_spawn(area/room) // Reworked to find any empty tile
	for(var/turf/T in shuffle(get_area_turfs(room)))
		if(!T.is_blocked_turf(TRUE))
			return T
