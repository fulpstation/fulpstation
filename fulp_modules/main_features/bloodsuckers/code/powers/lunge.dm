/datum/action/bloodsucker/targeted/lunge
	name = "Predatory Lunge"
	desc = "Spring at your target to grapple them without warning, or tear the dead's heart out. Attacks from concealment or the rear may even knock them down if strong enough."
	button_icon_state = "power_lunge"
	power_explanation = "<b>Predatory Lunge</b>:\n\
		Click any player to instantly dash at them, aggressively grabbing them.\n\
		You cannot use the Power if you are aggressively grabbed.\n\
		If the target is wearing riot gear or is a Monster Hunter, you will merely passively grab them.\n\
		If grabbed from behind or from the darkness (Cloak of Darkness counts), you will additionally knock the target down.\n\
		Higher levels will increase the knockdown dealt to enemies."
	power_flags = NONE
	check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY|BP_CANT_USE_WHILE_INCAPACITATED|BP_CANT_USE_WHILE_UNCONSCIOUS
	purchase_flags = BLOODSUCKER_CAN_BUY|VASSAL_CAN_BUY
	bloodcost = 10
	cooldown = 10 SECONDS
	target_range = 3
	power_activates_immediately = TRUE

/*
 *	Level 1: Grapple level 2
 *	Level 2: Grapple 3 from Behind
 *	Level 3: Grapple 3 from Shadows
 */

/datum/action/bloodsucker/targeted/lunge/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return FALSE
	/// Are we being grabbed?
	if(owner.pulledby && owner.pulledby.grab_state >= GRAB_AGGRESSIVE)
		if(display_error)
			to_chat(owner, span_warning("You're being grabbed!"))
		return FALSE
	return TRUE

/// Check: Are we lunging at a person?
/datum/action/bloodsucker/targeted/lunge/CheckValidTarget(atom/target_atom)
	. = ..()
	if(!.)
		return FALSE
	return isliving(target_atom)

/datum/action/bloodsucker/targeted/lunge/CheckCanTarget(atom/target_atom, display_error)
	// Default Checks (Distance)
	. = ..()
	if(!.)
		return FALSE
	/*
	/// Check: Range
	if(!(target_atom in view(target_range, get_turf(owner))))
		if(display_error)
			owner.balloon_alert(owner, "out of range.")
		return FALSE
	*/
	// Check: Turf
	var/mob/living/turf_target = target_atom
	if(!isturf(turf_target.loc))
		return FALSE
	// Check: can the Bloodsucker even move?
	var/mob/living/user = owner
	if(user.body_position == LYING_DOWN || HAS_TRAIT(owner, TRAIT_IMMOBILIZED))
		return FALSE
	return TRUE

/datum/action/bloodsucker/targeted/lunge/FireTargetedPower(atom/target_atom)
	. = ..()
	// set waitfor = FALSE   <---- DONT DO THIS! We WANT this power to hold up ClickWithPower(), so that we can unlock the power when it's done.
	var/mob/living/user = owner
	var/mob/living/carbon/target = target_atom
	var/turf/targeted_turf = get_turf(target)

	/// Stop pulling anyone (If we are)
	owner.pulling = null

	owner.face_atom(target_atom)
	/// Don't move as we perform this, please.
	ADD_TRAIT(user, TRAIT_IMMOBILIZED, BLOODSUCKER_TRAIT)
	/// Directly copied from haste.dm
	var/safety = get_dist(user, targeted_turf) * 3 + 1
	var/consequetive_failures = 0
	while(--safety && !target.Adjacent(user))
		/// This does not try to go around obstacles.
		var/success = step_towards(user, targeted_turf)
		if(!success)
			/// This does
			success = step_to(user, targeted_turf)
		if(!success)
			consequetive_failures++
			/// If 3 steps don't work, just stop.
			if(consequetive_failures >= 3)
				break
		/// we've succeeded at least once? Reset it.
		else
			consequetive_failures = 0
	/// It ended? Let's get our target now.
	lunge_end(target)

/datum/action/bloodsucker/targeted/lunge/proc/lunge_end(atom/hit_atom)
	var/mob/living/user = owner
	var/mob/living/carbon/target = hit_atom
	var/turf/target_turf = get_turf(target)
	// Check: Will our lunge knock them down? This is done if the target is looking away, the user is in Cloak of Darkness, or in a closet.
	var/do_knockdown = !is_source_facing_target(target, owner) || owner.alpha <= 40 || istype(owner.loc, /obj/structure/closet)

	/// We got a target?
	/// Am I next to my target to start giving the effects?
	if(user.Adjacent(target))
		// Did I slip?
		if(!user.body_position == STANDING_UP)
			return
		// Is my target a Monster hunter?
		if(IS_MONSTERHUNTER(target))
			owner.balloon_alert(owner, "you get pushed away!")
			target.grabbedby(owner)
			return

		owner.balloon_alert(owner, "you lunge at [target]!")
		/// Good to go!
		target.Stun(10 + level_current * 5)
		// Instantly aggro grab them if they don't have riot gear.
		target.grabbedby(owner)
		if(!target.is_shove_knockdown_blocked())
			target.grippedby(owner, instant = TRUE)
		// Did we knock them down?
		if(do_knockdown && level_current >= 3)
			target.Knockdown(10 + level_current * 5)
			target.Paralyze(0.1)
		/// Are they dead?
		if(target.stat == DEAD)
			var/obj/item/bodypart/chest = target.get_bodypart(BODY_ZONE_CHEST)
			var/datum/wound/slash/moderate/crit_wound = new
			crit_wound.apply_wound(chest)
			owner.visible_message(
				span_warning("[owner] tears into [target]'s chest!"),
				span_warning("You tear into [target]'s chest!"),
			)
			var/obj/item/organ/heart/myheart_now = locate() in target.internal_organs
			if(myheart_now)
				myheart_now.Remove(target)
				user.put_in_hands(myheart_now)
	// Lastly, did we get knocked down by the time we did this?
	if(user && user.incapacitated())
		if(!(user.body_position == LYING_DOWN))
			var/send_dir = get_dir(user, target_turf)
			new /datum/forced_movement(user, get_ranged_target_turf(user, send_dir, 1), 1, FALSE)
			user.spin(10)

	//DeactivatePower()

/datum/action/bloodsucker/targeted/lunge/DeactivatePower(mob/living/user = owner, mob/living/target)
	REMOVE_TRAIT(user, TRAIT_IMMOBILIZED, BLOODSUCKER_TRAIT)
	..()
