/datum/action/cooldown/werewolf
	name = "Werewolf power"
	desc = "A werewolf power."
	background_icon = 'fulp_modules/features/antagonists/bloodsuckers/icons/actions_bloodsucker.dmi'
	background_icon_state = "vamp_power_off"
	button_icon = 'fulp_modules/features/antagonists/bloodsuckers/icons/actions_bloodsucker.dmi'
	button_icon_state = "power_feed"
	buttontooltipstyle = "cult"
	transparent_when_unavailable = TRUE
	cooldown_time = 2 SECONDS
	check_flags = WP_TRANSFORM_REQUIRED

	var/datum/antagonist/werewolf/werewolf_datum_power
	/// Flags the ability has
	var/power_flags // WP_TOGGLED
	/// Whether or not the ability is activated
	var/active = FALSE

/datum/action/cooldown/werewolf/Grant(mob/user)
	. = ..()

	RegisterSignal(owner, WEREWOLF_TRANSFORMED, PROC_REF(update_status_on_signal))
	RegisterSignal(owner, WEREWOLF_REVERTED, PROC_REF(update_status_on_signal))

	var/datum/antagonist/werewolf/werewolf_datum = IS_WEREWOLF(user)
	if(werewolf_datum)
		werewolf_datum_power = werewolf_datum

/datum/action/cooldown/werewolf/Remove(mob/removed_from)
	UnregisterSignal(owner, WEREWOLF_TRANSFORMED)
	UnregisterSignal(owner, WEREWOLF_REVERTED)
	return ..()

/datum/action/cooldown/werewolf/IsAvailable(feedback)
	. = ..()
	if((check_flags & WP_TRANSFORM_REQUIRED) && !werewolf_datum_power.transformed)
		if(feedback)
			owner.balloon_alert(owner, "must be transformed!")
		return FALSE
	return .

/datum/action/cooldown/werewolf/Destroy()
	werewolf_datum_power = null
	return ..()

/// Whether or not the power can be used by the mob
/datum/action/cooldown/werewolf/proc/can_use(mob/living/carbon/user)
	if(!owner)
		return FALSE
	if(!IS_WEREWOLF(user))
		return FALSE
	if(!isliving(user))
		return FALSE
	if((check_flags & WP_TRANSFORM_REQUIRED) && !werewolf_datum_power.transformed)
		to_chat(user, span_warning("You can't use [name] while not transformed!"))
		return FALSE

	return TRUE

/datum/action/cooldown/werewolf/proc/activate_power()
	if(power_flags & WP_TOGGLED)
		active = TRUE
	return TRUE

/datum/action/cooldown/werewolf/proc/deactivate_power()
	active = FALSE
	return TRUE

/datum/action/cooldown/werewolf/Trigger(trigger_flags, atom/target)
	if(next_use_time <= world.time)
		if(!can_use(usr))
			return FALSE
		if(active)
			deactivate_power()
		else
			activate_power()
	return ..()
