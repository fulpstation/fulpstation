//////////////////////////////////////////////
//                                          //
//        ROUNDSTART BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/bloodsucker
	name = "Bloodsuckers"
	antag_flag = ROLE_BLOODSUCKER
	antag_datum = /datum/antagonist/bloodsucker
	protected_roles = list(
		// Command
		JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_HEAD_OF_SECURITY,
		// Security
		JOB_WARDEN, JOB_SECURITY_OFFICER, JOB_DETECTIVE,
		// Curator
		JOB_CURATOR,
	)
	restricted_roles = list("AI", "Cyborg")
	required_candidates = 1
	weight = 5
	cost = 10
	scaling_cost = 9
	requirements = list(10,10,10,10,10,10,10,10,10,10)
	antag_cap = list("denominator" = 24)

/datum/dynamic_ruleset/roundstart/bloodsucker/pre_execute(population)
	. = ..()
	var/num_bloodsuckers = get_antag_cap(population) * (scaled_times + 1)

	for(var/i = 1 to num_bloodsuckers)
		if(candidates.len <= 0)
			break
		var/mob/selected_mobs = pick_n_take(candidates)
		assigned += selected_mobs.mind
		selected_mobs.mind.restricted_roles = restricted_roles
		selected_mobs.mind.special_role = ROLE_BLOODSUCKER
		GLOB.pre_setup_antags += selected_mobs.mind
	return TRUE

/datum/dynamic_ruleset/roundstart/bloodsucker/execute()
	for(var/assigned_bloodsuckers in assigned)
		var/datum/mind/bloodsuckermind = assigned_bloodsuckers
		if(!bloodsuckermind.make_bloodsucker(assigned_bloodsuckers))
			assigned -= assigned_bloodsuckers
		GLOB.pre_setup_antags -= bloodsuckermind
	return TRUE

//////////////////////////////////////////////
//                                          //
//          MIDROUND BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/bloodsucker
	name = "Vampiric Accident"
	midround_ruleset_style = MIDROUND_RULESET_STYLE_HEAVY
	antag_datum = /datum/antagonist/bloodsucker
	antag_flag = ROLE_VAMPIRICACCIDENT
	antag_flag_override = ROLE_BLOODSUCKER
	protected_roles = list(
		JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_HEAD_OF_SECURITY,
		JOB_WARDEN, JOB_SECURITY_OFFICER, JOB_DETECTIVE,
		JOB_CURATOR,
	)
	restricted_roles = list("AI","Cyborg", "Positronic Brain")
	required_candidates = 1
	weight = 5
	cost = 10
	requirements = list(40,30,20,10,10,10,10,10,10,10)
	repeatable = FALSE

/datum/dynamic_ruleset/midround/bloodsucker/trim_candidates()
	. = ..()
	for(var/mob/living/player in living_players)
		if(issilicon(player)) // Your assigned role doesn't change when you are turned into a silicon.
			living_players -= player
		else if(is_centcom_level(player.z))
			living_players -= player // We don't allow people in CentCom
		else if(player.mind && (player.mind.special_role || player.mind.antag_datums?.len > 0))
			living_players -= player // We don't allow people with roles already

/datum/dynamic_ruleset/midround/bloodsucker/execute()
	var/mob/selected_mobs = pick(living_players)
	assigned += selected_mobs.mind
	living_players -= selected_mobs
	var/datum/mind/bloodsuckermind = selected_mobs.mind
	var/datum/antagonist/bloodsucker/sucker = new
	if(!bloodsuckermind.make_bloodsucker(selected_mobs.mind))
		assigned -= selected_mobs.mind
		message_admins("[ADMIN_LOOKUPFLW(selected_mobs)] was selected by the [name] ruleset, but couldn't be made into a Bloodsucker.")
		return FALSE
	sucker.bloodsucker_level_unspent = rand(2,3)
	message_admins("[ADMIN_LOOKUPFLW(selected_mobs)] was selected by the [name] ruleset and has been made into a midround Bloodsucker.")
	log_game("DYNAMIC: [key_name(selected_mobs)] was selected by the [name] ruleset and has been made into a midround Bloodsucker.")
	return TRUE

//////////////////////////////////////////////
//                                          //
//          LATEJOIN BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/latejoin/bloodsucker
	name = "Bloodsucker Breakout"
	antag_datum = /datum/antagonist/bloodsucker
	antag_flag = ROLE_BLOODSUCKERBREAKOUT
	antag_flag_override = ROLE_BLOODSUCKER
	protected_roles = list(
		JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_HEAD_OF_SECURITY,
		JOB_WARDEN, JOB_SECURITY_OFFICER, JOB_DETECTIVE,
		JOB_CURATOR,
	)
	restricted_roles = list("AI","Cyborg")
	required_candidates = 1
	weight = 5
	cost = 10
	requirements = list(10,10,10,10,10,10,10,10,10,10)
	repeatable = FALSE

