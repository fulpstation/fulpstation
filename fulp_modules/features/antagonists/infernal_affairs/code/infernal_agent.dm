/datum/antagonist/infernal_affairs
	name = "Infernal Affairs Agent"
	roundend_category = "infernal affairs agents"
	antagpanel_category = "Devil Affairs"
	antag_hud_name = "sintouched"
	hud_icon = 'fulp_modules/features/antagonists/infernal_affairs/icons/devil_antag_hud.dmi'
	job_rank = ROLE_INFERNAL_AFFAIRS
	preview_outfit = /datum/outfit/devil_affair_agent
	ui_name = "AntagInfoInfernalAgent"

	tip_theme = "syndicate"
	antag_tips = list(
		"You are an Infernal Affairs Agent, a poor soul who has been touched by the Devil.",
		"You have been given an uplink to hunt down your target and turn them in to the Devil for reaping.",
		"You always have a target, and are always being targeted, so watch your back.",
		"You can immediately notice Devils and Devils will immediately notice you.",
		"After killing a target, Alt-Click a paper to turn it into a calling card, this is required for Devils to turn in your target.",
		"You gain Telecrystals after every kill, but if the Devil is dead then you will instead bypass all this (including the rewards).",
	)

	///Boolean on whether we're currently the last one standing.
	var/last_one_standing = FALSE
	///The pinpointer agents have that points them to the general direction of their targets.
	var/datum/status_effect/agent_pinpointer/devil_affairs/target_pinpointer
	///reference to the uplink this traitor was given, if they were.
	var/datum/weakref/uplink_ref
	/// The uplink handler that this traitor belongs to.
	var/datum/uplink_handler/uplink_handler
	///The active objective this agent has to currently complete.
	var/datum/objective/assassinate/internal/active_objective

	///List of all items purchased by the agent, to consume on death.
	var/list/obj/item/purchased_uplink_items = list()

/datum/antagonist/infernal_affairs/on_gain(mob/living/mob_override)
	. = ..()
	SSinfernal_affairs.agent_datums += src
	owner.give_uplink(silent = TRUE, antag_datum = src)
	var/datum/component/uplink/uplink = owner.find_syndicate_uplink()
	uplink_ref = WEAKREF(uplink)

	uplink_handler = uplink.uplink_handler
	uplink_handler.has_progression = FALSE
	uplink_handler.has_objectives = FALSE
	uplink_handler.maximum_potential_objectives = 0
	if(owner.assigned_role.title != JOB_LAWYER)
		uplink_handler.telecrystals = 10

	target_pinpointer = owner.current.apply_status_effect(/datum/status_effect/agent_pinpointer/devil_affairs)
	RegisterSignal(uplink_handler, COMSIG_ON_UPLINK_PURCHASE, PROC_REF(on_uplink_purchase))

/datum/antagonist/infernal_affairs/on_removal()
	. = ..()
	SSinfernal_affairs.agent_datums -= src
	QDEL_NULL(target_pinpointer)
	remove_uplink()

/datum/antagonist/infernal_affairs/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	//IAAs can only see devils (handled by devils), not eachother, but devils can see them.
	add_team_hud(current_mob, antag_to_check = /datum/antagonist/devil)
	RegisterSignal(current_mob, COMSIG_LIVING_DEATH, PROC_REF(on_death))

/datum/antagonist/infernal_affairs/remove_innate_effects(mob/living/mob_override)
	var/mob/living/current_mob = owner.current || mob_override
	UnregisterSignal(current_mob, COMSIG_LIVING_DEATH)
	return ..()

///Handles affair agents when they die.
///If there are devils, update objectives to let them know they should hand the body in.
///If there aren't, go straight to harvesting (without the rewards).
/datum/antagonist/infernal_affairs/proc/on_death(atom/source, gibbed)
	SIGNAL_HANDLER
	for(var/datum/antagonist/devil/living_devil as anything in SSinfernal_affairs.devils)
		//we got a living devil around, go to them instead.
		if(living_devil.owner.current)
			SSinfernal_affairs.update_objective_datums()
			return
	INVOKE_ASYNC(src, PROC_REF(soul_harvested))

/**
 * ## on_uplink_purchase
 *
 * Called when an uplink item is purchased.
 * We will keep track of their items to destroy them when the Agent dies.
 */
