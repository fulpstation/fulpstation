/* Hide a random object somewhere on the station:
 *		var/turf/targetturf = get_random_station_turf()
 *		var/turf/targetturf = get_safe_random_station_turf()
 */

/datum/objective/bloodsucker
	martyr_compatible = TRUE

// GENERATE!
/datum/objective/bloodsucker/proc/generate_objective()
	update_explanation_text()

//////////////////////////////////////////////////////////////////////////////
//	//							 PROCS 									//	//


/// Look at all crew members, and for/loop through.
/datum/objective/bloodsucker/proc/return_possible_targets()
	var/list/possible_targets = list()
	for(var/datum/mind/possible_target in get_crewmember_minds())
		// Check One: Default Valid User
		if(possible_target != owner && ishuman(possible_target.current) && possible_target.current.stat != DEAD)// && is_unique_objective(possible_target))
			// Check Two: Am Bloodsucker? OR in Bloodsucker list?
			if(possible_target.has_antag_datum(/datum/antagonist/bloodsucker) || (possible_target in SSticker.mode.bloodsuckers))
				continue
			else
				possible_targets += possible_target

	return possible_targets


//////////////////////////////////////////////////////////////////////////////////////
//	//							 OBJECTIVES 									//	//

/datum/objective/bloodsucker/lair
	name = "claimlair"

// EXPLANATION
/datum/objective/bloodsucker/lair/update_explanation_text()
	explanation_text = "Create a lair by claiming a coffin, and protect it until the end of the shift."//  Make sure to keep it safe!"

// WIN CONDITIONS?
/datum/objective/bloodsucker/lair/check_completion()
	var/datum/antagonist/bloodsucker/antagdatum = owner.has_antag_datum(/datum/antagonist/bloodsucker)
	if(antagdatum && antagdatum.coffin && antagdatum.lair)
		return TRUE
	return FALSE

/// Space_Station_13_areas.dm  <--- all the areas

//////////////////////////////////////////////////////////////////////////////////////

/// Vassalize someone in charge (Head of Staff + QM)
/// LOOKUP: /datum/crewmonitor/proc/update_data(z) for .assignment to see how to get a person's PDA.
/datum/objective/bloodsucker/protege
	name = "vassalization"

	var/list/roles = list(
		"Captain",
		"Head of Personnel",
		"Head of Security",
		"Research Director",
		"Chief Engineer",
		"Chief Medical Officer",
		"Quartermaster"
	)
	var/list/departs = list(
		"Captain",
		"Head of Security",
		"Head of Personnel",
		"Research Director",
		"Chief Engineer",
		"Chief Medical Officer",
		"Quartermaster"
	)


	var/target_role	// Equals "HEAD" when it's not a department role.
	var/department_string

// GENERATE!
/datum/objective/bloodsucker/protege/generate_objective()
	target_role = rand(0,2) == 0 ? "HEAD" : pick(departs)

	// Heads?
	if(target_role == "HEAD")
		target_amount = rand(1, round(SSticker.mode.num_players() / 20))
		target_amount = clamp(target_amount,1,3)
	// Department?
	else
		switch(target_role)
			if("Captain")
				department_string = "Security" // They aren't security, but they do start mindshielded.
			if("Head of Security")
				department_string = "Security"
			if("Head of Personnel")
				department_string = "Cargo"
			if("Research Director")
				department_string = "Science"
			if("Chief Engineer")
				department_string = "Engineering"
			if("Chief Medical Officer")
				department_string = "Medical"
			if("Quartermaster")
				department_string = "Cargo"
		target_amount = rand(round(SSticker.mode.num_players() / 20), round(SSticker.mode.num_players() / 10))
		target_amount = clamp(target_amount, 2, 4)
	..()

// EXPLANATION
/datum/objective/bloodsucker/protege/update_explanation_text()
	if(target_role == "HEAD")
		if(target_amount == 1)
			explanation_text = "Guarantee a Vassal ends up as a Department Head or in a Leadership role."
		else
			explanation_text = "Guarantee [target_amount] Vassals end up as different Leadership or Department Heads."
	else
		explanation_text = "Have [target_amount] Vassal[target_amount==1?"":"s"] in the [department_string] department."

