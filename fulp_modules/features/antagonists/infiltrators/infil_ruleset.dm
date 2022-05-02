/datum/round_event_control/infiltrators
	name = "Spawn Infiltrators"
	typepath = /datum/round_event/ghost_role/infiltrator
	max_occurrences = 2
	weight = 5
	min_players = 10
	earliest_start = 30 MINUTES
	alert_observers = TRUE

/datum/round_event/ghost_role/infiltrator
	minimum_required = 1
	role_name = "Infiltrator"

/datum/round_event/ghost_role/infiltrator/spawn_role()
	var/list/spawn_locs = list()
	for(var/obj/effect/landmark/carpspawn/carp_spawn in GLOB.landmarks_list)
		if(!isturf(carp_spawn.loc))
			stack_trace("Carp spawn found not on a turf: [carp_spawn.type] on [isnull(carp_spawn.loc) ? "null" : carp_spawn.loc.type]")
			continue
		spawn_locs += carp_spawn.loc
	if(!spawn_locs.len)
		message_admins("No valid spawn locations found, aborting...")
		return MAP_ERROR


	var/list/candidates = get_candidates(ROLE_INFILTRATOR, ROLE_INFILTRATOR)
	if(!candidates.len)
		return NOT_ENOUGH_PLAYERS

	var/mob/dead/selected_candidate = pick(candidates)
	var/key = selected_candidate.key

	var/mob/living/carbon/human/infiltrator = create_infiltrator(pick(spawn_locs))
	infiltrator.key = key
	infiltrator.mind.add_antag_datum(/datum/antagonist/traitor/infiltrator)
	spawned_mobs += infiltrator
	message_admins("[ADMIN_LOOKUPFLW(infiltrator)] has been made into a infiltrator by an event.")
	log_game("[key_name(infiltrator)] was spawned as a infiltrator by an event.")

	return SUCCESSFUL_SPAWN

/proc/create_infiltrator(spawn_loc)
	var/mob/living/carbon/human/infiltrator = new(spawn_loc)
	infiltrator.randomize_human_appearance((RANDOMIZE_NAME|RANDOMIZE_SPECIES))
	return infiltrator

