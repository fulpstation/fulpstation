// Spawns monster hunters.
/datum/round_event_control/monster_hunters
	name = "Spawn Monster Hunter"
	typepath = /datum/round_event/monster_hunters
	max_occurrences = 1
	weight = 5
	min_players = 10
	earliest_start = 30 MINUTES
	alert_observers = FALSE

/datum/round_event/monster_hunters
	fakeable = FALSE
	///Whether the event should be cancelled.
	var/cancel_me = TRUE

/datum/round_event/monster_hunters/start()
	for(var/mob/living/carbon/human/all_players in GLOB.player_list)
		if(IS_CULTIST(all_players) || IS_HERETIC(all_players) || IS_BLOODSUCKER(all_players) || IS_WIZARD(all_players) || all_players.mind.has_antag_datum(/datum/antagonist/changeling))
			message_admins("MONSTERHUNTER NOTICE: Monster Hunters found a valid Monster.")
			cancel_me = FALSE
			break
	if(cancel_me)
		kill()
		return
	for(var/mob/living/carbon/human/all_players in shuffle(GLOB.player_list))
		if(!all_players.client || !all_players.mind || !(ROLE_MONSTERHUNTER in all_players.client.prefs.be_special))
			continue
		if(all_players.stat == DEAD)
			continue
		if(all_players.mind.assigned_role.departments_bitflags & (DEPARTMENT_BITFLAG_SECURITY|DEPARTMENT_BITFLAG_COMMAND))
			continue
		if(is_special_character(all_players))
			continue
		if(!all_players.getorgan(/obj/item/organ/internal/brain))
			continue
		all_players.mind.add_antag_datum(/datum/antagonist/monsterhunter)
		message_admins("MONSTERHUNTER NOTICE: [all_players] has awoken as a Monster Hunter.")
		break

//gives monsterhunters an icon in the antag selection panel
/datum/dynamic_ruleset/midround/monsterhunter
	name = "Monster Hunter"
	antag_datum = /datum/antagonist/monsterhunter
	midround_ruleset_style = MIDROUND_RULESET_STYLE_LIGHT
	antag_flag = ROLE_MONSTERHUNTER
	weight = 0
	cost = 200
	protected_roles = list(
		JOB_CAPTAIN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_PRISONER,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	restricted_roles = list(
		JOB_AI,
		JOB_CYBORG,
		ROLE_POSITRONIC_BRAIN,
	)
	required_candidates = 1
	requirements = list(10,10,10,10,10,10,10,10,10,10)


/datum/dynamic_ruleset/midround/monsterhunter/trim_candidates()
	..()
	for(var/mob/living/player in living_players)
		if(issilicon(player))
			living_players -= player
		if(is_centcom_level(player.z))
			living_players -= player
		if((player.mind?.special_role || player.mind?.antag_datums?.len))
			living_players -= player

/datum/dynamic_ruleset/midround/monsterhunter/ready(forced = FALSE)
	var/cancel = TRUE
	for(var/datum/antagonist/monster in GLOB.antagonists)
		var/datum/mind/candidate = monster.owner
		if(!candidate)
			continue
		if(IS_CULTIST(candidate.current) || IS_HERETIC(candidate.current) || IS_BLOODSUCKER(candidate.current) || IS_WIZARD(candidate.current) || candidate.has_antag_datum(/datum/antagonist/changeling))
			message_admins("MONSTERHUNTER NOTICE: Monster Hunters found a valid Monster.")
			cancel = FALSE
			break
	if(cancel)
		message_admins("MONSTERHUNTER NOTICE: Monster Hunters did not find a valid Monster.")
		return FALSE
	if (required_candidates > living_players.len)
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/monsterhunter/execute()
	var/mob/player = pick(living_players)
	assigned += player
	living_players -= player
	player.mind.add_antag_datum(/datum/antagonist/monsterhunter)
	message_admins("[ADMIN_LOOKUPFLW(player)] was selected by the [name] ruleset and has been made into a Monsterhunter.")
	log_game("DYNAMIC: [key_name(player)] was selected by the [name] ruleset and has been made into a Monsterhunter.")
	return TRUE