/datum/dynamic_ruleset/latejoin/bloodsucker/execute()
	var/mob/latejoiner = pick(candidates) // This should contain a single player, but in case.
	assigned += latejoiner.mind

	for(var/selected_player in assigned)
		var/datum/mind/bloodsuckermind = selected_player
		var/datum/antagonist/bloodsucker/sucker = new
		if(!bloodsuckermind.make_bloodsucker(selected_player))
			assigned -= selected_player
			message_admins("[ADMIN_LOOKUPFLW(selected_player)] was selected by the [name] ruleset, but couldn't be made into a Bloodsucker.")
			return FALSE
		sucker.bloodsucker_level_unspent = rand(2,3)
		message_admins("[ADMIN_LOOKUPFLW(selected_player)] was selected by the [name] ruleset and has been made into a midround Bloodsucker.")
		log_game("DYNAMIC: [key_name(selected_player)] was selected by the [name] ruleset and has been made into a midround Bloodsucker.")
	return TRUE


//////////////////////////////////////////////////////////////////////////////

/*
 *	# Assigning Bloodsucker status
 *
 *	Here we assign the Bloodsuckers themselves, ensuring they arent Plasmamen
 *	Also deals with Vassalization status.
 */

/datum/mind/proc/can_make_bloodsucker(datum/mind/convertee, datum/mind/converter)
	// Species Must have a HEART (Sorry Plasmamen)
	var/mob/living/carbon/human/user = convertee.current
	if(!(user.dna?.species) || !(user.mob_biotypes & MOB_ORGANIC))
		if(converter)
			to_chat(converter, span_danger("[convertee]'s DNA isn't compatible!"))
		return FALSE
	// Check for Fledgeling
	if(converter)
		message_admins("[convertee] has become a Bloodsucker, and was created by [converter].")
		log_admin("[convertee] has become a Bloodsucker, and was created by [converter].")
	return TRUE

/datum/mind/proc/make_bloodsucker(datum/mind/bloodsucker)
	if(!can_make_bloodsucker(bloodsucker))
		return FALSE
	add_antag_datum(/datum/antagonist/bloodsucker)
	return TRUE

/datum/mind/proc/remove_bloodsucker()
	var/datum/antagonist/bloodsucker/removed_bloodsucker = has_antag_datum(/datum/antagonist/bloodsucker)
	if(removed_bloodsucker)
		remove_antag_datum(/datum/antagonist/bloodsucker)
		special_role = null

/datum/antagonist/bloodsucker/proc/can_make_vassal(mob/living/converted, datum/mind/converter, can_vassal_sleeping = FALSE)//, check_antag_or_loyal=FALSE)
	// Not Correct Type: Abort
	if(!iscarbon(converted) || !converter)
		return FALSE
	if(converted.stat > UNCONSCIOUS && !can_vassal_sleeping)
		return FALSE
	// No Mind!
	if(!converted.mind)
		to_chat(converter, span_danger("[converted] isn't self-aware enough to be made into a Vassal."))
		return FALSE
	// Already MY Vassal
	var/datum/antagonist/vassal/vassaldatum = converted.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(istype(vassaldatum) && vassaldatum.master)
		if(vassaldatum.master.owner == converter)
			to_chat(converter, span_danger("[converted] is already your loyal Vassal!"))
		else
			to_chat(converter, span_danger("[converted] is the loyal Vassal of another Bloodsucker!"))
		return FALSE
	// Already Antag or Loyal (Vamp Hunters count as antags)
	if(!isnull(converted.mind.enslaved_to) || AmInvalidAntag(converted))
		to_chat(converter, span_danger("[converted] resists the power of your blood to dominate their mind!"))
		return FALSE
	return TRUE

/datum/antagonist/bloodsucker/proc/AmValidAntag(mob/target)
	/// Check if they are an antag, if so, check if they're Invalid.
	if(target.mind?.special_role || !isnull(target.mind?.antag_datums))
		return !AmInvalidAntag(target)
	/// Otherwise, just cancel out.
	return FALSE

/datum/antagonist/bloodsucker/proc/AmInvalidAntag(mob/target)
	/// Not an antag?
	if(!is_special_character(target))
		return FALSE
	/// Checks if the person is an antag banned from being vassalized, stored in bloodsucker's datum.
	for(var/datum/antagonist/antag_datum in target.mind.antag_datums)
		if(antag_datum.type in vassal_banned_antags)
			//message_admins("DEBUG VASSAL: Found Invalid: [antag_datum] // [antag_datum.type]")
			return TRUE
//	message_admins("DEBUG VASSAL: Valid Antags! (total of [target.antag_datums.len])")
	// WHEN YOU DELETE THE ABOVE: Remove the 3 second timer on converting the vassal too.
	return FALSE

/datum/antagonist/bloodsucker/proc/attempt_turn_vassal(mob/living/carbon/convertee, can_vassal_sleeping = FALSE)
	return make_vassal(convertee, owner, can_vassal_sleeping)

/datum/antagonist/bloodsucker/proc/make_vassal(mob/living/convertee, datum/mind/converter, sleeping = FALSE)
	if(!can_make_vassal(convertee, converter, can_vassal_sleeping = sleeping))
		return FALSE
	// Make Vassal
	var/datum/antagonist/vassal/vassaldatum = new(convertee.mind)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = converter.has_antag_datum(/datum/antagonist/bloodsucker)
	vassaldatum.master = bloodsuckerdatum
	convertee.mind.add_antag_datum(vassaldatum, vassaldatum.master.get_team())
	// Update Bloodsucker Title
	bloodsuckerdatum.SelectTitle(am_fledgling = FALSE) // Only works if you have no title yet.
	// Log it
	message_admins("[convertee] has become a Vassal, and is enslaved to [converter].")
	log_admin("[convertee] has become a Vassal, and is enslaved to [converter].")
	return TRUE
