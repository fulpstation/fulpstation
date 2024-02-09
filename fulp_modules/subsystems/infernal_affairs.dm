/**
 * ##infernal_affairs subsystem
 *
 * Supposed to handle the objectives of all Agents, ensuring they all have to kill eachother.
 * Also keeps track of their Antag gear, to remove it when their soul is collected.
 */
SUBSYSTEM_DEF(infernal_affairs)
	name = "Devil Affairs"
	flags = SS_NO_INIT|SS_NO_FIRE

	///List of all devils in-game. There is supposed to have only one, so this is in-case admins do some wacky shit.
	var/list/datum/antagonist/devil/devils = list()
	///List of all Agents in the loop and the gear they have.
	var/list/datum/antagonist/infernal_affairs/agent_datums = list()

/**
 * Enters a for() loop for all agents while assigning their target to be the first available agent.
 *
 * We assign all IAAs their position in the list to later assign them as objectives of one another.
 * Lists starts at 1, so we will immediately imcrement to get their target.
 * When the list goes over, we go back to the start AFTER incrementing the list, so they will have the first player as a target.
 * We skip over Hellbound people, and when there's only one left alive, we'll end the loop.
 */
/datum/controller/subsystem/infernal_affairs/proc/update_objective_datums()
	if(!length(agent_datums))
		return

	var/list_position = 1
	for(var/datum/antagonist/infernal_affairs/agents as anything in agent_datums)
		if(!agents.active_objective)
			agents.active_objective = new(src)
			agents.target_pinpointer.scan_target = agents.active_objective.target.current
		list_position++
		if(list_position > agent_datums.len)
			list_position = 1
		var/datum/antagonist/infernal_affairs/next_agent = agent_datums[list_position]
		if(next_agent == agents)
			agents.make_last_one_standing()
			continue
		if(agents.active_objective.target != next_agent)
			agents.active_objective.target = next_agent.owner
			agents.target_pinpointer.scan_target = agents.active_objective.target.current
	return TRUE
