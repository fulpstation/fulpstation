/datum/round_event_control/hehehehaw
	name = "Heeheeheehaw"
	typepath = /datum/round_event/hehehehaw
	weight = 100
	min_players = 1
	max_occurrences = 1

/datum/round_event/hehehehaw
	startWhen = 8
	fakeable = FALSE

/datum/round_event/hehehehaw/start()
	for(var/mob/all_mobs in GLOB.player_list)
		all_mobs.emote("laugh")

/datum/round_event/hehehehaw/announce()
	priority_announce("Nanotrasen has realized an incoming strike of laughter among the crew, please attempt to resist this.", "Heeheeheehaw.")
