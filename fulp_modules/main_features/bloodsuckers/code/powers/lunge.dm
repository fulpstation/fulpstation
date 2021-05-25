/datum/action/bloodsucker/targeted/lunge // WILLARDTODO: Fix this, refer to haste.dm maybe? Missing this ability on someone causes them to be trapped immobilized until they re-use it.
	name = "Predatory Lunge"
	desc = "Spring at your target to grapple them without warning, or tear the dead's heart out. Attacks from concealment or the rear may even knock them down."
	button_icon_state = "power_lunge"
	bloodcost = 10
	cooldown = 100
	target_range = 3
	power_activates_immediately = TRUE
	message_Trigger = ""
	must_be_capacitated = TRUE
	bloodsucker_can_buy = TRUE

/*
 *	Level 1: Grapple level 2
 *	Level 2: Grapple 3 from Behind
 *	Level 3: Grapple 3 from Shadows
 */

/datum/action/bloodsucker/targeted/lunge/CheckCanUse(display_error)
	/// Default checks
	if(!..(display_error))
		return FALSE
	/// Are we being grabbed?
	if(owner.pulledby && owner.pulledby.grab_state >= GRAB_AGGRESSIVE)
		if(display_error)
			to_chat(owner, "<span class='warning'>You're being grabbed!</span>")
		return FALSE
	return TRUE

/// Check: Are we lunging at a person?
/datum/action/bloodsucker/targeted/lunge/CheckValidTarget(atom/A)
	return isliving(A)

/datum/action/bloodsucker/targeted/lunge/CheckCanTarget(atom/A, display_error)
	/// Default Checks (Distance)
	if(!..())
		return FALSE
	/// Check: Self
	if(target == owner)
		return FALSE
/*
	/// Check: Range
	if(!(target in view(target_range, get_turf(owner))))
		if(display_error)
			to_chat(owner, "<span class='warning'>Your victim is too far away.</span>")
		return FALSE
*/
	/// Check: Turf
	var/mob/living/L = A
	if(!isturf(L.loc))
		return FALSE
	/// Check: can the Bloodsucker even move?
	var/mob/living/user = owner
	if(user.body_position == LYING_DOWN || HAS_TRAIT(owner, TRAIT_IMMOBILIZED))
		return FALSE
	return TRUE

/datum/action/bloodsucker/targeted/lunge/FireTargetedPower(atom/A)
	// set waitfor = FALSE   <---- DONT DO THIS! We WANT this power to hold up ClickWithPower(), so that we can unlock the power when it's done.
	var/mob/living/user = owner
	var/mob/living/carbon/target = A
	var/turf/T = get_turf(target)

	/// Stop pulling anyone (If we are)
	owner.pulling = null

	owner.face_atom(A)
	/// Don't move as we perform this, please.
	ADD_TRAIT(user, TRAIT_IMMOBILIZED, BLOODSUCKER_TRAIT)
	/// Directly copied from haste.dm
	var/consequetive_failures = 0
	while(!target.Adjacent(user))
		/// This does not try to go around obstacles.
		var/success = step_towards(user, T)
		if(!success)
			/// This does
			success = step_to(user, T)
		if(!success)
			/// If 3 steps don't work, just stop.
			if(++consequetive_failures >= 3)
				break
		else
			consequetive_failures = 0
	lunge_end(target)

/datum/action/bloodsucker/targeted/lunge/proc/lunge_end(atom/hit_atom)
	var/mob/living/user = owner
	var/mob/living/carbon/target = hit_atom
	var/turf/T = get_turf(target)
	/// Check: Will our lunge knock them down? This is done if the target is looking away, the user is in Cloak of Darkness, or in a closet.
	var/do_knockdown = !is_A_facing_B(target, owner) || owner.alpha <= 40 || istype(owner.loc, /obj/structure/closet)

	/// We got a target?
	/// Am I next to my target to start giving the effects?
	if(user.Adjacent(target))
		/// Is my target a Monster hunter?
		if(IS_MONSTERHUNTER(target))
			to_chat(owner, "<span class='warning'>You get pushed away as you advance, and fail to get a strong grasp!</span>")
			target.grabbedby(owner)
			return

		/// Good to go!
		target.Stun(15 + level_current * 5)
		/// Instantly aggro grab them
		target.grabbedby(owner)
		target.grippedby(owner, instant = TRUE)
		/// Did we knock them down?
		if(do_knockdown) //&& level_current >= 1)
			target.Knockdown(10 + level_current * 5)
			target.Paralyze(0.1)
		/// Are they dead?
		if(target.stat == DEAD)
			var/obj/item/bodypart/chest = target.get_bodypart(BODY_ZONE_CHEST)
			var/datum/wound/slash/moderate/crit_wound = new
			crit_wound.apply_wound(chest)
			owner.visible_message(
				"<span class='warning'>[owner] tears into [target]'s chest!</span>",
				"<span class='warning'>You tear into [target]'s chest!</span>"
				)
			var/obj/item/organ/heart/myheart_now = locate() in target.internal_organs
			if(myheart_now)
				myheart_now.Remove(target)
				user.put_in_hands(myheart_now)
				to_chat(owner, "<span class='warning'>You tear [myheart_now] out of [target]!</span>")
			else
				to_chat(user, "<span class='notice'>[target] doesn't have a heart to rip out!</span>")
	REMOVE_TRAIT(user, TRAIT_IMMOBILIZED, BLOODSUCKER_TRAIT)
	/// Lastly, did we get knocked down by the time we did this?
	if(user && user.incapacitated())
		if(!(user.body_position == LYING_DOWN))
			var/send_dir = get_dir(user, T)
			new /datum/forced_movement(user, get_ranged_target_turf(user, send_dir, 1), 1, FALSE)
			user.spin(10)

	//DeactivatePower()

/datum/action/bloodsucker/targeted/lunge/DeactivatePower(mob/living/user = owner, mob/living/target)
	REMOVE_TRAIT(user, TRAIT_IMMOBILIZED, BLOODSUCKER_TRAIT)
	..()
