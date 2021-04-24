/datum/game_mode/traitor/bloodsucker
	name = "traitor+bloodsucker"
	config_tag = "traitorsucker"
	report_type = "traitorsucker"
	false_report_weight = 10
	traitors_possible = 5 // Hard limit on Traitors if scaling is turned off
	restricted_jobs = list("AI", "Cyborg")
	protected_jobs = list("Captain", "Head of Personnel", "Head of Security", "Research Director", "Chief Engineer", "Chief Medical Officer", "Quartermaster", "Warden", "Security Officer", "Detective", "Brig Physician", "Deputy",)
	required_players = 10
	required_enemies = 1 // How many of each type are required
	recommended_enemies = 2
	reroll_friendly = 1
	announce_span = "Traitors and Bloodsuckers"
	announce_text = "There are vampiric monsters on the station along with some syndicate operatives out for their own gain! Do not let the bloodsuckers or the traitors succeed!"

	var/list/possible_bloodsuckers = list()
	var/const/bloodsucker_amount = 2

/datum/game_mode/traitor/bloodsucker/can_start()
	. = ..()
	if(!.)
		return
	possible_bloodsuckers = get_players_for_role(ROLE_BLOODSUCKER)
	if(possible_bloodsuckers.len < required_enemies)
		return FALSE
	return TRUE

/datum/game_mode/traitor/bloodsucker/pre_setup()
	if(CONFIG_GET(flag/protect_roles_from_antagonist))
		restricted_jobs += protected_jobs

	if(CONFIG_GET(flag/protect_assistant_from_antagonist))
		restricted_jobs += "Assistant"

	var/list/datum/mind/possible_bloodsuckers = get_players_for_role(ROLE_BLOODSUCKER)

	var/num_bloodsuckers = 1
	num_bloodsuckers = max(1, min(num_players(), bloodsucker_amount/2))

	if(possible_bloodsuckers.len>0)
		for(var/j = 0, j < num_bloodsuckers, j++)
			if(!possible_bloodsuckers.len)
				break
			var/datum/mind/bloodsucker = antag_pick(possible_bloodsuckers)
			antag_candidates -= bloodsucker
			possible_bloodsuckers -= bloodsucker
			bloodsucker.special_role = ROLE_BLOODSUCKER
			bloodsuckers += bloodsucker
			bloodsucker.restricted_roles = restricted_jobs
		. = ..()
		if(.)	//To ensure the game mode is going ahead
			for(var/antag in bloodsuckers)
				GLOB.pre_setup_antags += antag
		return
	else
		return FALSE

/datum/game_mode/traitor/bloodsucker/post_setup()
	for(var/datum/mind/bloodsucker in bloodsuckers)
		bloodsucker.add_antag_datum(/datum/antagonist/bloodsucker)
		GLOB.pre_setup_antags -= bloodsucker
	return ..()

/datum/game_mode/traitor/bloodsucker/generate_report()
	return "There's been a report of monsters roaming around with Vampiric abilities.\
			Nanotrasen believes it is entirely possible that said monsters have been sent by the Syndicate.\
			Please take care of the crew and their health, as it is impossible to tell if one is nearby."
