/datum/round_event_control/scrubber_overflow
	name = "Scrubber Overflow: Normal"
	typepath = /datum/round_event/scrubber_overflow
	weight = 10
	max_occurrences = 3
	min_players = 10
	category = EVENT_CATEGORY_JANITORIAL
	description = "The scrubbers release a tide of mostly harmless froth."

/datum/round_event/scrubber_overflow
	announce_when = 1
	start_when = 5
	/// The probability that the ejected reagents will be dangerous
	var/danger_chance = 1
	/// Amount of reagents ejected from each scrubber
	var/reagents_amount = 50
	/// A list of scrubbers that will have reagents ejected from them
	var/list/scrubbers = list()
	/// The list of chems that scrubbers can produce
	var/list/safer_chems = list(/datum/reagent/water,
		/datum/reagent/carbon,
		/datum/reagent/consumable/flour,
		/datum/reagent/space_cleaner,
		/datum/reagent/carpet/royal/blue,
		/datum/reagent/carpet/orange,
		/datum/reagent/consumable/nutriment,
		/datum/reagent/consumable/condensedcapsaicin,
		/datum/reagent/drug/mushroomhallucinogen,
		/datum/reagent/lube,
		/datum/reagent/glitter/blue,
		/datum/reagent/glitter/pink,
		/datum/reagent/cryptobiolin,
		/datum/reagent/blood,
		/datum/reagent/medicine/c2/multiver,
		/datum/reagent/water/holywater,
		/datum/reagent/consumable/ethanol,
		/datum/reagent/consumable/hot_coco,
		/datum/reagent/consumable/yoghurt,
		/datum/reagent/consumable/tinlux,
		/datum/reagent/hydrogen_peroxide,
		/datum/reagent/bluespace,
		/datum/reagent/pax,
		/datum/reagent/consumable/laughter,
		/datum/reagent/concentrated_barbers_aid,
		/datum/reagent/baldium,
		/datum/reagent/colorful_reagent,
		/datum/reagent/consumable/salt,
		/datum/reagent/consumable/ethanol/beer,
		/datum/reagent/hair_dye,
		/datum/reagent/consumable/sugar,
		/datum/reagent/glitter/white,
		/datum/reagent/gravitum,
		/datum/reagent/growthserum,
		/datum/reagent/yuck,
	)
	//needs to be chemid unit checked at some point

/datum/round_event/scrubber_overflow/announce(fake)
	priority_announce("The scrubbers network is experiencing a backpressure surge. Some ejection of contents may occur.", "Atmospherics alert")

/datum/round_event/scrubber_overflow/setup()
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/temp_vent in GLOB.machines)
		var/turf/scrubber_turf = get_turf(temp_vent)
		if(!scrubber_turf)
			continue
		if(!is_station_level(scrubber_turf.z))
			continue
		if(temp_vent.welded)
			continue
		if(!prob(50))
			continue
		scrubbers += temp_vent

	if(!scrubbers.len)
		return kill()

/datum/round_event_control/scrubber_overflow/can_spawn_event(players_amt)
	. = ..()
	if(!.)
		return
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/temp_vent in GLOB.machines)
		var/turf/scrubber_turf = get_turf(temp_vent)
		if(!scrubber_turf)
			continue
		if(!is_station_level(scrubber_turf.z))
			continue
		if(temp_vent.welded)
			continue
		return TRUE //there's at least one. we'll let the codergods handle the rest with prob() i guess.
	return FALSE



/datum/round_event/scrubber_overflow/start()
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/vent as anything in scrubbers)
		if(!vent.loc)
			CRASH("SCRUBBER SURGE: [vent] has no loc somehow?")

		var/datum/reagents/dispensed_reagent = new /datum/reagents(reagents_amount)
		dispensed_reagent.my_atom = vent
		if (prob(danger_chance))
			dispensed_reagent.add_reagent(get_random_reagent_id(), reagents_amount)
			new /mob/living/basic/cockroach(get_turf(vent))
			new /mob/living/basic/cockroach(get_turf(vent))
		else
			dispensed_reagent.add_reagent(pick(safer_chems), reagents_amount)

		dispensed_reagent.create_foam(/datum/effect_system/fluid_spread/foam, reagents_amount)

		CHECK_TICK

/datum/round_event_control/scrubber_overflow/threatening
	name = "Scrubber Overflow: Threatening"
	typepath = /datum/round_event/scrubber_overflow/threatening
	weight = 4
	min_players = 25
	max_occurrences = 1
	earliest_start = 35 MINUTES
	description = "The scrubbers release a tide of moderately harmless froth."

/datum/round_event/scrubber_overflow/threatening
	danger_chance = 10
	reagents_amount = 100

/datum/round_event_control/scrubber_overflow/catastrophic
	name = "Scrubber Overflow: Catastrophic"
	typepath = /datum/round_event/scrubber_overflow/catastrophic
	weight = 2
	min_players = 35
	max_occurrences = 1
	earliest_start = 45 MINUTES
	description = "The scrubbers release a tide of mildly harmless froth."

/datum/round_event/scrubber_overflow/catastrophic
	danger_chance = 30
	reagents_amount = 150
