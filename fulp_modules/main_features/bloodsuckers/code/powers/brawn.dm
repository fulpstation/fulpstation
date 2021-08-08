/datum/action/bloodsucker/targeted/brawn
	name = "Brawn"
	desc = "Snap restraints, break lockers and doors, or deal terrible damage with your bare hands."
	button_icon_state = "power_strength"
	bloodcost = 8
	cooldown = 90
	target_range = 1
	power_activates_immediately = TRUE
	must_be_capacitated = TRUE
	can_use_w_immobilize = TRUE
	bloodsucker_can_buy = TRUE

/datum/action/bloodsucker/targeted/brawn/CheckCanUse(display_error)
	if(!..()) // Default checks
		return FALSE
	///Have we used our power yet?
	var/usedPower = FALSE

	if(CheckBreakRestraints()) // Did we break out of our handcuffs?
		usedPower = TRUE
	if(usedPower || level_current >= 3)
		if(CheckEscapePuller()) // Did we knock a grabber down? We can only do this while not also breaking restraints if strong enough.
			usedPower = TRUE
	// If we broke restraints or knocked a grabber down, we've spent our power.
	if(usedPower == TRUE)
		PowerActivatedSuccessfully()
		return FALSE
	// Otherwise, we can now punch someone.
	return TRUE

// Look at 'biodegrade.dm' for reference
/datum/action/bloodsucker/targeted/brawn/proc/CheckBreakRestraints()
	var/mob/living/carbon/human/user = owner
	///Only one form of shackles removed per use
	var/used = FALSE

	// Breaks out of lockers
	if(istype(user.loc, /obj/structure/closet))
		var/obj/structure/closet/closet = user.loc
		if(!istype(closet))
			return FALSE
		closet.visible_message("<span class='warning'>[closet] tears apart as [user] bashes it open from within!</span>")
		to_chat(user, "<span class='warning'>We bash [closet] wide open!</span>")
		addtimer(CALLBACK(src, .proc/break_closet, user, closet), 1)
		used = TRUE

	// Remove both Handcuffs & Legcuffs
	var/obj/cuffs = user.get_item_by_slot(ITEM_SLOT_HANDCUFFED)
	var/obj/legcuffs = user.get_item_by_slot(ITEM_SLOT_LEGCUFFED)
	if(!used && (istype(cuffs) || istype(legcuffs)))
		user.visible_message("<span class='warning'>[user] discards their restraints like it's nothing!</span>", \
			"<span class='warning'>We break through our restraints!</span>")
		user.clear_cuffs(cuffs, TRUE)
		user.clear_cuffs(legcuffs, TRUE)
		used = TRUE

	// Remove Straightjackets
	if(user.wear_suit?.breakouttime && !used)
		var/obj/item/clothing/suit/S = user.get_item_by_slot(ITEM_SLOT_OCLOTHING)
		user.visible_message("<span class='warning'>[user] rips straight through the [user.p_their()] [S]!</span>", \
			"<span class='warning'>We tear through our straightjacket!</span>")
		if(S && user.wear_suit == S)
			qdel(S)
		used = TRUE

	// Did we end up using our ability? If so, play the sound effect and return TRUE
	if(used)
		playsound(get_turf(user), 'sound/effects/grillehit.ogg', 80, 1, -1)
	return used

// This is its own proc because its done twice, to repeat code copypaste.
/datum/action/bloodsucker/targeted/brawn/proc/break_closet(mob/living/carbon/human/user, obj/structure/closet/closet)
	if(closet)
		closet.welded = FALSE
		closet.locked = FALSE
		closet.broken = TRUE
		closet.open()

/datum/action/bloodsucker/targeted/brawn/proc/CheckEscapePuller()
	if(!owner.pulledby) // || owner.pulledby.grab_state <= GRAB_PASSIVE)
		return FALSE
	var/mob/M = owner.pulledby
	var/pull_power = M.grab_state
	playsound(get_turf(M), 'sound/effects/woodhit.ogg', 75, 1, -1)
	// Knock Down (if Living)
	if(isliving(M))
		var/mob/living/L = M
		L.Knockdown(pull_power * 10 + 20)
	// Knock Back (before Knockdown, which probably cancels pull)
	var/send_dir = get_dir(owner, M)
	var/turf/T = get_ranged_target_turf(M, send_dir, pull_power)
	owner.newtonian_move(send_dir) // Bounce back in 0 G
	M.throw_at(T, pull_power, TRUE, owner, FALSE) // Throw distance based on grab state! Harder grabs punished more aggressively.
	// /proc/log_combat(atom/user, atom/target, what_done, atom/object=null, addition=null)
	log_combat(owner, M, "used Brawn power")
	owner.visible_message(span_warning("[owner] tears free of [M]'s grasp!"), \
			 			span_warning("You shrug off [M]'s grasp!"))
	owner.pulledby = null // It's already done, but JUST IN CASE.
	return TRUE

