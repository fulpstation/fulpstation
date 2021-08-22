/*
 *	# Auspex
 *
 *	Level 1 - Cloak of Darkness until clicking an area, teleports the user to the selected area (max 1 tile)
 *	Level 2 - Cloak of Darkness until clicking an area, teleports the user to the selected area (max 2 tiles)
 *	Level 3 - Cloak of Darkness until clicking an area, teleports the user to the selected area
 *	Level 4 - Cloak of Darkness until clicking an area, teleports the user to the selected area, causes nearby people to bleed.
 *	Level 5 - Cloak of Darkness until clicking an area, teleports the user to the selected area, causes nearby people to fall asleep.
 */

// Look to /obj/effect/proc_holder/spell/pointed/void_blink for help.

/datum/action/bloodsucker/targeted/tremere/proc/auspex_blink(mob/living/user, turf/targeted_turf, level = 1)
	playsound(user, 'sound/magic/summon_karp.ogg', 60)
	playsound(targeted_turf, 'sound/magic/summon_karp.ogg', 60)

	new /obj/effect/particle_effect/smoke/vampsmoke(user.drop_location())
	new /obj/effect/particle_effect/smoke/vampsmoke(targeted_turf)

	for(var/mob/living/carbon/living_mob in range(1, targeted_turf)-user)
		if(IS_BLOODSUCKER(living_mob) || IS_VASSAL(living_mob))
			continue
		if(level >= 2)
			var/obj/item/bodypart/bodypart = pick(living_mob.bodyparts)
			var/datum/wound/slash/critical/crit_wound = new
			crit_wound.apply_wound(bodypart)
			living_mob.adjustFireLoss(20)
		if(level == 3)
			living_mob.SetUnconscious(10 SECONDS)

	do_teleport(user, targeted_turf, TRUE, no_effects = TRUE, channel = TELEPORT_CHANNEL_QUANTUM)

/datum/action/bloodsucker/targeted/tremere/auspex_one
	name = "Level 1: Auspex"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/auspex_two
	desc = "Hide yourself within a Cloak of Darkness, click on an area to teleport up to 1 tile away."

	button_icon_state = "power_tres"
	power_explanation = "<b>Level 1: Auspex</b>:\n\
		When Activated, you will be hidden in a Cloak of Darkness.\n\
		Click any area up to 1 tile away to teleport there, ending the Power."
	bloodsucker_can_buy = TRUE
	bloodcost = 5
	cooldown = 120
	target_range = 1
	power_activates_immediately = FALSE
	message_Trigger = "Where do you wish to teleport to?"
	must_be_capacitated = TRUE

/datum/action/bloodsucker/targeted/tremere/auspex_one/CheckValidTarget(atom/A)
	return isturf(A)

/datum/action/bloodsucker/targeted/tremere/auspex_one/UpdateButtonIcon(force = FALSE)
	. = ..()
	if(active)
		owner.AddElement(/datum/element/digitalcamo)
		animate(owner, alpha = 15, time = 1 SECONDS)
	else
		animate(owner, alpha = 255, time = 1 SECONDS)
		owner.RemoveElement(/datum/element/digitalcamo)

/datum/action/bloodsucker/targeted/tremere/auspex_one/FireTargetedPower(atom/A)
	var/mob/living/user = owner
	var/turf/targeted_turf = get_turf(A)
	auspex_blink(user, targeted_turf, level = 1)
	PowerActivatedSuccessfully()

/datum/action/bloodsucker/targeted/tremere/auspex_two
	name = "Level 2: Auspex"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/auspex_three
	desc = "Hide yourself within a Cloak of Darkness, click on an area to teleport."

	button_icon_state = "power_tres"
	power_explanation = "<b>Level 2: Auspex</b>:\n\
		When Activated, you will be hidden in a Cloak of Darkness.\n\
		Click any area up to 2 tile away to teleport there, ending the Power."
	bloodsucker_can_buy = TRUE
	bloodcost = 10
	cooldown = 100
	target_range = 2
	power_activates_immediately = FALSE
	message_Trigger = "Where do you wish to teleport to?"
	must_be_capacitated = TRUE

/datum/action/bloodsucker/targeted/tremere/auspex_two/CheckValidTarget(atom/A)
	return isturf(A)

/datum/action/bloodsucker/targeted/tremere/auspex_two/UpdateButtonIcon(force = FALSE)
	. = ..()
	if(active)
		owner.AddElement(/datum/element/digitalcamo)
		animate(owner, alpha = 15, time = 1 SECONDS)
	else
		animate(owner, alpha = 255, time = 1 SECONDS)
		owner.RemoveElement(/datum/element/digitalcamo)

