#define INTERNAL_AFFAIRS "Internal Affairs Agent"
#define EXTERNAL_AFFAIRS "External Affairs Agent"
#define EXTERNAL_CHANCE 20

/datum/antagonist/traitor/internal_affairs
	name = "Internal Affairs Agent"
	roundend_category = "internal affairs agents"
	suicide_cry = "FOR THE CORPORATION!!"
	job_rank = ROLE_INTERNAL_AFFAIRS
	preview_outfit = /datum/outfit/internal_affair_agent
	should_give_codewords = FALSE
	/// List of all Internal Affairs Agents
	var/list/target_list = list()
	/// List of all Targets we have stolen thus far
	var/list/datum/mind/targets_stolen = list()

/datum/antagonist/traitor/internal_affairs/specialization(datum/mind/new_owner)
	target_list += new_owner
	return src

/datum/antagonist/traitor/internal_affairs/on_gain()
	. = ..()
	RegisterSignal(owner.current, COMSIG_LIVING_REVIVE, .proc/on_revive)
	RegisterSignal(owner.current, COMSIG_LIVING_DEATH, .proc/on_death)

/datum/antagonist/traitor/internal_affairs/on_removal()
	UnregisterSignal(owner.current, COMSIG_LIVING_DEATH)
	UnregisterSignal(owner.current, COMSIG_LIVING_REVIVE)
	return ..()

/datum/antagonist/traitor/internal_affairs/apply_innate_effects()
	. = ..()
	owner?.current?.apply_status_effect(/datum/status_effect/agent_pinpointer)

/datum/antagonist/traitor/internal_affairs/remove_innate_effects()
	owner?.current?.remove_status_effect(/datum/status_effect/agent_pinpointer)
	return ..()

/datum/antagonist/traitor/internal_affairs/greet()
	var/crime = pick(
		"distribution of contraband", "unauthorized erotic action on duty",
		"embezzlement", "piloting under the influence",
		"dereliction of duty", "syndicate collaboration",
		"mutiny", "multiple homicides",
		"corporate espionage", "receiving bribes",
		"malpractice", "worship of prohibited life forms",
		"possession of profane texts", "murder",
		"arson", "insulting their manager",
		"grand theft", "conspiracy", "attempting to unionize",
		"vandalism", "gross incompetence",
	)

	to_chat(owner.current, span_notice("You are the [name]."))

	if(employer == EXTERNAL_AFFAIRS)
		to_chat(owner.current, span_userdanger("Your target has been framed for [crime], and you have been tasked with eliminating them to prevent them defending themselves in court."))
	else
		to_chat(owner.current, span_userdanger("Your target is suspected of [crime], and you have been tasked with eliminating them by any means necessary to avoid a costly and embarrassing public trial."))

	to_chat(owner.current, span_userdanger("Finally, watch your back. Your target has friends in high places, and intel suggests someone may have taken out a contract of their own to protect them."))
	owner.announce_objectives()

///When an IAA is revived, their hunter(s) have to kill them again
/datum/antagonist/traitor/internal_affairs/proc/on_revive()
	SIGNAL_HANDLER

	for(var/datum/mind/internal_minds as anything in target_list)
		for(var/datum/objective/assassinate/internal/internal_objectives as anything in internal_minds.get_all_objectives())
			if(!internal_objectives.target || internal_objectives.target != owner)
				continue
			if(internal_objectives.check_completion())
				CRASH("[src] ran on_revive but still completed an objective.")
			to_chat(owner.current, span_userdanger("Your sensors tell you that [internal_objectives.target.current.real_name], one of the targets you were meant to have killed, pulled one over on you, and is still alive - do the job properly this time!"))
			internal_objectives.stolen = FALSE
			internal_minds.objectives -= internal_objectives

///When an IAA dies, their hunter completes their objective and inherits their targets
/datum/antagonist/traitor/internal_affairs/proc/on_death()
	SIGNAL_HANDLER

	for(var/datum/mind/internal_minds as anything in target_list)
		for(var/datum/objective/assassinate/internal/internal_objectives as anything in internal_minds.get_all_objectives())
			if(!internal_objectives.target || internal_objectives.target != owner)
				continue
			if(!internal_objectives.check_completion())
				CRASH("[src] ran on_death and failed to complete an objective.")
			if(internal_objectives.stolen)
				break
			steal_targets(internal_objectives.target)
			internal_objectives.stolen = TRUE
			break

