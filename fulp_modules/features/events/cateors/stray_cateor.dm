//////////////////////////////
//////// Lone Cateor  ////////
//////////////////////////////

//A singular cateor appears and homes in on a random crew member.

/datum/round_event_control/stray_meteor/stray_lone_cateor
	name = "Stray Cateor"
	typepath = /datum/round_event/stray_meteor/stray_lone_cateor
	weight = 20 //A bit more likely than regular stray meteor because it's less harmful >;3
	min_players = 10
	max_occurrences = 1
	earliest_start = 15 MINUTES
	description = "Throw a cateor at the station that homes in on a random crew member."
	min_wizard_trigger_potency = 2
	max_wizard_trigger_potency = 5
	map_flags = NONE


/datum/round_event/stray_meteor/stray_lone_cateor
	fakeable = TRUE //Unlike a regular stray meteor, this one practically can't miss.
	var/list/viable_crew_targets = list() //A list of who can be targeted by the stray cateor

//Finds a random living crew member who meets a few criteria and makes the cateor launch towards them.
//Made using 'heart_attack.dm' as a reference.
/datum/round_event/stray_meteor/stray_lone_cateor/start()
	//Makes a list of who it should chase first
	for(var/mob/living/carbon/human/crew in shuffle(GLOB.player_list))
		if(crew.stat == DEAD || HAS_TRAIT(crew, TRAIT_CRITICAL_CONDITION) || isfelinid(crew) || !is_station_level(get_turf(crew)))
			continue
		if(!(crew.mind.assigned_role.job_flags & (JOB_CREW_MEMBER || JOB_AI || JOB_CYBORG)))
			continue
		else
			viable_crew_targets[crew] = 1
	var/victim = pick_weight(viable_crew_targets)

	var/obj/effect/meteor/cateor/new_cateor = new /obj/effect/meteor/cateor(
		spaceDebrisStartLoc(pick(GLOB.cardinals), pick(SSmapping.levels_by_trait(ZTRAIT_STATION))),
		get_turf(victim)
		)
	new_cateor.chase_target(victim, home = TRUE)
	new_cateor.Move()

/datum/round_event/stray_meteor/stray_lone_cateor/announce(fake)
	priority_announce(
		"Ouw sensows have been cowwupted by a stwange signatuwe detected appwoaching the station. Pwease \[ERROR, 'situation_advisory' DOES NOT EXIST\]",
		"ERR% @*#@!",
		'fulp_modules/sounds/misc/cat_raid_siren.ogg', //TODO: Replace with shortened version
		color_override = "yellow",
		sender_override = "Centwal Command Update"
	)
