/**
 *	# Tremere Powers
 *
 *	This file is for Tremere power procs and Bloodsucker procs that deals exclusively with Tremere.
 *	Tremere has quite a bit of unique Powers, so I thought it's own folder and file would be nice
 */

/datum/action/bloodsucker/targeted/tremere
	name = "Tremere Gift"
	desc = "A tremere exclusive gift."
	///The upgraded version of this Power. 'null' means it's the max level.
	var/upgraded_power = null

	// Icon stuff
	button_icon_state = "power_feed"
	background_icon_state = "tremere_power_off"
	background_icon_state_on = "tremere_power_on"
	background_icon_state_off = "tremere_power_off"
	button_icon = 'fulp_modules/features/bloodsuckers/icons/actions_tremere_bloodsucker.dmi'
	icon_icon = 'fulp_modules/features/bloodsuckers/icons/actions_tremere_bloodsucker.dmi'

	// Tremere powers don't level up, we have them hardcoded.
	level_current = 0
	// Re-defining these as we want total control over them
	power_flags = BP_AM_TOGGLE
	purchase_flags = NONE
	// Targeted stuff
	target_range = 99
	power_activates_immediately = TRUE

/datum/action/bloodsucker/targeted/tremere/CheckValidTarget(atom/target_atom)
	. = ..()
	if(!.)
		return FALSE
	return isliving(target_atom)

/datum/antagonist/bloodsucker/proc/LevelUpTremerePower(mob/living/user)
	var/list/options = list()
	for(var/datum/action/bloodsucker/targeted/tremere/power as anything in powers)
		if(isnull(power.upgraded_power))
			continue
		options[initial(power.name)] = power

	if(options.len >= 1)
		var/choice = tgui_input_list(user, "You have the opportunity to grow more ancient. Select a power you wish to upgrade.", "Your Blood Thickens...", options)
		/// Did you choose a power?
		if(!choice || !options[choice])
			to_chat(user, span_notice("You prevent your blood from thickening just yet, but you may try again later."))
			return FALSE
		if(bloodsucker_level_unspent <= 0)
			return FALSE

		var/datum/action/bloodsucker/targeted/tremere/selected_power = options[choice]
		if(selected_power.upgraded_power)
			BuyPower(new selected_power.upgraded_power)
			if(selected_power.active)
				selected_power.DeactivatePower()
			powers -= selected_power
			selected_power.Remove(user)
			user.balloon_alert(user, "upgraded [selected_power]!")
			to_chat(user, span_notice("You have upgraded [selected_power]!"))
			return TRUE
		else
			user.balloon_alert(user, "cannot upgrade [selected_power]!")
			to_chat(user, span_notice("[selected_power] is already at max level!"))
	return FALSE
