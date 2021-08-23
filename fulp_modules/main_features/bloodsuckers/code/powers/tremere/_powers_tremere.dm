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
	var/tremere_level

	// Icon stuff
	button_icon_state = "power_feed"
	background_icon_state = "vamp_power_off"
	background_icon_state_on = "vamp_power_on"
	background_icon_state_off = "vamp_power_off"

	// Targeted stuff
	target_range = 99
	message_Trigger = ""
	power_activates_immediately = TRUE

/datum/action/bloodsucker/targeted/tremere/Grant(mob/M)
	. = ..()
	RegisterSignal(owner, COMSIG_ON_BLOODSUCKERPOWER_UPGRADE, .proc/LevelUpTremerePower)

/datum/action/bloodsucker/targeted/tremere/Destroy()
	UnregisterSignal(owner, COMSIG_ON_BLOODSUCKERPOWER_UPGRADE)
	return ..()

/datum/action/bloodsucker/proc/LevelUpTremerePower(mob/living/user, datum/action/bloodsucker/targeted/tremere/tremerepower)
	SIGNAL_HANDLER

	var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	for(var/datum/action/bloodsucker/power in bloodsuckerdatum.powers)
		if(!istype(src, tremerepower))
			continue

		var/datum/action/bloodsucker/targeted/tremere/tremere_power = src
		if(!initial(tremere_power.upgraded_power))
			return FALSE
		bloodsuckerdatum.BuyPower(new tremere_power.upgraded_power)
		bloodsuckerdatum.powers -= src
		if(active)
			DeactivatePower()
		Remove(owner)
		return COMPONENT_UPGRADED_POWER

/datum/action/bloodsucker/targeted/tremere/CheckValidTarget(atom/A)
	return isliving(A)

/datum/action/bloodsucker/targeted/tremere/CheckCanTarget(atom/A, display_error)
	if(!..())
		return FALSE
	// Check: Self
	if(A == owner)
		return FALSE
	return TRUE
