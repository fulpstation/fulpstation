/datum/action/bloodsucker/brujah
	name = "Frenzy"
	desc = "Allow the Monster deep-inside of you, run free."
	button_icon_state = "power_brujah"
	power_explanation = "<b>Frenzy</b>:\n\
		A Brujah only Power. Activating it will make you enter a Frenzy.\n\
		When in a Frenzy, you get extra stun resistance, slowly gain brute damage, move faster, become mute/deaf,\n\
		and become unable to use complicated machinery as your screen goes blood-red."
	power_flags = BP_AM_TOGGLE|BP_AM_STATIC_COOLDOWN
	check_flags = BP_AM_COSTLESS_UNCONSCIOUS
	purchase_flags = NONE
	bloodcost = 2
	cooldown = 10 SECONDS

/datum/action/bloodsucker/brujah/ActivatePower(mob/living/user = owner)
	if(active && bloodsuckerdatum_power && bloodsuckerdatum_power.frenzied)
		owner.balloon_alert(owner, "already in a frenzy!")
		return FALSE
	user.apply_status_effect(STATUS_EFFECT_FRENZY)
	. = ..()

/datum/action/bloodsucker/brujah/DeactivatePower(mob/living/user = owner, mob/living/target)
	. = ..()
	user.remove_status_effect(STATUS_EFFECT_FRENZY)

/datum/action/bloodsucker/brujah/CheckCanDeactivate(display_error)
	var/mob/living/user = owner
	if(user.blood_volume < FRENZY_THRESHOLD_EXIT)
		owner.balloon_alert(owner, "not enough blood!")
		return FALSE
	. = ..()
