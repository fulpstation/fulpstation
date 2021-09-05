/*
 *	MEZMERIZE
 *	 Locks a target in place for a certain amount of time.
 *
 * 	Level 2: Additionally mutes
 * 	Level 3: Can be used through face protection
 * 	Level 5: Doesn't need to be facing you anymore
 * 	Level 6: Causes the target to fall asleep
 */

/datum/action/bloodsucker/targeted/mesmerize
	name = "Mesmerize"
	desc = "Dominate the mind of a mortal who can see your eyes."
	button_icon_state = "power_mez"
	power_explanation = "<b>Mesmerize</b>:\n\
		Click any player to attempt to mesmerize them.\n\
		You cannot wear anything covering your face, and both parties must be facing eachother. Obviously, both parties need to not be blind. \n\
		If your target is already mesmerized or a Monster Hunter, the Power will fail.\n\
		Once mesmerized, the target will be unable to move for a certain amount of time, scaling with level.\n\
		At level 2, your target will additionally be Muted.\n\
		At level 3, you will be able to use the power through items covering your face.\n\
		At level 5, you will be able to mesmerize regardless of your target's direction.\n\
		At level 6, you will cause your target to fall asleep.\n\
		Higher levels will increase the time of the mesmerize's freeze."
	bloodcost = 30
	cooldown = 200
	target_range = 5
	power_activates_immediately = FALSE
	message_Trigger = "Whom will you subvert to your will?"
	must_be_capacitated = TRUE
	bloodsucker_can_buy = TRUE
	vassal_can_buy = TRUE
	///Our mesmerized target - Prevents several mesmerizes.
	var/mob/living/mesmerized_target

/datum/action/bloodsucker/targeted/mesmerize/CheckCanUse(display_error)
	if(!..()) // Default checks
		return FALSE
	if(!owner.getorganslot(ORGAN_SLOT_EYES))
		if(display_error)
			// Cant use balloon alert, they've got no eyes!
			to_chat(owner, span_warning("You have no eyes with which to mesmerize."))
		return FALSE
	// Check: Eyes covered?
	var/mob/living/carbon/L = owner
	if(istype(L) && (L.is_eyes_covered() && level_current <= 2) || !isturf(L.loc))
		if(display_error)
			owner.balloon_alert(owner, "your eyes are concealed from sight.")
		return FALSE
	return TRUE

/datum/action/bloodsucker/targeted/mesmerize/CheckValidTarget(atom/A)
	return isliving(A)

/datum/action/bloodsucker/targeted/mesmerize/CheckCanTarget(atom/A, display_error)
	if(!..())
		return FALSE
	// Check: Self
	if(A == owner)
		return FALSE
	var/mob/living/target = A // We already know it's carbon due to CheckValidTarget()
	// No mind
	if(!target.mind)
		if(display_error)
			owner.balloon_alert(owner, "[target] is mindless.")
		return FALSE
	// Bloodsucker
	if(IS_BLOODSUCKER(target))
		if(display_error)
			owner.balloon_alert(owner, "bloodsuckers are immune to [src].")
		return FALSE
	// Dead/Unconscious
	if(target.stat > CONSCIOUS)
		if(display_error)
			owner.balloon_alert(owner, "[target] is not [(target.stat == DEAD || HAS_TRAIT(target, TRAIT_FAKEDEATH))?"alive":"conscious"].")
		return FALSE
	// Check: Target has eyes?
	if(!target.getorganslot(ORGAN_SLOT_EYES))
		if(display_error)
			owner.balloon_alert(owner, "[target] has no eyes!")
		return FALSE
	// Check: Target blind?
	if(target.eye_blind > 0)
		if(display_error)
			owner.balloon_alert(owner, "[target] is blind.")
		return FALSE
	// Check: Target See Me? (behind wall)
	if(!(owner in view(target_range, get_turf(target))))
		// Sub-Check: GET CLOSER
		//if (!(owner in range(target_range, get_turf(target)))
		//	if (display_error)
		//		to_chat(owner, span_warning("You're too far from your victim."))
		if(display_error)
			owner.balloon_alert(owner, "too far away!")
		return FALSE
	// Check: Facing target?
	if(!is_A_facing_B(owner, target)) // in unsorted.dm
		if(display_error)
			owner.balloon_alert(owner, "you must be facing [target].")
		return FALSE
	// Check: Target facing me? (On the floor, they're facing everyone)
	if(((target.mobility_flags & MOBILITY_STAND) && !is_A_facing_B(target, owner) && level_current <= 4))
		if(display_error)
			owner.balloon_alert(owner, "[target] must be facing you.")
		return FALSE

	// Gone through our checks, let's mark our guy.
	mesmerized_target = target
	return TRUE

