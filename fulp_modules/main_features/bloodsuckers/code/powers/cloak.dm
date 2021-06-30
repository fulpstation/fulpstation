/datum/action/bloodsucker/cloak
	name = "Cloak of Darkness"
	desc = "Blend into the shadows and become invisible to the untrained and Artificial eye. Slows you down and you cannot dissapear while mortals watch you."
	button_icon_state = "power_cloak"
	bloodcost = 5
	cooldown = 50
	bloodsucker_can_buy = TRUE
	amToggle = TRUE
	warn_constant_cost = TRUE
	var/was_running

/// Must have nobody around to see the cloak
/datum/action/bloodsucker/cloak/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return
	for(var/mob/living/M in viewers(9, owner) - owner)
		to_chat(owner, span_warning("You may only vanish into the shadows unseen."))
		return FALSE
	return TRUE

/datum/action/bloodsucker/cloak/ActivatePower(mob/living/user = owner)
	was_running = (user.m_intent == MOVE_INTENT_RUN)
	if(was_running)
		user.toggle_move_intent()
	user.AddElement(/datum/element/digitalcamo)
	. = ..()

/datum/action/bloodsucker/cloak/UsePower(mob/living/user)
	// Checks that we can keep using this.
	if(!..())
		return
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	// Pay Blood Toll (if awake)
	owner.alpha = max(25, owner.alpha - min(75, 10 + 5 * level_current))
	if(user.stat == CONSCIOUS)
		bloodsuckerdatum.AddBloodVolume(-0.2)
	// Prevents running while on Cloak of Darkness
	if(user.m_intent != MOVE_INTENT_WALK)
		user.toggle_move_intent()
		to_chat(user, span_warning("You attempt to run, crushing yourself in the process."))
		user.adjustBruteLoss(rand(5,15))

	addtimer(CALLBACK(src, .proc/UsePower, user), 0.5 SECONDS)

/datum/action/bloodsucker/cloak/ContinueActive(mob/living/user, mob/living/target)
	if(!..())
		return FALSE
	/// Must be CONSCIOUS
	if(user.stat != CONSCIOUS)
		to_chat(owner, span_warning("Your cloak failed due to you falling unconcious!"))
		return FALSE
	return TRUE

/datum/action/bloodsucker/cloak/DeactivatePower(mob/living/user = owner, mob/living/target)
	. = ..()
	user.alpha = 255
	user.RemoveElement(/datum/element/digitalcamo)
	if(was_running && user.m_intent == MOVE_INTENT_WALK)
		user.toggle_move_intent()
