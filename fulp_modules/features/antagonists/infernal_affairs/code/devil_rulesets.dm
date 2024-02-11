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
	)
	required_candidates = 6
	weight = 5
	cost = 10
	scaling_cost = 2
	requirements = list(10,10,10,10,10,10,10,10,10,10)
	antag_cap = list("denominator" = 24, "offset" = 3)

/datum/dynamic_ruleset/roundstart/infernal_affairs/pre_execute(population)
	. = ..()
	var/num_traitors = get_antag_cap(population) * (scaled_times + 1)
	for(var/affair_number = 1 to num_traitors)
		if(candidates.len <= 0)
			break
		var/mob/selected_mobs = pick_n_take(candidates)
		assigned += selected_mobs.mind
		selected_mobs.mind.restricted_roles = restricted_roles
		selected_mobs.mind.special_role = ROLE_INFERNAL_AFFAIRS
		GLOB.pre_setup_antags += selected_mobs.mind
	return TRUE

/datum/dynamic_ruleset/roundstart/infernal_affairs/execute()
	for (var/datum/mind/mind in assigned)
		if(!length(SSinfernal_affairs.devils))
			var/datum/antagonist/devil/devil_agent = new()
			selected_mobs.mind.add_antag_datum(devil_agent)
			selected_mobs.mind.special_role = ROLE_INFERNAL_AFFAIRS_DEVIL
		else
			mind.add_antag_datum(antag_datum)
		GLOB.pre_setup_antags -= mind

	SSinfernal_affairs.update_objective_datums()
	return TRUE
