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
	var/hastarget = FALSE
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
		current_behaviors += GET_AI_BEHAVIOR(/datum/ai_behavior/bloodsucker_check_gohome)
		/// Let's resist out of our fire, shall we?
		current_behaviors += GET_AI_BEHAVIOR(/datum/ai_behavior/resist)
		return

	if(!hastarget)
		/// We're looking for the closest Human here.
		for(var/mob/living/carbon/human/victims in oview(7, pawn))
			/// We dont want dead blood
			if(victims.stat >= DEAD)
				continue
			/// We don't want to drink our own Blood
			if(victims == living_pawn)
				continue
			/// Bloodsuckers cant be fed off of, so don't target them.
			if(IS_BLOODSUCKER(victims))
				continue
			/// Don't go for people that don't have Blood.
			if(NOBLOOD in victims.dna.species.species_traits)
				continue
			blackboard[BB_BLOODSUCKER_TARGET] = victims
			target = victims
			hastarget = TRUE
			break
	if(hastarget)
		current_movement_target = target
		current_behaviors += GET_AI_BEHAVIOR(/datum/ai_behavior/bloodsucker_attack_mob)

/// Mindlessly wander/trespass around until you find a target
/datum/ai_controller/bloodsucker/PerformIdleBehavior(delta_time)
	var/mob/living/living_pawn = pawn

	if(hastarget)
		return

	if(DT_PROB(HAUNTED_ITEM_TELEPORT_CHANCE, delta_time))
		playsound(pawn.loc, 'sound/magic/summon_karp.ogg', 60, TRUE)
		do_teleport(pawn, get_turf(pawn), 4, channel = TELEPORT_CHANNEL_MAGIC)

	if(DT_PROB(80, delta_time) && (living_pawn.mobility_flags & MOBILITY_MOVE))
		var/move_dir = pick(GLOB.alldirs)
		living_pawn.Move(get_step(living_pawn, move_dir), move_dir)

/* // Your powers should be deactivated by the lack of Blood anyways.
	for(var/datum/action/A in living_pawn.actions)
		if(A.active)
			A.Trigger()
*/

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
	/// We've got them grabbed? Start Feeding!
	if(living_pawn.pulling)
		for(var/datum/action/A in living_pawn.actions)
			if(istype(A, /datum/action/bloodsucker/feed))
				A.Trigger()

/// Using Vanishing Act if we're resisting and have it
/datum/ai_behavior/bloodsucker_check_gohome
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM // Allow us to move.

/datum/ai_behavior/bloodsucker_check_gohome/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/living_pawn = controller.pawn
	for(var/datum/action/A in living_pawn.actions)
		if(istype(A, /datum/action/bloodsucker/gohome))
			A.Trigger()
	finish_action(controller, FALSE)

/*
 *	# Split Personality
 *
 *	We're kicking the Bloodsucker into a split personality, and making the Main one be the AI.
 *	If you search up the definition of 'Shitcode', this will come up, along with my name in large, bold text.
 */

/// TG undefines these in the actual split personality file, we gotta re-define them.
#define OWNER 0
#define STRANGER 1

/datum/brain_trauma/severe/split_personality/frenzy
	name = "Frenzy"
	desc = "Patient's brain seems to have been overwhelmed by something far beyond himself, and has lost total consciousness."
	scan_desc = "complete insanity and lack of sentience"
	gain_text = ""
	lose_text = ""

/datum/brain_trauma/severe/split_personality/frenzy/on_gain()
	var/mob/living/M = owner
	if(M.stat == DEAD || !M.client)
		qdel(src)
		return
	make_backseats()
	get_ghost()
	. = ..()

/datum/brain_trauma/severe/split_personality/frenzy/make_backseats()
	stranger_backseat = new /mob/living/split_personality/frenzy(owner, src)
	owner_backseat = new(owner, src)

/datum/brain_trauma/severe/split_personality/frenzy/get_ghost()
	set waitfor = FALSE

/datum/brain_trauma/severe/split_personality/on_life(delta_time, times_fired)
	if(current_controller == OWNER)
		switch_personalities()

/datum/brain_trauma/severe/split_personality/frenzy/on_lose()
	if(current_controller != OWNER)
		switch_personalities()
	QDEL_NULL(stranger_backseat)
	QDEL_NULL(owner_backseat)
	QDEL_NULL(owner.current.ai_controller)
//	/mob/living/split_personality/frenzy(owner, src)

/datum/brain_trauma/severe/split_personality/frenzy/switch_personalities()
	if(QDELETED(owner) || QDELETED(stranger_backseat) || QDELETED(owner_backseat))
		return

	var/mob/living/split_personality/current_backseat
	var/mob/living/split_personality/free_backseat
	if(current_controller == OWNER)
		current_backseat = stranger_backseat
		free_backseat = owner_backseat
	else
		current_backseat = owner_backseat
		free_backseat = stranger_backseat

	/// Body to backseat
	var/h2b_id = owner.computer_id
	var/h2b_ip= owner.lastKnownIP
	owner.computer_id = null
	owner.lastKnownIP = null

	free_backseat.ckey = owner.ckey
	free_backseat.name = owner.name

	if(owner.mind)
		free_backseat.mind = owner.mind
	if(!free_backseat.computer_id)
		free_backseat.computer_id = h2b_id
	if(!free_backseat.lastKnownIP)
		free_backseat.lastKnownIP = h2b_ip

	/// Backseat to body
	var/s2h_id = current_backseat.computer_id
	var/s2h_ip= current_backseat.lastKnownIP
	current_backseat.computer_id = null
	current_backseat.lastKnownIP = null

	owner.ckey = current_backseat.ckey
	owner.mind = current_backseat.mind

	if(!owner.computer_id)
		owner.computer_id = s2h_id
	if(!owner.lastKnownIP)
		owner.lastKnownIP = s2h_ip

	current_controller = !current_controller

/// The mob controlling the body.
/mob/living/split_personality/frenzy
	name = "frenzy personality"
	real_name = "frenzied conscience"

/mob/living/split_personality/frenzy/Initialize(mapload, _trauma)
	if(iscarbon(loc))
		new /datum/ai_controller/bloodsucker(src)
		body = loc
		name = body.real_name
		real_name = body.real_name
		trauma = _trauma
	return ..()

/mob/living/split_personality/frenzy/Life(delta_time = SSMOBS_DT, times_fired)
	/// In case trauma deletion doesn't already do it
	if(QDELETED(body))
		qdel(src)

/mob/living/split_personality/frenzy/Login()
	. = ..()
	if(!. || !client)
		return FALSE

#undef OWNER
#undef STRANGER
