/datum/action/bloodsucker/track_monster
	name = "Track Monster"
	desc = "Take a moment to look for clues of any nearby monsters.<br>These creatures are slippery, and often look like the crew."
	button_icon = 'fulp_modules/features/bloodsuckers/icons/actions_bloodsucker.dmi'
	icon_icon = 'fulp_modules/features/bloodsuckers/icons/actions_bloodsucker.dmi'
	background_icon_state = "bs_power_off"
	button_icon_state = "power_hunter"
	power_flags = NONE
	check_flags = BP_CANT_USE_WHILE_INCAPACITATED|BP_CANT_USE_WHILE_UNCONSCIOUS
	purchase_flags = NONE
	cooldown = 30 SECONDS
	bloodcost = 0
	/// Removed, set to TRUE to re-add, either here to be a default function, or in-game through VV for neat Admin stuff -Willard
	var/give_pinpointer = FALSE

/datum/action/bloodsucker/track_monster/ActivatePower(mob/living/user = owner)
	. = ..()
	/// Return text indicating direction
	to_chat(user, span_notice("You look around, scanning your environment and discerning signs of any filthy, wretched affronts to the natural order."))
	if(!do_mob(user, owner, 80))
		return
	if(give_pinpointer)
		user.apply_status_effect(STATUS_EFFECT_HUNTERPINPOINTER)
	display_proximity()

/datum/action/bloodsucker/track_monster/proc/display_proximity()
	/// Pick target
	var/turf/my_loc = get_turf(owner)
	var/best_dist = 9999
	var/mob/living/closest_bloodsucker

	/// Track ALL living Monsters.
	var/list/datum/mind/monsters = list()
	for(var/mob/living/carbon/all_carbons in GLOB.alive_mob_list)
		if(!all_carbons.mind)
			continue
		var/datum/mind/carbon_minds = all_carbons.mind
		if(IS_HERETIC(all_carbons) || IS_BLOODSUCKER(all_carbons) || IS_CULTIST(all_carbons) || IS_WIZARD(all_carbons))
			monsters += carbon_minds
		if(carbon_minds.has_antag_datum(/datum/antagonist/changeling))
			monsters += carbon_minds
		if(carbon_minds.has_antag_datum(/datum/antagonist/ashwalker))
			monsters += carbon_minds
		if(carbon_minds.has_antag_datum(/datum/antagonist/wizard/apprentice))
			monsters += carbon_minds

	for(var/datum/mind/monster_minds in monsters)
		if(!monster_minds.current || monster_minds.current == owner) // || !get_turf(M.current) || !get_turf(owner))
			continue
		for(var/antag_datums in monster_minds.antag_datums)
			var/datum/antagonist/antag_datum = antag_datums
			if(!istype(antag_datum))
				continue
			var/their_loc = get_turf(monster_minds.current)
			var/distance = get_dist_euclidian(my_loc, their_loc)
			/// Found One: Closer than previous/max distance
			if(distance < best_dist && distance <= HUNTER_SCAN_MAX_DISTANCE)
				best_dist = distance
				closest_bloodsucker = monster_minds.current
				/// Stop searching through my antag datums and go to the next guy
				break

	/// Found one!
	if(closest_bloodsucker)
		var/distString = best_dist <= HUNTER_SCAN_MAX_DISTANCE / 2 ? "<b>somewhere closeby!</b>" : "somewhere in the distance."
		to_chat(owner, span_warning("You detect signs of monsters [distString]"))

	/// Will yield a "?"
	else
		to_chat(owner, span_notice("There are no monsters nearby."))
