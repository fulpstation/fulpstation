/datum/round_event_control/scrubber_clog
	name = "Minor Scrubber Clog"
	typepath = /datum/round_event/scrubber_clog
	weight = 25
	max_occurrences = 3
	earliest_start = 5 MINUTES

/datum/round_event/scrubber_clog
	announceWhen = 10
	startWhen = 5
	endWhen = 600

	///Scrubber selected for the event.
	var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubber
	///What mob will be spawned
	var/mob/spawned_mob = /mob/living/basic/cockroach
	///Cap on the number of spawned mobs that can be alive at once.
	var/maximum_spawns = 3
	///Interval between mob spawns.
	var/spawn_delay = 10
	///Used to track/limit produced mobs.
	var/list/living_mobs = list()
	///Used for tracking if the clog signal should be sent.
	var/clogged = TRUE

/datum/round_event/scrubber_clog/announce()
	priority_announce("Minor biological obstruction detected in the ventilation network. Blockage is believed to be in the [get_area_name(scrubber)].", "Custodial Notification")

/datum/round_event/scrubber_clog/setup()
	scrubber = get_scrubber()
	if(!scrubber)
		kill()
		CRASH("Unable to find suitable scrubber.")

	RegisterSignal(scrubber, COMSIG_PARENT_QDELETING, .proc/scrubber_move)

	spawned_mob = get_mob()
	endWhen = rand(300, 600)
	maximum_spawns = rand(3, 5)
	spawn_delay = rand(10, 15)

/datum/round_event/scrubber_clog/start() //Sets the scrubber up for unclogging/mob production.
	scrubber.clog()
	scrubber.produce_mob(spawned_mob, living_mobs) //The first one's free!

/datum/round_event/scrubber_clog/tick() //Checks if spawn_interval is met, then sends signal to scrubber to produce a mob.
	if(activeFor % spawn_delay == 0 && scrubber.clogged)
		life_check()
		if(living_mobs.len < maximum_spawns && clogged)
			scrubber.produce_mob(spawned_mob, living_mobs)

/datum/round_event/scrubber_clog/end() //No end announcement. If you want to take the easy way out and just leave the vent welded, you must open it at your own peril.
	scrubber.unclog()
	scrubber = null
	living_mobs.Cut()

/**
 * Selects which mob will be spawned for a given scrubber clog event.
 *
 * Creates a static list of mobs, which is different based on the severity of the event being run, and returns a pick() of it.
 */

/datum/round_event/scrubber_clog/proc/get_mob()
	var/static/list/mob_list = list(
				/mob/living/simple_animal/mouse,
				/mob/living/basic/cockroach,
				/mob/living/simple_animal/butterfly,
	)
	return pick(mob_list)

/**
 * Finds a valid scrubber for the scrubber clog event.
 *
 * For every scrubber in the round, checks if the scrubber turf is on-station, and is neither welded nor already clogged, and
 * adds it to a list. A random scrubber is picked from this list, and returned as the scrubber that will be used for the event.
 */

/datum/round_event/scrubber_clog/proc/get_scrubber()
	var/list/scrubber_list = list()
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/scrubber in GLOB.machines)
		var/turf/scrubber_turf = get_turf(scrubber)
		if(scrubber_turf && is_station_level(scrubber_turf.z) && !scrubber.welded && !scrubber.clogged)
			scrubber_list += scrubber
	return pick(scrubber_list)

/**
 * Checks which mobs in the mob spawn list are alive.
 *
 * Checks each mob in the living_mobs list, to see if they're dead or not. If dead, they're removed from the list.
 * This is used to keep new mobs spawning as the old ones die.
 */

/datum/round_event/scrubber_clog/proc/life_check()
	for(var/datum/weakref/mob_ref as anything in living_mobs)
		var/mob/living/real_mob = mob_ref.resolve()
		if(QDELETED(real_mob) || real_mob.stat == DEAD)
			living_mobs -= mob_ref

