/*
 *	# Tremere Powers
 *
 *	This file is for Tremere power procs and Bloodsucker procs that deals exclusively with Tremere.
 *	Tremere has quite a bit of unique Powers, so I thought it's own folder and file would be nice
 */

/datum/action/bloodsucker/targeted/tremere
	name = "Tremere Gift"
	desc = "A tremere exclusive gift."
	tremere_power = TRUE
	var/upgraded_power

	// Icon stuff
	button_icon = 'fulp_modules/main_features/bloodsuckers/icons/actions_bloodsucker.dmi'
	background_icon_state = "vamp_power_off"
	background_icon_state_on = "vamp_power_on"
	background_icon_state_off = "vamp_power_off"
	icon_icon = 'fulp_modules/main_features/bloodsuckers/icons/actions_bloodsucker.dmi'
	button_icon_state = "power_feed"

/datum/action/bloodsucker/targeted/tremere/proc/end_mesmerize(mob/living/user, mob/living/target)
	target.notransform = FALSE
	if(istype(user) && target.stat == CONSCIOUS && (target in view(6, get_turf(user))))
		owner.balloon_alert(owner, "[target] snapped out of their trance.")


/// We deactivate your Power, delete it, then Purchase the new one.
/datum/antagonist/bloodsucker/proc/tremere_upgrade_power(datum/action/bloodsucker/tremere/tremerepower)
	for(var/datum/action/bloodsucker/power in powers)
		if(!istype(power, initial(tremerepower)))
			continue
		if(!initial(tremerepower.upgraded_power))
			return FALSE
		var/datum/action/bloodsucker/targeted/tremere/tremere_upgraded_power = initial(tremerepower.upgraded_power)
		BuyPower(new tremere_upgraded_power)
		powers -= power
		if(power.active)
			power.DeactivatePower()
		power.Remove(owner.current)
		return TRUE
