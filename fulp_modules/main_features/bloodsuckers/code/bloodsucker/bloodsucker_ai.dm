#define BB_BLOODSUCKER_TARGET "BB_bloodsucker_target"

/*
 *	# Frenzy
 *
 *	Once Bloodsuckers reach a certain amount of Blood, they enter Frenzy
 *	An AI takes over their body and searches to suck Blood from the closest person.
 *
 *	This is nearly-entirely stolen from Monkey AI.
 */

/datum/ai_controller/bloodsucker
	movement_delay = 0.4 SECONDS
	blackboard = list(BB_BLOODSUCKER_TARGET = null)

/// Giving control to the Ghost
/datum/ai_controller/bloodsucker/TryPossessPawn(atom/new_pawn)
	if(!isliving(new_pawn))
		return AI_CONTROLLER_INCOMPATIBLE
	RegisterSignal(new_pawn, COMSIG_MOB_MOVESPEED_UPDATED, .proc/update_movespeed)
	return ..()

/// Taking control away from the Ghost
/datum/ai_controller/bloodsucker/UnpossessPawn(destroy)
	UnregisterSignal(pawn, list(COMSIG_MOB_MOVESPEED_UPDATED))
	return ..()

/datum/ai_controller/bloodsucker/proc/update_movespeed(mob/living/pawn)
	SIGNAL_HANDLER
	movement_delay = pawn.cached_multiplicative_slowdown

/// Looking for our target
/datum/ai_controller/bloodsucker/SelectBehaviors(delta_time)
	var/mob/living/living_pawn = pawn
	current_behaviors = list()
	var/mob/living/target = blackboard[BB_BLOODSUCKER_TARGET]

	/// Are we on fire? Extinguish ourselves.
	if(SHOULD_RESIST(living_pawn))
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(living_pawn)
		/// If we have Gohome ability, let's use it.
		for(var/datum/action/bloodsucker/P in bloodsuckerdatum.powers)
			if(istype(P, /datum/action/bloodsucker/gohome))
				P.ActivatePower()
		current_behaviors += GET_AI_BEHAVIOR(/datum/ai_behavior/resist)
		return

	if(!target)
		/// We're looking for the closest person here.
		for(var/mob/living/victims in oview(7, pawn))
			if(IS_DEAD_OR_INCAP(victims))
				continue
			blackboard[BB_BLOODSUCKER_TARGET] = victims
			target = victims
			break
	if(target)
		current_movement_target = target
		current_behaviors += GET_AI_BEHAVIOR(/datum/ai_behavior/bloodsucker_attack_mob)

/// Found our target!
/datum/ai_behavior/bloodsucker_attack_mob
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM // Allow us to move, yes.

/datum/ai_behavior/bloodsucker_attack_mob/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/target = controller.blackboard[BB_BLOODSUCKER_TARGET]

	/// Are we close? Let's attack them now!
	if(isturf(target.loc))
		bloodsucker_attack(controller, target, delta_time)

/// The attack itself.
/datum/ai_behavior/bloodsucker_attack_mob/proc/bloodsucker_attack(datum/ai_controller/controller, mob/living/target, delta_time)
	var/mob/living/living_pawn = controller.pawn
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(living_pawn)

	/// We have enough Blood? Snap out of it!
	if(living_pawn.blood_volume >= BLOOD_VOLUME_SURVIVE)
		bloodsuckerdatum.EndFrenzy()

	/// Start grabbing them
	living_pawn.start_pulling(target)
	target.grippedby(living_pawn, instant = TRUE) //instant aggro grab
	living_pawn.setDir(get_dir(living_pawn, target))
	/// Start sucking their blood
	for(var/datum/action/bloodsucker/P in bloodsuckerdatum.powers)
		if(istype(P, /datum/action/bloodsucker/feed))
			P.ActivatePower()
