/*
 *	# Dominate;
 *
 *	Level 1 - Mesmerizes target
 *	Level 2 - Mesmerizes and mutes target
 *	Level 3 - Mesmerizes, blinds and mutes target
 *	Level 4 - Target (if at least in crit & has a mind) will revive as a Mute/Deaf Vassal for 5 minutes before dying.
 *	Level 5 - Target (if at least in crit & has a mind) will revive as a Vassal for 8 minutes before dying.
 */

/datum/action/bloodsucker/targeted/tremere/dominate_one
	name = "Level 1: Dominate"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/dominate_two
	desc = "Mesmerize any foe who stands still long enough."

	button_icon_state = "power_mez"
	power_explanation = "<b>Level 1: Dominate</b>:\n\
		Click any person to, after a 4 second timer, Mesmerize them.\n\
		This will completely immobilize them for the next 10.5 seconds."
	bloodsucker_can_buy = TRUE
	bloodcost = 40
	cooldown = 500
	target_range = 6
	power_activates_immediately = FALSE
	message_Trigger = "Whom will you subvert to your will?"
	must_be_capacitated = TRUE

/datum/action/bloodsucker/targeted/tremere/dominate_one/FireTargetedPower(atom/A)
	. = ..()
	var/mob/living/target = A
	var/mob/living/user = owner
	attempt_mesmerize(target, user, level = 1)

/datum/action/bloodsucker/targeted/tremere/proc/attempt_mesmerize(mob/living/target, mob/living/user, level = 1)
	if(!do_mob(user, target, 3 SECONDS, NONE, TRUE))
		return

	PowerActivatedSuccessfully() // PAY COST! BEGIN COOLDOWN!
	var/power_time = 90 + level * 15
	if(IS_MONSTERHUNTER(target))
		to_chat(target, span_notice("You feel you something crawling under your skin, but it passes."))
		return
	if(HAS_TRAIT_FROM(target, TRAIT_MUTE, BLOODSUCKER_TRAIT))
		owner.balloon_alert(owner, "[target] is already in some form of hypnotic gaze.")
		return
	if(iscarbon(target))
		var/mob/living/carbon/mesmerized = target
		owner.balloon_alert(owner, "successfully mesmerized [mesmerized].")
		if(level == 2)
			ADD_TRAIT(target, TRAIT_MUTE, BLOODSUCKER_TRAIT)
		if(level == 3)
			ADD_TRAIT(target, TRAIT_BLIND, BLOODSUCKER_TRAIT)
		mesmerized.Immobilize(power_time)
		//mesmerized.silent += power_time / 10 // Silent isn't based on ticks.
		mesmerized.next_move = world.time + power_time // <--- Use direct change instead. We want an unmodified delay to their next move // mesmerized.changeNext_move(power_time) // check click.dm
		mesmerized.notransform = TRUE // <--- Fuck it. We tried using next_move, but they could STILL resist. We're just doing a hard freeze.
		addtimer(CALLBACK(src, .proc/end_mesmerize, user, target), power_time)
	if(issilicon(target))
		var/mob/living/silicon/mesmerized = target
		mesmerized.emp_act(EMP_HEAVY)
		owner.balloon_alert(owner, "temporarily shut [mesmerized] down.")

