/datum/action/bloodsucker
	name = "Vampiric Gift"
	desc = "A vampiric gift."
	//This is the FILE for the background icon
	button_icon = 'fulp_modules/features/bloodsuckers/icons/actions_bloodsucker.dmi'
	//This is the ICON_STATE for the background icon
	background_icon_state = "vamp_power_off"
	var/background_icon_state_on = "vamp_power_on"
	var/background_icon_state_off = "vamp_power_off"
	icon_icon = 'fulp_modules/features/bloodsuckers/icons/actions_bloodsucker.dmi'
	button_icon_state = "power_feed"
	buttontooltipstyle = "cult"
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
	var/purchase_flags = NONE // BLOODSUCKER_CAN_BUY|VASSAL_CAN_BUY|HUNTER_CAN_BUY

	// VARS //
	///If the Power is currently active.
	var/active = FALSE
	/// Cooldown between each use.
	var/cooldown = 2 SECONDS
	/// Check: If the Cooldown is over yet
	var/power_cooldown = 0
	/// What Tremere level is this Power?
	var/tremere_level
	///Can increase to yield new abilities - Each Power ranks up each Rank
	var/level_current = 0
	///The cost to ACTIVATE this Power
	var/bloodcost
	///The cost to MAINTAIN this Power - Only used for Constant Cost Powers
	var/constant_bloodcost

// Modify description to add cost.
/datum/action/bloodsucker/New(Target)
	. = ..()
	if(bloodcost > 0)
		desc += "<br><br><b>COST:</b> [bloodcost] Blood"
	if(constant_bloodcost)
		desc += "<br><br><b>CONSTANT COST:</b><i> [name] costs [constant_bloodcost] Blood maintain active.</i>"
	if(power_flags & BP_AM_SINGLEUSE)
		desc += "<br><br><b>SINGLE USE:</br><i> [name] can only be used once per night.</i>"

/datum/action/bloodsucker/Grant(mob/user)
	. = ..()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner)
	if(bloodsuckerdatum)
		bloodsuckerdatum_power = bloodsuckerdatum

/datum/action/bloodsucker/Destroy()
	bloodsuckerdatum_power = null
	return ..()

/mob/living/proc/explain_powers()
	set name = "Bloodsucker Help"
	set category = "Mentor"

	var/datum/antagonist/bloodsucker/bloodsuckerdatum = mind.has_antag_datum(/datum/antagonist/bloodsucker)
	var/choice = tgui_input_list(usr, "What Power are you looking into?", "Mentorhelp v2", bloodsuckerdatum.powers)
	if(!choice)
		return
	var/datum/action/bloodsucker/power = choice
	to_chat(usr, span_warning("[power.power_explanation]"))

/**
 * # NOTES
 *
 * click.dm <--- Where we can take over mouse clicks
 * spells.dm  /add_ranged_ability()  <--- How we take over the mouse click to use a power on a target.
 */

/datum/action/bloodsucker/Trigger()
	if(active && CheckCanDeactivate(TRUE)) // Active? DEACTIVATE AND END!
		DeactivatePower()
		return FALSE
	if(!CheckCanPayCost(TRUE) || !CheckCanUse(TRUE))
		return FALSE
	PayCost()
	UpdateButtonIcon()
	if(!(power_flags & BP_AM_TOGGLE) || !active)
		StartCooldown() // Must come AFTER UpdateButton(), otherwise icon will revert.
	if(power_flags & BP_AM_TOGGLE)
		active = !active
		UpdateButtonIcon()
		ActivatePower() //We're doing this here because it has to be after 'active = !active'
		return TRUE // Don't keep going down, or else it'll be Deactivated.
	ActivatePower() // This is placed here so Toggled Powers can run and return before this occurs.
	if(power_flags & BP_AM_SINGLEUSE)
		RemoveAfterUse()
	if(active) // Did we not manually disable? Handle it here.
		DeactivatePower()
	return TRUE

/datum/action/bloodsucker/proc/CheckCanPayCost(display_error)
	if(!owner || !owner.mind)
		return FALSE
	// Cooldown?
	if(power_cooldown > world.time)
		if(display_error)
			to_chat(owner, "[src] is unavailable. Wait [(power_cooldown - world.time) / 10] seconds.")
		return FALSE
	// Have enough blood? Bloodsuckers in a Frenzy don't need to pay them
	var/mob/living/user = owner
	if(bloodsuckerdatum_power?.frenzied)
		return TRUE
	if(user.blood_volume < bloodcost)
		if(display_error)
			to_chat(owner, span_warning("You need at least [bloodcost] blood to activate [name]"))
		return FALSE
	return TRUE

