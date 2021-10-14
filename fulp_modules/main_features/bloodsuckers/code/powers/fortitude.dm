/datum/action/bloodsucker/fortitude
	name = "Fortitude"
	desc = "Withstand egregious physical wounds and walk away from attacks that would stun, pierce, and dismember lesser beings."
	button_icon_state = "power_fortitude"
	power_explanation = "<b>Fortitude</b>:\n\
		Activating Fortitude will provide pierce, stun and dismember immunity.\n\
		You will additionally gain resistance to Brute and Stamina damge, scaling with level.\n\
		While using Fortitude, attempting to run will crush you.\n\
		At level 4, you gain complete stun immunity.\n\
		Higher levels will increase Brute and Stamina resistance."
	power_flags = BP_AM_TOGGLE
	check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY|BP_AM_COSTLESS_UNCONSCIOUS
	purchase_flags = BLOODSUCKER_CAN_BUY|VASSAL_CAN_BUY
	bloodcost = 30
	cooldown = 8 SECONDS
	constant_bloodcost = 0.2
	var/was_running
	var/fortitude_resist // So we can raise and lower your brute resist based on what your level_current WAS.

/datum/action/bloodsucker/fortitude/ActivatePower(mob/living/user = owner)
	owner.balloon_alert(owner, "fortitude turned on.")
	to_chat(user, span_notice("Your flesh, skin, and muscles become as steel."))
	// Traits & Effects
	ADD_TRAIT(user, TRAIT_PIERCEIMMUNE, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_NODISMEMBER, BLOODSUCKER_TRAIT)
	ADD_TRAIT(user, TRAIT_PUSHIMMUNE, BLOODSUCKER_TRAIT)
	if(level_current >= 4)
		ADD_TRAIT(user, TRAIT_STUNIMMUNE, BLOODSUCKER_TRAIT) // They'll get stun resistance + this, who cares.
	var/mob/living/carbon/human/bloodsucker_user = owner
	if(IS_BLOODSUCKER(owner) || IS_VASSAL(owner))
		fortitude_resist = max(0.3, 0.7 - level_current * 0.1)
		bloodsucker_user.physiology.brute_mod *= fortitude_resist
		bloodsucker_user.physiology.stamina_mod *= fortitude_resist
	if(IS_MONSTERHUNTER(owner))
		bloodsucker_user.physiology.brute_mod *= 0.4
		bloodsucker_user.physiology.burn_mod *= 0.4
		ADD_TRAIT(user, TRAIT_STUNIMMUNE, BLOODSUCKER_TRAIT)

	was_running = (user.m_intent == MOVE_INTENT_RUN)
	if(was_running)
		user.toggle_move_intent()
	. = ..()

/datum/action/bloodsucker/fortitude/UsePower(mob/living/carbon/user)
	// Checks that we can keep using this.
	. = ..()
	if(!.)
		return
	/// Prevents running while on Fortitude
	if(user.m_intent != MOVE_INTENT_WALK)
		user.toggle_move_intent()
		user.balloon_alert(user, "you attempt to run, crushing yourself.")
		user.adjustBruteLoss(rand(5,15))
	/// We don't want people using fortitude being able to use vehicles
	if(user.buckled && istype(user.buckled, /obj/vehicle))
		user.buckled.unbuckle_mob(src, force=TRUE)

/datum/action/bloodsucker/fortitude/DeactivatePower(mob/living/user = owner)
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/bloodsucker_user = owner
	if(IS_BLOODSUCKER(owner) || IS_VASSAL(owner))
		bloodsucker_user.physiology.brute_mod /= fortitude_resist
		if(!HAS_TRAIT_FROM(user, TRAIT_STUNIMMUNE, BLOODSUCKER_TRAIT))
			bloodsucker_user.physiology.stamina_mod /= fortitude_resist
	if(IS_MONSTERHUNTER(owner))
		bloodsucker_user.physiology.brute_mod /= 0.4
		bloodsucker_user.physiology.burn_mod /= 0.4
	// Remove Traits & Effects
	REMOVE_TRAIT(user, TRAIT_PIERCEIMMUNE, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_NODISMEMBER, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_PUSHIMMUNE, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(user, TRAIT_STUNIMMUNE, BLOODSUCKER_TRAIT)

	if(was_running && user.m_intent == MOVE_INTENT_WALK)
		user.toggle_move_intent()
	owner.balloon_alert(owner, "fortitude turned off.")
	return ..()

/// Monster Hunter version
/datum/action/bloodsucker/fortitude/hunter
	name = "Flow"
	desc = "Use the arts to Flow, giving shove and stun immunity, as well as brute, burn, dismember and pierce resistance. You cannot run while this is active."
	purchase_flags = HUNTER_CAN_BUY
