#define VASSAL_SCAN_MIN_DISTANCE 5
#define VASSAL_SCAN_MAX_DISTANCE 500
/// 2s update time.
#define VASSAL_SCAN_PING_TIME 20

/datum/antagonist/vassal
	name = "Vassal"
	roundend_category = "vassals"
	antagpanel_category = "Bloodsucker"
	job_rank = ROLE_BLOODSUCKER
	show_in_roundend = FALSE
	show_name_in_check_antagonists = TRUE
	// tips = VASSAL_TIPS // Willard - Uncomment this to enable antag tips.
	/// Who made me?
	var/datum/antagonist/bloodsucker/master
	/// Purchased powers.
	var/list/datum/action/powers = list()
	/// Am I protected from getting my antag removed if I get Mindshielded?
	var/protected_from_mindshielding = FALSE
	/// Tremere Vassals only - Have I been mutated?
	var/mutilated = FALSE
	/// Ventrue Vassals only - Am I their Favorite?
	var/favorite_vassal = FALSE
	/// What level am I? This is only increased through Ventrue's raising of a Vassal
	var/vassal_level

/datum/antagonist/vassal/apply_innate_effects(mob/living/mob_override)
	return

/datum/antagonist/vassal/remove_innate_effects(mob/living/mob_override)
	return

/datum/antagonist/vassal/on_gain()
	/// Enslave them to their Master
	if(master)
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = master.owner.has_antag_datum(/datum/antagonist/bloodsucker)
		if(bloodsuckerdatum)
			bloodsuckerdatum.vassals |= src
			/// Is my Master part of Tremere?
			if(bloodsuckerdatum.my_clan == CLAN_TREMERE)
				protected_from_mindshielding = TRUE
		owner.enslave_mind_to_creator(master.owner.current)
	/// Give Vassal Pinpointer
	owner.current.apply_status_effect(/datum/status_effect/agent_pinpointer/vassal_edition)
	/// Give Recuperate Power
	var/datum/action/bloodsucker/recuperate/new_Recuperate = new()
	powers += new_Recuperate
	new_Recuperate.Grant(owner.current)
	/// Give Objectives
	var/datum/objective/bloodsucker/vassal/vassal_objective = new
	vassal_objective.owner = owner
	vassal_objective.generate_objective()
	add_objective(vassal_objective)
	/// Give Vampire Language & Hud
	owner.current.grant_all_languages(FALSE, FALSE, TRUE)
	owner.current.grant_language(/datum/language/vampiric)
	update_vassal_icons_added(owner.current, "vassal")
	. = ..()

/datum/antagonist/vassal/on_removal()
	/// Free them from their Master
	if(master && master.owner)
		master.vassals -= src
		if(owner.enslaved_to == master.owner.current)
			owner.enslaved_to = null
	/// Remove Pinpointer
	owner.current.remove_status_effect(/datum/status_effect/agent_pinpointer/vassal_edition)
	/// Remove ALL Traits, as long as its from BLOODSUCKER_TRAIT's source.
	for(var/T in owner.current.status_traits)
		REMOVE_TRAIT(owner.current, T, BLOODSUCKER_TRAIT)
	/// Remove Recuperate Power
	while(powers.len)
		var/datum/action/bloodsucker/power = pick(powers)
		powers -= power
		power.Remove(owner.current)
	/// Remove Language & Hud
	owner.current.remove_language(/datum/language/vampiric)
	update_vassal_icons_removed(owner.current)
	return ..()

/datum/antagonist/vassal/proc/add_objective(datum/objective/O)
	objectives += O

/datum/antagonist/vassal/proc/remove_objectives(datum/objective/O)
	objectives -= O