// WIN CONDITIONS?
/datum/objective/bloodsucker/protege/check_completion()

	var/datum/antagonist/bloodsucker/antagdatum = owner.has_antag_datum(/datum/antagonist/bloodsucker)
	if(!antagdatum || antagdatum.vassals.len == 0)
		return FALSE

	// Get list of all jobs that are qualified (for HEAD, this is already done)
	var/list/valid_jobs
	if(target_role == "HEAD")
		valid_jobs = roles
	else
		valid_jobs = list()
		var/list/alljobs = subtypesof(/datum/job) // This is just a list of TYPES, not the actual variables!
		for(var/T in alljobs)
			var/datum/job/J = SSjob.GetJobType(T)
			if(!istype(J))
				continue
			// Found a job whose Dept Head matches either list of heads, or this job IS the head
			if((target_role in J.department_head) || target_role == J.title)
				valid_jobs += J.title

	// Check Vassals, and see if they match
	var/objcount = 0
	var/list/counted_roles = list() // So you can't have more than one Captain count.
	for(var/datum/antagonist/vassal/V in antagdatum.vassals)
		if(!V || !V.owner)	// Must exist somewhere, and as a vassal.
			continue

		var/thisRole = "none"

		// Mind Assigned
		if((V.owner.assigned_role in valid_jobs) && !(V.owner.assigned_role in counted_roles))
			//to_chat(owner, "<span class='userdanger'>PROTEGE OBJECTIVE: (MIND ROLE)</span>")
			thisRole = V.owner.assigned_role
		// Mob Assigned
		else if((V.owner.current.job in valid_jobs) && !(V.owner.current.job in counted_roles))
			//to_chat(owner, "<span class='userdanger'>PROTEGE OBJECTIVE: (MOB JOB)</span>")
			thisRole = V.owner.current.job
		// PDA Assigned
		else if(V.owner.current && ishuman(V.owner.current))
			var/mob/living/carbon/human/H = V.owner.current
			var/obj/item/card/id/I =  H.wear_id ? H.wear_id.GetID() : null
			if (I && (I.assignment in valid_jobs) && !(I.assignment in counted_roles))
				//to_chat(owner, "<span class='userdanger'>PROTEGE OBJECTIVE: (GET ID)</span>")
				thisRole = I.assignment

		// NO MATCH
		if(thisRole == "none")
			continue

		// SUCCESS!
		objcount ++
		if(target_role == "HEAD")
			counted_roles += thisRole // Add to list so we don't count it again (but only if it's a Head)

	return objcount >= target_amount
	/* 			NOTE!!!!!!!!!!!
	 *
	 *			Look for jobs value on mobs! This is assigned at start, but COULD be assigned from HoP?
	 *
	 *			ALSO - Search through all jobs (look for prefs earlier that look for all jobs, and search through all jobs to see if their head matches the head listed, or it IS the head)
	 *
	 *			ALSO - registered_account in _vending.dm for banks, and assigning new ones.
	 *
	 */

//////////////////////////////////////////////////////////////////////////////////////

/// Eat blood from a lot of people
/datum/objective/bloodsucker/gourmand

// HOW: Track each feed (if human). Count victory.

//////////////////////////////////////////////////////////////////////////////////////

/// Convert a crewmate
/datum/objective/bloodsucker/embrace

// HOW: Find crewmate. Check if person is a bloodsucker

//////////////////////////////////////////////////////////////////////////////////////

/// Defile a facility with blood
/datum/objective/bloodsucker/desecrate

	// Space_Station_13_areas.dm  <--- all the areas

//////////////////////////////////////////////////////////////////////////////////////

/// Destroy the Solar Arrays
/datum/objective/bloodsucker/solars
/* -- Removed due to TG updates breaking it + It's not a good objective, replaced with Vassalhim objective instead.
// Space_Station_13_areas.dm  <--- all the areas
/datum/objective/bloodsucker/solars/update_explanation_text()
	explanation_text = "Prevent all solar arrays on the station from functioning."
/datum/objective/bloodsucker/solars/check_completion()
	// Sort through all /obj/machinery/power/solar_control in the station ONLY, and check that they are functioning.
	// Make sure that lastgen is 0 or connected_panels.len is 0. Doesnt matter if it's tracking.
	for (var/obj/machinery/power/solar_control/SC in SSsun.solars)
		// Check On Station:
		var/turf/T = get_turf(SC)
		if(!T || !is_station_level(T.z)) // <------ Taken from NukeOp
			//message_admins("DEBUG A: [SC] not on station!")
			continue // Not on station! We don't care about this.
		if (SC && SC.lastgen > 0 && SC.connected_panels.len > 0 && SC.connected_tracker)
			return FALSE
	return TRUE
*/

//////////////////////////////////////////////////////////////////////////////////////

