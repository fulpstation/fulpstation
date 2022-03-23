//////////////////////////////////////////////
//                                          //
//            INTERNAL AFFAIRS              //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/devil_affairs
	name = "Devil Affairs"
	antag_flag = ROLE_DEVIL_AFFAIRS
	antag_datum = /datum/antagonist/traitor/devil_affairs
	protected_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_SECURITY, JOB_WARDEN, JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_PRISONER)
	restricted_roles = list(JOB_AI, JOB_CYBORG)
	required_candidates = 6
	weight = 0
	cost = 8
	scaling_cost = 2
	requirements = list(8,8,8,8,8,8,8,8,8,8)
	antag_cap = list("denominator" = 24, "offset" = 3)
	///List of all IAAs, inserted in the correct order to assign eachother as objectives of one another.
	var/list/target_list = list()

/datum/dynamic_ruleset/roundstart/devil_affairs/pre_execute(population)
	. = ..()
	var/num_traitors = get_antag_cap(population)
	for(var/affair_number = 1 to num_traitors)
		if(candidates.len <= 0)
			break
		var/mob/M = pick_n_take(candidates)
		assigned += M.mind
		M.mind.restricted_roles = restricted_roles
		GLOB.pre_setup_antags += M.mind

	//We assign all IAAs their position in the list to later assign them as objectives of one another.
	var/list_position = 0
	for(var/datum/mind/iaa_minds in assigned)
		list_position++
		if(list_position + 1 > assigned.len)
			list_position = 0
		target_list[iaa_minds] = assigned[list_position+1]
	return TRUE

/datum/dynamic_ruleset/roundstart/devil_affairs/execute()
	. = ..()
	if(!.)
		return FALSE

	// We do get_antag_minds as they have already been removed from 'assigned'.
	for(var/datum/mind/assigned_traitors as anything in get_antag_minds(/datum/antagonist/traitor/devil_affairs))
		var/datum/antagonist/traitor/devil_affairs/daa_datum = assigned_traitors.has_antag_datum(/datum/antagonist/traitor/devil_affairs)
		if(target_list.len && target_list[assigned_traitors])
			var/datum/mind/target_mind = target_list[assigned_traitors]

			var/datum/objective/assassinate/internal/kill_objective = new
			kill_objective.owner = assigned_traitors
			kill_objective.target = target_mind
			kill_objective.update_explanation_text()
			daa_datum.objectives += kill_objective

	return TRUE
