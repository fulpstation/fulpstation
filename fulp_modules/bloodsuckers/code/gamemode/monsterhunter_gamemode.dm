/*
 * 		MONSTER HUNTERS:
 * 	Their job is to hunt Monsters.
 * 	They spawn by default 20 minutes into a Bloodsucker round,
 * 	They also randomly spawn in other rounds, as some unique flavor.
 * 	They can also be used as Admin-only antags during rounds such as;
 * 	- Changeling murderboning rounds
 * 	- Lategame Cult round
 * 	- Ect.
 */

/// The default, for Bloodsucker rounds.
/datum/round_event_control/bloodsucker_hunters
	name = "Spawn Monster Hunter - Bloodsucker"
	typepath = /datum/round_event/bloodsucker_hunters
	max_occurrences = 1 // We have to see how Bloodsuckers are in game to decide if having more than 1 is beneficial.
	weight = 2000
	min_players = 10
	earliest_start = 20 MINUTES
	alert_observers = FALSE
	gamemode_whitelist = list("bloodsucker")

/datum/round_event/bloodsucker_hunters
	fakeable = FALSE

/datum/round_event/bloodsucker_hunters/start()
	for(var/mob/living/carbon/human/H in shuffle(GLOB.player_list))
		var/list/no_hunter_jobs = list("Captain", "Head of Personnel", "Head of Security", "Research Director", "Chief Engineer", "Chief Medical Officer", "Quartermaster", "Warden", "Security Officer", "Detective", "Brig Physician", "Prisoner") //, "Deputy")
		if(!H.client || !(ROLE_MONSTERHUNTER in H.client.prefs.be_special))
			continue
		if(H.stat == DEAD)
			continue
		if(!SSjob.GetJob(H.mind.assigned_role) || (H.mind.assigned_role in GLOB.nonhuman_positions)) // Only crewmembers on-station.
			continue
		if(!SSjob.GetJob(H.mind.assigned_role) || (H.mind.assigned_role in no_hunter_jobs))
			continue
		if(!H.mind.has_antag_datum(/datum/antagonist/vassal))
			continue
		if(!H.mind.has_antag_datum(/datum/antagonist/bloodsucker))
			continue
		if(!H.mind.has_antag_datum(/datum/antagonist/monsterhunter))
			continue
		if(!H.getorgan(/obj/item/organ/brain))
			continue
		H.mind.add_antag_datum(/datum/antagonist/monsterhunter)
		message_admins("BLOODSUCKER NOTICE: [H] has awoken as a Monster Hunter.")
		break

/// Randomly spawned Monster hunters during TraitorChangeling, Changeling, Heretic and Cult rounds.
/datum/round_event_control/monster_hunters
	name = "Spawn Monster Hunter - Misc"
	typepath = /datum/round_event/monster_hunters
	max_occurrences = 1
	weight = 3
	min_players = 10
	earliest_start = 30 MINUTES
	alert_observers = FALSE
	gamemode_whitelist = list("traitorchan", "changeling", "heresy", "cult")

/datum/round_event/monster_hunters
	fakeable = FALSE

/datum/round_event/monster_hunters/start()
	for(var/mob/living/carbon/human/H in shuffle(GLOB.player_list))
		var/list/no_hunter_jobs = list("Captain", "Head of Personnel", "Head of Security", "Research Director", "Chief Engineer", "Chief Medical Officer", "Quartermaster", "Warden", "Security Officer", "Detective", "Brig Physician", "Prisoner") //, "Deputy")
		if(!H.client || !(ROLE_MONSTERHUNTER in H.client.prefs.be_special))
			continue
		if(H.stat == DEAD)
			continue
		if(!SSjob.GetJob(H.mind.assigned_role) || (H.mind.assigned_role in GLOB.nonhuman_positions))
			continue
		if(!SSjob.GetJob(H.mind.assigned_role) || (H.mind.assigned_role in no_hunter_jobs))
			continue
		if(!H.mind.has_antag_datum(/datum/antagonist/changeling))
			continue
		if(!H.mind.has_antag_datum(/datum/antagonist/heretic))
			continue
		if(!H.mind.has_antag_datum(/datum/antagonist/cult))
			continue
		if(H.mind.has_antag_datum(/datum/antagonist/monsterhunter))
			continue
		if(!H.getorgan(/obj/item/organ/brain))
			continue
		H.mind.add_antag_datum(/datum/antagonist/monsterhunter)
		message_admins("[H] has awoken as a Monster Hunter.")
		break

/*
 *	Old version below.
 * 	I have no idea how its meant to work, but I replaced it with the above for now.
 *	If someone wants to use it, go ahead, I got enough headaches.
 *	-Willard
 */

/*
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
*/