/**
 * Finds a new scrubber for the event if the original is destroyed.
 *
 * This is used when the scrubber for the event is destroyed. It picks a new scrubber and announces that the event has moved elsewhere.
 * Handles the scrubber ref if there are no valid scrubbers to replace it with.
 */

/datum/round_event/scrubber_clog/proc/scrubber_move(datum/source)
	SIGNAL_HANDLER
	scrubber = null //If by some great calamity, the last valid scrubber is destroyed, the ref is cleared.
	scrubber = get_scrubber()
	if(!scrubber)
		kill()
		CRASH("Unable to find suitable scrubber.")

	RegisterSignal(scrubber, COMSIG_PARENT_QDELETING, .proc/scrubber_move)

	scrubber.clog()
	scrubber.produce_mob(spawned_mob, living_mobs)

	priority_announce("Lifesign readings have moved to a new location in the ventilation network. New Location: [prob(50) ? "Unknown.":"[get_area_name(scrubber)]."]", "Lifesign Notification")

/datum/round_event_control/scrubber_clog/major
	name = "Major Scrubber Clog"
	typepath = /datum/round_event/scrubber_clog/major
	weight = 12
	max_occurrences = 3
	earliest_start = 10 MINUTES

/datum/round_event/scrubber_clog/major/setup()
	. = ..()
	maximum_spawns = rand(2,4)
	spawn_delay = rand(15,20)

/datum/round_event/scrubber_clog/major/get_mob()
	var/static/list/mob_list = list(
		/mob/living/simple_animal/hostile/rat,
		/mob/living/simple_animal/hostile/bee,
		/mob/living/simple_animal/hostile/giant_spider,
	)
	return pick(mob_list)

/datum/round_event/scrubber_clog/major/announce()
	priority_announce("Major biological obstruction detected in the ventilation network. Blockage is believed to be in the [get_area_name(scrubber)] area.", "Infestation Alert")

/datum/round_event_control/scrubber_clog/critical
	name = "Critical Scrubber Clog"
	typepath = /datum/round_event/scrubber_clog/critical
	weight = 8
	min_players = 15
	max_occurrences = 1
	earliest_start = 25 MINUTES

/datum/round_event/scrubber_clog/critical
	maximum_spawns = 3

/datum/round_event/scrubber_clog/critical/setup()
	. = ..()
	spawn_delay = rand(15,25)

/datum/round_event/scrubber_clog/critical/announce()
	priority_announce("Potentially hazardous lifesigns detected in the [get_area_name(scrubber)] ventilation network.", "Security Alert")

/datum/round_event/scrubber_clog/critical/get_mob()
	var/static/list/mob_list = list(
		/mob/living/simple_animal/hostile/carp,
		/mob/living/simple_animal/hostile/bee/toxin,
		/mob/living/basic/cockroach/glockroach,
	)
	return pick(mob_list)

/datum/round_event_control/scrubber_clog/strange
	name = "Strange Scrubber Clog"
	typepath = /datum/round_event/scrubber_clog/strange
	weight = 5
	max_occurrences = 1

/datum/round_event/scrubber_clog/strange
	maximum_spawns = 3

/datum/round_event/scrubber_clog/strange/setup()
	. = ..()
	endWhen = rand(600, 720)
	spawn_delay = rand(6, 25) //Wide range, for maximum utility/comedy

/datum/round_event/scrubber_clog/strange/announce()
	priority_announce("Unusual lifesign readings detected in the [get_area_name(scrubber)] ventilation network.", "Lifesign Alert", ANNOUNCER_ALIENS)

/datum/round_event/scrubber_clog/strange/get_mob()
	var/static/list/mob_list = list(
		/mob/living/simple_animal/hostile/retaliate/goose, //Janitors HATE geese.
		/mob/living/simple_animal/hostile/bear,
		/mob/living/simple_animal/pet/gondola,
		/mob/living/simple_animal/hostile/mushroom,
		/mob/living/simple_animal/hostile/lightgeist,
	)
	return pick(mob_list)
