/*
 *	# Hide a random object somewhere on the station:
 *
 *	var/turf/targetturf = get_random_station_turf()
 *	var/turf/targetturf = get_safe_random_station_turf()
 */

/datum/objective/bloodsucker
	martyr_compatible = TRUE

// GENERATE
/datum/objective/bloodsucker/New()
	update_explanation_text()
	..()

//////////////////////////////////////////////////////////////////////////////
//	//							 PROCS 									//	//

/// Look at all crew members, and for/loop through.
/datum/objective/bloodsucker/proc/return_possible_targets()
	var/list/possible_targets = list()
	for(var/datum/mind/possible_target in get_crewmember_minds())
		// Check One: Default Valid User
		if(possible_target != owner && ishuman(possible_target.current) && possible_target.current.stat != DEAD)// && is_unique_objective(possible_target))
			// Check Two: Am Bloodsucker? OR in Bloodsucker list?
			if(possible_target.has_antag_datum(/datum/antagonist/bloodsucker))
				continue
			else
				possible_targets += possible_target

	return possible_targets

//////////////////////////////////////////////////////////////////////////////////////
//	//							 OBJECTIVES 									//	//
//////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////
//    DEFAULT OBJECTIVES    //
//////////////////////////////

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

/datum/objective/bloodsucker/survive
	name = "bloodsuckersurvive"

// EXPLANATION
/datum/objective/bloodsucker/survive/update_explanation_text()
	explanation_text = "Survive the entire shift without succumbing to Final Death."

// WIN CONDITIONS?
/datum/objective/bloodsucker/survive/check_completion()
	/// Must have a body.
	if(!owner.current || !isliving(owner.current))
		return FALSE
	/// Did I reach Final Death?
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.current.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	return !bloodsuckerdatum.AmFinalDeath

//////////////////////////////////////////////////////////////////////////////////////

/// Vassalize someone in charge (Head of Staff + QM)
/// LOOKUP: /datum/crewmonitor/proc/update_data(z) for .assignment to see how to get a person's PDA.
/datum/objective/bloodsucker/protege
	name = "vassalization"

	var/list/heads = list(
		"Captain",
		"Head of Personnel",
		"Head of Security",
		"Research Director",
		"Chief Engineer",
		"Chief Medical Officer",
		"Quartermaster",
	)
	var/list/departs = list(
		"Head of Security",
		"Head of Personnel",
		"Research Director",
		"Chief Engineer",
		"Chief Medical Officer",
	)

	var/target_role	// Equals "HEAD" when it's not a department role.
	var/department_string

// GENERATE!
/datum/objective/bloodsucker/protege/New()
	// Choose between Command and a Department
	switch(rand(0,2))
		if(0) // Command
			target_amount = 1
			target_role = "HEAD"
		else // Department
			target_amount = rand(2,3)
			target_role = pick(departs)
			switch(target_role)
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
	..()

// EXPLANATION
/datum/objective/bloodsucker/protege/update_explanation_text()
	if(target_role == "HEAD")
		explanation_text = "Guarantee a Vassal ends up as a Department Head or in a Leadership role."
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
		valid_jobs = heads
	else
		valid_jobs = list()
		var/list/alljobs = subtypesof(/datum/job) // This is just a list of TYPES, not the actual variables!
		for(var/T in alljobs)
			var/datum/job/J = SSjob.GetJobType(T)
			if(!istype(J))
				continue
			// Found a job whose Dept Head matches either list of heads, or this job IS the head. We exclude the QM from this, HoP handles Cargo.
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
			//to_chat(owner, span_userdanger("PROTEGE OBJECTIVE: (MIND ROLE)"))
			thisRole = V.owner.assigned_role
		// Mob Assigned
		else if((V.owner.current.job in valid_jobs) && !(V.owner.current.job in counted_roles))
			//to_chat(owner, span_userdanger("PROTEGE OBJECTIVE: (MOB JOB)"))
			thisRole = V.owner.current.job
		// PDA Assigned
		else if(V.owner.current && ishuman(V.owner.current))
			var/mob/living/carbon/human/H = V.owner.current
			var/obj/item/card/id/I =  H.wear_id ? H.wear_id.GetID() : null
			if(I && (I.assignment in valid_jobs) && !(I.assignment in counted_roles))
				//to_chat(owner, span_userdanger("PROTEGE OBJECTIVE: (GET ID)"))
				thisRole = I.assignment

		// NO MATCH
		if(thisRole == "none")
			continue

		// SUCCESS!
		objcount++
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

/// NOTE: Look up /steal in objective.dm for inspiration.
/// Steal hearts. You just really wanna have some hearts.
/datum/objective/bloodsucker/heartthief
	name = "heartthief"

// GENERATE!
/datum/objective/bloodsucker/heartthief/New()
	target_amount = rand(2,3)
	..()

