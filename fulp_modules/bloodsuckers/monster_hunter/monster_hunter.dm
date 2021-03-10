#define HUNTER_SCAN_MIN_DISTANCE 8
#define HUNTER_SCAN_MAX_DISTANCE 35
#define HUNTER_SCAN_PING_TIME 20 //5s update time.

/datum/antagonist/monsterhunter
	name = "Hunter"
	roundend_category = "hunters"
	antagpanel_category = "Monster Hunter"
	job_rank = ROLE_MONSTERHUNTER
	var/list/datum/action/powers = list() // Purchased powers
	var/datum/martial_art/my_kungfu // Hunters know a lil kung fu.
	var/bad_dude = FALSE // Every first hunter spawned is a SHIT LORD.
	var/give_objectives = TRUE

/datum/antagonist/monsterhunter/apply_innate_effects(mob/living/mob_override)
	return

/datum/antagonist/monsterhunter/remove_innate_effects(mob/living/mob_override)
	return

/datum/antagonist/monsterhunter/on_gain()
	. = ..()
	SSticker.mode.monsterhunter += owner
	// Hunter Pinpointer
	owner.current.apply_status_effect(/datum/status_effect/agent_pinpointer/hunter_edition)
	// Give Hunter Power
	var/datum/action/P = new /datum/action/bloodsucker/trackvamp
	P.Grant(owner.current)
	// Give Hunter Martial Arts
	if (rand(1,2) == 1)
		var/datum/martial_art/pick_type = pick(/datum/martial_art/cqc, /datum/martial_art/krav_maga, /datum/martial_art/krav_maga, /datum/martial_art/wrestling, /datum/martial_art/hunterfu)  // /datum/martial_art/boxing  <--- doesn't include grabbing, so don't use!
		my_kungfu = new pick_type //pick (/datum/martial_art/boxing, /datum/martial_art/cqc) // ick_type
		my_kungfu.teach(owner.current, 0)
	// Give Hunter Objective
	var/datum/objective/bloodsucker/monsterhunter/monsterhunter_objective = new
	monsterhunter_objective.owner = owner
	monsterhunter_objective.generate_objective()
	objectives += monsterhunter_objective
	// Badguy Hunter? (Give him BADGUY objectives)
	if(bad_dude)
		// Stolen DIRECTLY from datum_traitor.dm
		if(prob(15) && !(locate(/datum/objective/download) in objectives) && !(owner.assigned_role in list("Research Director", "Scientist", "Roboticist", "Geneticist")))
			var/datum/objective/download/download_objective = new
			download_objective.owner = owner
			download_objective.gen_amount_goal()
			objectives += download_objective
		else
			var/datum/objective/steal/steal_objective = new
			steal_objective.owner = owner
			steal_objective.find_target()
			objectives += steal_objective
	return ..()

/datum/antagonist/monsterhunter/on_removal()
	// Clear Antag
	SSticker.mode.monsterhunter -= owner
	owner.special_role = null
	if(!LAZYLEN(owner.antag_datums))
		owner.current.remove_from_current_living_antags()
	if(!silent && owner.current)
		farewell()
	// Master Pinpointer
	owner.current.remove_status_effect(/datum/status_effect/agent_pinpointer/hunter_edition)
	// Remove martial arts
	if(owner.current)
		for (var/datum/action/bloodsucker/P in owner.current.actions)
			P.Remove(owner.current)
		my_kungfu.remove(owner.current)
	// Remove Hunter Objectives
	remove_objective()
	return ..()

/datum/antagonist/monsterhunter/proc/add_objective(datum/objective/O)
	objectives += O

/datum/antagonist/monsterhunter/proc/remove_objective()
	for(var/O in objectives)
		objectives -= O
		qdel(O)

/datum/antagonist/monsterhunter/greet()
	to_chat(owner.current, "<span class='userdanger'>You are a fearless Monster Hunter!</span>")
	to_chat(owner.current, "<span class='announce'>You know there's one or more filthy creature onboard the station, though their identities elude you.</span><br>")
	to_chat(owner.current, "<span class='announce'>It's your job to root them out, destroy their nests, and save the crew.</span><br>")
	to_chat(owner.current, "<span class='announce'>Use <b>WHATEVER MEANS NECESSARY</b> to find these creatures, no matter who gets hurt or what you have to destroy to do it.</span><br>")
	to_chat(owner.current, "<span class='announce'>There are greater stakes at hand than the safety of the station!</span><br>")
	to_chat(owner.current,"<span class='announce'>However, security may detain you if they discover your mission.</span><br>")
	if(my_kungfu != null)
		to_chat(owner.current, "<span class='boldannounce'>Hunter Tip: Use your [my_kungfu.name] techniques to give you an advantage over the enemy.</span><br>")
	owner.announce_objectives()

