#define HUNTER_SCAN_MIN_DISTANCE 8
#define HUNTER_SCAN_MAX_DISTANCE 15
/// 5s update time
#define HUNTER_SCAN_PING_TIME 20
/// Used for the pinpointer
#define STATUS_EFFECT_HUNTERPINPOINTER /datum/status_effect/agent_pinpointer/hunter_edition

/datum/antagonist/monsterhunter
	name = "Monster Hunter"
	roundend_category = "hunters"
	antagpanel_category = "Monster Hunter"
	job_rank = ROLE_MONSTERHUNTER
	antag_hud_type = ANTAG_HUD_OBSESSED
	antag_hud_name = "obsessed"
	var/list/datum/action/powers = list()
	var/datum/martial_art/my_kungfu // Hunters know a lil kung fu.
	var/give_objectives = TRUE
	var/datum/action/bloodsucker/trackvamp = new/datum/action/bloodsucker/trackvamp()
	var/datum/action/bloodsucker/fortitude = new/datum/action/bloodsucker/fortitude/hunter()

/datum/antagonist/monsterhunter/apply_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	add_antag_hud(antag_hud_type, antag_hud_name, M)

/datum/antagonist/monsterhunter/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	remove_antag_hud(antag_hud_type, M)

/datum/antagonist/monsterhunter/on_gain()
	SSticker.mode.monsterhunter += owner
	// Buffs Monster Hunters
	owner.unconvertable = TRUE
	ADD_TRAIT(owner.current, TRAIT_NOSOFTCRIT, BLOODSUCKER_TRAIT)
	ADD_TRAIT(owner.current, TRAIT_NOCRITDAMAGE, BLOODSUCKER_TRAIT)
	// Give Monster Hunter powers
	trackvamp.Grant(owner.current)
	fortitude.Grant(owner.current)
	if(give_objectives) // Give Hunter Objective
		var/datum/objective/bloodsucker/monsterhunter/monsterhunter_objective = new
		monsterhunter_objective.owner = owner
		monsterhunter_objective.generate_objective()
		objectives += monsterhunter_objective
		// Give Theft objectives
		if(prob(35) && !(locate(/datum/objective/download) in objectives) && !(owner.assigned_role in list("Research Director", "Scientist", "Roboticist", "Geneticist")))
			var/datum/objective/download/download_objective = new
			download_objective.owner = owner
			download_objective.gen_amount_goal()
			objectives += download_objective
		else
			var/datum/objective/steal/steal_objective = new
			steal_objective.owner = owner
			steal_objective.find_target()
			objectives += steal_objective
/*		// If the Theft objective isnt enough to get Monster hunters to not team with Security, swap it out with this.
		// Give Assassinate objective
		var/sec_members = SSjob.get_all_sec()
		for(var/datum/mind/M in sec_members)
			var/datum/objective/assassinate/kill_objective = new()
			kill_objective.owner = owner
			kill_objective.find_target()
			objectives += kill_objective */
	// Give Martial Arts
	var/datum/martial_art/pick_type = pick(/datum/martial_art/wrestling, /datum/martial_art/hunterfu, /datum/martial_art/hunterfu, /datum/martial_art/hunterfu, /datum/martial_art/hunterfu) // Hunter-Fu, 20% chance at Wrestling
	my_kungfu = new pick_type
	my_kungfu.teach(owner.current, 0)
	. = ..()