// EXPLANATION
/datum/objective/bloodsucker/heartthief/update_explanation_text()
	. = ..()
	explanation_text = "Steal and keep [target_amount] organic heart\s."

// WIN CONDITIONS?
/datum/objective/bloodsucker/heartthief/check_completion()
	if(!owner.current)
		return FALSE
	var/list/all_items = owner.current.GetAllContents()
	var/itemcount = FALSE
	for(var/obj/I in all_items)
		if(istype(I, /obj/item/organ/heart/))
			var/obj/item/organ/heart/heart_item = I
			if(!(heart_item.organ_flags & ORGAN_SYNTHETIC)) // No robo-hearts allowed
				itemcount++
			if(itemcount >= target_amount)
				return TRUE

	return FALSE

//////////////////////////////////////////////////////////////////////////////////////

///Eat blood from a lot of people
/datum/objective/bloodsucker/gourmand
	name = "gourmand"

// GENERATE!
/datum/objective/bloodsucker/gourmand/New()
	target_amount = rand(450,650)
	..()

// EXPLANATION
/datum/objective/bloodsucker/gourmand/update_explanation_text()
	. = ..()
	explanation_text = "Using your Feed ability, drink [target_amount] units of Blood."

// WIN CONDITIONS?
/datum/objective/bloodsucker/gourmand/check_completion()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.current.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(!bloodsuckerdatum)
		return FALSE
	var/stolen_blood = bloodsuckerdatum.total_blood_drank
	if(stolen_blood >= target_amount)
		return TRUE
	return FALSE

// HOW: Track each feed (if human). Count victory.



//////////////////////////////
//     CLAN OBJECTIVES      //
//////////////////////////////

/// Drink certain amount of Blood while in a Frenzy - Brujah Clan Objective
/datum/objective/bloodsucker/gourmand/brujah
	name = "brujah gourmand"
//	NOTE: This is a copy paste from default Gourmand objective.

// EXPLANATION
/datum/objective/bloodsucker/gourmand/brujah/update_explanation_text()
	. = ..()
	explanation_text = "While in a Frenzy, using your Feed ability, drink [target_amount] units of Blood."

// WIN CONDITIONS?
/datum/objective/bloodsucker/gourmand/brujah/check_completion()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.current.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(!bloodsuckerdatum)
		return FALSE
	var/stolen_blood = bloodsuckerdatum.frenzy_blood_drank
	if(stolen_blood >= target_amount)
		return TRUE
	return FALSE

//////////////////////////////////////////////////////////////////////////////////////

/// Steal the Archive of the Kindred - Nosferatu Clan objective
/datum/objective/bloodsucker/kindred
	name = "steal kindred"

// EXPLANATION
/datum/objective/bloodsucker/kindred/update_explanation_text()
	. = ..()
	explanation_text = "Ensure Tremere steals and keeps control over the Archive of the Kindred."

// WIN CONDITIONS?
/datum/objective/bloodsucker/kindred/check_completion()
	if(!owner.current)
		return FALSE
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.current.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(!bloodsuckerdatum)
		return FALSE

	for(var/datum/mind/M in bloodsuckerdatum.clan?.members)
		var/datum/antagonist/bloodsucker/allsuckers = M.has_antag_datum(/datum/antagonist/bloodsucker)
		if(allsuckers.my_clan != CLAN_TREMERE)
			continue
		if(!isliving(M.current))
			continue
		var/list/all_items = allsuckers.owner.current.GetAllContents()
		for(var/obj/I in all_items)
			if(istype(I, /obj/item/book/kindred))
				return TRUE
	return FALSE

//////////////////////////////////////////////////////////////////////////////////////

/// Max out a Tremere Power - Tremere Clan objective
/datum/objective/bloodsucker/tremere_power
	name = "tremerepower"

// EXPLANATION
/datum/objective/bloodsucker/tremere_power/update_explanation_text()
	explanation_text = "Upgrade a Blood Magic power to the maximum level, remember that Vassalizing gives more Ranks!"

// WIN CONDITIONS?
/datum/objective/bloodsucker/tremere_power/check_completion()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.has_antag_datum(/datum/antagonist/bloodsucker)
	for(var/datum/action/bloodsucker/targeted/tremere/tremere_powers in bloodsuckerdatum.powers)
		if(tremere_powers.tremere_level >= 5)
			return TRUE
	return FALSE

//////////////////////////////////////////////////////////////////////////////////////

/// Convert a crewmate - Ventrue Clan objective
/datum/objective/bloodsucker/embrace
	name = "embrace"

// EXPLANATION
/datum/objective/bloodsucker/embrace/update_explanation_text()
	. = ..()
	explanation_text = "Use the Candelabrum to Rank your Favorite Vassal up enough to become a Bloodsucker."

