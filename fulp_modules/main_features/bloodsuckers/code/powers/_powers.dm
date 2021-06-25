/datum/action/bloodsucker
	name = "Vampiric Gift"
	desc = "A vampiric gift."
	///This is the file for the BACKGROUND icon
	button_icon = 'fulp_modules/main_features/bloodsuckers/icons/actions_bloodsucker.dmi'
	///This is the state for the background icon
	background_icon_state = "vamp_power_off"
	var/background_icon_state_on = "vamp_power_on"
	var/background_icon_state_off = "vamp_power_off"
	icon_icon = 'fulp_modules/main_features/bloodsuckers/icons/actions_bloodsucker.dmi'
	button_icon_state = "power_feed"
	buttontooltipstyle = "cult"

	// Action Related
	///Am I asked to choose a target when enabled? (Shows as toggled ON when armed)
	var/amTargetted = FALSE
	///Can I be actively turned on and off?
	var/amToggle = FALSE
	///Am I removed after a single use?
	var/amSingleUse = FALSE
	var/active = FALSE
	/// 10 ticks, 1 second.
	var/cooldown = 20
	/// From action.dm: next_use_time = world.time + cooldown_time
	var/cooldownUntil = 0

	// Power related
	///Can increase to yield new abilities. Each power goes up in strength each Rank.
	var/level_current = 0
	//var/level_max = 1
	var/bloodcost
	///For passive abilities that dont need a button - Taken from Changeling
	var/needs_button = TRUE
	///Bloodsuckers can purchase this when Ranking up
	var/bloodsucker_can_buy = FALSE
	///Ventrue Vassals can have this power purchased when Ranking up
	var/vassal_can_buy = FALSE
	///Some powers charge you for staying on. Masquerade, Cloak, Veil, etc.
	var/warn_constant_cost = FALSE
	///Powers that can be used in Torpor - Just Masquerade
	var/can_use_in_torpor = FALSE
	///Powers that can only be used while in a Frenzy - Unless you're part of Brujah
	var/can_use_in_frenzy = FALSE
	///Do we need to be standing and ready?
	var/must_be_capacitated = FALSE
	///Brawn can be used when incapacitated/laying if it's because you're being immobilized. NOTE: If must_be_capacitated is FALSE, this is irrelevant.
	var/can_use_w_immobilize = FALSE
	///Can I use this while staked?
	var/can_use_w_stake = FALSE
	///Feed, Masquerade, and One-Shot powers don't improve their cooldown.
	var/cooldown_static = FALSE
	/// This goes to Vassals or Hunters, but NOT bloodsuckers. - Replaced with vassal_can_buy kept here because Monsterhunters??
	//var/not_bloodsucker = FALSE
	///Can't use this ability while unconcious.
	var/must_be_concious = TRUE

/// Modify description to add cost.
/datum/action/bloodsucker/New()
	if(bloodcost > 0)
		desc += "<br><br><b>COST:</b> [bloodcost] Blood"
	if(warn_constant_cost)
		desc += "<br><br><i>Your over-time blood consumption increases while [name] is active.</i>"
	if(amSingleUse)
		desc += "<br><br><i>Useable once per night.</i>"
	..()

/*							NOTES
 *
 * 	click.dm <--- Where we can take over mouse clicks
 *	spells.dm  /add_ranged_ability()  <--- How we take over the mouse click to use a power on a target.
 */

/datum/action/bloodsucker/Trigger()
	if(active && CheckCanDeactivate(TRUE)) // Active? DEACTIVATE AND END!
		DeactivatePower()
		return
	if(!CheckCanPayCost(TRUE) || !CheckCanUse(TRUE))
		return
	if(amSingleUse)
		RemoveAfterUse()
	PayCost()
	UpdateButtonIcon()
	if(!amToggle || !active)
		StartCooldown() // Must come AFTER UpdateButton(), otherwise icon will revert.
	if(amToggle)
		active = !active
		UpdateButtonIcon()
		ActivatePower() //We're doing this here because it has to be after 'active = !active'
		return // Don't keep going down, or else it'll be Deactivated.
	ActivatePower() // This is placed here so amToggle's can run and return before this occurs.
	if(active) // Did we not manually disable? Handle it here.
		DeactivatePower()

/datum/action/bloodsucker/proc/CheckCanPayCost(display_error)
	if(!owner || !owner.mind)
		return FALSE
	// Cooldown?
	if(cooldownUntil > world.time)
		if(display_error)
			to_chat(owner, "[src] is unavailable. Wait [(cooldownUntil - world.time) / 10] seconds.")
		return FALSE
	// Have enough blood? Bloodsuckers in a Frenzy don't need to pay them
	var/mob/living/L = owner
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(L)
	if(bloodsuckerdatum?.Frenzied)
		return TRUE
	if(L.blood_volume < bloodcost)
		if(display_error)
			to_chat(owner, span_warning("You need at least [bloodcost] blood to activate [name]"))
		return FALSE
	return TRUE

