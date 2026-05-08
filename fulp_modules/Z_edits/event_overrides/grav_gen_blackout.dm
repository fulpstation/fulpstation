/datum/round_event_control/gravity_generator_blackout/New()
	. = ..()
	if(at_lowpop(15))
		weight = 0
		max_occurrences = 0

	if(at_lowpop(30))
		weight = 20
		max_occurrences = 3