/datum/antagonist/monsterhunter/on_removal()
	// Remove buffs
	REMOVE_TRAIT(owner.current, TRAIT_NOSOFTCRIT, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(owner.current, TRAIT_NOCRITDAMAGE, BLOODSUCKER_TRAIT)
	// Remove Monster Hunter powers
	trackvamp.Remove(owner.current)
	fortitude.Remove(owner.current)
	// Remove Martial Arts
	if(my_kungfu)
		my_kungfu.remove(owner.current)
	SSticker.mode.monsterhunter -= owner
	if(!silent && owner.current)
		to_chat(owner.current, "<span class='userdanger'>Your hunt has ended: you are no longer a monster hunter</span>")
	owner.special_role = null
	return ..()

//ADMIN TOOLS
/// Called when using admin tools to give antag status
/datum/antagonist/monsterhunter/admin_add(datum/mind/new_owner,mob/admin)
	message_admins("[key_name_admin(admin)] made [key_name_admin(new_owner)] into [name].")
	log_admin("[key_name(admin)] made [key_name(new_owner)] into [name].")
	new_owner.add_antag_datum(src)

/// Called when removing antagonist using admin tools
/datum/antagonist/monsterhunter/admin_remove(mob/user)
	if(!user)
		return
	message_admins("[key_name_admin(user)] has removed [name] antagonist status from [key_name_admin(owner)].")
	log_admin("[key_name(user)] has removed [name] antagonist status from [key_name(owner)].")
	on_removal()

/datum/antagonist/monsterhunter/proc/add_objective(datum/objective/O)
	objectives += O

/datum/antagonist/monsterhunter/proc/remove_objective(datum/objective/O)
	objectives -= O

/datum/antagonist/monsterhunter/greet()
	to_chat(owner.current, "<span class='userdanger'>After witnessing recent events on the station, we return to your old profession, we are a Monster Hunter!</span>")
	to_chat(owner.current, "<span class='announce'>While we can kill anyone in our way to destroy the monsters lurking around, <b>causing property damage is unacceptable</b>.</span><br>")
	to_chat(owner.current, "<span class='announce'>However, security WILL detain us if they discover our mission.</span><br>")
	to_chat(owner.current, "<span class='announce'>In exchange for our services, it shouldn't matter if a few items are gone missing for our... personal collection.</span><br>")
	if(my_kungfu != null)
		to_chat(owner.current, "<span class='boldannounce'>Hunter Tip: Use your [my_kungfu.name] techniques to give you an advantage over the enemy.</span><br>")
	owner.current.playsound_local(null, 'sound/effects/his_grace_ascend.ogg', 100, FALSE, pressure_affected = FALSE)
	owner.announce_objectives()

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//			Monster Hunter Abilities
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/action/bloodsucker/trackvamp
	name = "Track Monster" // "Cellular Emporium"
	desc = "Take a moment to look for clues of any nearby monsters.<br>These creatures are slippery, and often look like the crew."
	button_icon = 'fulp_modules/bloodsuckers/icons/actions_bloodsucker.dmi' // This is the file for the BACKGROUND icon
	background_icon_state = "vamp_power_off" // And this is the state for the background icon
	icon_icon = 'fulp_modules/bloodsuckers/icons/actions_bloodsucker.dmi' // This is the file for the ACTION icon
	button_icon_state = "power_hunter" // And this is the state for the action icon
	amToggle = FALSE // Action-Related
	cooldown = 300 // 10 ticks, 1 second.
	bloodcost = 5
	var/give_pinpointer = FALSE // Removed, set to TRUE to re-add -Willard

/datum/action/bloodsucker/trackvamp/ActivatePower()
	. = ..()
	var/mob/living/carbon/user = owner
	// Return text indicating direction
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
	// Pick target
	var/turf/my_loc = get_turf(owner)
	//var/list/mob/living/carbon/vamps = list()
	var/best_dist = 9999
	var/mob/living/best_vamp

	// Track ALL MONSTERS in Game Mode
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
			var/datum/antagonist/antag_datum = a // var/datum/antagonist/antag_datum = M.has_antag_datum(/datum/antagonist/bloodsucker)
			if(!istype(antag_datum) || antag_datum.AmFinalDeath())
				continue
			var/their_loc = get_turf(M.current)
			var/distance = get_dist_euclidian(my_loc, their_loc)
			// Found One: Closer than previous/max distance
			if (distance < best_dist && distance <= HUNTER_SCAN_MAX_DISTANCE)
				best_dist = distance
				best_vamp = M.current
				break // Stop searching through my antag datums and go to the next guy

	// Found one!
	if(best_vamp)
		var/distString = best_dist <= HUNTER_SCAN_MAX_DISTANCE / 2 ? "<b>somewhere closeby!</b>" : "somewhere in the distance."
		to_chat(owner, "<span class='warning'>You detect signs of monsters [distString]</span>")

	// Will yield a "?"
	else
		to_chat(owner, "<span class='notice'>There are no monsters nearby.</span>")

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//			Monster Hunter Pinpointer
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/// TAKEN FROM:  /datum/action/changeling/pheromone_receptors    // pheromone_receptors.dm    for a version of tracking that Changelings have!
/datum/status_effect/agent_pinpointer/hunter_edition
	alert_type = /atom/movable/screen/alert/status_effect/agent_pinpointer/hunter_edition
	minimum_range = HUNTER_SCAN_MIN_DISTANCE
	tick_interval = HUNTER_SCAN_PING_TIME
	duration = 160 // Lasts 10s
	range_fuzz_factor = 5 // PINPOINTER_EXTRA_RANDOM_RANGE

/atom/movable/screen/alert/status_effect/agent_pinpointer/hunter_edition
	name = "Monster Tracking"
	desc = "You always know where the hellspawn are."

/datum/status_effect/agent_pinpointer/hunter_edition/scan_for_target()
	var/turf/my_loc = get_turf(owner)

	var/list/mob/living/carbon/monsters = list()
	for(var/mob/living/carbon/C in GLOB.alive_mob_list)
		if(C != owner && C.mind)
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
			if(istype(monsters))
				var/their_loc = get_turf(C)
				var/distance = get_dist_euclidian(my_loc, their_loc)
				if(distance < HUNTER_SCAN_MAX_DISTANCE)
					monsters[C] = (HUNTER_SCAN_MAX_DISTANCE ** 2) - (distance ** 2)

	if(monsters.len)
		scan_target = pickweight(monsters) // Point at a 'random' monster, biasing heavily towards closer ones.
		to_chat(owner, "<span class='warning'>You detect signs of monsters to the <b>[dir2text(get_dir(my_loc,get_turf(scan_target)))]!</b></span>")
	else
		scan_target = null

/datum/status_effect/agent_pinpointer/hunter_edition/Destroy()
	if(scan_target)
		to_chat(owner, "<span class='notice'>You've lost the trail.</span>")
	..()