/// These checks can be scanned every frame while a ranged power is on.
/datum/action/bloodsucker/proc/CheckCanUse(display_error)
	if(!owner || !owner.mind)
		return FALSE
	// Torpor?
	if(!can_use_in_torpor && HAS_TRAIT(owner, TRAIT_NODEATH))
		if(display_error)
			to_chat(owner, span_warning("Not while you're in Torpor."))
		return FALSE
	// Stake?
	if(!can_use_w_stake && owner.AmStaked())
		if(display_error)
			to_chat(owner, span_warning("You have a stake in your chest! Your powers are useless."))
		return FALSE
	if(owner.reagents?.has_reagent(/datum/reagent/consumable/garlic))
		if(display_error)
			to_chat(owner, span_warning("Garlic in your blood is interfering with your powers!"))
		return FALSE
	if(must_be_concious)
		if(owner.stat != CONSCIOUS)
			if(display_error)
				to_chat(owner, span_warning("You can't do this while you are unconcious!"))
			return FALSE
	// Incapacitated?
	if(must_be_capacitated)
		var/mob/living/L = owner
		if (!can_use_w_immobilize && (!(L.mobility_flags & MOBILITY_STAND) || L.incapacitated(ignore_restraints=TRUE,ignore_grab=TRUE)))
			if(display_error)
				to_chat(owner, span_warning("Not while you're incapacitated!"))
			return FALSE
	// Constant Cost (out of blood)
	if(warn_constant_cost)
		var/mob/living/L = owner
		if(L.blood_volume <= 0)
			if(display_error)
				to_chat(owner, span_warning("You don't have the blood to upkeep [src]."))
			return FALSE
	// In a Frenzy?
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(bloodsuckerdatum && bloodsuckerdatum.Frenzied && !bloodsuckerdatum.my_clan == CLAN_BRUJAH)
		if(!can_use_in_frenzy)
			if(display_error)
				to_chat(owner, span_warning("You cannot use powers while in a Frenzy!"))
			return FALSE
	return TRUE

/// NOTE: With this formula, you'll hit half cooldown at level 8 for that power.
/datum/action/bloodsucker/proc/StartCooldown()
	set waitfor = FALSE
	// Alpha Out
	button.color = rgb(128,0,0,128)
	button.alpha = 100
	// Calculate Cooldown (by power's level)
	var/this_cooldown = (cooldown_static || amSingleUse) ? cooldown : max(cooldown / 2, cooldown - (cooldown / 16 * (level_current-1)))

	// Wait for cooldown
	cooldownUntil = world.time + this_cooldown
	spawn(this_cooldown)
		// Alpha In
		button.color = rgb(255,255,255,255)
		button.alpha = 255

/datum/action/bloodsucker/proc/CheckCanDeactivate(display_error)
	return TRUE

/datum/action/bloodsucker/UpdateButtonIcon(force = FALSE)
	background_icon_state = active? background_icon_state_on : background_icon_state_off
	..()

/datum/action/bloodsucker/proc/PayCost()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	// Bloodsuckers in a Frenzy don't have enough Blood to pay it, so just don't.
	if(bloodsuckerdatum?.Frenzied)
		return
	if(bloodsuckerdatum)
		bloodsuckerdatum.AddBloodVolume(-bloodcost)
	else
		var/mob/living/carbon/human/H = owner
		H.blood_volume -= bloodcost

/datum/action/bloodsucker/proc/ActivatePower()
	if(amToggle)
		UsePower(owner)

/datum/action/bloodsucker/proc/DeactivatePower(mob/living/user = owner, mob/living/target)
	active = FALSE
	UpdateButtonIcon()
	StartCooldown()

///Used by powers that are continuously active (That use amToggle)
/datum/action/bloodsucker/proc/UsePower(mob/living/user)
	if(!active) // Power isn't active? Then stop here, so we dont keep looping UsePower for a non existent Power.
		return FALSE
	if(!ContinueActive(user)) // We can't afford the Power? Deactivate it.
		DeactivatePower()
		return FALSE
	return TRUE

/// Used by loops to make sure this power can stay active.
/datum/action/bloodsucker/proc/ContinueActive(mob/living/user, mob/living/target)
	if(!active)
		return FALSE
	if(!user)
		return FALSE
	if(!warn_constant_cost || user.blood_volume > 0)
		return TRUE

/// Used to unlearn Go Home ability
/datum/action/bloodsucker/proc/RemoveAfterUse()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(istype(bloodsuckerdatum))
		bloodsuckerdatum.powers -= src
	Remove(owner)

/datum/action/bloodsucker/proc/Upgrade()
	level_current++

///////////////////////////////////  PASSIVE POWERS	///////////////////////////////////

/*
/// New Type: Passive (Always on, no button)
/datum/action/bloodsucker/passive
/// Don't Display Button! (it doesn't do anything anyhow)
/datum/action/bloodsucker/passive/New()
	..()
	button.screen_loc = DEFAULT_BLOODSPELLS
	button.moved = DEFAULT_BLOODSPELLS
	button.ordered = FALSE
/datum/action/bloodsucker/passive/Destroy()
	if(owner)
		Remove(owner)
	target = null
	return ..()
*/