/datum/antagonist/vassal/greet()
	to_chat(owner, "<span class='userdanger'>You are now the mortal servant of [master.owner.current], a bloodsucking vampire!</span>")
	to_chat(owner, "<span class='boldannounce'>The power of [master.owner.current.p_their()] immortal blood compels you to obey [master.owner.current.p_them()] in all things, even offering your own life to prolong theirs.<br>\
			You are not required to obey any other Bloodsucker, for only [master.owner.current] is your master. The laws of Nanotrasen do not apply to you now; only your vampiric master's word must be obeyed.<span>")
	to_chat(owner, "<span class='userdanger'>Vassal Tip: Avoid being mindshielded at all costs!</span>")
	owner.current.playsound_local(null, 'sound/magic/mutate.ogg', 100, FALSE, pressure_affected = FALSE)
	antag_memory += "You became the mortal servant of <b>[master.owner.current]</b>, a bloodsucking vampire!<br>"
	/// Message told to your Master.
	to_chat(master.owner, "<span class='userdanger'>[owner.current] has become addicted to your immortal blood. [owner.current.p_they(TRUE)] [owner.current.p_are()] now your undying servant!</span>")
	master.owner.current.playsound_local(null, 'sound/magic/mutate.ogg', 100, FALSE, pressure_affected = FALSE)

/datum/antagonist/vassal/farewell()
	owner.current.visible_message("<span class='deconversion_message'>[owner.current] eyes dart feverishly from side to side, and then stop. [owner.current.p_they(TRUE)] seem[owner.current.p_s()] calm,\
			like [owner.current.p_they()] [owner.current.p_have()] regained some lost part of [owner.current.p_them()]self.</span>", null, null, null, owner.current)
	to_chat(owner, "<span class ='deconversion_message bold'>With a snap, you are no longer enslaved to [master.owner]! You breathe in heavily, having regained your free will.</span>")
	owner.current.playsound_local(null, 'sound/magic/mutate.ogg', 100, FALSE, pressure_affected = FALSE)
	/// Message told to your (former) Master.
	if(master && master.owner)
		to_chat(master.owner, "<span class='userdanger'>You feel the bond with your vassal [owner.current] has somehow been broken!</span>")

/// If we weren't created by a bloodsucker, then we cannot be a vassal (assigned from antag panel)
/datum/antagonist/vassal/can_be_owned(datum/mind/new_owner)
	if(!master)
		return FALSE
	return ..()

/// Used for Admin removing Vassals.
/datum/mind/proc/remove_vassal()
	var/datum/antagonist/vassal/C = has_antag_datum(/datum/antagonist/vassal)
	if(C)
		remove_antag_datum(/datum/antagonist/vassal)

/// When a Bloodsucker gets FinalDeath, all Vassals are freed - This is a Bloodsucker proc, not a Vassal one.
/datum/antagonist/bloodsucker/proc/FreeAllVassals()
	for(var/datum/antagonist/vassal/V in vassals)
		remove_vassal(V.owner)

/// Called by FreeAllVassals()
/datum/antagonist/bloodsucker/proc/remove_vassal(datum/mind/vassal)
	vassal.remove_antag_datum(/datum/antagonist/vassal)

/// Used when your Master teaches you a new Power.
/datum/antagonist/vassal/proc/BuyPower(datum/action/bloodsucker/power)
	powers += power
	power.Grant(owner.current)

/datum/antagonist/vassal/proc/LevelUpPowers()
	for(var/datum/action/bloodsucker/power in powers)
		power.level_current++

/*
 *	# Vassal HUDs
 *
 *	We're basically coping Bloodsuckers here.
 *	They share the same code, so most of it is dealt by Bloodsucker code.
 */

/datum/antagonist/vassal/proc/update_vassal_icons_added(mob/living/vassal, icontype = "vassal")
	// This is a copy of Bloodsucker's hud.
	var/datum/atom_hud/antag/bloodsucker/hud = GLOB.huds[ANTAG_HUD_BLOODSUCKER]
	hud.join_hud(vassal)
	set_antag_hud(vassal, icontype)
	owner.current.hud_list[ANTAG_HUD].icon = image('fulp_modules/main_features/bloodsuckers/icons/bloodsucker_icons.dmi', owner.current, "bloodsucker")

