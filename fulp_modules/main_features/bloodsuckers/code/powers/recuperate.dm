/// Used by Vassals
/datum/action/bloodsucker/recuperate
	name = "Sanguine Recuperation"
	desc = "Slowly heals you overtime using your master's blood, in exchange for some of your own blood and effort."
	button_icon_state = "power_recup"
	amToggle = TRUE
	bloodcost = 3.5 // Increments every 5 seconds; damage increases over time
	cooldown = 100

/datum/action/bloodsucker/recuperate/ActivatePower()
	var/mob/living/carbon/C = owner
	var/datum/antagonist/vassal/vassaldatum = owner.mind.has_antag_datum(/datum/antagonist/vassal)

	to_chat(owner, "<span class='notice'>Your muscles clench as your master's immortal blood mixes with your own, knitting your wounds.</span>")
	while(ContinueActive(owner))
		C.adjustBruteLoss(-1.5)
		C.adjustToxLoss(-2, forced = TRUE)
		C.adjustStaminaLoss(bloodcost * 1.1)
		/// Plasmamen won't lose blood, they don't have any, so they don't heal from Burn.
		if(!(NOBLOOD in C.dna.species.species_traits))
			C.blood_volume -= bloodcost
			C.adjustFireLoss(-0.5)
		/// Take bloodcost from their Master.
			var/mob/living/carbon/H = vassaldatum.master
			H.blood_volume -= bloodcost
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
	if(owner.stat >= DEAD)
		to_chat(owner, "<span class='notice'>You cannot use Recuperate while incapacitated.</span>")
		return FALSE
	if(owner.incapacitated())
		to_chat(owner, "<span class='notice'>You cannot use Recuperate while incapacitated.</span>")
		return FALSE
	return TRUE

/datum/action/bloodsucker/recuperate/ContinueActive(mob/living/user)
	if(user.stat >= DEAD)
		to_chat(owner, "<span class='notice'>You are dead.</span>")
		return FALSE
	if(user.incapacitated())
		to_chat(owner, "<span class='notice'>You are too exhausted to keep recuperating...</span>")
		return FALSE
	return TRUE

