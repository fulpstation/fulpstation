// NOTE: All Targeted spells are Toggles! We just don't bother checking here.
/datum/action/bloodsucker/targeted
	power_flags = BP_AM_TOGGLE

	var/target_range = 99
	var/prefire_message = ""
	///Most powers happen the moment you click. Some, like Mesmerize, require time and shouldn't cost you if they fail.
	var/power_activates_immediately = TRUE
	///Is this power LOCKED due to being used?
	var/power_in_use = FALSE

/// Modify description to add notice that this is aimed.
/datum/action/bloodsucker/targeted/New(Target)
	desc += "<br>\[<i>Targeted Power</i>\]"
	return ..()

/datum/action/bloodsucker/targeted/Remove(mob/living/remove_from)
	. = ..()
	if(remove_from.click_intercept == src)
		unset_click_ability(remove_from)

/datum/action/bloodsucker/targeted/Trigger(trigger_flags, atom/target)
	if(active && CheckCanDeactivate())
		DeactivatePower()
		return FALSE
	if(!CheckCanPayCost(owner) || !CheckCanUse(owner))
		return FALSE

	ActivatePower()
	if(prefire_message != "")
		to_chat(owner, span_announce("[prefire_message]"))
	if(target)
		return InterceptClickOn(owner, null, target)

	var/datum/action/cooldown/already_set = owner.click_intercept
	if(already_set == src)
		// if we clicked ourself and we're already set, unset and return
		return unset_click_ability(owner)

	else if(istype(already_set))
		// if we have an active set already, unset it before we set our's
		already_set.unset_click_ability(owner)

	return set_click_ability(owner)

/datum/action/bloodsucker/targeted/DeactivatePower()
	if(power_flags & BP_AM_TOGGLE)
		STOP_PROCESSING(SSprocessing, src)
	active = FALSE
	UpdateButtons()
//	..() // we don't want to pay cost here

/// Check if target is VALID (wall, turf, or character?)
/datum/action/bloodsucker/targeted/proc/CheckValidTarget(atom/target_atom)
	if(target_atom == owner)
		return FALSE
	return TRUE

/// Check if valid target meets conditions
/datum/action/bloodsucker/targeted/proc/CheckCanTarget(atom/target_atom)
	// Out of Range
	if(!(target_atom in view(target_range, owner)))
		if(target_range > 1) // Only warn for range if it's greater than 1. Brawn doesn't need to announce itself.
			owner.balloon_alert(owner, "out of range.")
		return FALSE
	return istype(target_atom)

/// Click Target
/datum/action/bloodsucker/targeted/proc/ClickWithPower(atom/target_atom)
	// CANCEL RANGED TARGET check
	if(power_in_use || !CheckValidTarget(target_atom))
		return FALSE
	// Valid? (return true means DON'T cancel power!)
	if(!CheckCanPayCost() || !CheckCanUse(owner) || !CheckCanTarget(target_atom))
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
	unset_click_ability(owner)
	PayCost()
	StartCooldown()	// Do AFTER UpdateIcon() inside of DeactivatePower. Otherwise icon just gets wiped.
	DeactivatePower()

/datum/action/bloodsucker/targeted/proc/InterceptClickOn(mob/living/caller, params, atom/target)
	ClickWithPower(target)

/datum/action/bloodsucker/proc/set_click_ability(mob/on_who)
	on_who.click_intercept = src
	return TRUE

/datum/action/bloodsucker/proc/unset_click_ability(mob/on_who)
	on_who.click_intercept = null
	return TRUE
