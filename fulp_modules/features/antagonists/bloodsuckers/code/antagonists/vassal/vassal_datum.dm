#define VASSAL_SCAN_MIN_DISTANCE 5
#define VASSAL_SCAN_MAX_DISTANCE 500
/// 2s update time.
#define VASSAL_SCAN_PING_TIME 20

/datum/antagonist/vassal
	name = "\improper Vassal"
	roundend_category = "vassals"
	antagpanel_category = "Bloodsucker"
	job_rank = ROLE_BLOODSUCKER
	antag_hud_name = "vassal"
	show_in_roundend = FALSE
	hud_icon = 'fulp_modules/features/antagonists/bloodsuckers/icons/bloodsucker_icons.dmi'

	/// The Master Bloodsucker's antag datum.
	var/datum/antagonist/bloodsucker/master
	/// List of all Purchased Powers, like Bloodsuckers.
	var/list/datum/action/powers = list()
	///Whether this vassal is already a special type of Vassal.
	var/special_type = FALSE
	///Description of what this Vassal does.
	var/vassal_description

/datum/antagonist/vassal/antag_panel_data()
	return "Master : [master.owner.name]"

/datum/antagonist/vassal/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	current_mob.apply_status_effect(/datum/status_effect/agent_pinpointer/vassal_edition)
	add_team_hud(current_mob)

/datum/antagonist/vassal/add_team_hud(mob/target)
	QDEL_NULL(team_hud_ref)

	team_hud_ref = WEAKREF(target.add_alt_appearance(
		/datum/atom_hud/alternate_appearance/basic/has_antagonist,
		"antag_team_hud_[REF(src)]",
		image(hud_icon, target, antag_hud_name),
	))

	var/datum/atom_hud/alternate_appearance/basic/has_antagonist/hud = team_hud_ref.resolve()

	var/list/mob/living/mob_list = list()
	mob_list += master.owner.current
	for(var/datum/antagonist/vassal/vassal as anything in master.vassals)
		mob_list += vassal.owner.current

	for (var/datum/atom_hud/alternate_appearance/basic/has_antagonist/antag_hud as anything in GLOB.has_antagonist_huds)
		if(!(antag_hud.target in mob_list))
			continue
		antag_hud.show_to(target)
		hud.show_to(antag_hud.target)

/datum/antagonist/vassal/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	current_mob.remove_status_effect(/datum/status_effect/agent_pinpointer/vassal_edition)

/datum/antagonist/vassal/pre_mindshield(mob/implanter, mob/living/mob_override)
	return COMPONENT_MINDSHIELD_PASSED

/// This is called when the antagonist is successfully mindshielded.
/datum/antagonist/vassal/on_mindshield(mob/implanter, mob/living/mob_override)
	owner.remove_antag_datum(/datum/antagonist/vassal)
	owner.current.log_message("has been deconverted from Vassalization by [implanter]!", LOG_ATTACK, color="#960000")
	return COMPONENT_MINDSHIELD_DECONVERTED

/datum/antagonist/vassal/proc/on_examine(datum/source, mob/examiner, examine_text)
	SIGNAL_HANDLER

	if(!iscarbon(source))
		return
	var/mob/living/carbon/carbon_source = source
	var/vassal_examine = carbon_source.return_vassal_examine(examiner)
	if(vassal_examine)
		examine_text += vassal_examine

/datum/antagonist/vassal/on_gain()
	RegisterSignal(owner.current, COMSIG_PARENT_EXAMINE, .proc/on_examine)
	/// Enslave them to their Master
	if(!master || !istype(master, master))
		return
	if(special_type)
		if(!master.special_vassals[special_type])
			master.special_vassals[special_type] = list()
		master.special_vassals[special_type] |= src
	master.vassals |= src
	owner.enslave_mind_to_creator(master.owner.current)
	owner.current.log_message("has been vassalized by [master.owner.current]!", LOG_ATTACK, color="#960000")
	/// Give Recuperate Power
	BuyPower(new /datum/action/bloodsucker/recuperate)
	/// Give Objectives
	var/datum/objective/bloodsucker/vassal/vassal_objective = new
	vassal_objective.owner = owner
	objectives += vassal_objective
	/// Give Vampire Language & Hud
	owner.current.grant_all_languages(FALSE, FALSE, TRUE)
	owner.current.grant_language(/datum/language/vampiric)
	return ..()