///////////////////////////////////  TARGETTED POWERS	///////////////////////////////////

/// NOTE: All Targeted spells are Toggles! We just don't bother checking here.
/datum/action/bloodsucker/targeted
	var/target_range = 99
	var/message_Trigger = "Select a target."
	var/obj/effect/proc_holder/bloodsucker/bs_proc_holder
	///Most powers happen the moment you click. Some, like Mesmerize, require time and shouldn't cost you if they fail.
	var/power_activates_immediately = TRUE
	///Is this power LOCKED due to being used?
	var/power_in_use = FALSE

/// Modify description to add notice that this is aimed.
/datum/action/bloodsucker/targeted/New(Target)
	desc += "<br>\[<i>Targeted Power</i>\]"
	..()
	// Create Proc Holder for intercepting clicks
	bs_proc_holder = new()
	bs_proc_holder.linked_power = src

/datum/action/bloodsucker/targeted/Trigger()
	// Click power: Begin Aim
	if(active && CheckCanDeactivate(TRUE))
		DeactivateRangedAbility()
		DeactivatePower()
		return
	if(!CheckCanPayCost(TRUE) || !CheckCanUse(TRUE))
		return
	active = !active
	UpdateButtonIcon()
	// Create & Link Targeting Proc
	var/mob/living/L = owner
	if(L.ranged_ability)
		L.ranged_ability.remove_ranged_ability()
	bs_proc_holder.add_ranged_ability(L)
	if(message_Trigger != "")
		to_chat(owner, span_announce("[message_Trigger]"))

/datum/action/bloodsucker/targeted/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return
	if(!owner.client) // <--- We don't allow non client usage so that using powers like mesmerize will FAIL if you try to use them as ghost. Why? because ranged_abvility in spell.dm
		return FALSE //		doesn't let you remove powers if you're not there. So, let's just cancel the power entirely.
	return TRUE

/datum/action/bloodsucker/targeted/DeactivatePower(mob/living/user = owner, mob/living/target)
	// Don't run ..(), we don't want to engage the cooldown until we USE this power!
	active = FALSE
	UpdateButtonIcon()

/// Only Turned off when CLICK is disabled...aka, when you successfully clicked
/datum/action/bloodsucker/targeted/proc/DeactivateRangedAbility()
	bs_proc_holder.remove_ranged_ability()

/// Check if target is VALID (wall, turf, or character?)
/datum/action/bloodsucker/targeted/proc/CheckValidTarget(atom/A)
	return FALSE // FALSE targets nothing.

/// Check if valid target meets conditions
/datum/action/bloodsucker/targeted/proc/CheckCanTarget(atom/A, display_error)
	// Out of Range
	if(!(A in view(target_range, owner)))
		if(display_error && target_range > 1) // Only warn for range if it's greater than 1. Brawn doesn't need to announce itself.
			to_chat(owner, span_warning("Your target is out of range."))
		return FALSE
	return istype(A)

/// Click Target
/datum/action/bloodsucker/targeted/proc/ClickWithPower(atom/A)
	// CANCEL RANGED TARGET check
	if(power_in_use || !CheckValidTarget(A))
		return FALSE
	// Valid? (return true means DON'T cancel power!)
	if(!CheckCanPayCost(TRUE) || !CheckCanUse(TRUE) || !CheckCanTarget(A, TRUE))
		return TRUE
	// Skip this part so we can return TRUE right away.
	if(power_activates_immediately)
		PowerActivatedSuccessfully() // Mesmerize pays only after success.
	power_in_use = TRUE	 // Lock us into this ability until it successfully fires off. Otherwise, we pay the blood even if we fail.
	FireTargetedPower(A) // We use this instead of ActivatePower(), which has no input
	power_in_use = FALSE
	return TRUE

/// Like ActivatePower, but specific to Targeted (and takes an atom input). We don't use ActivatePower for targeted.
/datum/action/bloodsucker/targeted/proc/FireTargetedPower(atom/A)

/// The power went off! We now pay the cost of the power.
/datum/action/bloodsucker/targeted/proc/PowerActivatedSuccessfully()
	PayCost()
	DeactivateRangedAbility()
	DeactivatePower()
	StartCooldown()	// Do AFTER UpdateIcon() inside of DeactivatePower. Otherwise icon just gets wiped.

/// Used by loops to make sure this power can stay active.
/datum/action/bloodsucker/targeted/ContinueActive(mob/living/user, mob/living/target)
	return ..()

/// Target Proc Holder
/obj/effect/proc_holder/bloodsucker
	var/datum/action/bloodsucker/targeted/linked_power

/obj/effect/proc_holder/bloodsucker/remove_ranged_ability(msg)
	..()
	linked_power.DeactivatePower()

/obj/effect/proc_holder/bloodsucker/InterceptClickOn(mob/living/caller, params, atom/A)
	return linked_power.ClickWithPower(A)
