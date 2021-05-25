#define HUNTER_SCAN_MIN_DISTANCE 8
#define HUNTER_SCAN_MAX_DISTANCE 15
/// 5s update time
#define HUNTER_SCAN_PING_TIME 20
/// Used for the pinpointer
#define STATUS_EFFECT_HUNTERPINPOINTER /datum/status_effect/agent_pinpointer/hunter_edition

/datum/antagonist/monsterhunter
	name = "Monster Hunter"
	roundend_category = "Monster Hunters"
	antagpanel_category = "Monster Hunter"
	job_rank = ROLE_MONSTERHUNTER
	antag_hud_type = ANTAG_HUD_OBSESSED
	antag_hud_name = "obsessed"
	var/list/datum/action/powers = list()
	var/datum/martial_art/hunterfu/my_kungfu = new
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
	/// Buffs Monster Hunters
	owner.unconvertable = TRUE
	ADD_TRAIT(owner.current, TRAIT_NOSOFTCRIT, BLOODSUCKER_TRAIT)
	ADD_TRAIT(owner.current, TRAIT_NOCRITDAMAGE, BLOODSUCKER_TRAIT)
	/// Give Monster Hunter powers
	trackvamp.Grant(owner.current)
	fortitude.Grant(owner.current)
	if(give_objectives)
		/// Give Hunter Objective
		var/datum/objective/bloodsucker/monsterhunter/monsterhunter_objective = new
		monsterhunter_objective.owner = owner
		monsterhunter_objective.generate_objective()
		objectives += monsterhunter_objective
		/// Give Theft Objective
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
/*		// >> If the Theft objective isnt enough to get Monster hunters to not team with Security, swap it out with this.

		/// Give Assassinate objective
		var/sec_members = SSjob.get_all_sec()
		for(var/datum/mind/M in sec_members)
			var/datum/objective/assassinate/kill_objective = new()
			kill_objective.owner = owner
			kill_objective.find_target()
			objectives += kill_objective */

	/// Give Martial Arts
	my_kungfu.teach(owner.current, 0)
	/// Teach Stake crafting
	owner.teach_crafting_recipe(/datum/crafting_recipe/hardened_stake)
	owner.teach_crafting_recipe(/datum/crafting_recipe/silver_stake)
	. = ..()

/datum/antagonist/monsterhunter/on_removal()
	/// Remove buffs
	owner.unconvertable = FALSE
	REMOVE_TRAIT(owner.current, TRAIT_NOSOFTCRIT, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(owner.current, TRAIT_NOCRITDAMAGE, BLOODSUCKER_TRAIT)
	/// Remove Monster Hunter powers
	trackvamp.Remove(owner.current)
	fortitude.Remove(owner.current)
	/// Remove Martial Arts
	if(my_kungfu)
		my_kungfu.remove(owner.current)
	to_chat(owner.current, "<span class='userdanger'>Your hunt has ended: You enter retirement, and are no longer a Monster Hunter.</span>")
	return ..()

/// Mind version
/datum/mind/proc/make_monsterhunter()
	var/datum/antagonist/monsterhunter/C = has_antag_datum(/datum/antagonist/monsterhunter)
	if(!C)
		C = add_antag_datum(/datum/antagonist/monsterhunter)
		special_role = ROLE_MONSTERHUNTER
	return C

/datum/mind/proc/remove_monsterhunter()
	var/datum/antagonist/monsterhunter/C = has_antag_datum(/datum/antagonist/monsterhunter)
	if(C)
		remove_antag_datum(/datum/antagonist/monsterhunter)
		special_role = null

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

/datum/antagonist/monsterhunter/proc/remove_objectives(datum/objective/O)
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

//////////////////////////////////////////////////////////////////////////
//			Monster Hunter Pinpointer
//////////////////////////////////////////////////////////////////////////

/// TAKEN FROM:  /datum/action/changeling/pheromone_receptors    // pheromone_receptors.dm    for a version of tracking that Changelings have!
/datum/status_effect/agent_pinpointer/hunter_edition
	alert_type = /atom/movable/screen/alert/status_effect/agent_pinpointer/hunter_edition
	minimum_range = HUNTER_SCAN_MIN_DISTANCE
	tick_interval = HUNTER_SCAN_PING_TIME
	duration = 10 SECONDS
	range_fuzz_factor = 5 //PINPOINTER_EXTRA_RANDOM_RANGE

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
		/// Point at a 'random' monster, biasing heavily towards closer ones.
		scan_target = pickweight(monsters)
		to_chat(owner, "<span class='warning'>You detect signs of monsters to the <b>[dir2text(get_dir(my_loc,get_turf(scan_target)))]!</b></span>")
	else
		scan_target = null

/datum/status_effect/agent_pinpointer/hunter_edition/Destroy()
	if(scan_target)
		to_chat(owner, "<span class='notice'>You've lost the trail.</span>")
	..()