/datum/antagonist/vassal/on_removal()
	UnregisterSignal(owner.current, COMSIG_PARENT_EXAMINE)
	//Free them from their Master
	if(master && master.owner)
		if(special_type && master.special_vassals[special_type])
			master.special_vassals[special_type] -= src
		master.vassals -= src
		owner.enslaved_to = null
	//Remove ALL Traits, as long as its from BLOODSUCKER_TRAIT's source.
	for(var/all_status_traits in owner.current.status_traits)
		REMOVE_TRAIT(owner.current, all_status_traits, BLOODSUCKER_TRAIT)
	//Remove Recuperate Power
	while(powers.len)
		var/datum/action/bloodsucker/power = pick(powers)
		powers -= power
		power.Remove(owner.current)
	//Remove Language & Hud
	owner.current.remove_language(/datum/language/vampiric)
	return ..()

/datum/antagonist/vassal/on_body_transfer(mob/living/old_body, mob/living/new_body)
	. = ..()
	for(var/datum/action/bloodsucker/all_powers as anything in powers)
		all_powers.Remove(old_body)
		all_powers.Grant(new_body)

/datum/antagonist/vassal/proc/add_objective(datum/objective/added_objective)
	objectives += added_objective

/datum/antagonist/vassal/greet()
	. = ..()
	if(silent)
		return

	to_chat(owner, span_userdanger("You are now the mortal servant of [master.owner.current], a Bloodsucker!"))
	to_chat(owner, span_boldannounce("The power of [master.owner.current.p_their()] immortal blood compels you to obey [master.owner.current.p_them()] in all things, even offering your own life to prolong theirs.\n\
		You are not required to obey any other Bloodsucker, for only [master.owner.current] is your master. The laws of Nanotrasen do not apply to you now; only your vampiric master's word must be obeyed.")) // if only there was a /p_theirs() proc...
	owner.current.playsound_local(null, 'sound/magic/mutate.ogg', 100, FALSE, pressure_affected = FALSE)
	antag_memory += "You, becoming the mortal servant of <b>[master.owner.current]</b>, a bloodsucking vampire!<br>"
	/// Message told to your Master.
	to_chat(master.owner, span_userdanger("[owner.current] has become addicted to your immortal blood. [owner.current.p_they(TRUE)] [owner.current.p_are()] now your undying servant!"))
	master.owner.current.playsound_local(null, 'sound/magic/mutate.ogg', 100, FALSE, pressure_affected = FALSE)

/datum/antagonist/vassal/farewell()
	if(silent)
		return

	owner.current.visible_message(
		span_deconversion_message("[owner.current]'s eyes dart feverishly from side to side, and then stop. [owner.current.p_they(TRUE)] seem[owner.current.p_s()] calm, \
			like [owner.current.p_they()] [owner.current.p_have()] regained some lost part of [owner.current.p_them()]self."), \
		span_deconversion_message("With a snap, you are no longer enslaved to [master.owner]! You breathe in heavily, having regained your free will."))
	owner.current.playsound_local(null, 'sound/magic/mutate.ogg', 100, FALSE, pressure_affected = FALSE)
	/// Message told to your (former) Master.
	if(master && master.owner)
		to_chat(master.owner, span_cultbold("You feel the bond with your vassal [owner.current] has somehow been broken!"))

