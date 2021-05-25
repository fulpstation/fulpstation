/datum/action/bloodsucker/distress
	name = "Distress"
	desc = "Injure yourself, allowing you to make a desperate call for help to your master and other vassals."
	button_icon_state = "power_recover"
	amToggle = TRUE
	vassal_can_buy = FALSE//TRUE
	bloodcost = 10
	cooldown = 100

// WILLARD TODO: lol
/datum/action/bloodsucker/distress/CheckCanUse(display_error)
	if(owner.stat >= DEAD || owner.incapacitated())
		to_chat(owner, "<span class='notice'>You cannot call for help while incapacitated.</span>")
		return FALSE
	return TRUE

/datum/action/bloodsucker/distress/ActivatePower()
	var/turf/open/floor/target_turf = get_area(owner)
	var/datum/antagonist/vassal/vassaldatum = owner.mind.has_antag_datum(/datum/antagonist/vassal)
	var/mob/living/user = owner

	/// Check one: You're a Vassal with a Master
	if(vassaldatum.master)
		/// Check two: Your Master is a Bloodsucker
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = vassaldatum.master.owner.has_antag_datum(/datum/antagonist/bloodsucker)
		if(istype(bloodsuckerdatum) && vassaldatum.master == bloodsuckerdatum)
			to_chat(bloodsuckerdatum, "<span class='userdanger'>[owner] is desperately calling for help at [target_turf]!</span>")
			/// Search for your Master's Vassals
			for(var/datum/antagonist/vassal/V in bloodsuckerdatum.vassals)
				/// Alert all of Master's vassals, but yourself.
				if(V == owner)
					continue
				to_chat(V, "<span class='userdanger'>[owner] is desperately calling for help at [target_turf]!</span>")

			/// Now pay the price. A small one - Bloodcost is done automatically by the Power.
			user.adjustBruteLoss(10)

	//PayCost()
	//DeactivatePower()
