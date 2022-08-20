/datum/round_event_control/bruh_moment
	name = "Bruh Moment"
	typepath = /datum/round_event/bruh_moment
	weight = 10
	max_occurrences = 1

/datum/round_event/bruh_moment
	startWhen = 8

/datum/round_event/bruh_moment/start()
	for(var/mob/living/all_players as anything in GLOB.alive_player_list)
		all_players.say("bruh")

/datum/round_event/bruh_moment/announce(fake)
	priority_announce("An incoming Bruh Moment has been detected. Please stand by.", "Anomaly Alert")
