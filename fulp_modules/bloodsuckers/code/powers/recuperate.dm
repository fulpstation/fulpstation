/// Used by Vassals
/datum/action/bloodsucker/recuperate
	name = "Sanguine Recuperation"
	desc = "Slowly heals you overtime using your master's blood, in exchange for some of your own blood and effort."
	button_icon_state = "power_recup"
	amToggle = TRUE
	bloodcost = 5 // Increments every 5 seconds; damage increases over time
	cooldown = 100

/datum/action/bloodsucker/recuperate/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return
	if(owner.stat >= DEAD)
		return FALSE
	return TRUE

/datum/action/bloodsucker/recuperate/ActivatePower()
	to_chat(owner, "<span class='notice'>Your muscles clench as your master's immortal blood mixes with your own, knitting your wounds.</span>")
	var/mob/living/carbon/C = owner
	var/mob/living/carbon/human/H
	if(ishuman(owner))
		H = owner
	while(ContinueActive(owner))
		C.adjustBruteLoss(-1.5)
		C.adjustFireLoss(-0.5)
		C.adjustToxLoss(-2, forced = TRUE)
		C.blood_volume -= 1
		C.adjustStaminaLoss(bloodcost * 1.1)
		// Stop Bleeding
		if(istype(H) && H.is_bleeding())
			for(var/obj/item/bodypart/part in H.bodyparts)
				part.generic_bleedstacks--
		C.Jitter(5)
		sleep(10)
	// DONE!
	//DeactivatePower(owner)

/datum/action/bloodsucker/recuperate/ContinueActive(mob/living/user, mob/living/target)
	return ..() && user.stat <= DEAD && user.blood_volume > 500
