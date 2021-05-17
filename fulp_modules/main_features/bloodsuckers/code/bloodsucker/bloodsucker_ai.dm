#define BB_BLOODSUCKER_TARGET "BB_bloodsucker_target"

/*
 *	# Frenzy
 *
 *	Once Bloodsuckers reach a certain amount of Blood, they enter Frenzy
 *	An AI takes over their body and searches to suck Blood from the closest person.
 *
 *	This is nearly-entirely stolen from Monkey AI.
 */

/// AI controller ///

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
		/// If we have Gohome ability, let's use it.
		for(var/datum/action/A in living_pawn.actions)
			if(istype(A, /datum/action/bloodsucker/gohome))
				A.Trigger()
		/// Let's resist out of our fire, shall we?
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

/// Mindlessly wander/trespass around until you find a target
/datum/ai_controller/bloodsucker/PerformIdleBehavior(delta_time)
	var/mob/living/living_pawn = pawn

	if(BB_BLOODSUCKER_TARGET)
		return

	if(DT_PROB(HAUNTED_ITEM_TELEPORT_CHANCE, delta_time))
		playsound(pawn.loc, 'sound/magic/summon_karp.ogg', 60, TRUE)
		do_teleport(pawn, get_turf(pawn), 4, channel = TELEPORT_CHANNEL_MAGIC)

	if(DT_PROB(80, delta_time) && (living_pawn.mobility_flags & MOBILITY_MOVE))
		var/move_dir = pick(GLOB.alldirs)
		living_pawn.Move(get_step(living_pawn, move_dir), move_dir)

/// AI Behavior ///

/// Found our target!
/datum/ai_behavior/bloodsucker_attack_mob
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM // Allow us to move.

/datum/ai_behavior/bloodsucker_attack_mob/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/target = controller.blackboard[BB_BLOODSUCKER_TARGET]

	/// Are we close? Let's attack them now!
	if(in_range(controller.pawn, target))
		bloodsucker_attack(controller, target, delta_time)

/// The attack itself.
/datum/ai_behavior/bloodsucker_attack_mob/proc/bloodsucker_attack(datum/ai_controller/controller, mob/living/target, delta_time)
	var/mob/living/living_pawn = controller.pawn

	/// Start grabbing them
	if(living_pawn.pulling != target)
		target.grabbedby(living_pawn)
		target.grabbedby(living_pawn, supress_message = TRUE)
		for(var/datum/action/A in living_pawn.actions)
			if(istype(A, /datum/action/bloodsucker/feed))
				A.Trigger()