// WIN CONDITIONS?
/datum/objective/bloodsucker/embrace/check_completion()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.current.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(!bloodsuckerdatum || bloodsuckerdatum.my_clan != CLAN_VENTRUE)
		return FALSE
	for(var/datum/antagonist/vassal/vassaldatum in bloodsuckerdatum.vassals)
		if(vassaldatum.owner && vassaldatum.favorite_vassal)
			if(vassaldatum.owner.has_antag_datum(/datum/antagonist/bloodsucker))
				return TRUE
	return FALSE



//////////////////////////////
// MONSTERHUNTER OBJECTIVES //
//////////////////////////////

/datum/objective/bloodsucker/monsterhunter
	name = "destroymonsters"

// EXPLANATION
/datum/objective/bloodsucker/monsterhunter/update_explanation_text()
	. = ..()
	explanation_text = "Destroy all monsters on [station_name()]."

// WIN CONDITIONS?
/datum/objective/bloodsucker/monsterhunter/check_completion()
	var/list/datum/mind/monsters = list()
	for(var/mob/living/players in GLOB.alive_mob_list)
		if(IS_HERETIC(players) || IS_CULTIST(players) || IS_BLOODSUCKER(players) || IS_WIZARD(players))
			monsters += players
		if(players?.mind?.has_antag_datum(/datum/antagonist/changeling))
			monsters += players
		if(players?.mind?.has_antag_datum(/datum/antagonist/wizard/apprentice))
			monsters += players
	for(var/datum/mind/M in monsters)
		if(M && M != owner && M.current.stat != DEAD)
			return FALSE
	return TRUE



//////////////////////////////
//     VASSAL OBJECTIVES    //
//////////////////////////////

/datum/objective/bloodsucker/vassal

// EXPLANATION
/datum/objective/bloodsucker/vassal/update_explanation_text()
	. = ..()
	explanation_text = "Guarantee the success of your Master's mission!"

// WIN CONDITIONS?
/datum/objective/bloodsucker/vassal/check_completion()
	var/datum/antagonist/vassal/antag_datum = owner.has_antag_datum(/datum/antagonist/vassal)
	return antag_datum.master?.owner?.current?.stat != DEAD



//////////////////////////////
//    REMOVED OBJECTIVES    //
//////////////////////////////

/// Defile a facility with blood
/datum/objective/bloodsucker/desecrate

	// Space_Station_13_areas.dm  <--- all the areas

//////////////////////////////////////////////////////////////////////////////////////

/// Destroy the Solar Arrays
/datum/objective/bloodsucker/solars
/* // TG Updates broke this, it needs maintaining.
// Space_Station_13_areas.dm  <--- all the areas
/datum/objective/bloodsucker/solars/update_explanation_text()
	. = ..()
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

// NOTE: Look up /assassinate in objective.dm for inspiration.
/// Vassalize a target.
/datum/objective/bloodsucker/vassalhim
	name = "vassalhim"
	var/target_role_type = FALSE

/datum/objective/bloodsucker/vassalhim/New()
	var/list/possible_targets = return_possible_targets()
	find_target(possible_targets)
	..()

// EXPLANATION
/datum/objective/bloodsucker/vassalhim/update_explanation_text()
	. = ..()
	if(target?.current)
		explanation_text = "Ensure [target.name], the [!target_role_type ? target.assigned_role.title : target.special_role], is Vassalized via the Persuasion Rack."
	else
		explanation_text = "Free Objective"

/datum/objective/bloodsucker/vassalhim/admin_edit(mob/admin)
	admin_simple_target_pick(admin)

// WIN CONDITIONS?
/datum/objective/bloodsucker/vassalhim/check_completion()
	if(!target || target.has_antag_datum(/datum/antagonist/vassal))
		return TRUE
	return FALSE

/// Enter Frenzy repeatedly
/datum/objective/bloodsucker/frenzy
	name = "frenzy"

/datum/objective/bloodsucker/frenzy/New()
	target_amount = rand(3,4)
	..()

/datum/objective/bloodsucker/frenzy/update_explanation_text()
	. = ..()
	explanation_text = "Enter Frenzy [target_amount] of times without succumbing to Final Death."

/datum/objective/bloodsucker/frenzy/check_completion()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.current.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(!bloodsuckerdatum)
		return FALSE
	if(bloodsuckerdatum.Frenzies >= target_amount)
		return TRUE
	return FALSE

//////////////////////////////////////////////////////////////////////////////////////

/// Mutilate a certain amount of Vassals
/*
/datum/objective/bloodsucker/vassal_mutilation
	name = "steal kindred"
/datum/objective/bloodsucker/vassal_mutilation/New()
	target_amount = rand(2,3)
	..()

// EXPLANATION
/datum/objective/bloodsucker/vassal_mutilation/update_explanation_text()
	. = ..()
	explanation_text = "Mutate [target_amount] of Vassals into vile sevant creatures."

// WIN CONDITIONS?
/datum/objective/bloodsucker/vassal_mutilation/check_completion()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.current.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(bloodsuckerdatum.vassals_mutated >= target_amount)
		return TRUE
	return FALSE
*/
