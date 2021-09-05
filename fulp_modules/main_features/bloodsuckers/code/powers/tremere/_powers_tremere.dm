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
	background_icon_state = "tremere_power_off"
	background_icon_state_on = "tremere_power_on"
	background_icon_state_off = "tremere_power_off"
	button_icon = 'fulp_modules/main_features/bloodsuckers/icons/actions_tremere_bloodsucker.dmi'
	icon_icon = 'fulp_modules/main_features/bloodsuckers/icons/actions_tremere_bloodsucker.dmi'
	// Targeted stuff
	target_range = 99
	message_Trigger = ""
	power_activates_immediately = TRUE

/datum/action/bloodsucker/targeted/tremere/Trigger()
	. = ..()
	if(!.)
		return
	ActivatePower()

/datum/antagonist/bloodsucker/proc/LevelUpTremerePower(mob/living/user)

	var/list/options = list()
	for(var/datum/action/bloodsucker/targeted/tremere/power in powers)
		if(!(locate(power) in powers))
			continue
		var/datum/action/bloodsucker/targeted/tremere/current_power = (locate(power) in powers)
		if(initial(power.tremere_level) >= current_power.tremere_level)
			options[initial(power.name)] = power

	if(options.len >= 1)
		var/choice = tgui_input_list(user, "You have the opportunity to grow more ancient. Select a power you wish to Upgrade.", "Your Blood Thickens...", options)
		/// Did you choose a power?
		if(!choice || !options[choice])
			to_chat(user, span_notice("You prevent your blood from thickening just yet, but you may try again later."))
			return FALSE
		if(bloodsucker_level_unspent <= 0)
			return FALSE

		var/datum/action/bloodsucker/targeted/tremere/P = options[choice]
		if(P.upgraded_power)
			BuyPower(new P.upgraded_power)
			if(P.active)
				P.DeactivatePower()
			powers -= P
			P.Remove(user)
			user.balloon_alert(user, "upgraded [P]!")
			to_chat(user, span_notice("You have upgraded [P]!"))
			return TRUE
		else
			user.balloon_alert(user, "cannot upgrade [P]!")
			to_chat(user, span_notice("[P] is already at max level!"))
	return FALSE


/datum/action/bloodsucker/targeted/tremere/CheckValidTarget(atom/A)
	return isliving(A)

/datum/action/bloodsucker/targeted/tremere/CheckCanTarget(atom/A, display_error)
	if(!..())
		return FALSE
	// Check: Self
	if(A == owner)
		return FALSE
	return TRUE