/datum/antagonist/vassal/proc/update_vassal_icons_removed(mob/living/vassal)
	var/datum/atom_hud/antag/hud = GLOB.huds[ANTAG_HUD_BLOODSUCKER]
	hud.leave_hud(vassal)
	set_antag_hud(vassal, null)

/*
 *	# Vassal Pinpointer
 *
 *	Pinpointer that points to their Master's location at all times.
 *	Unlike the Monster hunter one, this one is permanently active, and has no power needed to activate it.
 */

/datum/status_effect/agent_pinpointer/vassal_edition
	id = "agent_pinpointer"
	alert_type = /atom/movable/screen/alert/status_effect/agent_pinpointer/vassal_edition
	minimum_range = VASSAL_SCAN_MIN_DISTANCE
	tick_interval = VASSAL_SCAN_PING_TIME
	duration = -1
	range_fuzz_factor = 0

/atom/movable/screen/alert/status_effect/agent_pinpointer/vassal_edition
	name = "Blood Bond"
	desc = "You always know where your master is."
//	icon = 'icons/obj/device.dmi'
//	icon_state = "pinon"

/datum/status_effect/agent_pinpointer/vassal_edition/on_creation(mob/living/new_owner, ...)
	..()
	var/datum/antagonist/vassal/antag_datum = new_owner.mind.has_antag_datum(/datum/antagonist/vassal)
	scan_target = antag_datum?.master?.owner?.current

/datum/status_effect/agent_pinpointer/vassal_edition/scan_for_target()
	// DO NOTHING. We already have our target, and don't wanna do anything from agent_pinpointer

/datum/status_effect/agent_pinpointer/vassal_edition/Destroy()
	if(scan_target)
		to_chat(owner, "<span class='notice'>You've lost your master's trail.</span>")
	..()

/*
 *	# Vassal Feeding
 *
 *	Ventrue's Favorite Vassal can feed once they reach a certain level, this handles that.
 *	This is a direct Copy & Paste from the Bloodsucker version.
 */

/datum/antagonist/vassal/proc/HandleFeeding(mob/living/carbon/target, mult=1)
	var/blood_taken = min(15, target.blood_volume) * mult
	target.blood_volume -= blood_taken
	// Simple Animals lose a LOT of blood, and take damage. This is to keep cats, cows, and so forth from giving you insane amounts of blood.
	if(!ishuman(target))
		target.blood_volume -= (blood_taken / max(target.mob_size, 0.1)) * 3.5 // max() to prevent divide-by-zero
		target.apply_damage_type(blood_taken / 3.5) // Don't do too much damage, or else they die and provide no blood nourishment.
		if(target.blood_volume <= 0)
			target.blood_volume = 0
			target.death(0)
	///////////
	// Shift Body Temp (toward Target's temp, by volume taken)
	owner.current.bodytemperature = ((owner.current.blood_volume * owner.current.bodytemperature) + (blood_taken * target.bodytemperature)) / (owner.current.blood_volume + blood_taken)
	// our volume * temp, + their volume * temp, / total volume
	///////////
	// Reduce Value Quantity
	if(target.stat == DEAD) // Penalty for Dead Blood
		blood_taken /= 3
	if(!ishuman(target)) // Penalty for Non-Human Blood
		blood_taken /= 2
	//if (!iscarbon(target)) // Penalty for Animals (they're junk food)
	// Apply to Volume
	AddBloodVolume(blood_taken)
	// Reagents (NOT Blood!)
	if(target.reagents && target.reagents.total_volume)
		target.reagents.trans_to(owner.current, INGEST, 1) // Run transfer of 1 unit of reagent from them to me.
	owner.current.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, 1) // Play THIS sound for user only. The "null" is where turf would go if a location was needed. Null puts it right in their head.

/datum/antagonist/vassal/proc/AddBloodVolume(value)
	owner.current.blood_volume = clamp(owner.current.blood_volume + value, 0, 560)
