/*
 *	# Dominate;
 *
 *	Level 1 - Mesmerizes target
 *	Level 2 - Mesmerizes and mutes target
 *	Level 3 - Mesmerizes, blinds and mutes target
 *	Level 4 - Target (if at least in crit & has a mind) will revive as a Mute/Deaf Vassal for 5 minutes before dying.
 *	Level 5 - Target (if at least in crit & has a mind) will revive as a Vassal for 8 minutes before dying.
 */

// Copied from mesmerize.dm

/datum/action/bloodsucker/targeted/tremere/dominate
	name = "Level 1: Dominate"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/dominate/two
	tremere_level = 1
	desc = "Mesmerize any foe who stands still long enough."
	button_icon_state = "power_dominate"
	power_explanation = "<b>Level 1: Dominate</b>:\n\
		Click any person to, after a 4 second timer, Mesmerize them.\n\
		This will completely immobilize them for the next 10.5 seconds."
	bloodcost = 15
	cooldown = 500
	target_range = 6

/datum/action/bloodsucker/targeted/tremere/dominate/two
	name = "Level 2: Dominate"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/dominate/three
	tremere_level = 2
	desc = "Mesmerize and mute any foe who stands still long enough."
	power_explanation = "<b>Level 2: Dominate</b>:\n\
		Click any person to, after a 4 second timer, Mesmerize them.\n\
		This will completely immobilize and mute them for the next 12 seconds."
	bloodcost = 20
	cooldown = 400

/datum/action/bloodsucker/targeted/tremere/dominate/three
	name = "Level 3: Dominate"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/dominate/advanced
	tremere_level = 3
	desc = "Mesmerize, mute and blind any foe who stands still long enough."
	power_explanation = "<b>Level 3: Dominate</b>:\n\
		Click any person to, after a 4 second timer, Mesmerize them.\n\
		This will completely immobilize, mute, and blind them for the next 13.5 seconds."
	bloodcost = 30
	cooldown = 350

/datum/action/bloodsucker/targeted/tremere/dominate/advanced
	name = "Level 4: Possession"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/dominate/advanced/two
	tremere_level = 4
	desc = "Mesmerize, mute and blind any foe who stands still long enough, or convert the damaged to temporary Vassals."
	power_explanation = "<b>Level 4: Possession</b>:\n\
		Click any person to, after a 4 second timer, Mesmerize them.\n\
		This will completely immobilize, mute, and blind them for the next 13.5 seconds.\n\
		However, if your target is in critical condition or dead, they will instead be turned into a temporary Vassal.\n\
		If you use this on a currently dead normal Vassal, you will instead revive them normally.\n\
		Despite being Mute and Deaf, they will still have complete loyalty to you, until their death in 5 minutes upon use."
	background_icon_state = "tremere_power_gold_off"
	background_icon_state_on = "tremere_power_gold_on"
	background_icon_state_off = "tremere_power_gold_off"
	bloodcost = 80
	cooldown = 1800 // 3 minutes

/datum/action/bloodsucker/targeted/tremere/dominate/advanced/two
	name = "Level 5: Possession"
	desc = "Mesmerize, mute and blind any foe who stands still long enough, or convert the damaged to temporary Vassals."
	tremere_level = 5
	upgraded_power = null
	power_explanation = "<b>Level 5: Possession</b>:\n\
		Click any person to, after a 4 second timer, Mesmerize them.\n\
		This will completely immobilize, mute, and blind them for the next 13.5 seconds.\n\
		However, if your target is in critical condition or dead, they will instead be turned into a temporary Vassal.\n\
		If you use this on a currently dead normal Vassal, you will instead revive them normally.\n\
		They will have complete loyalty to you, until their death in 8 minutes upon use."
	bloodcost = 100
	cooldown = 1200 // 2 minutes


/datum/action/bloodsucker/targeted/tremere/dominate/CheckCanTarget(atom/A, display_error)
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

/datum/action/bloodsucker/targeted/tremere/dominate/FireTargetedPower(atom/A)
	. = ..()
	var/mob/living/target = A
	var/mob/living/user = owner
	if(target.stat >= SOFT_CRIT && user.Adjacent(target) && tremere_level >= 4)
		attempt_vassalize(target, user)
		return
	attempt_mesmerize(target, user)

/datum/action/bloodsucker/targeted/tremere/dominate/proc/attempt_mesmerize(mob/living/target, mob/living/user)
	if(!do_mob(user, target, 3 SECONDS, NONE, TRUE))
		return

	PowerActivatedSuccessfully()
	var/power_time = 90 + tremere_level * 15
	if(IS_MONSTERHUNTER(target))
		to_chat(target, span_notice("You feel you something crawling under your skin, but it passes."))
		return
	if(HAS_TRAIT_FROM(target, TRAIT_MUTE, BLOODSUCKER_TRAIT))
		owner.balloon_alert(owner, "[target] is already in some form of hypnotic gaze.")
		return
	if(iscarbon(target))
		var/mob/living/carbon/mesmerized = target
		owner.balloon_alert(owner, "successfully mesmerized [mesmerized].")
		if(tremere_level >= 2)
			ADD_TRAIT(target, TRAIT_MUTE, BLOODSUCKER_TRAIT)
		if(tremere_level >= 3)
			ADD_TRAIT(target, TRAIT_BLIND, BLOODSUCKER_TRAIT)
		mesmerized.Immobilize(power_time)
		mesmerized.next_move = world.time + power_time
		mesmerized.notransform = TRUE
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

/datum/action/bloodsucker/targeted/tremere/dominate/proc/attempt_vassalize(mob/living/target, mob/living/user)
	if(!do_mob(user, target, 6 SECONDS, NONE, TRUE))
		return

	var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(IS_VASSAL(target))
		PowerActivatedSuccessfully()
		to_chat(user, span_warning("We revive [target]!"))
		target.mind.grab_ghost()
		target.revive(full_heal = TRUE, admin_revive = TRUE)
		return
	if(IS_MONSTERHUNTER(target))
		to_chat(target, span_notice("Their body refuses to react..."))
		return
	if(!bloodsuckerdatum.attempt_turn_vassal(target))
		return
	PowerActivatedSuccessfully()
	to_chat(user, span_warning("We revive [target]!"))
	target.mind.grab_ghost()
	target.revive(full_heal = TRUE, admin_revive = TRUE)
	var/living_time
	if(tremere_level == 4)
		living_time = 5 MINUTES
		ADD_TRAIT(target, TRAIT_MUTE, BLOODSUCKER_TRAIT)
		ADD_TRAIT(target, TRAIT_DEAF, BLOODSUCKER_TRAIT)
	else if(tremere_level == 5)
		living_time = 8 MINUTES
	addtimer(CALLBACK(src, .proc/end_possession, target), living_time)

/datum/action/bloodsucker/targeted/tremere/proc/end_possession(mob/living/user)
	REMOVE_TRAIT(user, TRAIT_MUTE, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_DEAF, BLOODSUCKER_TRAIT)
	user.mind.remove_vassal()
	to_chat(user, span_warning("You feel the Blood of your Master quickly flee!"))
	user.death()
