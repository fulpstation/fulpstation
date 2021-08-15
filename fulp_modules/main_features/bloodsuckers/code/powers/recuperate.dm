/// Used by Vassals
/datum/action/bloodsucker/recuperate
	name = "Sanguine Recuperation"
	desc = "Slowly heals you overtime using your master's blood, in exchange for some of your own blood and effort."
	button_icon_state = "power_recup"
	amToggle = TRUE
	bloodcost = 2.5
	cooldown = 100

/datum/action/bloodsucker/recuperate/ActivatePower(mob/living/carbon/user = owner)
//	var/datum/antagonist/vassal/vassaldatum = owner.mind.has_antag_datum(/datum/antagonist/vassal) // WILLARDTODO: Fix this.
	to_chat(owner, "<span class='notice'>Your muscles clench as your master's immortal blood mixes with your own, knitting your wounds.</span>")
	. = ..()

/datum/action/bloodsucker/recuperate/UsePower(mob/living/carbon/user)
	// Checks that we can keep using this.
	if(!..())
		return
	user.adjustBruteLoss(-2.5)
	user.adjustToxLoss(-2, forced = TRUE)
	user.adjustStaminaLoss(bloodcost * 1.1)
	// Plasmamen won't lose blood, they don't have any, so they don't heal from Burn.
	if(!(NOBLOOD in user.dna.species.species_traits))
		user.blood_volume -= bloodcost
		user.adjustFireLoss(-1.5)
	// Take bloodcost from their Master.
/*
		var/mob/living/carbon/H = vassaldatum.master
		H.blood_volume -= bloodcost
*/
	// Stop Bleeding
	if(istype(user) && user.is_bleeding())
		for(var/obj/item/bodypart/part in user.bodyparts)
			part.generic_bleedstacks--
	user.Jitter(5)

	addtimer(CALLBACK(src, .proc/UsePower, user), 2 SECONDS)

/datum/action/bloodsucker/recuperate/CheckCanUse(display_error)
/*	. = ..()
	if(!.) // Vassals use this, not Bloodsuckers, so we don't want them using these checks.
		return */
	if(owner.stat >= DEAD)
		to_chat(owner, span_notice("You cannot use Recuperate while incapacitated."))
		return FALSE
	if(owner.incapacitated())
		to_chat(owner, span_notice("You cannot use Recuperate while incapacitated."))
		return FALSE
	return TRUE

/datum/action/bloodsucker/recuperate/ContinueActive(mob/living/user)
	if(user.stat >= DEAD)
		to_chat(owner, span_notice("You are dead."))
		return FALSE
	if(user.incapacitated())
		to_chat(owner, span_notice("You are too exhausted to keep recuperating..."))
		return FALSE
	return TRUE
