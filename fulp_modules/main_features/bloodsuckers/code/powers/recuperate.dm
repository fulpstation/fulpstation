/// Used by Vassals
/datum/action/bloodsucker/recuperate
	name = "Sanguine Recuperation"
	desc = "Slowly heals you overtime using your master's blood, in exchange for some of your own blood and effort."
	button_icon_state = "power_recup"
	amToggle = TRUE
	bloodcost = 5 // Increments every 5 seconds; damage increases over time
	cooldown = 100

/datum/action/bloodsucker/recuperate/ActivatePower()
	var/mob/living/carbon/human/C = owner

	to_chat(owner, "<span class='notice'>Your muscles clench as your master's immortal blood mixes with your own, knitting your wounds.</span>")
	while(ContinueActive(owner))
		C.adjustBruteLoss(-1.5)
		C.adjustFireLoss(-0.5)
		C.adjustToxLoss(-2, forced = TRUE)
		C.adjustStaminaLoss(bloodcost * 1.1)
		/// Plasmamen won't lose blood, they don't have any.
		if(!HAS_TRAIT(C, NOBLOOD))
			C.blood_volume -= bloodcost
		/// Stop Bleeding
		if(istype(C) && C.is_bleeding())
			for(var/obj/item/bodypart/part in C.bodyparts)
				part.generic_bleedstacks--
		C.Jitter(5)
		sleep(10)
	// DONE!
	//DeactivatePower(owner)

/datum/action/bloodsucker/recuperate/CheckCanUse(display_error)
/*	. = ..()
	if(!.) // Vassals use this, not Bloodsuckers, so we don't want them using these checks.
		return */
	if(!owner.stat)
		return FALSE
	return TRUE

/datum/action/bloodsucker/recuperate/ContinueActive(mob/living/user)
	if(user.stat >= HARD_CRIT)
		return FALSE
	return ..()
