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
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(IS_CULTIST(H) || IS_HERETIC(H) || IS_BLOODSUCKER(H) || IS_WIZARD(H) || H.mind.has_antag_datum(/datum/antagonist/changeling))
			message_admins("MONSTERHUNTER NOTICE: Monster Hunters found a valid Monster.")
			cancel_me = FALSE
			break
	// because kill() doesn't work.
	if(cancel_me)
		return
	for(var/mob/living/carbon/human/H in shuffle(GLOB.player_list))
		/// From obsessed
		if(!H.client || !H.mind || !(ROLE_MONSTERHUNTER in H.client.prefs.be_special))
			continue
		if(H.stat == DEAD)
			continue
		if(H.mind.assigned_role.departments_bitflags & (DEPARTMENT_BITFLAG_SECURITY|DEPARTMENT_BITFLAG_COMMAND))
			continue
		/// Bobux no IS_CHANGELING
		if(IS_HERETIC(H) || IS_CULTIST(H) || IS_BLOODSUCKER(H) || IS_VASSAL(H) || IS_WIZARD(H) || H.mind.has_antag_datum(/datum/antagonist/changeling))
			continue
		if(!H.getorgan(/obj/item/organ/brain))
			continue
		H.mind.add_antag_datum(/datum/antagonist/monsterhunter)
		message_admins("MONSTERHUNTER NOTICE: [H] has awoken as a Monster Hunter.")
		break
