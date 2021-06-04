/datum/action/bloodsucker/distress
	name = "Distress"
	desc = "Injure yourself, allowing you to make a desperate call for help to your Master."
	button_icon_state = "power_recover"
	amToggle = TRUE
	vassal_can_buy = TRUE
	bloodcost = 10
	cooldown = 100

/datum/action/bloodsucker/distress/CheckCanUse(display_error)
	if(owner.stat >= DEAD || owner.incapacitated())
		to_chat(owner, "<span class='notice'>You cannot call for help while incapacitated.</span>")
		return FALSE
	return TRUE

/datum/action/bloodsucker/distress/ActivatePower()
	var/mob/living/carbon/user = owner
	var/turf/open/floor/target_turf = get_area(user)
	var/datum/antagonist/vassal/vassaldatum = user.mind.has_antag_datum(/datum/antagonist/vassal)

	to_chat(user, "<span class='notice'>You call out for help from your Master and their Vassals.</span>")

	/// Let's find your Master
	for(var/datum/mind/M as anything in get_antag_minds(/datum/antagonist/bloodsucker))
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = M.has_antag_datum(/datum/antagonist/bloodsucker)
		/// Are they MY Bloodsucker?
		if(istype(bloodsuckerdatum) && vassaldatum.master)
			to_chat(M, "<span class='userdanger'>[owner], your loyal Vassal, is desperately calling for aid at [target_turf]!</span>")

	/// Now pay the price. A small one - Bloodcost is done automatically by the Power.
	user.adjustBruteLoss(10)
//	PayCost()
//	DeactivatePower()
