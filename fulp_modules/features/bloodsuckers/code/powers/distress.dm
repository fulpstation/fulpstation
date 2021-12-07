/datum/action/bloodsucker/distress
	name = "Distress"
	desc = "Injure yourself, allowing you to make a desperate call for help to your Master."
	button_icon_state = "power_distress"
	power_explanation = "<b>Distress</b>:\n\
		Use this Power from anywhere and your Master Bloodsucker will instnatly be alerted of your location."
	power_flags = NONE
	check_flags = NONE
	purchase_flags = NONE
	bloodcost = 10
	cooldown = 10 SECONDS

/datum/action/bloodsucker/distress/ActivatePower(mob/living/user = owner)
	var/turf/open/floor/target_area = get_area(user)
	var/datum/antagonist/vassal/vassaldatum = user.mind.has_antag_datum(/datum/antagonist/vassal)

	owner.balloon_alert(owner, "you call out for your master!")
	to_chat(vassaldatum.master.owner, "<span class='userdanger'>[owner], your loyal Vassal, is desperately calling for aid at [target_area]!</span>")

	// Now pay the price. A small one - Bloodcost is done automatically by the Power's PayCost, which is done automatically.
	user.adjustBruteLoss(10)
	. = ..()
