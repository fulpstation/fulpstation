/// Event, this will also cause mechs to play for keeps.
/datum/round_event_control/mech_dropoff
	name = "Mech Dropoff Events"
	typepath = /datum/round_event/mech_dropoff
	weight = 0
	min_players = 1
	max_occurrences = 1

/datum/round_event/mech_dropoff
	fakeable = FALSE

/datum/round_event/mech_dropoff/start()
	. = ..()
	for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
		if(!H.mind) // Only if you have a mind
			continue
		H.put_in_hands(new /obj/item/choice_beacon/mech_kit)
		playsound(get_turf(H),'sound/magic/summon_magic.ogg', 50, TRUE)

/datum/round_event/mech_dropoff/announce()
	priority_announce("To improve morale, we've utilized our Bluespace Mecha technology to send mech kits to all crewmembers. Hit a crewmember with them to battle them, playing for wins.", "Its Mech Time")
