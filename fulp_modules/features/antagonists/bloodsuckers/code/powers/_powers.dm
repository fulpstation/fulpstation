/datum/action/bloodsucker
	name = "Vampiric Gift"
	desc = "A vampiric gift."
	//This is the FILE for the background icon
	button_icon = 'fulp_modules/features/antagonists/bloodsuckers/icons/actions_bloodsucker.dmi'
	//This is the ICON_STATE for the background icon
	background_icon_state = "vamp_power_off"
	icon_icon = 'fulp_modules/features/antagonists/bloodsuckers/icons/actions_bloodsucker.dmi'
	button_icon_state = "power_feed"
	buttontooltipstyle = "cult"
	transparent_when_unavailable = TRUE

	///Background icon when the Power is active.
	var/background_icon_state_on = "vamp_power_on"
	///Background icon when the Power is NOT active.
	var/background_icon_state_off = "vamp_power_off"

	/// The text that appears when using the help verb, meant to explain how the Power changes when ranking up.
	var/power_explanation = ""
	///The owner's stored Bloodsucker datum
	var/datum/antagonist/bloodsucker/bloodsuckerdatum_power

	// FLAGS //
	/// The effects on this Power (Toggled/Single Use/Static Cooldown)
	var/power_flags = BP_AM_TOGGLE|BP_AM_SINGLEUSE|BP_AM_STATIC_COOLDOWN|BP_AM_COSTLESS_UNCONSCIOUS
	/// Requirement flags for checks
	check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY|BP_CANT_USE_WHILE_STAKED|BP_CANT_USE_WHILE_INCAPACITATED|BP_CANT_USE_WHILE_UNCONSCIOUS
	/// Who can purchase the Power
	var/purchase_flags = NONE // BLOODSUCKER_CAN_BUY|TREMERE_CAN_BUY|VASSAL_CAN_BUY|HUNTER_CAN_BUY

	// COOLDOWNS //
	///Timer between Power uses.
	COOLDOWN_DECLARE(bloodsucker_power_cooldown)

	// VARS //
	/// If the Power is currently active.
	var/active = FALSE
	/// Cooldown you'll have to wait between each use, decreases depending on level.
	var/cooldown = 2 SECONDS
	///Can increase to yield new abilities - Each Power ranks up each Rank
	var/level_current = 0
	///The cost to ACTIVATE this Power
	var/bloodcost = 0
	///The cost to MAINTAIN this Power - Only used for Constant Cost Powers
	var/constant_bloodcost = 0

// Modify description to add cost.
/datum/action/bloodsucker/New(Target)
	. = ..()
	if(bloodcost > 0)
		desc += "<br><br><b>COST:</b> [bloodcost] Blood"
	if(constant_bloodcost > 0)
		desc += "<br><br><b>CONSTANT COST:</b><i> [name] costs [constant_bloodcost] Blood maintain active.</i>"
	if(power_flags & BP_AM_SINGLEUSE)
		desc += "<br><br><b>SINGLE USE:</br><i> [name] can only be used once per night.</i>"

/datum/action/bloodsucker/Destroy()
	bloodsuckerdatum_power = null
	return ..()

/datum/action/bloodsucker/IsAvailable()
	return COOLDOWN_FINISHED(src, bloodsucker_power_cooldown)

/datum/action/bloodsucker/Grant(mob/user)
	. = ..()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner)
	if(bloodsuckerdatum)
		bloodsuckerdatum_power = bloodsuckerdatum

//This is when we CLICK on the ability Icon, not USING.
/datum/action/bloodsucker/Trigger(trigger_flags)
	if(active && CheckCanDeactivate()) // Active? DEACTIVATE AND END!
		DeactivatePower()
		return FALSE
	if(!CheckCanPayCost() || !CheckCanUse(owner))
		return FALSE
	PayCost()
	ActivatePower()
	if(!(power_flags & BP_AM_TOGGLE) || !active)
		StartCooldown()
	return TRUE

/datum/action/bloodsucker/proc/CheckCanPayCost()
	if(!owner || !owner.mind)
		return FALSE
	// Cooldown?
	if(!COOLDOWN_FINISHED(src, bloodsucker_power_cooldown))
		owner.balloon_alert(owner, "power unavailable!")
		to_chat(owner, "[src] on cooldown!")
		return FALSE
	// Have enough blood? Bloodsuckers in a Frenzy don't need to pay them
	var/mob/living/user = owner
	if(bloodsuckerdatum_power?.frenzied)
		return TRUE
	if(user.blood_volume < bloodcost)
		to_chat(owner, span_warning("You need at least [bloodcost] blood to activate [name]"))
		return FALSE
	return TRUE

