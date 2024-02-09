//////////////////////////////////////////////
//                                          //
//            INFERNAL AFFAIRS              //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/infernal_affairs
	name = "Devil Affairs"
	antag_flag = ROLE_INFERNAL_AFFAIRS
	antag_datum = /datum/antagonist/infernal_affairs
	protected_roles = list(
		JOB_CAPTAIN,
		JOB_HEAD_OF_SECURITY,
		JOB_HEAD_OF_PERSONNEL,
		JOB_RESEARCH_DIRECTOR,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_QUARTERMASTER,
		JOB_WARDEN,
		JOB_SECURITY_OFFICER,
		JOB_DETECTIVE,
	)
	restricted_roles = list(
		JOB_AI,
		JOB_CYBORG,
		JOB_PERSONAL_AI,
	)
	required_candidates = 6
	weight = 0
	cost = 8
	scaling_cost = 2
	requirements = list(8,8,8,8,8,8,8,8,8,8)
	antag_cap = list("denominator" = 24, "offset" = 3)

/datum/dynamic_ruleset/roundstart/infernal_affairs/pre_execute(population)
	. = ..()
	var/num_traitors= get_antag_cap(population)
	for(var/affair_number = 1 to num_traitors)
		if(candidates.len <= 0)
			break
		var/mob/M = pick_n_take(candidates)
		if(!SSinfernal_affairs.devils.len)
			var/datum/antagonist/devil/devil_agent = new()
			M.mind.add_antag_datum(devil_agent)
			M.mind.special_role = ROLE_INFERNAL_AFFAIRS_DEVIL
		else
			assigned += M.mind
			M.mind.special_role = ROLE_INFERNAL_AFFAIRS
		M.mind.restricted_roles = restricted_roles
	return TRUE

/datum/dynamic_ruleset/roundstart/infernal_affairs/execute()
	. = ..()
	if(!.)
		return FALSE
	SSinfernal_affairs.update_objective_datums()
	return TRUE
