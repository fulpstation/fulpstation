/datum/action/bloodsucker/distress
	name = "Distress"
	desc = "Injure yourself, allowing you to make a desperate call for help to your Master."
	button_icon_state = "power_distress"
	amToggle = TRUE
	bloodcost = 10
	cooldown = 100

/datum/action/bloodsucker/distress/CheckCanUse(display_error)
	if(owner.stat >= DEAD || owner.incapacitated())
		to_chat(owner, span_notice("You cannot call for help while incapacitated."))
		return FALSE
	return TRUE

/datum/action/bloodsucker/distress/ActivatePower(mob/living/user = owner)
	var/turf/open/floor/target_area = get_area(user)
	var/datum/antagonist/vassal/vassaldatum = user.mind.has_antag_datum(/datum/antagonist/vassal)

	to_chat(user, span_notice("You call out for help from your Master and their Vassals."))

	// Let's find your Master
	for(var/datum/mind/M as anything in get_antag_minds(/datum/antagonist/bloodsucker))
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = M.has_antag_datum(/datum/antagonist/bloodsucker)
		// Are they MY Bloodsucker?
		if(istype(bloodsuckerdatum) && vassaldatum.master)
			to_chat(M, span_userdanger("[owner], your loyal Vassal, is desperately calling for aid at [target_area]!"))

	// Now pay the price. A small one - Bloodcost is done automatically by the Power's PayCost, which is done automatically.
	user.adjustBruteLoss(10)
	. = ..()
