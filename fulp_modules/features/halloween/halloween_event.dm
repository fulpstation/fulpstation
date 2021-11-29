/datum/round_event_control/halloween_costumes
	name = "Halloween Costume Drop"
	holidayID = HALLOWEEN
	typepath = /datum/round_event/halloween_costumes
	weight = 80 //super likely to happen
	min_players = 1
	max_occurrences = 1

/datum/round_event/halloween_costumes
	fakeable = FALSE

/datum/round_event/halloween_costumes/start()
	..()
	for(var/mob/living/carbon/human/all_players in GLOB.alive_mob_list)
		all_players.put_in_hands(new /obj/item/halloween_gift)
		playsound(get_turf(all_players),'sound/magic/summon_magic.ogg', 50, TRUE)

/datum/round_event/halloween_costumes/announce()
	priority_announce("To improve morale, we've utilized our Bluespace Wardrobe technology to send bulk halloween costumes over. Enjoy.", "Its Spooky Time")
