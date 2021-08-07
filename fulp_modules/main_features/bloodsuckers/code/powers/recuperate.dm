/// Used by Vassals
/datum/action/bloodsucker/recuperate
	name = "Sanguine Recuperation"
	desc = "Slowly heals you overtime using your master's blood, in exchange for some of your own blood and effort."
	button_icon_state = "power_recup"
	amToggle = TRUE
	bloodcost = 2.5
	cooldown = 100

/datum/action/bloodsucker/recuperate/ActivatePower(mob/living/carbon/user = owner)
	to_chat(owner, "<span class='notice'>Your muscles clench as your master's immortal blood mixes with your own, knitting your wounds.</span>")
	owner.balloon_alert(owner, "recuperate turned on.")
	. = ..()

/datum/action/bloodsucker/recuperate/UsePower(mob/living/carbon/user)
	if(!..())
		return

	user.adjustBruteLoss(-2.5)
	user.adjustToxLoss(-2, forced = TRUE)
	user.adjustStaminaLoss(bloodcost * 1.1)
	// Plasmamen won't lose blood, they don't have any, so they don't heal from Burn.
	if(!(NOBLOOD in user.dna.species.species_traits))
		user.blood_volume -= bloodcost
		user.adjustFireLoss(-1.5)
	// Stop Bleeding
	if(istype(user) && user.is_bleeding())
		for(var/obj/item/bodypart/part in user.bodyparts)
			part.generic_bleedstacks--
	user.Jitter(5)

/datum/action/bloodsucker/recuperate/CheckCanUse(display_error)
/*	if(!..()) // Vassals use this, not Bloodsuckers, so we don't want them using these checks.
		return */
	if(owner.stat >= DEAD || owner.incapacitated())
		owner.balloon_alert(owner, "you are incapacitated...")
		return FALSE
	return TRUE

/datum/action/bloodsucker/recuperate/ContinueActive(mob/living/user)
	if(user.stat >= DEAD)
		to_chat(owner, span_notice("You are dead."))
		return FALSE
	if(user.incapacitated())
		owner.balloon_alert(owner, "you are too exhausted...")
		return FALSE
	return TRUE

/datum/action/bloodsucker/recuperate/DeactivatePower(mob/living/user = owner, mob/living/target)
	. = ..()
	owner.balloon_alert(owner, "recuperate turned off.")