/datum/action/bloodsucker/targeted/tremere/proc/end_mesmerize(mob/living/user, mob/living/target)
	target.notransform = FALSE
	REMOVE_TRAIT(target, TRAIT_BLIND, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(target, TRAIT_MUTE, BLOODSUCKER_TRAIT)
	if(istype(user) && target.stat == CONSCIOUS && (target in view(6, get_turf(user))))
		owner.balloon_alert(owner, "[target] snapped out of their trance.")

/datum/action/bloodsucker/targeted/tremere/dominate_two
	name = "Level 2: Dominate"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/dominate_three
	desc = "Mesmerize and mute any foe who stands still long enough."

	button_icon_state = "power_mez"
	power_explanation = "<b>Level 2: Dominate</b>:\n\
		Click any person to, after a 4 second timer, Mesmerize them.\n\
		This will completely immobilize and mute them for the next 12 seconds."
	bloodsucker_can_buy = TRUE
	bloodcost = 30
	cooldown = 450
	target_range = 6
	power_activates_immediately = FALSE
	message_Trigger = "Whom will you subvert to your will?"
	must_be_capacitated = TRUE

/datum/action/bloodsucker/targeted/tremere/dominate_two/FireTargetedPower(atom/A)
	. = ..()
	var/mob/living/target = A
	var/mob/living/user = owner
	attempt_mesmerize(target, user, level = 2)

/datum/action/bloodsucker/targeted/tremere/dominate_three
	name = "Level 3: Dominate"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/dominate_four
	desc = "Mesmerize, mute and blind any foe who stands still long enough."

	button_icon_state = "power_mez"
	power_explanation = "<b>Level 3: Dominate</b>:\n\
		Click any person to, after a 4 second timer, Mesmerize them.\n\
		This will completely immobilize, mute, and blind them for the next 13.5 seconds."
	bloodsucker_can_buy = TRUE
	bloodcost = 30
	cooldown = 400
	target_range = 6
	power_activates_immediately = FALSE
	message_Trigger = "Whom will you subvert to your will?"
	must_be_capacitated = TRUE

/datum/action/bloodsucker/targeted/tremere/dominate_three/FireTargetedPower(atom/A)
	. = ..()
	var/mob/living/target = A
	var/mob/living/user = owner
	attempt_mesmerize(target, user, level = 3)

/datum/action/bloodsucker/targeted/tremere/dominate_four
	name = "Level 4: Possession"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/dominate_five
	desc = "Mesmerize, mute and blind any foe who stands still long enough, or convert the damaged to temporary Vassals."

	button_icon_state = "power_strength"
	power_explanation = "<b>Level 4: Possession</b>:\n\
		Click any person to, after a 4 second timer, Mesmerize them.\n\
		This will completely immobilize, mute, and blind them for the next 13.5 seconds.\n\
		However, if your target is in critical condition or dead, they will instead be turned into a temporary Vassal.\n\
		Despite being Mute and Deaf, they will still have complete loyalty to you, until their death in 5 minutes upon use."
	bloodsucker_can_buy = TRUE
	bloodcost = 100
	cooldown = 3000 // 5 minutes
	target_range = 1
	power_activates_immediately = FALSE
	message_Trigger = "Whom will you subvert to your will?"
	must_be_capacitated = TRUE

/datum/action/bloodsucker/targeted/tremere/dominate_four/CheckCanTarget(atom/A, display_error)
	if(!..())
		return FALSE
	// Check: Self
	if(A == owner)
		return FALSE
	var/mob/living/target = A
	if(!target.mind)
		if(display_error)
			owner.balloon_alert(owner, "[target] is mindless.")
		return FALSE
	return TRUE

/datum/action/bloodsucker/targeted/tremere/dominate_four/FireTargetedPower(atom/A)
	. = ..()
	var/mob/living/target = A
	var/mob/living/user = owner
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)

	if(target.stat <= CONSCIOUS)
		attempt_mesmerize(target, user, level = 3)
		return

	if(!do_mob(user, target, 6 SECONDS, NONE, TRUE))
		return
	if(IS_MONSTERHUNTER(target))
		to_chat(target, span_notice("Their body refuses to react..."))
		return
	PowerActivatedSuccessfully()
	to_chat(user, span_warning("We revive [target]!"))
	target.mind.grab_ghost()
	target.revive(full_heal = TRUE, admin_revive = TRUE)
	ADD_TRAIT(target, TRAIT_MUTE, BLOODSUCKER_TRAIT)
	ADD_TRAIT(target, TRAIT_DEAF, BLOODSUCKER_TRAIT)
	bloodsuckerdatum.attempt_turn_vassal(target)
	addtimer(CALLBACK(src, .proc/end_possession, target), 5 MINUTES)

/datum/action/bloodsucker/targeted/tremere/dominate_five
	name = "Level 5: Possession"
	bloodsucker_can_buy = TRUE
	desc = "Mesmerize, mute and blind any foe who stands still long enough, or convert the damaged to temporary Vassals."

	button_icon_state = "power_strength"
	power_explanation = "<b>Level 5: Possession</b>:\n\
		Click any person to, after a 4 second timer, Mesmerize them.\n\
		This will completely immobilize, mute, and blind them for the next 13.5 seconds.\n\
		However, if your target is in critical condition or dead, they will instead be turned into a temporary Vassal.\n\
		They will have complete loyalty to you, until their death in 8 minutes upon use."
	bloodsucker_can_buy = TRUE
	bloodcost = 100
	cooldown = 1800 // 3 minutes
	target_range = 1
	power_activates_immediately = FALSE
	message_Trigger = "Whom will you subvert to your will?"
	must_be_capacitated = TRUE

/datum/action/bloodsucker/targeted/tremere/dominate_five/CheckCanTarget(atom/A, display_error)
	if(!..())
		return FALSE
	// Check: Self
	if(A == owner)
		return FALSE
	var/mob/living/target = A
	if(!target.mind)
		if(display_error)
			owner.balloon_alert(owner, "[target] is mindless.")
		return FALSE
	return TRUE

/datum/action/bloodsucker/targeted/tremere/dominate_five/FireTargetedPower(atom/A)
	. = ..()
	var/mob/living/target = A
	var/mob/living/user = owner
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)

	if(target.stat <= CONSCIOUS)
		attempt_mesmerize(target, user, level = 3)
		return

	if(!do_mob(user, target, 6 SECONDS, NONE, TRUE))
		return
	if(IS_MONSTERHUNTER(target))
		to_chat(target, span_notice("Their body refuses to react..."))
		return
	PowerActivatedSuccessfully()
	to_chat(user, span_warning("We revive [target]!"))
	target.mind.grab_ghost()
	target.revive(full_heal = TRUE, admin_revive = TRUE)
	bloodsuckerdatum.attempt_turn_vassal(target)
	addtimer(CALLBACK(src, .proc/end_possession, target), 8 MINUTES)


/datum/action/bloodsucker/targeted/tremere/proc/end_possession(mob/living/user)
	REMOVE_TRAIT(user, TRAIT_MUTE, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_DEAF, BLOODSUCKER_TRAIT)
	user.mind.remove_vassal()
	to_chat(user, span_warning("You feel the Blood of your Master quickly flee!"))
	user.death()