/// When a Bloodsucker gets FinalDeath, all Vassals are freed - This is a Bloodsucker proc, not a Vassal one.
/datum/antagonist/bloodsucker/proc/free_all_vassals()
	for(var/datum/antagonist/vassal/all_vassals in vassals)
		// Skip over any Bloodsucker Vassals, they're too far gone to have all their stuff taken away from them
		if(all_vassals.owner.has_antag_datum(/datum/antagonist/bloodsucker))
			all_vassals.owner.current.remove_status_effect(/datum/status_effect/agent_pinpointer/vassal_edition)
			continue
		if(all_vassals.special_type == REVENGE_VASSAL)
			continue
		all_vassals.owner.add_antag_datum(/datum/antagonist/ex_vassal)
		all_vassals.owner.remove_antag_datum(/datum/antagonist/vassal)

/// Used when your Master teaches you a new Power.
/datum/antagonist/vassal/proc/BuyPower(datum/action/bloodsucker/power)
	powers += power
	power.Grant(owner.current)
	log_uplink("[key_name(owner.current)] purchased [power].")

/datum/antagonist/vassal/proc/LevelUpPowers()
	for(var/datum/action/bloodsucker/power in powers)
		power.level_current++

/// Called when we are made into the Favorite Vassal
/datum/antagonist/vassal/proc/make_special(datum/antagonist/vassal/vassal_type)
	//store what we need
	var/datum/mind/vassal_owner = owner
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = master

	//remove our antag datum
	silent = TRUE
	vassal_owner.remove_antag_datum(/datum/antagonist/vassal)

	//give our new one
	var/datum/antagonist/vassal/vassaldatum = new vassal_type(vassal_owner)
	vassaldatum.master = bloodsuckerdatum
	vassaldatum.silent = TRUE
	vassal_owner.add_antag_datum(vassaldatum, vassaldatum.master.get_team())
	vassaldatum.silent = FALSE

	//send alerts of completion
	to_chat(master, span_danger("You have turned [vassal_owner.current] into your [vassaldatum.name]! They will no longer be deconverted upon Mindshielding!"))
	to_chat(vassal_owner, span_notice("As Blood drips over your body, you feel closer to your Master... You are now the Favorite Vassal!"))
	vassal_owner.current.playsound_local(null, 'sound/magic/mutate.ogg', 75, FALSE, pressure_affected = FALSE)

/**
 * Favorite Vassal
 *
 * Gets some cool abilities depending on the Clan.
 */
/datum/antagonist/vassal/favorite
	name = "\improper Favorite Vassal"
	show_in_antagpanel = FALSE
	antag_hud_name = "vassal6"
	special_type = FAVORITE_VASSAL
	vassal_description = "The Favorite Vassal gets unique abilities over other Vassals depending on your Clan \
		and becomes completely immune to Mindshields. If part of Ventrue, this is the Vassal you will rank up."

	///Bloodsucker levels, but for Vassals, used by Ventrue.
	var/vassal_level

/datum/antagonist/vassal/favorite/on_gain()
	. = ..()
	SEND_SIGNAL(master.my_clan, BLOODSUCKER_MAKE_FAVORITE, src, master)

/datum/antagonist/vassal/favorite/pre_mindshield(mob/implanter, mob/living/mob_override)
	return COMPONENT_MINDSHIELD_RESISTED

///Set the Vassal's rank to their Bloodsucker level
/datum/antagonist/vassal/favorite/proc/set_vassal_level(mob/living/carbon/human/target)
	master.bloodsucker_level = vassal_level

/**
 * Revenge Vassal
 *
 * Has the goal to 'get revenge' when their Master dies.
 */
/datum/antagonist/vassal/revenge
	name = "\improper Revenge Vassal"
	roundend_category = "abandoned Vassals"
	show_in_roundend = TRUE
	show_in_antagpanel = FALSE
	antag_hud_name = "vassal4"
	special_type = REVENGE_VASSAL
	vassal_description = "The Revenge Vassal will not deconvert on your Final Death, \
		instead they will gain all your Powers, and the objective to take revenge for your demise. \
		They additionally maintain your Vassals after your departure, rather than become aimless."

	///all ex-vassals brought back into the fold.
	var/list/datum/antagonist/ex_vassals = list()

