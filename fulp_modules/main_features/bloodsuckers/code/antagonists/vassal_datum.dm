#define VASSAL_SCAN_MIN_DISTANCE 5
#define VASSAL_SCAN_MAX_DISTANCE 500
#define VASSAL_SCAN_PING_TIME 20 // 2s update time.

/datum/antagonist/vassal
	name = "Vassal"
	roundend_category = "vassals"
	antagpanel_category = "Bloodsucker"
	show_in_roundend = FALSE
	job_rank = ROLE_BLOODSUCKER
	var/datum/antagonist/bloodsucker/master // Who made me?
	var/list/datum/action/powers = list() // Purchased powers

/datum/antagonist/vassal/apply_innate_effects(mob/living/mob_override)
	return

/datum/antagonist/vassal/remove_innate_effects(mob/living/mob_override)
	return

/datum/antagonist/vassal/on_gain()
	// Mindslave Add
	if(master)
		var/datum/antagonist/bloodsucker/B = master.owner.has_antag_datum(/datum/antagonist/bloodsucker)
		if(B)
			B.vassals |= src
		owner.enslave_mind_to_creator(master.owner.current)
	// Master Pinpointer
	owner.current.apply_status_effect(/datum/status_effect/agent_pinpointer/vassal_edition)
	// Powers
	var/datum/action/bloodsucker/recuperate/new_Recuperate = new()
	powers += new_Recuperate
	new_Recuperate.Grant(owner.current)
	// Give Vassal Objective
	var/datum/objective/bloodsucker/vassal/vassal_objective = new
	vassal_objective.owner = owner
	vassal_objective.generate_objective()
	objectives += vassal_objective
	owner.current.grant_all_languages(FALSE, FALSE, TRUE)
	owner.current.grant_language(/datum/language/vampiric)
	update_vassal_icons_added(owner.current, "vassal")
	. = ..()

/datum/antagonist/vassal/on_removal()
	// Mindslave Remove
	if(master && master.owner)
		master.vassals -= src
		if(owner.enslaved_to == master.owner.current)
			owner.enslaved_to = null
	// Master Pinpointer
	owner.current.remove_status_effect(/datum/status_effect/agent_pinpointer/vassal_edition)
	// Powers
	while(powers.len)
		var/datum/action/power = pick(powers)
		powers -= power
		power.Remove(owner.current)
	// Remove Hunter Objectives
	remove_objective()
	owner.current.remove_language(/datum/language/vampiric)
	// Clear Antag
	owner.special_role = null
	update_vassal_icons_removed(owner.current)
	return ..()

/datum/antagonist/vassal/proc/add_objective(datum/objective/O)
	objectives += O

/datum/antagonist/vassal/proc/remove_objective(datum/objective/O)
	objectives -= O

/datum/antagonist/vassal/greet()
	to_chat(owner, "<span class='userdanger'>You are now the mortal servant of [master.owner.current], a bloodsucking vampire!</span>")
	to_chat(owner, "<span class='boldannounce'>The power of [master.owner.current.p_their()] immortal blood compells you to obey [master.owner.current.p_them()] in all things, even offering your own life to prolong theirs.<br>\
			You are not required to obey any other Bloodsucker, for only [master.owner.current] is your master. The laws of Nanotrasen do not apply to you now; only your vampiric master's word must be obeyed.<span>")
	to_chat(owner, "<span class='userdanger'>Vassal Tip: Avoid being mindshielded at all costs!</span>")
	/// Effects...
	owner.current.playsound_local(null, 'sound/magic/mutate.ogg', 100, FALSE, pressure_affected = FALSE)
	/// And to your new Master...
	to_chat(master.owner, "<span class='userdanger'>[owner.current] has become addicted to your immortal blood. [owner.current.p_they(TRUE)] [owner.current.p_are()] now your undying servant!</span>")
	master.owner.current.playsound_local(null, 'sound/magic/mutate.ogg', 100, FALSE, pressure_affected = FALSE)
	antag_memory += "You became the mortal servant of <b>[master.owner.current]</b>, a bloodsucking vampire!<br>"

/datum/antagonist/vassal/farewell()
	owner.current.visible_message("[owner.current]'s eyes dart feverishly from side to side, and then stop. [owner.current.p_they(TRUE)] seem[owner.current.p_s()] calm, \
			like [owner.current.p_they()] [owner.current.p_have()] regained some lost part of [owner.current.p_them()]self.",\
			"<span class='userdanger'><FONT size = 3>With a snap, you are no longer enslaved to [master.owner]! You breathe in heavily, having regained your free will.</FONT></span>")
	owner.current.playsound_local(null, 'sound/magic/mutate.ogg', 100, FALSE, pressure_affected = FALSE)
	/// And to your former Master...
	if(master && master.owner)
		to_chat(master.owner, "<span class='userdanger'>You feel the bond with your vassal [owner.current] has somehow been broken!</span>")

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

/datum/antagonist/bloodsucker/proc/remove_vassal(datum/mind/vassal)
	vassal.remove_antag_datum(/datum/antagonist/vassal)

/datum/antagonist/vassal/proc/update_vassal_icons_added(mob/living/vassal, icontype = "vassal")
	var/datum/atom_hud/antag/bloodsucker/hud = GLOB.huds[ANTAG_HUD_BLOODSUCKER]
	hud.join_hud(vassal)
	/// Located in icons/mob/hud.dmi
	set_antag_hud(vassal, icontype)
	/// FULP ADDITION! Check prepare_huds in mob.dm to see why.
	owner.current.hud_list[ANTAG_HUD].icon = image('fulp_modules/main_features/bloodsuckers/icons/bloodsucker_icons.dmi', owner.current, "bloodsucker")

/datum/antagonist/vassal/proc/update_vassal_icons_removed(mob/living/vassal)
	var/datum/atom_hud/antag/hud = GLOB.huds[ANTAG_HUD_BLOODSUCKER]
	hud.leave_hud(vassal)
	set_antag_hud(vassal, null)

/// If we weren't created by a bloodsucker, then we cannot be a vassal (assigned from antag panel)
/datum/antagonist/vassal/can_be_owned(datum/mind/new_owner)
	if(!master)
		return FALSE
	return ..()

/// When a Bloodsucker gets FinalDeath.
/datum/antagonist/bloodsucker/proc/FreeAllVassals()
	for(var/datum/antagonist/vassal/V in vassals)
		remove_vassal(V.owner)