/datum/antagonist/monsterhunter/farewell()
	to_chat(owner.current, "<span class='userdanger'>Your hunt has ended: you are no longer a monster hunter</span>")

// TAKEN FROM:  /datum/action/changeling/pheromone_receptors    // pheromone_receptors.dm      for a version of tracking that Changelings have!
/datum/status_effect/agent_pinpointer/hunter_edition
	alert_type = /atom/movable/screen/alert/status_effect/agent_pinpointer/hunter_edition
	minimum_range = HUNTER_SCAN_MIN_DISTANCE
	tick_interval = HUNTER_SCAN_PING_TIME
	duration = 160 // Lasts 10s
	range_fuzz_factor = 5//PINPOINTER_EXTRA_RANDOM_RANGE

/atom/movable/screen/alert/status_effect/agent_pinpointer/hunter_edition
	name = "Monster Tracking"
	desc = "You always know where the hellspawn are."

/datum/status_effect/agent_pinpointer/hunter_edition/on_creation(mob/living/new_owner, ...)
	..()

	// Pick target
	var/turf/my_loc = get_turf(owner)
	var/list/mob/living/carbon/vamps = list()

	for(var/datum/mind/M in SSticker.mode.bloodsuckers)
		if (!M.current || M.current == owner || !get_turf(M.current) || !get_turf(new_owner))
			continue
		var/datum/antagonist/bloodsucker/antag_datum = M.has_antag_datum(/datum/antagonist/bloodsucker)
		if(!istype(antag_datum))
			continue
		var/their_loc = get_turf(M.current)
		var/distance = get_dist_euclidian(my_loc, their_loc)
		if (distance < HUNTER_SCAN_MAX_DISTANCE)
			vamps[M.current] = (HUNTER_SCAN_MAX_DISTANCE ** 2) - (distance ** 2)
	// Found one!
	if(vamps.len)
		scan_target = pickweight(vamps) //Point at a 'random' vamp, biasing heavily towards closer ones.
		to_chat(owner, "<span class='warning'>You detect signs of monsters to the <b>[dir2text(get_dir(my_loc,get_turf(scan_target)))]!</b></span>")
	// Will yield a "?"
	else
		to_chat(owner, "<span class='notice'>There are no monsters nearby.</span>")
	// Force Point-To Immediately
	point_to_target()

/datum/status_effect/agent_pinpointer/hunter_edition/scan_for_target()
	// Lose target? Done. Otherwise, scan for target's current position.
	if (!scan_target && owner)
		owner.remove_status_effect(/datum/status_effect/agent_pinpointer/hunter_edition)

	// NOTE: Do NOT run ..(), or else we'll remove our target.

/datum/status_effect/agent_pinpointer/hunter_edition/Destroy()
	if (scan_target)
		to_chat(owner, "<span class='notice'>You've lost the trail.</span>")
	..()

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/action/bloodsucker/trackvamp
	name = "Track Monster"// "Cellular Emporium"
	desc = "Take a moment to look for clues of any nearby monsters.<br>These creatures are slippery, and often look like the crew."
	button_icon = 'fulp_modules/bloodsuckers/icons/actions_bloodsucker.dmi'	//This is the file for the BACKGROUND icon
	background_icon_state = "vamp_power_off"		//And this is the state for the background icon
	icon_icon = 'fulp_modules/bloodsuckers/icons/actions_bloodsucker.dmi'		//This is the file for the ACTION icon
	button_icon_state = "power_hunter" 				//And this is the state for the action icon
	amToggle = FALSE  // Action-Related
	cooldown = 300 // 10 ticks, 1 second.
	bloodcost = 0

/datum/action/bloodsucker/trackvamp/ActivatePower()
	var/mob/living/user = owner
	to_chat(user, "<span class='notice'>You look around, scanning your environment and discerning signs of any filthy, wretched affronts to the natural order.</span>")

	if (!do_mob(user,owner,80))
		return
	// Add Power
	// REMOVED //user.apply_status_effect(/datum/status_effect/agent_pinpointer/hunter_edition)
	// We don't track direction anymore!
	// Return text indicating direction
	display_proximity()
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
//	monsters += SSticker.mode.culties // Not working, TG uses 'var/list/culties' rather than 'var/list/datum/mind/culties'
//	monsters += SSticker.mode.changelings // Not working, TG uses 'var/list/changelings' rather than 'var/list/datum/mind/changelings'

	for(var/datum/mind/M in monsters)
		if (!M.current || M.current == owner) // || !get_turf(M.current) || !get_turf(owner))
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
		//to_chat(owner, "<span class='warning'>You detect signs of Bloodsuckers to the <b>[dir2text(get_dir(my_loc,get_turf(targetVamp)))]!</b></span>")
		to_chat(owner, "<span class='warning'>You detect signs of monsters [distString]</span>")

	// Will yield a "?"
	else
		to_chat(owner, "<span class='notice'>There are no monsters nearby.</span>")
