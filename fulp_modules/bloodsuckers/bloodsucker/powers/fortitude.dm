/datum/action/bloodsucker/fortitude
	name = "Fortitude"
	desc = "Withstand egregious physical wounds and walk away from attacks that would stun, pierce, and dismember lesser beings. You cannot run while active."
	button_icon_state = "power_fortitude"
	bloodcost = 30
	cooldown = 80
	bloodsucker_can_buy = TRUE
	amToggle = TRUE
	warn_constant_cost = TRUE
	var/was_running

	var/fortitude_resist // So we can raise and lower your brute resist based on what your level_current WAS.

/datum/action/bloodsucker/fortitude/ActivatePower()
	var/datum/antagonist/bloodsucker/B = owner.mind.has_antag_datum(/datum/antagonist)
	var/mob/living/user = owner
	to_chat(user, "<span class='notice'>Your flesh, skin, and muscles become as steel.</span>")
	// Traits & Effects
	ADD_TRAIT(user, TRAIT_PIERCEIMMUNE, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_NODISMEMBER, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_STUNIMMUNE, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_NORUNNING, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_PUSHIMMUNE, BLOODSUCKER_TRAIT)
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		fortitude_resist = max(0.3, 0.7 - level_current * 0.1)
		H.physiology.brute_mod *= fortitude_resist
	was_running = (user.m_intent == MOVE_INTENT_RUN)
	if(was_running)
		user.toggle_move_intent()
	while(B && ContinueActive(user) || user.m_intent == MOVE_INTENT_RUN)
		if(istype(user.buckled, /obj/vehicle)) // We dont want people using fortitude being able to use vehicles
			var/obj/vehicle/V = user.buckled
			V.unbuckle_mob(user, force = TRUE)
			to_chat(user, "<span class='notice'>You fall over, your weight making you too heavy to be able to ride any vehicle!</span>")
		// Pay Blood Toll (if awake)
		if(owner.mind.has_antag_datum(/datum/antagonist/bloodsucker)) // Prevents the Monster Hunter version from runtiming
			if(user.stat == CONSCIOUS)
				B.AddBloodVolume(-0.5)
		sleep(20) // Check every few ticks that we haven't disabled this power
	// Return to Running (if you were before)

/datum/action/bloodsucker/fortitude/DeactivatePower(mob/living/user = owner, mob/living/target)
	..()
	// Restore Traits & Effects
	REMOVE_TRAIT(user, TRAIT_PIERCEIMMUNE, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_NODISMEMBER, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_STUNIMMUNE, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_NORUNNING, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_PUSHIMMUNE, BLOODSUCKER_TRAIT)
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/H = owner
	H.physiology.brute_mod /= fortitude_resist
	H.physiology.burn_mod /= fortitude_resist
	if(was_running && user.m_intent == MOVE_INTENT_WALK)
		user.toggle_move_intent()

/// Monster Hunter version
/datum/action/bloodsucker/fortitude/hunter
	name = "Flow"
	desc = "Use knowledge learned from Monsters to survive attacks that would otherwise stun, pierce, and dismember. Like the ones you've learned this from, you cannot run while active."
	button_icon_state = "power_fortitude"
	bloodcost = 2 // Powers don't like working when there's no bloodcost
	cooldown = 80
	bloodsucker_can_buy = FALSE
	amToggle = TRUE
	warn_constant_cost = FALSE