/datum/action/bloodsucker/targeted/brawn/FireTargetedPower(atom/A)
	// set waitfor = FALSE   <---- DONT DO THIS! We WANT this power to hold up ClickWithPower(), so that we can unlock the power when it's done.
	var/mob/living/target = A
	var/mob/living/user = owner
	// Target Type: Mob
	if(isliving(target))
		var/mob/living/carbon/user_C = user
		var/hitStrength = user_C.dna.species.punchdamagehigh * 1.25 + 2
		// Knockdown!
		var/powerlevel = min(5, 1 + level_current)
		if(rand(5 + powerlevel) >= 5)
			target.visible_message(span_danger("[user] lands a vicious punch, sending [target] away!"), \
							  span_userdanger("[user] has landed a horrifying punch on you, sending you flying!"), null, COMBAT_MESSAGE_RANGE)
			target.Knockdown(min(5, rand(10, 10 * powerlevel)))
		// Attack!
		owner.balloon_alert(owner, "you punch [target]!")
		playsound(get_turf(target), 'sound/weapons/punch4.ogg', 60, 1, -1)
		user.do_attack_animation(target, ATTACK_EFFECT_SMASH)
		var/obj/item/bodypart/affecting = target.get_bodypart(ran_zone(target.zone_selected))
		target.apply_damage(hitStrength, BRUTE, affecting)
		// Knockback
		var/send_dir = get_dir(owner, target)
		var/turf/T = get_ranged_target_turf(target, send_dir, powerlevel)
		owner.newtonian_move(send_dir) // Bounce back in 0 G
		target.throw_at(T, powerlevel, TRUE, owner) //new /datum/forced_movement(target, get_ranged_target_turf(target, send_dir, (hitStrength / 4)), 1, FALSE)
		// Target Type: Cyborg (Also gets the effects above)
		if(issilicon(target))
			target.emp_act(EMP_HEAVY)
	// Target Type: Door
	else if(istype(target, /obj/machinery/door))
		if(level_current >= 3)
			var/obj/machinery/door/D = target
			playsound(get_turf(usr), 'sound/machines/airlock_alien_prying.ogg', 40, 1, -1)
			owner.balloon_alert(owner, "you prepare to tear open [D]")
			if(do_mob(usr, target, 2.5 SECONDS))
				if(D.Adjacent(user))
					D.balloon_alert_to_viewers("breaks open as [user] bashes it!")
					user.Stun(10)
					user.do_attack_animation(D, ATTACK_EFFECT_SMASH)
					playsound(get_turf(D), 'sound/effects/bang.ogg', 30, 1, -1)
					D.open(2) // open(2) is like a crowbar or jaws of life.
		else
			owner.balloon_alert(owner, "you're too weak for this!")
			return FALSE
	// Target Type: Locker
	else if(istype(target, /obj/structure/closet))
		if(level_current >= 2)
			var/obj/structure/closet/C = target
			user.balloon_alert(user, "you prepare to bash [C] open")
			if(do_mob(usr, target, 2.5 SECONDS))
				C.balloon_alert_to_viewers("breaks open as [user] bashes it!")
				addtimer(CALLBACK(src, .proc/break_closet, user, C), 1)
				playsound(get_turf(user), 'sound/effects/grillehit.ogg', 80, 1, -1)
		else
			owner.balloon_alert(owner, "you're too weak for this!")
			return FALSE

/datum/action/bloodsucker/targeted/brawn/CheckValidTarget(atom/A)
	return isliving(A) || istype(A, /obj/machinery/door) || istype(A, /obj/structure/closet)

/datum/action/bloodsucker/targeted/brawn/CheckCanTarget(atom/A, display_error)
	// DEFAULT CHECKS (Distance)
	if(!..()) // Disable range notice for Brawn.
		return FALSE
	// Must outside Closet to target anyone!
	if(!isturf(owner.loc))
		return FALSE
	// Check: Self
	if(A == owner)
		return FALSE
	// Target Type: Living
	if(isliving(A))
		return TRUE
	// Target Type: Door
	else if(istype(A, /obj/machinery/door))
		return TRUE
	// Target Type: Locker
	else if(istype(A, /obj/structure/closet))
		return TRUE
	return ..() // yes, FALSE! You failed if you got here! BAD TARGET

/// Vassal version
/datum/action/bloodsucker/targeted/brawn/vassal
	name = "Strength"
	desc = "Snap restraints, break lockers and doors, or deal terrible damage with your bare hands."
	bloodsucker_can_buy = FALSE
	vassal_can_buy = TRUE