/datum/action/bloodsucker/targeted/mesmerize/FireTargetedPower(atom/A)
	. = ..()
	// set waitfor = FALSE   <---- DONT DO THIS!We WANT this power to hold up ClickWithPower(), so that we can unlock the power when it's done.

	var/mob/living/user = owner

	if(istype(mesmerized_target))
		owner.balloon_alert(owner, "attempting to hypnotically gaze [mesmerized_target]...")

	if(!do_mob(user, mesmerized_target, 4 SECONDS, NONE, TRUE, extra_checks = CALLBACK(src, .proc/ContinueActive, user, mesmerized_target)))
		return

	PowerActivatedSuccessfully() // PAY COST! BEGIN COOLDOWN!
	var/power_time = 90 + level_current * 15
	if(IS_MONSTERHUNTER(mesmerized_target))
		to_chat(mesmerized_target, span_notice("You feel your eyes burn for a while, but it passes."))
		return
	if(HAS_TRAIT_FROM(mesmerized_target, TRAIT_MUTE, BLOODSUCKER_TRAIT))
		owner.balloon_alert(owner, "[mesmerized_target] is already in a hypnotic gaze.")
		return
	if(iscarbon(mesmerized_target))
		var/mob/living/carbon/mesmerized = mesmerized_target
		owner.balloon_alert(owner, "successfully mesmerized [mesmerized].")
		if(level_current >= 6)
			ADD_TRAIT(mesmerized, TRAIT_KNOCKEDOUT, BLOODSUCKER_TRAIT)
		else if(level_current >= 2)
			ADD_TRAIT(mesmerized, TRAIT_MUTE, BLOODSUCKER_TRAIT)
		mesmerized.Immobilize(power_time)
		//mesmerized.silent += power_time / 10 // Silent isn't based on ticks.
		mesmerized.next_move = world.time + power_time // <--- Use direct change instead. We want an unmodified delay to their next move // mesmerized.changeNext_move(power_time) // check click.dm
		mesmerized.notransform = TRUE // <--- Fuck it. We tried using next_move, but they could STILL resist. We're just doing a hard freeze.
		addtimer(CALLBACK(src, .proc/end_mesmerize, user, mesmerized_target), power_time)
	if(issilicon(mesmerized_target))
		var/mob/living/silicon/mesmerized = mesmerized_target
		mesmerized.emp_act(EMP_HEAVY)
		owner.balloon_alert(owner, "temporarily shut [mesmerized] down.")
	// Finished, clear target.
	mesmerized_target = null

/datum/action/bloodsucker/targeted/mesmerize/proc/end_mesmerize(mob/living/user, mob/living/target)
	target.notransform = FALSE
	REMOVE_TRAIT(target, TRAIT_KNOCKEDOUT, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(target, TRAIT_MUTE, BLOODSUCKER_TRAIT)
	// They Woke Up! (Notice if within view)
	if(istype(user) && target.stat == CONSCIOUS && (target in view(6, get_turf(user))))
		owner.balloon_alert(owner, "[target] snapped out of their trance.")

/datum/action/bloodsucker/targeted/mesmerize/ContinueActive(mob/living/user, mob/living/target)
	return ..() && CheckCanUse() && CheckCanTarget(target)
