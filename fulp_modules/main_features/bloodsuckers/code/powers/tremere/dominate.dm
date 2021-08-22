/*
 *	# Dominate;
 *
 *	Level 1 - Mesmerizes target
 *	Level 2 - Mesmerizes and mutes target
 *	Level 3 - Mesmerizes, blinds and mutes target
 *	Level 4 - Target (if at least in crit & has a mind) will revive as a Mute/Deaf Vassal for 5 minutes before dying.
 *	Level 5 - Target (if at least in crit & has a mind) will revive as a Vassal for 5 minutes before dying.
 */

/datum/action/bloodsucker/targeted/tremere/dominate_one
	name = "Level 1: Dominate"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/dominate_two
	desc = "Mesmerize any foe who stands still long enough."

	button_icon_state = "power_mez"
	power_explanation = "<b>Level 1: Dominate</b>:\n\
		Click any person to, after a 4 second timer, Mesmerize them.\n\
		This will completely immobilize them for the next 12 seconds."
	bloodsucker_can_buy = TRUE
	bloodcost = 30
	cooldown = 500
	target_range = 6
	power_activates_immediately = FALSE
	message_Trigger = "Whom will you subvert to your will?"
	must_be_capacitated = TRUE

/datum/action/bloodsucker/targeted/tremere/dominate_one/FireTargetedPower(atom/A)
	var/mob/living/target = A
	var/mob/living/user = owner

	if(!do_mob(user, target, 3 SECONDS, NONE, TRUE))
		return

	PowerActivatedSuccessfully() // PAY COST! BEGIN COOLDOWN!
	var/power_time = 12 SECONDS
	if(IS_MONSTERHUNTER(target))
		to_chat(target, span_notice("You feel your eyes burn for a while, but it passes."))
		return
	if(HAS_TRAIT_FROM(target, TRAIT_MUTE, BLOODSUCKER_TRAIT))
		owner.balloon_alert(owner, "[target] is already in some form of hypnotic gaze.")
		return
	if(iscarbon(target))
		var/mob/living/carbon/mesmerized = target
		owner.balloon_alert(owner, "successfully mesmerized [mesmerized].")
		mesmerized.Immobilize(power_time)
		//mesmerized.silent += power_time / 10 // Silent isn't based on ticks.
		mesmerized.next_move = world.time + power_time // <--- Use direct change instead. We want an unmodified delay to their next move // mesmerized.changeNext_move(power_time) // check click.dm
		mesmerized.notransform = TRUE // <--- Fuck it. We tried using next_move, but they could STILL resist. We're just doing a hard freeze.
		addtimer(CALLBACK(src, .proc/end_mesmerize, user, target), power_time)
	if(issilicon(target))
		var/mob/living/silicon/mesmerized = target
		mesmerized.emp_act(EMP_HEAVY)
		owner.balloon_alert(owner, "temporarily shut [mesmerized] down.")


/datum/action/bloodsucker/targeted/tremere/dominate_two
	name = "Level 2: Dominate"
	bloodsucker_can_buy = TRUE
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/dominate_three

/datum/action/bloodsucker/targeted/tremere/dominate_three
	name = "Level 3: Dominate"
	bloodsucker_can_buy = TRUE
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/dominate_four

/datum/action/bloodsucker/targeted/tremere/dominate_four
	name = "Level 4: Posession"
	bloodsucker_can_buy = TRUE
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/dominate_five

/datum/action/bloodsucker/targeted/tremere/dominate_five
	name = "Level 5: Posession"
	bloodsucker_can_buy = TRUE