/datum/action/bloodsucker/targeted/tremere/auspex_two/FireTargetedPower(atom/A)
	var/mob/living/user = owner
	var/turf/targeted_turf = get_turf(A)
	auspex_blink(user, targeted_turf, level = 1)
	PowerActivatedSuccessfully()

/datum/action/bloodsucker/targeted/tremere/auspex_three
	name = "Level 3: Auspex"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/auspex_four
	desc = "Hide yourself within a Cloak of Darkness, click on an area to teleport."

	button_icon_state = "power_tres"
	power_explanation = "<b>Level 3: Auspex</b>:\n\
		When Activated, you will be hidden in a Cloak of Darkness.\n\
		Click any area up to teleport there, ending the Power."
	bloodsucker_can_buy = TRUE
	bloodcost = 15
	cooldown = 80
	power_activates_immediately = FALSE
	message_Trigger = "Where do you wish to teleport to?"
	must_be_capacitated = TRUE

/datum/action/bloodsucker/targeted/tremere/auspex_three/CheckValidTarget(atom/A)
	return isturf(A)

/datum/action/bloodsucker/targeted/tremere/auspex_three/UpdateButtonIcon(force = FALSE)
	. = ..()
	if(active)
		owner.AddElement(/datum/element/digitalcamo)
		animate(owner, alpha = 15, time = 1 SECONDS)
	else
		animate(owner, alpha = 255, time = 1 SECONDS)
		owner.RemoveElement(/datum/element/digitalcamo)

/datum/action/bloodsucker/targeted/tremere/auspex_three/FireTargetedPower(atom/A)
	var/mob/living/user = owner
	var/turf/targeted_turf = get_turf(A)
	auspex_blink(user, targeted_turf, level = 1)
	PowerActivatedSuccessfully()

/datum/action/bloodsucker/targeted/tremere/auspex_four
	name = "Level 4: Auspex"
	upgraded_power = /datum/action/bloodsucker/targeted/tremere/auspex_five
	desc = "Hide yourself within a Cloak of Darkness, click on an area to teleport, leaving nearby people bleeding."

	button_icon_state = "power_tres"
	power_explanation = "<b>Level 4: Auspex</b>:\n\
		When Activated, you will be hidden in a Cloak of Darkness.\n\
		Click any area up to teleport there, ending the Power and causing people at your end location to start bleeding."
	bloodsucker_can_buy = TRUE
	bloodcost = 20
	cooldown = 60
	power_activates_immediately = FALSE
	message_Trigger = "Where do you wish to teleport to?"
	must_be_capacitated = TRUE

/datum/action/bloodsucker/targeted/tremere/auspex_four/CheckValidTarget(atom/A)
	return isturf(A)

/datum/action/bloodsucker/targeted/tremere/auspex_four/UpdateButtonIcon(force = FALSE)
	. = ..()
	if(active)
		owner.AddElement(/datum/element/digitalcamo)
		animate(owner, alpha = 15, time = 1 SECONDS)
	else
		animate(owner, alpha = 255, time = 1 SECONDS)
		owner.RemoveElement(/datum/element/digitalcamo)

/datum/action/bloodsucker/targeted/tremere/auspex_four/FireTargetedPower(atom/A)
	var/mob/living/user = owner
	var/turf/targeted_turf = get_turf(A)
	auspex_blink(user, targeted_turf, level = 2)
	PowerActivatedSuccessfully()

/datum/action/bloodsucker/targeted/tremere/auspex_five
	name = "Level 5: Auspex"
	desc = "Hide yourself within a Cloak of Darkness, click on an area to teleport, leaving nearby people asleep."

	button_icon_state = "power_tres"
	power_explanation = "<b>Level 5: Auspex</b>:\n\
		When Activated, you will be hidden in a Cloak of Darkness.\n\
		Click any area up to teleport there, ending the Power and causing people at your end location to fall asleep for 10 seconds."
	bloodsucker_can_buy = TRUE
	bloodcost = 25
	cooldown = 80
	power_activates_immediately = FALSE
	message_Trigger = "Where do you wish to teleport to?"
	must_be_capacitated = TRUE

/datum/action/bloodsucker/targeted/tremere/auspex_five/CheckValidTarget(atom/A)
	return isturf(A)

/datum/action/bloodsucker/targeted/tremere/auspex_five/UpdateButtonIcon(force = FALSE)
	. = ..()
	if(active)
		owner.AddElement(/datum/element/digitalcamo)
		animate(owner, alpha = 15, time = 1 SECONDS)
	else
		animate(owner, alpha = 255, time = 1 SECONDS)
		owner.RemoveElement(/datum/element/digitalcamo)

/datum/action/bloodsucker/targeted/tremere/auspex_five/FireTargetedPower(atom/A)
	var/mob/living/user = owner
	var/turf/targeted_turf = get_turf(A)
	auspex_blink(user, targeted_turf, level = 3)
	PowerActivatedSuccessfully()