/datum/antagonist/infernal_affairs/proc/on_uplink_purchase(datum/uplink_handler/uplink_handler_source, atom/spawned_item, mob/user)
	SIGNAL_HANDLER
	if(!isitem(spawned_item))
		return
	purchased_uplink_items += spawned_item.get_all_contents()

/**
 * ##soul_harvested
 *
 * Handles making their mind unrevivable and the deletion of all their items,
 * on top of all misc effects like updating objectives and giving rewards.
 */
/datum/antagonist/infernal_affairs/proc/soul_harvested(datum/antagonist/infernal_affairs/killer)
	SSinfernal_affairs.agent_datums -= src
	ADD_TRAIT(owner, TRAIT_HELLBOUND, DEVIL_TRAIT)
	ADD_TRAIT(owner.current, TRAIT_DEFIB_BLACKLISTED, DEVIL_TRAIT)
	QDEL_LIST(purchased_uplink_items)

	//grant the soul to ALL devils, though without admin intervention there should only be one.
	for(var/datum/antagonist/devil/devil as anything in SSinfernal_affairs.devils)
		if(devil.owner.current)
			devil.update_souls_owned(1)

	if(killer && killer.owner.assigned_role.title != JOB_LAWYER)
		killer.uplink_handler.telecrystals += rand(3,5)

	SSinfernal_affairs.update_objective_datums()

///Removes the uplink from the agent, unregistering the proper signal.
/datum/antagonist/infernal_affairs/proc/remove_uplink()
	if(uplink_handler)
		UnregisterSignal(uplink_handler, COMSIG_ON_UPLINK_PURCHASE)
		QDEL_NULL(uplink_handler)

///Turns the agent into the last one standing.
/datum/antagonist/infernal_affairs/proc/make_last_one_standing()
	if(last_one_standing)
		return
	var/datum/objective/hijack/hijack_objective = new()
	hijack_objective.owner = owner
	objectives += hijack_objective
	last_one_standing = TRUE
	QDEL_NULL(target_pinpointer)
	update_static_data_for_all_viewers()

/datum/antagonist/infernal_affairs/ui_data(mob/user)
	var/list/data = ..()
	data["last_one_standing"] = last_one_standing
	data["target_state"] = "Alive"
	if(active_objective)
		data["target_name"] = active_objective?.target.name || "Unknown"
		data["target_job"] = active_objective?.target.assigned_role.title || "Unassigned"
		switch(active_objective.target.current.stat)
			if(UNCONSCIOUS, HARD_CRIT)
				data["target_state"] = "Unconscious"
			if(DEAD)
				data["target_state"] = "Dead"
	else
		data["target_name"] = "Unknown"
		data["target_job"] = "Unassigned"
	var/datum/component/uplink/uplink = uplink_ref?.resolve()
	if(uplink)
		data["code"] = uplink.unlock_code
		data["failsafe_code"] = uplink.failsafe_code
		data["uplink_unlock_info"] = uplink.unlock_text
	return data

/**
 * Devil Affairs Outfit
 */
/datum/outfit/devil_affair_agent
	name = "Devil Affairs Agent (Preview only)"

	uniform = /obj/item/clothing/under/rank/centcom/officer
	head = /obj/item/clothing/head/costume_2019/devil_horns
	glasses = /obj/item/clothing/glasses/sunglasses
	r_hand = /obj/item/melee/energy/sword

/datum/outfit/devil_affair_agent/post_equip(mob/living/carbon/human/owner, visualsOnly)
	var/obj/item/melee/energy/sword/sword = locate() in owner.held_items
	if(sword.flags_1 & INITIALIZED_1)
		sword.attack_self()
	else //Atoms aren't initialized during the screenshots unit test, so we can't call attack_self for it as the sword doesn't have the transforming weapon component to handle the icon changes. The below part is ONLY for the antag screenshots unit test.
		sword.icon_state = "e_sword_on_red"
		sword.inhand_icon_state = "e_sword_on_red"
		sword.worn_icon_state = "e_sword_on_red"
		owner.update_held_items()

/**
 * Infernal Pinpointer
 * It does not scan for a target, we set it manually by the
 * Infernal Affairs Subsystem instead.
 */
/datum/status_effect/agent_pinpointer/devil_affairs/scan_for_target()
	return
