/*
 * 		MONSTER HUNTERS:
 * 	Their job is to hunt Monsters.
 * 	I didnt know what better way to implement this, so they just cancel out if the antag is missing
 * 	They can also be used as Admin-only antags during rounds such as;
 * 	- Changeling murderboning rounds
 * 	- Lategame Cult round
 * 	- Ect.
 */


/// The default, for Bloodsucker rounds.
/datum/round_event_control/bloodsucker_hunters
	name = "Spawn Monster Hunter - Bloodsucker"
	typepath = /datum/round_event/bloodsucker_hunters
	max_occurrences = 1
	weight = 2000
	min_players = 10
	earliest_start = 30 MINUTES
	alert_observers = FALSE

/datum/round_event/bloodsucker_hunters
	fakeable = FALSE

/datum/round_event/bloodsucker_hunters/start()
	for(var/mob/living/carbon/human/H in shuffle(GLOB.player_list))
		if(!H.mind.has_antag_datum(/datum/antagonist/bloodsucker))
			break
		if(!H.client || !(ROLE_MONSTERHUNTER in H.client.prefs.be_special))
			continue
		if(H.stat == DEAD)
			continue
		if(!SSjob.GetJob(H.mind.assigned_role) || (H.mind.assigned_role in GLOB.nonhuman_positions))
			continue
		if(!SSjob.GetJob(H.mind.assigned_role) || (H.mind.assigned_role in GLOB.command_positions))
			continue
		if(!SSjob.GetJob(H.mind.assigned_role) || (H.mind.assigned_role in GLOB.security_positions))
			continue
		if(H.mind.has_antag_datum(/datum/antagonist/vassal))
			continue
		if(H.mind.has_antag_datum(/datum/antagonist/bloodsucker))
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
	weight = 7
	min_players = 10
	earliest_start = 25 MINUTES
	alert_observers = FALSE

/datum/round_event/monster_hunters
	fakeable = FALSE

/datum/round_event/monster_hunters/start()
	for(var/mob/living/carbon/human/H in shuffle(GLOB.player_list))
		if(!H.mind.has_antag_datum(/datum/antagonist/changeling))
			break
		if(!H.mind.has_antag_datum(/datum/antagonist/heretic))
			break
		if(!H.mind.has_antag_datum(/datum/antagonist/cult))
			break
		if(!H.mind.has_antag_datum(/datum/antagonist/wizard))
			break
		if(!H.mind.has_antag_datum(/datum/antagonist/wizard/apprentice))
			break
		if(!H.client || !(ROLE_MONSTERHUNTER in H.client.prefs.be_special))
			continue
		if(H.stat == DEAD)
			continue
		if(!SSjob.GetJob(H.mind.assigned_role) || (H.mind.assigned_role in GLOB.nonhuman_positions))
			continue
		if(!SSjob.GetJob(H.mind.assigned_role) || (H.mind.assigned_role in GLOB.command_positions))
			continue
		if(!SSjob.GetJob(H.mind.assigned_role) || (H.mind.assigned_role in GLOB.security_positions))
			continue
		if(H.mind.has_antag_datum(/datum/antagonist/changeling))
			continue
		if(H.mind.has_antag_datum(/datum/antagonist/heretic))
			continue
		if(H.mind.has_antag_datum(/datum/antagonist/cult))
			continue
		if(!H.getorgan(/obj/item/organ/brain))
			continue
		H.mind.add_antag_datum(/datum/antagonist/monsterhunter)
		message_admins("MONSTERHUNTER NOTICE: [H] has awoken as a Monster Hunter.")
		break
