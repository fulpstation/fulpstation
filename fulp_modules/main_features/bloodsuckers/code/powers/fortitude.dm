/datum/action/bloodsucker/fortitude
	name = "Fortitude"
	desc = "Withstand egregious physical wounds and walk away from attacks that would stun, pierce, and dismember lesser beings. You cannot run while active."
	button_icon_state = "power_fortitude"
	bloodcost = 30
	cooldown = 80
	bloodsucker_can_buy = TRUE
	amToggle = TRUE
	warn_constant_cost = TRUE
	can_use_in_torpor = TRUE
	var/was_running
	var/fortitude_resist // So we can raise and lower your brute resist based on what your level_current WAS.

/datum/action/bloodsucker/fortitude/ActivatePower(mob/living/user = owner)
	var/datum/antagonist/bloodsucker/B = owner.mind.has_antag_datum(/datum/antagonist)
	to_chat(user, "<span class='notice'>Your flesh, skin, and muscles become as steel.</span>")
	// Traits & Effects
	ADD_TRAIT(user, TRAIT_PIERCEIMMUNE, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_NODISMEMBER, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_PUSHIMMUNE, BLOODSUCKER_TRAIT)
	if(IS_BLOODSUCKER(owner))
		var/mob/living/carbon/human/H = owner
		fortitude_resist = max(0.3, 0.7 - level_current * 0.1)
		H.physiology.brute_mod *= fortitude_resist
		H.physiology.stamina_mod *= fortitude_resist
	/// As they cant level up their powers, give them the pre-nerf effects.
	if(IS_MONSTERHUNTER(owner) || IS_VASSAL(owner))
		ADD_TRAIT(user, TRAIT_STUNIMMUNE, BLOODSUCKER_TRAIT)
	was_running = (user.m_intent == MOVE_INTENT_RUN)
	if(was_running)
		user.toggle_move_intent()
	while(B && ContinueActive(user))
		/// Prevents running while on Fortitude
		if(user.m_intent != MOVE_INTENT_WALK)
			user.toggle_move_intent()
			to_chat(user, "<span class='warning'>You attempt to run, crushing yourself in the process.</span>")
			user.adjustBruteLoss(rand(5,15))
		/// We don't want people using fortitude being able to use vehicles
		if(user.buckled && istype(user.buckled, /obj/vehicle))
			user.buckled.unbuckle_mob(src, force=TRUE)
		if(IS_BLOODSUCKER(owner))
			/// Pay Blood Toll (if awake)
			if(user.stat == CONSCIOUS)
				B.AddBloodVolume(-0.5)
		sleep(20)

/datum/action/bloodsucker/fortitude/DeactivatePower(mob/living/user = owner)
	/// Restore Traits & Effects
	REMOVE_TRAIT(user, TRAIT_PIERCEIMMUNE, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_NODISMEMBER, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_PUSHIMMUNE, BLOODSUCKER_TRAIT)
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/H = owner
	if(owner.mind.has_antag_datum(/datum/antagonist/bloodsucker))
		H.physiology.brute_mod /= fortitude_resist
		H.physiology.stamina_mod /= fortitude_resist
	if(owner.mind.has_antag_datum(/datum/antagonist/monsterhunter))
		REMOVE_TRAIT(user, TRAIT_STUNIMMUNE, BLOODSUCKER_TRAIT)
	if(was_running && user.m_intent == MOVE_INTENT_WALK)
		user.toggle_move_intent()
	return ..()

/// Monster Hunter version
/datum/action/bloodsucker/fortitude/hunter
	name = "Flow"
	desc = "Use the arts to Flow to your advantage, giving stun and shove immunity, as well as dismember and pierce resistance. Like the Vampire you learned from, you are unable to run while it is active."
	button_icon_state = "power_fortitude"
	bloodcost = 0
	cooldown = 80
	bloodsucker_can_buy = FALSE
	amToggle = TRUE
	warn_constant_cost = FALSE

/// Vassal version
/datum/action/bloodsucker/fortitude/vassal
	name = "Force"
	desc = "Use your Master's teachings to Force yourself to keep your guard through stuns, shovings, dismemberment and piercings. You are unable to run while this is active."
	button_icon_state = "power_fortitude"
	bloodcost = 0
	cooldown = 80
	bloodsucker_can_buy = FALSE
	vassal_can_buy = TRUE
	amToggle = TRUE
	warn_constant_cost = FALSE
