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
		"Captain", "Head of Personnel", "Head of Security",
		// Security
		"Warden", "Security Officer", "Detective", "Brig Physician",
		// Deputies
		"Deputy", "Deputy (Supply)", "Deputy (Engineering)", "Deputy (Medical)", "Deputy (Science)", "Deputy (Service)",
		// Curator
		"Curator",
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
		var/mob/M = pick_n_take(candidates)
		assigned += M.mind
		M.mind.restricted_roles = restricted_roles
		M.mind.special_role = ROLE_BLOODSUCKER
		GLOB.pre_setup_antags += M.mind
	return TRUE

/datum/dynamic_ruleset/roundstart/bloodsucker/execute()
	for(var/M in assigned)
		var/datum/mind/bloodsuckermind = M
		if(!bloodsuckermind.make_bloodsucker(M))
			assigned -= M
		GLOB.pre_setup_antags -= bloodsuckermind
	return TRUE

//////////////////////////////////////////////
//                                          //
//          MIDROUND BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/bloodsucker
	name = "Vampiric Accident"
	antag_datum = /datum/antagonist/bloodsucker
	antag_flag = ROLE_BLOODSUCKER
	protected_roles = list(
		"Captain", "Head of Personnel", "Head of Security",
		"Warden", "Security Officer", "Detective", "Brig Physician", "Deputy",
		"Deputy", "Deputy (Supply)", "Deputy (Engineering)", "Deputy (Medical)", "Deputy (Science)", "Deputy (Service)",
		"Curator",
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
	var/mob/M = pick(living_players)
	assigned += M
	living_players -= M
	var/datum/mind/bloodsuckermind = M
	var/datum/antagonist/bloodsucker/sucker = new
	if(!bloodsuckermind.make_bloodsucker(M))
		assigned -= M
		message_admins("[ADMIN_LOOKUPFLW(M)] was selected by the [name] ruleset, but couldn't be made into a Bloodsucker.")
		return FALSE
	sucker.bloodsucker_level_unspent = rand(2,3)
	message_admins("[ADMIN_LOOKUPFLW(M)] was selected by the [name] ruleset and has been made into a midround Bloodsucker.")
	log_game("DYNAMIC: [key_name(M)] was selected by the [name] ruleset and has been made into a midround Bloodsucker.")
	return TRUE

//////////////////////////////////////////////
//                                          //
//          LATEJOIN BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/latejoin/bloodsucker
	name = "Bloodsucker Breakout"
	antag_datum = /datum/antagonist/bloodsucker
	antag_flag = ROLE_BLOODSUCKER
	protected_roles = list(
		"Captain", "Head of Personnel", "Head of Security",
		"Warden", "Security Officer", "Detective", "Brig Physician", "Deputy",
		"Deputy", "Deputy (Supply)", "Deputy (Engineering)", "Deputy (Medical)", "Deputy (Science)", "Deputy (Service)",
		"Curator",
	)
	restricted_roles = list("AI","Cyborg")
	required_candidates = 1
	weight = 5
	cost = 10
	requirements = list(10,10,10,10,10,10,10,10,10,10)
	repeatable = FALSE

/datum/dynamic_ruleset/latejoin/bloodsucker/execute()
	var/mob/M = pick(candidates) // This should contain a single player, but in case.
	assigned += M.mind

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

/datum/mind/proc/can_make_bloodsucker(datum/mind/bloodsucker, datum/mind/creator)
	// Species Must have a HEART (Sorry Plasmamen)
	var/mob/living/carbon/human/H = bloodsucker.current
	if(!(H.dna?.species) || !(H.mob_biotypes & MOB_ORGANIC))
		if(creator)
			to_chat(creator, span_danger("[bloodsucker]'s DNA isn't compatible!"))
		return FALSE
	// Check for Fledgeling
	if(creator)
		// Check if their Creator is Malkavian trying to turn a Beefman into one.
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = creator.has_antag_datum(/datum/antagonist/bloodsucker)
		if(bloodsuckerdatum?.my_clan == CLAN_MALKAVIAN)
			if(isbeefman(bloodsucker.current))
				return FALSE
		message_admins("[bloodsucker] has become a Bloodsucker, and was created by [creator].")
		log_admin("[bloodsucker] has become a Bloodsucker, and was created by [creator].")
	return TRUE

/datum/mind/proc/make_bloodsucker(datum/mind/bloodsucker, datum/mind/creator)
	if(!can_make_bloodsucker(bloodsucker))
		return FALSE
	add_antag_datum(/datum/antagonist/bloodsucker)
	return TRUE

/datum/mind/proc/remove_bloodsucker()
	var/datum/antagonist/bloodsucker/C = has_antag_datum(/datum/antagonist/bloodsucker)
	if(C)
		remove_antag_datum(/datum/antagonist/bloodsucker)
		special_role = null

/datum/antagonist/bloodsucker/proc/can_make_vassal(mob/living/target, datum/mind/creator, display_warning = TRUE)//, check_antag_or_loyal=FALSE)
	// Not Correct Type: Abort
	if(!iscarbon(target) || !creator)
		return FALSE
	if(target.stat > UNCONSCIOUS)
		return FALSE
	// No Mind!
	if(!target.mind)
		if(display_warning)
			to_chat(creator, span_danger("[target] isn't self-aware enough to be made into a Vassal."))
		return FALSE
	// Already MY Vassal
	var/datum/antagonist/vassal/V = target.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(istype(V) && V.master)
		if(V.master.owner == creator)
			if(display_warning)
				to_chat(creator, span_danger("[target] is already your loyal Vassal!"))
		else
			if(display_warning)
				to_chat(creator, span_danger("[target] is the loyal Vassal of another Bloodsucker!"))
		return FALSE
	// Already Antag or Loyal (Vamp Hunters count as antags)
	if(target.mind.enslaved_to || AmInvalidAntag(target)) //!VassalCheckAntagValid(target.mind, check_antag_or_loyal)) // HAS_TRAIT(target, TRAIT_MINDSHIELD, "implant") ||
		if(display_warning)
			to_chat(creator, span_danger("[target] resists the power of your blood to dominate their mind!"))
		return FALSE
	return TRUE

/datum/antagonist/bloodsucker/proc/AmValidAntag(mob/M)
	/// Check if they are an antag, if so, check if they're Invalid.
	if(M.mind?.special_role || !isnull(M.mind?.antag_datums))
		return !AmInvalidAntag(M)
	/// Otherwise, just cancel out.
	return FALSE

/datum/antagonist/bloodsucker/proc/AmInvalidAntag(mob/M)
	/// Not an antag?
	if(!is_special_character(M))
		return FALSE
	/// Checks if the person is an antag banned from being vassalized, stored in bloodsucker's datum.
	for(var/datum/antagonist/antag_datum in M.mind.antag_datums)
		if(antag_datum.type in vassal_banned_antags)
			//message_admins("DEBUG VASSAL: Found Invalid: [antag_datum] // [antag_datum.type]")
			return TRUE
	//message_admins("DEBUG VASSAL: Valid Antags! (total of [M.antag_datums.len])")
	// WHEN YOU DELETE THE ABOVE: Remove the 3 second timer on converting the vassal too.
	return FALSE

/datum/antagonist/bloodsucker/proc/attempt_turn_vassal(mob/living/carbon/C)
	C.silent = 0
	return make_vassal(C, owner)

/datum/antagonist/bloodsucker/proc/make_vassal(mob/living/target, datum/mind/creator)
	if(!can_make_vassal(target, creator))
		return FALSE
	// Make Vassal
	var/datum/antagonist/vassal/V = new(target.mind)
	var/datum/antagonist/bloodsucker/B = creator.has_antag_datum(/datum/antagonist/bloodsucker)
	V.master = B
	target.mind.add_antag_datum(V, V.master.get_team())
	// Update Bloodsucker Title
	B.SelectTitle(am_fledgling = FALSE) // Only works if you have no title yet.
	// Log it
	message_admins("[target] has become a Vassal, and is enslaved to [creator].")
	log_admin("[target] has become a Vassal, and is enslaved to [creator].")
	return TRUE
