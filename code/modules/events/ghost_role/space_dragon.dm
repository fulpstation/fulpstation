/datum/round_event_control/space_dragon
	name = "Spawn Space Dragon"
	typepath = /datum/round_event/ghost_role/space_dragon
	weight = 7
	max_occurrences = 1
	min_players = 20
	dynamic_should_hijack = TRUE
	category = EVENT_CATEGORY_ENTITIES
	description = "Spawns a space dragon, which will try to take over the station."
	min_wizard_trigger_potency = 6
	max_wizard_trigger_potency = 7

/datum/round_event/ghost_role/space_dragon
	minimum_required = 1
	role_name = "Space Dragon"
	announce_when = 10

/datum/round_event/ghost_role/space_dragon/announce(fake)
	priority_announce("A large organic energy flux has been recorded near [station_name()], please stand by.", "Lifesign Alert")

/datum/round_event/ghost_role/space_dragon/spawn_role()

	var/list/candidates = get_candidates(ROLE_SPACE_DRAGON, ROLE_SPACE_DRAGON)
	if(!candidates.len)
		return NOT_ENOUGH_PLAYERS

	var/mob/dead/selected = pick(candidates)
	var/key = selected.key

	var/spawn_location = find_space_spawn()
	if(isnull(spawn_location))
		return MAP_ERROR

	var/mob/living/simple_animal/hostile/space_dragon/dragon = new (spawn_location)
	dragon.key = key
	dragon.mind.set_assigned_role(SSjob.GetJobType(/datum/job/space_dragon))
	dragon.mind.special_role = ROLE_SPACE_DRAGON
	dragon.mind.add_antag_datum(/datum/antagonist/space_dragon)
	playsound(dragon, 'sound/magic/ethereal_exit.ogg', 50, TRUE, -1)
	message_admins("[ADMIN_LOOKUPFLW(dragon)] has been made into a Space Dragon by an event.")
	dragon.log_message("was spawned as a Space Dragon by an event.", LOG_GAME)
	spawned_mobs += dragon
	return SUCCESSFUL_SPAWN
