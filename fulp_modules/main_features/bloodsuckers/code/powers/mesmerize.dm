/*
 *	MEZMERIZE
 *	 STAY: Target will do everything they can to stand in the same place.
 *	 FOLLOW: Target follows you, spouting random phrases from their history (or maybe Poly's or NPC's vocab?)
 *	 ATTACK: Target finds a nearby non-Bloodsucker victim to attack.
 */

/datum/action/bloodsucker/targeted/mesmerize
	name = "Mesmerize"
	desc = "Dominate the mind of a mortal who can see your eyes."
	button_icon_state = "power_mez"
	bloodcost = 30
	cooldown = 200
	target_range = 5
	power_activates_immediately = FALSE
	message_Trigger = "Whom will you subvert to your will?"
	must_be_capacitated = TRUE
	bloodsucker_can_buy = TRUE

/datum/action/bloodsucker/targeted/mesmerize/CheckCanUse(display_error)
	. = ..()
	if(!.) // DEFAULT CHECKS
		return FALSE
	if(!owner.getorganslot(ORGAN_SLOT_EYES))
		if(display_error)
			to_chat(owner, span_warning("You have no eyes with which to mesmerize."))
		return FALSE
	// Check: Eyes covered?
	var/mob/living/L = owner
	if(istype(L) && L.is_eyes_covered() || !isturf(owner.loc))
		if(display_error)
			to_chat(owner, span_warning("Your eyes are concealed from sight."))
		return FALSE
	return TRUE

/datum/action/bloodsucker/targeted/mesmerize/CheckValidTarget(atom/A)
	return isliving(A)

/datum/action/bloodsucker/targeted/mesmerize/CheckCanTarget(atom/A, display_error)
	// DON'T DO THIS - Mesmerize is meant to work from a distance.
//	if(!..())
//		return FALSE
	// Check: Self
	if(A == owner)
		return FALSE
	var/mob/living/target = A // We already know it's carbon due to CheckValidTarget()
	// Bloodsucker
	if(target.mind && target.mind.has_antag_datum(/datum/antagonist/bloodsucker))
		if(display_error)
			to_chat(owner, span_warning("Bloodsuckers are immune to [src]."))
		return FALSE
	// Dead/Unconscious
	if(target.stat > CONSCIOUS)
		if(display_error)
			to_chat(owner, span_warning("Your victim is not [(target.stat == DEAD || HAS_TRAIT(target, TRAIT_FAKEDEATH))?"alive":"conscious"]."))
		return FALSE
	// Check: Target has eyes?
	if(!target.getorganslot(ORGAN_SLOT_EYES))
		if(display_error)
			to_chat(owner, span_warning("They have no eyes!"))
		return FALSE
	// Check: Target blind?
	if(target.eye_blind > 0)
		if(display_error)
			to_chat(owner, span_warning("Your victim's eyes are glazed over. They cannot perceive you."))
		return FALSE
	// Check: Target See Me? (behind wall)
	if(!(owner in view(target_range, get_turf(target))))
		// Sub-Check: GET CLOSER
		//if (!(owner in range(target_range, get_turf(target)))
		//	if (display_error)
		//		to_chat(owner, span_warning("You're too far from your victim."))
		if(display_error)
			to_chat(owner, span_warning("You're too far outside your victim's view."))
		return FALSE
	// Check: Facing target?
	if(!is_A_facing_B(owner,target)) // in unsorted.dm
		if(display_error)
			to_chat(owner, span_warning("You must be facing your victim."))
		return FALSE
	// Check: Target facing me? (On the floor, they're facing everyone)
	if((target.mobility_flags & MOBILITY_STAND) && !is_A_facing_B(target,owner))
		if(display_error)
			to_chat(owner, span_warning("Your victim must be facing you to see into your eyes."))
		return FALSE

	return TRUE

/datum/action/bloodsucker/targeted/mesmerize/FireTargetedPower(atom/A)
	// set waitfor = FALSE   <---- DONT DO THIS!We WANT this power to hold up ClickWithPower(), so that we can unlock the power when it's done.

	var/mob/living/target = A
	var/mob/living/user = owner

	if(istype(target))
		to_chat(user, span_notice("You attempt to hypnotically gaze [target]."))

	if(do_mob(user, target, 4 SECONDS, NONE, TRUE, extra_checks = CALLBACK(src, .proc/ContinueActive, user, target)))
		PowerActivatedSuccessfully() // PAY COST! BEGIN COOLDOWN!
		var/power_time = 90 + level_current * 15
		if(iscarbon(target))
			var/mob/living/carbon/mesmerized = target
			if(IS_MONSTERHUNTER(mesmerized))
				to_chat(mesmerized, span_notice("You feel your eyes burn for a while, but it passes."))
				return
			ADD_TRAIT(mesmerized, TRAIT_MUTE, BLOODSUCKER_TRAIT)
			to_chat(user, span_notice("[mesmerized] is fixed in place by your hypnotic gaze."))
			mesmerized.Immobilize(power_time)
			//mesmerized.silent += power_time / 10 // Silent isn't based on ticks.
			mesmerized.next_move = world.time + power_time // <--- Use direct change instead. We want an unmodified delay to their next move // mesmerized.changeNext_move(power_time) // check click.dm
			mesmerized.notransform = TRUE // <--- Fuck it. We tried using next_move, but they could STILL resist. We're just doing a hard freeze.
			spawn(power_time)
				if(istype(mesmerized))
					mesmerized.notransform = FALSE
					REMOVE_TRAIT(mesmerized, TRAIT_MUTE, BLOODSUCKER_TRAIT)
					// They Woke Up! (Notice if within view)
					if(istype(user) && mesmerized.stat == CONSCIOUS && (mesmerized in view(6, get_turf(user))))
						to_chat(user, span_warning("[mesmerized] has snapped out of their trance."))
		if(issilicon(target))
			var/mob/living/silicon/mesmerized = target
			mesmerized.emp_act(EMP_HEAVY)
			to_chat(user, span_warning("You have temporarily shut [mesmerized] down."))

/datum/action/bloodsucker/targeted/mesmerize/ContinueActive(mob/living/user, mob/living/target)
	return ..() && CheckCanUse() && CheckCanTarget(target)

///Vassal edition
/datum/action/bloodsucker/targeted/mesmerize/hypnotize
	name = "Hypnotize"
	desc = "Stare into the eyes of someone watching you, temporarily hypnotizing them."
	bloodsucker_can_buy = FALSE
	vassal_can_buy = TRUE