/datum/antagonist/vassal/revenge/roundend_report()
	var/list/report = list()
	report += printplayer(owner)
	if(objectives.len)
		report += printobjectives(objectives)

	// Now list their vassals
	if(ex_vassals.len)
		report += "<span class='header'>The Vassals brought back into the fold were...</span>"
		for(var/datum/antagonist/ex_vassal/all_vassals as anything in ex_vassals)
			if(!all_vassals.owner)
				continue
			report += "<b>[all_vassals.owner.name]</b> the [all_vassals.owner.assigned_role.title]"

	return report.Join("<br>")

/datum/antagonist/vassal/revenge/on_gain()
	. = ..()
	RegisterSignal(master.my_clan, BLOODSUCKER_FINAL_DEATH, .proc/on_master_death)

/datum/antagonist/vassal/revenge/on_removal()
	UnregisterSignal(master.my_clan, BLOODSUCKER_FINAL_DEATH)
	return ..()

/datum/antagonist/vassal/revenge/ui_static_data(mob/user)
	var/list/data = list()
	for(var/datum/action/bloodsucker/power as anything in powers)
		var/list/power_data = list()

		power_data["power_name"] = power.name
		power_data["power_explanation"] = power.power_explanation
		power_data["power_icon"] = power.button_icon_state

		data["power"] += list(power_data)

	return data + ..()

/datum/antagonist/vassal/revenge/proc/on_master_death(datum/source, mob/living/carbon/master)
	SIGNAL_HANDLER

	for(var/datum/objective/all_objectives as anything in objectives)
		objectives -= all_objectives
	BuyPower(new /datum/action/bloodsucker/vassal_blood)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(master)
	for(var/datum/action/bloodsucker/master_powers as anything in bloodsuckerdatum.powers)
		if(master_powers.purchase_flags & BLOODSUCKER_DEFAULT_POWER)
			continue
		master_powers.Grant(owner.current)
		owner.current.remove_status_effect(/datum/status_effect/agent_pinpointer/vassal_edition)

	var/datum/objective/survive/new_objective = new
	new_objective.name = "Avenge Bloodsucker"
	new_objective.explanation_text = "Avenge your Bloodsucker's death by recruiting their ex-vassals and continuing their operations."
	new_objective.owner = owner
	objectives += new_objective

	if(info_button_ref)
		QDEL_NULL(info_button_ref)

	ui_name = "AntagInfoRevengeVassal" //give their new ui
	var/datum/action/antag_info/info_button = new(src)
	info_button.Grant(owner.current)
	info_button_ref = WEAKREF(info_button)

/datum/antagonist/vassal/admin_add(datum/mind/new_owner, mob/admin)
	var/list/datum/mind/possible_vampires = list()
	for(var/datum/antagonist/bloodsucker/bloodsuckerdatums in GLOB.antagonists)
		var/datum/mind/vamp = bloodsuckerdatums.owner
		if(!vamp)
			continue
		if(!vamp.current)
			continue
		if(vamp.current.stat == DEAD)
			continue
		possible_vampires += vamp
	if(!length(possible_vampires))
		message_admins("[key_name_admin(usr)] tried vassalizing [key_name_admin(new_owner)], but there were no bloodsuckers!")
		return
	var/datum/mind/choice = input("Which bloodsucker should this vassal belong to?", "Bloodsucker") in possible_vampires
	if(!choice)
		return
	log_admin("[key_name_admin(usr)] turned [key_name_admin(new_owner)] into a vassal of [key_name_admin(choice)]!")
	var/datum/antagonist/bloodsucker/vampire = choice.has_antag_datum(/datum/antagonist/bloodsucker)
	master = vampire
	new_owner.add_antag_datum(src)
	to_chat(choice, span_notice("Through divine intervention, you've gained a new vassal!"))