/// These checks can be scanned every frame while a ranged power is on.
/datum/action/bloodsucker/proc/CheckCanUse(display_error)
	if(!owner || !owner.mind)
		return FALSE
	var/mob/living/bloodsuckerliving = owner
	// Torpor?
	if((check_flags & BP_CANT_USE_IN_TORPOR) && HAS_TRAIT(owner, TRAIT_NODEATH))
		if(display_error)
			to_chat(owner, span_warning("Not while you're in Torpor."))
		return FALSE
	// Frenzy?
	if((check_flags & BP_CANT_USE_IN_FRENZY) && (bloodsuckerdatum_power?.frenzied && bloodsuckerdatum_power?.my_clan != CLAN_BRUJAH))
		if(display_error)
			to_chat(owner, span_warning("You cannot use powers while in a Frenzy!"))
		return FALSE
	// Stake?
	if((check_flags & BP_CANT_USE_WHILE_STAKED) && owner.AmStaked())
		if(display_error)
			to_chat(owner, span_warning("You have a stake in your chest! Your powers are useless."))
		return FALSE
	// Conscious?
	if((check_flags & BP_CANT_USE_WHILE_UNCONSCIOUS) && owner.stat != CONSCIOUS)
		if(display_error)
			to_chat(owner, span_warning("You can't do this while you are unconcious!"))
		return FALSE
	// Incapacitated?
	if((check_flags & BP_CANT_USE_WHILE_INCAPACITATED) && (bloodsuckerliving.incapacitated(ignore_restraints=TRUE,ignore_grab=TRUE)))
		if(display_error)
			to_chat(owner, span_warning("Not while you're incapacitated!"))
		return FALSE
	// Constant Cost (out of blood)
	if(constant_bloodcost && bloodsuckerliving.blood_volume <= 0)
		if(display_error)
			to_chat(owner, span_warning("You don't have the blood to upkeep [src]."))
		return FALSE
	return TRUE

/// NOTE: With this formula, you'll hit half cooldown at level 8 for that power.
/datum/action/bloodsucker/proc/StartCooldown()
	// Alpha Out
	button.color = rgb(128,0,0,128)
	button.alpha = 100
	// Calculate Cooldown (by power's level)
	var/this_cooldown = ((power_flags & BP_AM_STATIC_COOLDOWN) || (power_flags & BP_AM_SINGLEUSE)) ? cooldown : max(cooldown / 2, cooldown - (cooldown / 16 * (level_current-1)))

	// Wait for cooldown
	power_cooldown = world.time + this_cooldown
	addtimer(CALLBACK(src, .proc/alpha_in), this_cooldown)

/datum/action/bloodsucker/proc/alpha_in()
	button.color = rgb(255,255,255,255)
	button.alpha = 255

/datum/action/bloodsucker/proc/CheckCanDeactivate(display_error)
	return TRUE

/datum/action/bloodsucker/UpdateButtonIcon(force = FALSE)
	background_icon_state = active ? background_icon_state_on : background_icon_state_off
	. = ..()

/datum/action/bloodsucker/proc/PayCost()
	// Bloodsuckers in a Frenzy don't have enough Blood to pay it, so just don't.
	if(bloodsuckerdatum_power?.frenzied)
		return
	var/mob/living/carbon/human/user = owner
	user.blood_volume -= bloodcost
	bloodsuckerdatum_power?.update_hud()

/datum/action/bloodsucker/proc/ActivatePower()
	if(power_flags & BP_AM_TOGGLE)
		RegisterSignal(owner, COMSIG_LIVING_BIOLOGICAL_LIFE, .proc/UsePower)

/datum/action/bloodsucker/proc/DeactivatePower(mob/living/user = owner, mob/living/target)
	if(power_flags & BP_AM_TOGGLE)
		UnregisterSignal(owner, COMSIG_LIVING_BIOLOGICAL_LIFE)
	active = FALSE
	UpdateButtonIcon()
	StartCooldown()

///Used by powers that are continuously active (That have BP_AM_TOGGLE flag)
/datum/action/bloodsucker/proc/UsePower(mob/living/user)
	SIGNAL_HANDLER

	if(!active) // Power isn't active? Then stop here, so we dont keep looping UsePower for a non existent Power.
		return FALSE
	if(!ContinueActive(user)) // We can't afford the Power? Deactivate it.
		DeactivatePower()
		return FALSE
	// We can keep this up (For now), so Pay Cost!
	if(!(power_flags & BP_AM_COSTLESS_UNCONSCIOUS) && user.stat != CONSCIOUS)
		bloodsuckerdatum_power?.AddBloodVolume(-constant_bloodcost)
	return TRUE

/// Checks to make sure this power can stay active
/datum/action/bloodsucker/proc/ContinueActive(mob/living/user, mob/living/target)
	if(!active)
		return FALSE
	if(!user)
		return FALSE
	if(!constant_bloodcost || user.blood_volume > 0)
		return TRUE

/// Used to unlearn Single-Use Powers
/datum/action/bloodsucker/proc/RemoveAfterUse()
	bloodsuckerdatum_power?.powers -= src
	Remove(owner)

/datum/action/bloodsucker/proc/Upgrade()
	level_current++

