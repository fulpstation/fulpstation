/*
 *	This file is for any additions related to jobs to make fulp-only jobs
 *	functional with little conflict.
 *
 *
 *
 */


		//	ID CARDS	//

/obj/item/card
	// var/datum/job/linkedJobType         // This is a TYPE, not a ref to a particular instance. We'll use this for finding the job and hud icon of each job.

// Used to assign the HUD icon linked to the job ID Card.
/obj/item/proc/return_icon_hud()
	var/datum/job/linkedJobType
	var/obj/item/card/id/id_card = GetID()

	if(!id_card)
		return
	var/card_assignment = id_card.trim?.assignment
	if (card_assignment in GLOB.fulp_job_assignments)
		return 'fulp_modules/jobs/huds.dmi'

	if (!linkedJobType || card_assignment == "Unassigned")
		return 'icons/mob/hud.dmi'

	return initial(linkedJobType.hud_icon)


		//	JOBS	//

/datum/job
	var/id_icon = 'icons/obj/card.dmi'	// Overlay on your ID
	var/hud_icon = 'icons/mob/hud.dmi'	// Sec Huds see this

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
