/datum/action/bloodsucker/distress
	name = "Distress"
	desc = "Injure yourself, allowing you to make a desperate call for help to your master and other vassals."
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
	var/turf/open/floor/target_turf = get_area(owner)
	var/datum/antagonist/vassal/vassaldatum = owner.mind.has_antag_datum(/datum/antagonist/vassal)
	var/mob/living/user = owner

	/// Check one: You're a Vassal with a Master
	if(vassaldatum.master)
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = vassaldatum.master.owner.has_antag_datum(/datum/antagonist/bloodsucker)
		/// Check two: Your Master is a Bloodsucker
		if(bloodsuckerdatum)
			/// Search for your Master's Vassals
			for(var/datum/antagonist/vassal/V in bloodsuckerdatum.vassals)
				/// Alert all of Master's vassals, but yourself.
				if(V == owner)
					continue
				var/mob/living/vassals = V
				to_chat(vassals, "<span class='userdanger'>[owner] is desperately calling for help at [target_turf]!</span>")
			var/mob/living/my_master = bloodsuckerdatum
			to_chat(my_master, "<span class='userdanger'>[owner] is desperately calling for help at [target_turf]!</span>")
			/// Now pay the price. A small one - Bloodcost is done automatically by the Power.
			user.adjustBruteLoss(10)

	//PayCost()
	//DeactivatePower()