/// Affairs Agents can only roll Internal or External, rather than the normal
/datum/antagonist/traitor/internal_affairs/pick_employer()
	var/faction = prob(EXTERNAL_CHANCE) ? EXTERNAL_AFFAIRS : INTERNAL_AFFAIRS

	employer = faction

	traitor_flavor = strings(IAA_FLAVOR_FILE, employer)

	// External Affairs get an additional objective, done here since objectives are already assigned
	if(employer == EXTERNAL_AFFAIRS)
		objectives += forge_single_generic_objective()

/datum/antagonist/traitor/internal_affairs/forge_traitor_objectives()
	if(target_list.len && target_list[owner])
		var/datum/mind/target_mind = target_list[owner]
		var/datum/objective/assassinate/internal/kill_objective = new
		kill_objective.owner = owner
		kill_objective.target = target_mind
		objectives += kill_objective

/datum/antagonist/traitor/internal_affairs/forge_ending_objective()
	if(issilicon(owner.current))
		ending_objective = new /datum/objective/survive/malf
		ending_objective.owner = owner
	else
		ending_objective = new /datum/objective/escape
		ending_objective.owner = owner
	objectives += ending_objective

/// Upon killing a target, we steal their target, to continue the cycle.
/datum/antagonist/traitor/internal_affairs/proc/steal_targets(datum/mind/victim)
	if(!owner.current || owner.current.stat == DEAD)
		return
	to_chat(owner.current, span_userdanger("Target eliminated: [victim.name]"))
	for(var/datum/objective/assassinate/internal/objective as anything in owner.get_all_objectives())
		if(objective.target == owner)
			continue
		if(targets_stolen.Find(objective.target) == 0)
			var/datum/objective/assassinate/internal/new_objective = new
			new_objective.owner = owner
			new_objective.target = objective.target
			new_objective.update_explanation_text()
			objectives += new_objective
			targets_stolen += objective.target
			var/status_text = objective.check_completion() ? "neutralised" : "active"
			to_chat(owner.current, span_userdanger("New target added to database: [objective.target.name] ([status_text])"))

	check_last_man_standing()

/// Check all our internal objectives, if one fails, return. Otherwise, we're the last man standing
/datum/antagonist/traitor/internal_affairs/proc/check_last_man_standing()
	for(var/datum/objective/assassinate/internal/objective as anything in owner.get_all_objectives())
		if(!objective.check_completion())
			return
	if(employer == EXTERNAL_AFFAIRS)
		to_chat(owner.current, span_userdanger("All the loyalist agents are dead, and no more is required of you. Die a glorious death, agent."))
	else
		to_chat(owner.current, span_userdanger("All the other agents are dead, and you're the last loose end. Stage a Syndicate terrorist attack to cover up for today's events. You no longer have any limits on collateral damage."))

	replace_escape_objective(owner)
	make_iaa_unrevivable()

/// Upon becoming the last man standing, all other IAA's become unrevivable
/datum/antagonist/traitor/internal_affairs/proc/make_iaa_unrevivable()
	for(var/datum/mind/internal_minds as anything in target_list)
		var/mob/living/carbon/agents = internal_minds.current
		if(istype(agents) && agents.stat == DEAD)
			agents.makeUncloneable()

/datum/antagonist/traitor/internal_affairs/proc/replace_escape_objective()
	if(!owner || !objectives.len)
		return
	for(var/datum/objective/assassinate/internal/objective as anything in owner.get_all_objectives())
		objectives -= objective

	var/datum/objective/martyr/martyr_objective = new
	martyr_objective.owner = owner
	objectives += martyr_objective


/datum/outfit/internal_affair_agent
	name = "IAA (Preview only)"

	uniform = /obj/item/clothing/under/rank/centcom/officer
	glasses = /obj/item/clothing/glasses/sunglasses
	r_hand = /obj/item/melee/energy/sword

/datum/outfit/internal_affair_agent/post_equip(mob/living/carbon/human/owner, visualsOnly)
	var/obj/item/melee/energy/sword/sword = locate() in owner.held_items
	sword.icon_state = "e_sword_on_blue"
	sword.worn_icon_state = "e_sword_on_blue"

	owner.update_inv_hands()

#undef INTERNAL_AFFAIRS
#undef EXTERNAL_AFFAIRS
#undef EXTERNAL_CHANCE
