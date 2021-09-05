/datum/action/bloodsucker/brujah
	name = "Frenzy"
	desc = "Allow the Monster deep-inside of you, run free."
	button_icon_state = "power_brujah"
	power_explanation = "<b>Frenzy</b>:\n\
		A Brujah only Power. Activating it will make you enter a Frenzy.\n\
		When in a Frenzy, you get extra stun resistance, slowly gain brute damage, move faster, become mute/deaf,\n\
		and become unable to use complicated machinery as your screen goes blood-red."
	bloodcost = 2
	conscious_constant_bloodcost = TRUE
	cooldown = 100
	amToggle = TRUE
	cooldown_static = TRUE
	can_use_w_stake = TRUE

/datum/action/bloodsucker/brujah/ActivatePower(mob/living/user = owner)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(active && bloodsuckerdatum && bloodsuckerdatum.Frenzied)
		owner.balloon_alert(owner, "already in a frenzy!")
		return FALSE
	user.AddComponent(/datum/component/bloodsucker_frenzy)
	. = ..()

/datum/action/bloodsucker/brujah/DeactivatePower(mob/living/user = owner, mob/living/target)
	. = ..()
	qdel(user.GetComponent(/datum/component/bloodsucker_frenzy))

/datum/action/bloodsucker/brujah/CheckCanDeactivate(display_error)
	var/mob/living/user = owner
	if(user.blood_volume < FRENZY_THRESHOLD_EXIT)
		owner.balloon_alert(owner, "not enough blood!")
		return FALSE
	. = ..()
