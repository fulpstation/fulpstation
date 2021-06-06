/*
 * 		MONSTER HUNTERS:
 * 	Their job is to hunt Monsters.
 * 	I didnt know what better way to implement this, so they just cancel out if there's no monsters.
 * 	They can also be used as Admin-only antags during rounds such as;
 * 	- Changeling murderboning rounds
 * 	- Lategame Cult round
 * 	- Ect.
 */


/// Spawns monster hunters.
/datum/round_event_control/monster_hunters
	name = "Spawn Monster Hunter"
	typepath = /datum/round_event/monster_hunters
	max_occurrences = 1
	weight = 50
	min_players = 10
	earliest_start = 25 MINUTES
	alert_observers = FALSE

/datum/round_event/monster_hunters
	fakeable = FALSE
	var/monsters = FALSE

/datum/round_event/monster_hunters/start()
	for(var/mob/players in GLOB.alive_mob_list)
		/// Make sure there are monsters on the station, otherwise don't spawn them in
		if(IS_CULTIST(players) || IS_HERETIC(players) || IS_BLOODSUCKER(players) || IS_WIZARD(players) || players.mind.has_antag_datum(/datum/antagonist/changeling))
			spawn_monsters()
		else
			message_admins("MONSTERHUNTER NOTICE: Monster Hunters couldnt verify any Monsters.")
			return

/datum/round_event/monster_hunters/proc/spawn_monsters()
	for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
		/// From obsessed
		if(!H.mind)
			continue
		if(!H.client || !(ROLE_MONSTERHUNTER in H.client.prefs.be_special))
			continue
		if(H.stat == DEAD)
			continue
		if(!SSjob.GetJob(H.mind.assigned_role) || (H.mind.assigned_role in GLOB.command_positions) || (H.mind.assigned_role in GLOB.security_positions))
			continue
		if(IS_HERETIC(H) || IS_CULTIST(H) || IS_BLOODSUCKER(H) || IS_VASSAL(H) || IS_WIZARD(H) || H.mind.has_antag_datum(/datum/antagonist/changeling))
			continue
		if(!H.getorgan(/obj/item/organ/brain))
			continue
		H.mind.add_antag_datum(/datum/antagonist/monsterhunter)
		message_admins("MONSTERHUNTER NOTICE: [H] has awoken as a Monster Hunter.")
		break
