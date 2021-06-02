/// From 'Cellular Emporium'... somehow?
/datum/action/bloodsucker/trackvamp
	name = "Track Monster"
	desc = "Take a moment to look for clues of any nearby monsters.<br>These creatures are slippery, and often look like the crew."
	button_icon = 'fulp_modules/main_features/bloodsuckers/icons/actions_bloodsucker.dmi'
	background_icon_state = "vamp_power_off"
	icon_icon = 'fulp_modules/main_features/bloodsuckers/icons/actions_bloodsucker.dmi'
	button_icon_state = "power_hunter"
	amToggle = FALSE
	cooldown = 300
	bloodcost = 5
	/// Removed, set to TRUE to re-add, either here to be a default function, or in-game through VV for neat Admin stuff -Willard
	var/give_pinpointer = FALSE

/datum/action/bloodsucker/trackvamp/ActivatePower()
	. = ..()
	var/mob/living/carbon/user = owner
	/// Return text indicating direction
	to_chat(user, "<span class='notice'>You look around, scanning your environment and discerning signs of any filthy, wretched affronts to the natural order.</span>")
	if(!do_mob(user, owner, 80))
		return
	if(give_pinpointer)
		user.apply_status_effect(STATUS_EFFECT_HUNTERPINPOINTER)
	display_proximity()
	PayCost()
	// NOTE: DON'T DEACTIVATE!
	//DeactivatePower()

/datum/action/bloodsucker/trackvamp/proc/display_proximity()
	/// Pick target
	var/turf/my_loc = get_turf(owner)
	var/best_dist = 9999
	var/mob/living/best_vamp

	/// Track ALL living Monsters.
	var/list/datum/mind/monsters = list()
	for(var/mob/living/carbon/C in GLOB.alive_mob_list)
		if(C.mind)
			var/datum/mind/UM = C.mind
			if(UM.has_antag_datum(/datum/antagonist/changeling))
				monsters += UM
			if(UM.has_antag_datum(/datum/antagonist/heretic))
				monsters += UM
			if(UM.has_antag_datum(/datum/antagonist/bloodsucker))
				monsters += UM
			if(UM.has_antag_datum(/datum/antagonist/cult))
				monsters += UM
			if(UM.has_antag_datum(/datum/antagonist/ashwalker))
				monsters += UM
			if(UM.has_antag_datum(/datum/antagonist/wizard))
				monsters += UM
			if(UM.has_antag_datum(/datum/antagonist/wizard/apprentice))
				monsters += UM

	for(var/datum/mind/M in monsters)
		if(!M.current || M.current == owner) // || !get_turf(M.current) || !get_turf(owner))
			continue
		for(var/a in M.antag_datums)
			var/datum/antagonist/antag_datum = a
			if(!istype(antag_datum))
				continue
			var/their_loc = get_turf(M.current)
			var/distance = get_dist_euclidian(my_loc, their_loc)
			/// Found One: Closer than previous/max distance
			if (distance < best_dist && distance <= HUNTER_SCAN_MAX_DISTANCE)
				best_dist = distance
				best_vamp = M.current
				/// Stop searching through my antag datums and go to the next guy
				break

	/// Found one!
	if(best_vamp)
		var/distString = best_dist <= HUNTER_SCAN_MAX_DISTANCE / 2 ? "<b>somewhere closeby!</b>" : "somewhere in the distance."
		to_chat(owner, "<span class='warning'>You detect signs of monsters [distString]</span>")

	/// Will yield a "?"
	else
		to_chat(owner, "<span class='notice'>There are no monsters nearby.</span>")
