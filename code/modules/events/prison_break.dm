/datum/round_event_control/grey_tide
	name = "Grey Tide"
	typepath = /datum/round_event/grey_tide
	max_occurrences = 2
	min_players = 5
	category = EVENT_CATEGORY_ENGINEERING
	description = "Bolts open all doors in one or more departments."

/datum/round_event/grey_tide
	announce_when = 50
	end_when = 20
	var/list/area/areasToOpen = list()
	var/list/potential_areas = list(/area/station/command,
									/area/station/engineering,
									/area/station/medical,
									/area/station/security,
									/area/station/cargo,
									/area/station/science)
	var/severity = 1


/datum/round_event/grey_tide/setup()
	announce_when = rand(50, 60)
	end_when = rand(20, 30)
	severity = rand(1,3)
	for(var/i in 1 to severity)
		var/picked_area = pick_n_take(potential_areas)
		for(var/area/A in world)
			if(istype(A, picked_area))
				areasToOpen += A


/datum/round_event/grey_tide/announce(fake)
	if(areasToOpen && areasToOpen.len > 0)
		priority_announce("Gr3y.T1d3 virus detected in [station_name()] door subroutines. Severity level of [severity]. Recommend station AI involvement.", "Security Alert")
	else
		log_world("ERROR: Could not initiate grey-tide. No areas in the list!")
		kill()


/datum/round_event/grey_tide/start()
	for(var/area/A in areasToOpen)
		for(var/obj/machinery/light/L in A)
			L.flicker(10)

/datum/round_event/grey_tide/end()
	for(var/area/A in areasToOpen)
		for(var/obj/O in A)
			if(istype(O, /obj/structure/closet/secure_closet))
				var/obj/structure/closet/secure_closet/temp = O
				temp.locked = FALSE
				temp.update_appearance()
			else if(istype(O, /obj/machinery/door/airlock))
				var/obj/machinery/door/airlock/temp = O
				if(temp.critical_machine) //Skip doors in critical positions, such as the SM chamber.
					continue
				temp.prison_open()
			else if(istype(O, /obj/machinery/status_display/door_timer))
				var/obj/machinery/status_display/door_timer/temp = O
				temp.timer_end(forced = TRUE)
