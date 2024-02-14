GLOBAL_DATUM_INIT(infernal_affair_manager, /datum/infernal_affair_manager, new)

/**
 * ##infernal_affairs manager
 *
 * Supposed to handle the objectives of all Agents, ensuring they all have to kill eachother.
 * Also keeps track of their Antag gear, to remove it when their soul is collected.
 */
/datum/infernal_affair_manager
	///List of all human corpses that have had their souls collected.
	var/list/mob/living/carbon/human/stored_humans
	///The datum of the last one standing, when there is one.
	var/datum/antagonist/infernal_affairs/last_one_standing
	///List of all devils in-game. There is supposed to have only one, so this is in-case admins do some wacky shit.
	var/list/datum/antagonist/devil/devils = list()
	/// Lazy assoc list of [refs to humans] to [image previews of the human]. Icons of all agents currently in play.
	var/list/mob/living/carbon/human/agent_icons
	///List of all Agents in the loop and the gear they have.
	var/list/datum/antagonist/infernal_affairs/agent_datums = list()

/datum/infernal_affair_manager/Destroy()
	last_one_standing = null
	QDEL_NULL(stored_humans)
	LAZYNULL(agent_icons)
	return ..()

/datum/infernal_affair_manager/proc/add_agent(mob/living/carbon/human/target)
	var/image/target_image = image(icon = target.icon, icon_state = target.icon_state)
	target_image.overlays = target.overlays
	LAZYSET(agent_icons, target, icon2base64(getFlatIcon(target_image)))

/datum/infernal_affair_manager/proc/remove_agent(mob/living/carbon/human/target)
	LAZYREMOVE(stored_humans, target)
	LAZYREMOVE(agent_icons, target)
	agent_datums -= src

/**
 * Enters a for() loop for all agents while assigning their target to be the first available agent.
 *
 * We assign all IAAs their position in the list to later assign them as objectives of one another.
 * Lists starts at 1, so we will immediately increment to get their target.
 * When the list goes over, we go back to the start AFTER incrementing the list, so they will have the first player as a target.
 * We skip over Hellbound people, and when there's only one left alive, we'll end the loop.
 */
/datum/infernal_affair_manager/proc/update_objective_datums()
	if(!length(agent_datums))
		return
	if(last_one_standing && length(agent_datums) >= 2)
		last_one_standing.remove_last_one_standing()

	var/list_position = 1
	for(var/datum/antagonist/infernal_affairs/agents as anything in agent_datums)
		if(!agents.active_objective)
			log_game("[agents.owner.current] has been given a new active objective, being injected into the Infernal Affair system.")
			add_agent(agents.owner.current)
			agents.active_objective = new(agents)
		list_position++
		if(list_position > agent_datums.len)
			list_position = 1
		var/datum/antagonist/infernal_affairs/next_agent = agent_datums[list_position]
		if(next_agent == agents)
			agents.make_last_one_standing()
			continue
		if(agents.active_objective.target != next_agent)
			log_game("[agents.owner.current] has a new target: [next_agent.owner.current].")
			agents.active_objective.target = next_agent.owner
	return TRUE
