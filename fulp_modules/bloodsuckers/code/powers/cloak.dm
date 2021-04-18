/datum/action/bloodsucker/cloak
	name = "Cloak of Darkness"
	desc = "Blend into the shadows and become invisible to the untrained eye. Slows you down and you cannot dissapear while mortals watch you."
	button_icon_state = "power_cloak"
	bloodcost = 5
	cooldown = 50
	bloodsucker_can_buy = TRUE
	amToggle = TRUE
	warn_constant_cost = TRUE
	var/was_running
	var/lum

/// Must have nobody around to see the cloak
/datum/action/bloodsucker/cloak/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return
	for(var/mob/living/M in viewers(9, owner) - owner)
		to_chat(owner, "<span class='warning'>You may only vanish into the shadows unseen.</span>")
		return FALSE
	return TRUE

/datum/action/bloodsucker/cloak/ActivatePower()
	var/datum/antagonist/bloodsucker/B = owner.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	var/mob/living/user = owner

	was_running = (user.m_intent == MOVE_INTENT_RUN)
	if(was_running)
		user.toggle_move_intent()

	while(B && ContinueActive(user) && do_mob(user, user, 0.5 SECONDS, timed_action_flags = (IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE|IGNORE_HELD_ITEM), progress = FALSE))
		// Pay Blood Toll (if awake)
		owner.alpha = max(35, owner.alpha - min(75, 10 + 5 * level_current))
		if(user.stat == CONSCIOUS)
			B.AddBloodVolume(-0.2)
		if(user.m_intent != MOVE_INTENT_WALK) // Prevents running while on Fortitude
			user.toggle_move_intent()
			to_chat(user, "<span class='warning'>You attempt to run, crushing yourself in the process.</span>")
			user.adjustBruteLoss(rand(5,15))

/datum/action/bloodsucker/cloak/ContinueActive(mob/living/user, mob/living/target)
	if(!..())
		return FALSE
	if(user.stat == !CONSCIOUS) // Must be CONSCIOUS
		to_chat(owner, "<span class='warning'>Your cloak failed due to you falling unconcious!</span>")
		return FALSE
	return TRUE

/datum/action/bloodsucker/cloak/DeactivatePower(mob/living/user = owner, mob/living/target)
	..()
	user.alpha = 255

	if(was_running && user.m_intent == MOVE_INTENT_WALK)
		user.toggle_move_intent()
