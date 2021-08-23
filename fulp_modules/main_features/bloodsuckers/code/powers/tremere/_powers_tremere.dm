/*
 *	# Tremere Powers
 *
 *	This file is for Tremere power procs and Bloodsucker procs that deals exclusively with Tremere.
 *	Tremere has quite a bit of unique Powers, so I thought it's own folder and file would be nice
 */

/datum/action/bloodsucker/targeted/tremere
	name = "Tremere Gift"
	desc = "A tremere exclusive gift."
	var/upgraded_power

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

/datum/action/bloodsucker/targeted/tremere/proc/LevelUpTremerePower(mob/living/user = owner)
	SIGNAL_HANDLER

	var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	var/list/options = list()
	for(var/datum/action/bloodsucker/targeted/tremere/power in bloodsuckerdatum.powers)
		if((locate(power) in bloodsuckerdatum.powers) && (initial(power.tremere_level) >= ((locate(power) in bloodsuckerdatum.powers).tremere_level)))
			options[initial(power.name)] = power

	if(options.len >= 1)
		var/choice = tgui_input_list(owner, "You have the opportunity to grow more ancient. Select a power you wish to Upgrade.", "Your Blood Thickens...", options)
		/// Did you choose a power?
		if(!choice || !options[choice])
			to_chat(owner, span_notice("You prevent your blood from thickening just yet, but you may try again later."))
			return
		if(bloodsuckerdatum.bloodsucker_level_unspent <= 0)
			return

		var/datum/action/bloodsucker/targeted/tremere/P = options[choice]
		if(!initial(P.upgraded_power))
			user.balloon_alert(user, "cannot upgrade [initial(P.name)]!")
			to_chat(owner, span_notice("[initial(P.name)] is already at max level!"))
			return FALSE
		bloodsuckerdatum.BuyPower(new P.upgraded_power)
		bloodsuckerdatum.powers -= P
		if(active)
			DeactivatePower()
		Remove(owner)
		user.balloon_alert(user, "upgraded [initial(P.name)]!")
		to_chat(owner, span_notice("You have upgraded [initial(P.name)]!"))
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
