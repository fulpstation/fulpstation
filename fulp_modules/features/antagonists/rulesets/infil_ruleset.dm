/datum/dynamic_ruleset/midround/from_ghosts/infiltrator
	name = "Infiltrator"
	ruleset_flags = RULESET_INVADER
	preview_antag_datum = /datum/antagonist/traitor/fulp_infiltrator
	pref_flag = ROLE_INFILTRATOR
	weight = 7

/datum/dynamic_ruleset/midround/from_ghosts/infiltrator/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/traitor/fulp_infiltrator)
	candidate.current.forceMove(find_space_spawn())

/datum/round_event_control/missilegalore
	name = "Missiles"
	typepath = /datum/round_event/missilegalore
	category = EVENT_CATEGORY_ENGINEERING
	max_occurrences = 0
	weight = 0

/datum/round_event/missilegalore/announce(fake)
	priority_announce("Multiple missiles detected en route to the station. Seek shelter", "Missile Detection System", 'fulp_modules/features/antagonists/infiltrators/sounds/missile_alert.ogg')

/datum/round_event/missilegalore/start()
	for(var/i = 1, i < 6, i++)
		var/turf/targetloc = get_safe_random_station_turf()
		podspawn(list(
		"target" = targetloc,
		"style" = /datum/pod_style/missile,
		"effectMissile" = TRUE,
		"explosionSize" = list(3,4,5,5),
		"delays" = list(POD_TRANSIT = 60, POD_FALLING = 60),
	))