///Checks if the Power is available to use.
/datum/action/bloodsucker/proc/CheckCanUse(mob/living/carbon/user)
	if(!owner)
		return FALSE
	if(!isliving(user))
		return FALSE
	// Torpor?
	if((check_flags & BP_CANT_USE_IN_TORPOR) && HAS_TRAIT(user, TRAIT_NODEATH))
		to_chat(user, span_warning("Not while you're in Torpor."))
		return FALSE
	// Frenzy?
	if((check_flags & BP_CANT_USE_IN_FRENZY) && (bloodsuckerdatum_power?.frenzied && bloodsuckerdatum_power?.my_clan != CLAN_BRUJAH))
		to_chat(user, span_warning("You cannot use powers while in a Frenzy!"))
		return FALSE
	// Stake?
	if((check_flags & BP_CANT_USE_WHILE_STAKED) && user.AmStaked())
		to_chat(user, span_warning("You have a stake in your chest! Your powers are useless."))
		return FALSE
	// Conscious? -- We use our own (AB_CHECK_CONSCIOUS) here so we can control it more, like the error message.
	if((check_flags & BP_CANT_USE_WHILE_UNCONSCIOUS) && user.stat != CONSCIOUS)
		to_chat(user, span_warning("You can't do this while you are unconcious!"))
		return FALSE
	// Incapacitated?
	if((check_flags & BP_CANT_USE_WHILE_INCAPACITATED) && (user.incapacitated(IGNORE_RESTRAINTS, IGNORE_GRAB)))
		to_chat(user, span_warning("Not while you're incapacitated!"))
		return FALSE
	// Constant Cost (out of blood)
	if(constant_bloodcost > 0 && user.blood_volume <= 0)
		to_chat(user, span_warning("You don't have the blood to upkeep [src]."))
		return FALSE
	return TRUE

/// NOTE: With this formula, you'll hit half cooldown at level 8 for that power.
/datum/action/bloodsucker/proc/StartCooldown()
	// Calculate Cooldown (by power's level)
	var/this_cooldown
	if(power_flags & BP_AM_STATIC_COOLDOWN)
		this_cooldown = cooldown
	else
		this_cooldown = max(cooldown / 2, cooldown - (cooldown / 16 * (level_current-1)))

	// Wait for cooldown
	COOLDOWN_START(src, bloodsucker_power_cooldown, this_cooldown)
	addtimer(CALLBACK(src, .proc/UpdateButtons), this_cooldown+(1 SECONDS))

/datum/action/bloodsucker/proc/CheckCanDeactivate()
	return TRUE

/datum/action/bloodsucker/UpdateButton(atom/movable/screen/movable/action_button/button, status_only = FALSE, force = FALSE)
	if(active)
		background_icon_state = background_icon_state_on
	else
		background_icon_state = background_icon_state_off
	return ..()

/datum/action/bloodsucker/proc/PayCost()
	// Bloodsuckers in a Frenzy don't have enough Blood to pay it, so just don't.
	if(bloodsuckerdatum_power?.frenzied)
		return
	var/mob/living/carbon/human/user = owner
	user.blood_volume -= bloodcost
	bloodsuckerdatum_power?.update_hud()

/datum/action/bloodsucker/proc/ActivatePower()
	active = TRUE
	if(power_flags & BP_AM_TOGGLE)
		START_PROCESSING(SSprocessing, src)

	owner.log_message("used [src][bloodcost != 0 ? " at the cost of [bloodcost]" : ""].", LOG_ATTACK, color="red")
	UpdateButtons()

/datum/action/bloodsucker/proc/DeactivatePower()
	if(power_flags & BP_AM_TOGGLE)
		STOP_PROCESSING(SSprocessing, src)
	if(power_flags & BP_AM_SINGLEUSE)
		RemoveAfterUse()
		return
	active = FALSE
	StartCooldown()
	UpdateButtons()

///Used by powers that are continuously active (That have BP_AM_TOGGLE flag)
/datum/action/bloodsucker/process(delta_time)
	if(!ContinueActive(owner)) // We can't afford the Power? Deactivate it.
		DeactivatePower()
		return FALSE
	// We can keep this up (For now), so Pay Cost!
	if(!(power_flags & BP_AM_COSTLESS_UNCONSCIOUS) && owner.stat != CONSCIOUS)
		bloodsuckerdatum_power?.AddBloodVolume(-constant_bloodcost)
	return TRUE

/// Checks to make sure this power can stay active
/datum/action/bloodsucker/proc/ContinueActive(mob/living/user, mob/living/target)
	if(!user)
		return FALSE
	if(!constant_bloodcost > 0 || user.blood_volume > 0)
		return TRUE

/// Used to unlearn Single-Use Powers
/datum/action/bloodsucker/proc/RemoveAfterUse()
	bloodsuckerdatum_power?.powers -= src
	Remove(owner)
