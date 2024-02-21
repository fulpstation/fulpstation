/datum/ai_behavior/unbuckle_mob

/datum/ai_behavior/unbuckle_mob/perform(seconds_per_tick, datum/ai_controller/controller)
	. = ..()

	var/mob/living/living_pawn = controller.pawn
	var/atom/movable/buckled_to = living_pawn.buckled

	if(isnull(buckled_to))
		finish_action(controller, FALSE)
		return

	buckled_to.unbuckle_mob(living_pawn)
	finish_action(controller, TRUE)
