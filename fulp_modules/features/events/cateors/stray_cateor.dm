//////////////////////////////
//////// Lone Cateor  ////////
//////////////////////////////

//A singular cateor appears and homes in on a random crew member.

/datum/round_event_control/stray_meteor/stray_lone_cateor
	name = "Stray Cateor"
	typepath = /datum/round_event/stray_meteor/stray_lone_cateor
	weight = 25 //More likely than regular stray meteor because it's less harmful >;3
	min_players = 5
	max_occurrences = 4
	earliest_start = 15 MINUTES
	description = "Throws a cateor at the station directed at a random crew member."
	min_wizard_trigger_potency = 2
	max_wizard_trigger_potency = 5
	map_flags = NONE
	admin_setup = list() //Empty list, no admin setup >:3


/datum/round_event/stray_meteor/stray_lone_cateor
	announce_when = 3

//Finds a random living crew member who meets a few criteria and makes the cateor launch towards them.
//Made using 'heart_attack.dm' as a reference.
/datum/round_event/stray_meteor/stray_lone_cateor/start()
	var/list/viable_crew_targets = list() //Makes a list of who it should chase first
	for(var/mob/living/crew in shuffle(GLOB.player_list))
		var/turf/crew_turf = get_turf(crew)
		if(crew.stat == DEAD || HAS_TRAIT(crew, TRAIT_CRITICAL_CONDITION) || !is_station_level(crew_turf.z))
			continue
		if(isfelinid(crew))
			continue
		else
			viable_crew_targets.Add(crew)

	var/mob/living/victim = pick(viable_crew_targets)

	var/obj/effect/meteor/cateor/new_cateor = new /obj/effect/meteor/cateor(
		spaceDebrisStartLoc(pick(GLOB.cardinals), pick(SSmapping.levels_by_trait(ZTRAIT_STATION))),
		NONE
	)

	//For some reason the homing doesn't quite work, so we just move ten times faster, give...
	//...the victim an ominous hynpotic premonition, and hope for the best.
	new_cateor.chase_target(get_turf(victim), 0.01, TRUE)
	to_chat(victim, span_hypnophrase("We awe appwoaching, pwease <i>STAND STIWL</i>."))

/datum/round_event/stray_meteor/stray_lone_cateor/announce(fake)
	priority_announce(
		"Ouw sensows have been cowwupted by a stwange signatuwe detected appwoaching the station. Pwease \[ERROR, 'situation_advisory' DOES NOT EXIST\]",
		"ERR% *@w@!",
		'sound/effects/footstep/meowstep1.ogg',
		color_override = "yellow",
		sender_override = "Centwal Command Update"
	)