/// NOTE: Look up /steal in objective.dm for inspiration.
/// Steal hearts. You just really wanna have some hearts.
/datum/objective/bloodsucker/heartthief
	name = "heartthief"
	martyr_compatible = FALSE

// GENERATE!
/datum/objective/bloodsucker/heartthief/generate_objective()
	target_amount = rand(2,3)
	update_explanation_text()
	return target_amount

// EXPLANATION
/datum/objective/bloodsucker/heartthief/update_explanation_text()
	. = ..()
	explanation_text = "Steal and keep [target_amount] heart[target_amount == 1 ? "" : "s"]."			// TO DO:     Limit them to Human Only!

// WIN CONDITIONS?
/datum/objective/bloodsucker/heartthief/check_completion()
	if(!owner.current)
		return FALSE
	var/list/all_items = owner.current.GetAllContents()
	var/itemcount = FALSE
	for(var/obj/I in all_items)
		if(istype(I, /obj/item/organ/heart/))
			itemcount++
			if(itemcount >= target_amount)
				return TRUE

	return FALSE

//////////////////////////////////////////////////////////////////////////////////////

/// NOTE: Look up /assassinate in objective.dm for inspiration.
/// Vassalize a target.
/datum/objective/bloodsucker/vassalhim
	name = "vassalhim"
	var/target_role_type = FALSE

// FIND TARGET/GENERATE OBJECTIVE
/datum/objective/bloodsucker/vassalhim/find_target_by_role(role, role_type=FALSE, invert=FALSE)
	if(!invert)
		target_role_type = role_type
	..()

// EXPLANATION
/datum/objective/bloodsucker/vassalhim/update_explanation_text()
	..()
	if(target?.current)
		explanation_text = "Ensure [target.name], the [!target_role_type ? target.assigned_role : target.special_role], is Vassalized."
	else
		explanation_text = "Free Objective"

/datum/objective/bloodsucker/vassalhim/admin_edit(mob/admin)
	admin_simple_target_pick(admin)

// WIN CONDITIONS?
/datum/objective/bloodsucker/vassalhim/check_completion()
	if(target.has_antag_datum(/datum/antagonist/vassal))
		return TRUE
	return FALSE

/datum/objective/bloodsucker/vassalhim/admin_edit(mob/admin)
	admin_simple_target_pick(admin)

//////////////////////////////////////////////////////////////////////////////////////

/datum/objective/bloodsucker/survive
	name = "bloodsuckersurvive"
	martyr_compatible = FALSE

// EXPLANATION
/datum/objective/bloodsucker/survive/update_explanation_text()
	explanation_text = "Survive the entire shift without succumbing to Final Death."

// WIN CONDITIONS?
/datum/objective/bloodsucker/survive/check_completion()
	// Must have a body.
	if(!owner.current || !isliving(owner.current))
		return FALSE
	// Dead, without a head or heart? Cya
	return owner.current.stat != DEAD

//////////////////////////////////////////////////////////////////////////////////////

/datum/objective/bloodsucker/monsterhunter
	name = "destroymonsters"

// GENERATE!
/datum/objective/bloodsucker/monsterhunter/generate_objective()
	update_explanation_text()

// EXPLANATION
/datum/objective/bloodsucker/monsterhunter/update_explanation_text()
	explanation_text = "Destroy all monsters on [station_name()]."

// WIN CONDITIONS?
/datum/objective/bloodsucker/monsterhunter/check_completion()
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
			if(UM.has_antag_datum(/datum/antagonist/wizard))
				monsters += UM
			if(UM.has_antag_datum(/datum/antagonist/wizard/apprentice))
				monsters += UM
	for(var/datum/mind/M in monsters)
		if(M && M != owner && M.current && M.current.stat != DEAD && get_turf(M.current))
			return FALSE
	return TRUE


//////////////////////////////////////////////////////////////////////////////////////

/datum/objective/bloodsucker/vassal

// GENERATE!
/datum/objective/bloodsucker/vassal/generate_objective()
	update_explanation_text()

// EXPLANATION
/datum/objective/bloodsucker/vassal/update_explanation_text()
	explanation_text = "Guarantee the success of your Master's mission!"

// WIN CONDITIONS?
/datum/objective/bloodsucker/vassal/check_completion()
	var/datum/antagonist/vassal/antag_datum = owner.has_antag_datum(/datum/antagonist/vassal)
	return antag_datum.master && antag_datum.master.owner && antag_datum.master.owner.current && antag_datum.master.owner.current.stat != DEAD
