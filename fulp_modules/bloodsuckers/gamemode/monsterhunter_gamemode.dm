/*
 * 		MONSTER HUNTERS:
 * 	Their job is to hunt Monsters.
 * 	They spawn by default 30 minutes into a Bloodsucker round,
 * 	but they can also be used as Admin-only antags during rounds such as;
 * 	- Changeling murderboning rounds
 * 	- Lategame Cult round
 * 	- Ect.
*/

/datum/game_mode/proc/assign_monster_hunters(monster_count = 2, list/datum/mind/exclude_from_hunter)

	var/list/no_hunter_jobs = list("AI","Cyborg")
	if(CONFIG_GET(flag/protect_roles_from_antagonist))
		no_hunter_jobs += list("Captain", "Head of Personnel", "Head of Security", "Research Director", "Chief Engineer", "Chief Medical Officer", "Quartermaster", "Warden", "Security Officer", "Detective", "Brig Physician") //, "Deputy")

	if(CONFIG_GET(flag/protect_assistant_from_antagonist))
		no_hunter_jobs += "Assistant"

	// Assign Hunters
	var/list/datum/mind/hunter_candidates = get_players_for_role(ROLE_MONSTERHUNTER)

	for(var/i = 1, i < monster_count, i++) // Start at 1 so we skip Hunters if there's only one sucker.
		if(!hunter_candidates.len)
			break
		// Assign Hunter
		var/datum/mind/hunter = pick(hunter_candidates)
		hunter_candidates.Remove(hunter)
		// Already Antag? Skip
		if(islist(exclude_from_hunter) && (locate(hunter) in exclude_from_hunter)) //if (islist(hunter.antag_datums) && hunter.antag_datums.len)
			i--
			continue
		monsterhunter += hunter
		hunter.restricted_roles = no_hunter_jobs
		log_game("[hunter.key] (ckey) has been selected as a Hunter.")
