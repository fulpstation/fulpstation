/datum/dynamic_ruleset/roundstart/infernal_affairs
	name = "Devil Affairs"
	antag_flag = ROLE_INFERNAL_AFFAIRS
	antag_datum = /datum/antagonist/infernal_affairs
	protected_roles = list(
		JOB_CAPTAIN,
		JOB_HEAD_OF_SECURITY,
		JOB_HEAD_OF_PERSONNEL,
		JOB_WARDEN,
		JOB_SECURITY_OFFICER,
		JOB_DETECTIVE,
	)
	restricted_roles = list(
		JOB_AI,
		JOB_CYBORG,
	)
	minimum_players = 25
	required_candidates = 6
	weight = 5
	cost = 15
	scaling_cost = 4
	requirements = list(10,10,10,10,10,10,10,10,10,10)
	antag_cap = list("denominator" = 15)

/datum/dynamic_ruleset/roundstart/infernal_affairs/pre_execute(population)
	. = ..()
	var/num_agents = min(5, get_antag_cap(population) * (scaled_times + 1))
	for(var/affair_number = 1 to num_agents)
		if(candidates.len <= 0)
			break
		var/mob/selected_mobs = pick_n_take(candidates)
		assigned += selected_mobs.mind
		selected_mobs.mind.restricted_roles = restricted_roles
		selected_mobs.mind.special_role = ROLE_INFERNAL_AFFAIRS
		GLOB.pre_setup_antags += selected_mobs.mind
	return TRUE

/datum/dynamic_ruleset/roundstart/infernal_affairs/execute()
	var/datum/mind/devil_mind = pick_n_take(assigned)
	devil_mind.add_antag_datum(/datum/antagonist/devil)
	devil_mind.special_role = ROLE_INFERNAL_AFFAIRS_DEVIL

	for(var/datum/mind/assigned_player in assigned)
		assigned_player.add_antag_datum(antag_datum)

	GLOB.infernal_affair_manager.update_objective_datums()
	return TRUE

//Here so devils have an antag tips icon, see /datum/asset/spritesheet/antagonists for more information
/datum/dynamic_ruleset/devil
	name = "Devil (Do not run)"
	antag_flag = ROLE_INFERNAL_AFFAIRS_DEVIL
	antag_datum = /datum/antagonist/devil
	weight = 0
	required_candidates = 100
	cost = 100
