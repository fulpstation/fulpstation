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
		// Bobux no IS_CHANGELING
		if(IS_HERETIC(all_players) || IS_CULTIST(all_players) || IS_BLOODSUCKER(all_players) || IS_VASSAL(all_players) || IS_WIZARD(all_players) || all_players.mind.has_antag_datum(/datum/antagonist/changeling))
			continue
		if(!all_players.getorgan(/obj/item/organ/brain))
			continue
		all_players.mind.add_antag_datum(/datum/antagonist/monsterhunter)
		message_admins("MONSTERHUNTER NOTICE: [all_players] has awoken as a Monster Hunter.")
		break