///////////////////////////////////  TARGETED POWERS	///////////////////////////////////

/// NOTE: All Targeted spells are Toggles! We just don't bother checking here.
/datum/action/bloodsucker/targeted
	var/obj/effect/proc_holder/bloodsucker/bs_proc_holder
	var/target_range = 99
	var/prefire_message = ""
	///Most powers happen the moment you click. Some, like Mesmerize, require time and shouldn't cost you if they fail.
	var/power_activates_immediately = TRUE
	///Is this power LOCKED due to being used?
	var/power_in_use = FALSE

/// Modify description to add notice that this is aimed.
/datum/action/bloodsucker/targeted/New(Target)
	desc += "<br>\[<i>Targeted Power</i>\]"
	. = ..()
	// Create Proc Holder for intercepting clicks
	bs_proc_holder = new()
	bs_proc_holder.linked_power = src

/datum/action/bloodsucker/targeted/Trigger()
	// Click power: Begin Aim
	if(active && CheckCanDeactivate(TRUE))
		DeactivatePower()
		return FALSE
	if(!CheckCanPayCost(TRUE) || !CheckCanUse(TRUE))
		return FALSE
	active = !active
	UpdateButtonIcon()
	// Create & Link Targeting Proc
	var/mob/living/user = owner
	if(user.ranged_ability)
		user.ranged_ability.remove_ranged_ability()
	bs_proc_holder.add_ranged_ability(user)
	if(prefire_message != "")
		to_chat(owner, span_announce("[prefire_message]"))
	return TRUE

/datum/action/bloodsucker/targeted/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return FALSE
	// We don't allow non client usage so that using powers like mesmerize will FAIL if you try to use them as ghost.
	if(!owner.client)
		return FALSE
	return TRUE

/datum/action/bloodsucker/targeted/DeactivatePower(mob/living/user = owner, mob/living/target)
	// Don't run ..(), we don't want to engage the cooldown until we USE this power!
	active = FALSE
	UpdateButtonIcon()
	DeactivateRangedAbility()

/// Only Turned off when CLICK is disabled...aka, when you successfully clicked
/datum/action/bloodsucker/targeted/proc/DeactivateRangedAbility()
	bs_proc_holder.remove_ranged_ability()

/// Check if target is VALID (wall, turf, or character?)
/datum/action/bloodsucker/targeted/proc/CheckValidTarget(atom/target_atom)
	if(target_atom == owner)
		return FALSE
	return TRUE

/// Check if valid target meets conditions
/datum/action/bloodsucker/targeted/proc/CheckCanTarget(atom/target_atom, display_error)
	// Out of Range
	if(!(target_atom in view(target_range, owner)))
		if(display_error && target_range > 1) // Only warn for range if it's greater than 1. Brawn doesn't need to announce itself.
			owner.balloon_alert(owner, "out of range.")
		return FALSE
	return istype(target_atom)

/// Click Target
/datum/action/bloodsucker/targeted/proc/ClickWithPower(atom/target_atom)
	// CANCEL RANGED TARGET check
	if(power_in_use || !CheckValidTarget(target_atom))
		return FALSE
	// Valid? (return true means DON'T cancel power!)
	if(!CheckCanPayCost(TRUE) || !CheckCanUse(TRUE) || !CheckCanTarget(target_atom, TRUE))
		return TRUE
	power_in_use = TRUE // Lock us into this ability until it successfully fires off. Otherwise, we pay the blood even if we fail.
	FireTargetedPower(target_atom) // We use this instead of ActivatePower(), which has no input
	// Skip this part so we can return TRUE right away.
	if(power_activates_immediately)
		PowerActivatedSuccessfully() // Mesmerize pays only after success.
	power_in_use = FALSE
	return TRUE

/// Like ActivatePower, but specific to Targeted (and takes an atom input). We don't use ActivatePower for targeted.
/datum/action/bloodsucker/targeted/proc/FireTargetedPower(atom/target_atom)
	log_combat(owner, target_atom, "used [name] on")

/// The power went off! We now pay the cost of the power.
/datum/action/bloodsucker/targeted/proc/PowerActivatedSuccessfully()
	PayCost()
	DeactivatePower()
	StartCooldown()	// Do AFTER UpdateIcon() inside of DeactivatePower. Otherwise icon just gets wiped.

/// Used by loops to make sure this power can stay active.
/datum/action/bloodsucker/targeted/ContinueActive(mob/living/user, mob/living/target)
	return ..()

/// Target Proc Holder
/obj/effect/proc_holder/bloodsucker
	var/datum/action/bloodsucker/targeted/linked_power

/*
/obj/effect/proc_holder/bloodsucker/remove_ranged_ability(msg)
	..()
	linked_power.DeactivatePower()
*/

/obj/effect/proc_holder/bloodsucker/InterceptClickOn(mob/living/caller, params, atom/targeted_atom)
	return linked_power.ClickWithPower(targeted_atom)
