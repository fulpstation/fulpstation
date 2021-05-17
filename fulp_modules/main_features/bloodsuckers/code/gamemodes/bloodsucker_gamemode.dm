//////////////////////////////////////////////
//                                          //
//        ROUNDSTART BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/bloodsucker
	name = "Bloodsuckers"
	antag_flag = ROLE_BLOODSUCKER
	antag_datum = /datum/antagonist/bloodsucker
	protected_roles = list("Captain", "Head of Personnel", "Head of Security", "Research Director", "Chief Engineer", "Chief Medical Officer", "Quartermaster", "Warden", "Security Officer", "Detective", "Brig Physician", "Deputy",)
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
		var/mob/picked_candidate = pick_n_take(candidates)
		assigned += picked_candidate.mind
		picked_candidate.mind.restricted_roles = restricted_roles
		picked_candidate.mind.special_role = ROLE_BLOODSUCKER
		GLOB.pre_setup_antags += picked_candidate.mind
	return TRUE

/datum/dynamic_ruleset/roundstart/bloodsucker/execute()
	for(var/c in assigned)
		var/datum/mind/bloodsucker = c
		var/datum/antagonist/bloodsucker/new_antag = new antag_datum()
		bloodsucker.add_antag_datum(new_antag)
		GLOB.pre_setup_antags -= bloodsucker
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
	protected_roles = list("Captain", "Head of Personnel", "Head of Security", "Research Director", "Chief Engineer", "Chief Medical Officer", "Quartermaster", "Warden", "Security Officer", "Detective", "Brig Physician", "Deputy",)
	restricted_roles = list("AI","Cyborg", "Positronic Brain")
	required_candidates = 1
	weight = 5
	cost = 10
	requirements = list(40,30,20,10,10,10,10,10,10,10)
	/// We should preferably not just have several Bloodsucker midrounds, as they are nerfed hard due to missing Sols.
	repeatable = FALSE

/datum/dynamic_ruleset/midround/autotraitor/acceptable(population = 0, threat = 0)
	var/player_count = mode.current_players[CURRENT_LIVING_PLAYERS].len
	var/antag_count = mode.current_players[CURRENT_LIVING_ANTAGS].len
	var/max_suckers = round(player_count / 10) + 1
	var/too_little_antags = antag_count < max_suckers
	if (!too_little_antags)
		log_game("DYNAMIC: Too many living antags compared to living players ([antag_count] living antags, [player_count] living players, [max_suckers] max bloodsuckers)")
		return FALSE

	if (!prob(mode.threat_level))
		log_game("DYNAMIC: Random chance to roll autotraitor failed, it was a [mode.threat_level]% chance.")
		return FALSE

	return ..()

/datum/dynamic_ruleset/midround/autotraitor/trim_candidates()
	..()
	for(var/mob/living/player in living_players)
		if(issilicon(player)) // Your assigned role doesn't change when you are turned into a silicon.
			living_players -= player
		else if(is_centcom_level(player.z))
			living_players -= player // We don't allow people in CentCom
		else if(player.mind && (player.mind.special_role || player.mind.antag_datums?.len > 0))
			living_players -= player // We don't allow people with roles already

/datum/dynamic_ruleset/midround/autotraitor/ready(forced = FALSE)
	if (required_candidates > living_players.len)
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/autotraitor/execute()
	var/mob/M = pick(living_players)
	assigned += M
	living_players -= M
	var/datum/antagonist/bloodsucker/Sucker = new
	M.mind.add_antag_datum(Sucker)
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
	protected_roles = list("Captain", "Head of Personnel", "Head of Security", "Research Director", "Chief Engineer", "Chief Medical Officer", "Quartermaster", "Warden", "Security Officer", "Detective", "Brig Physician", "Deputy",)
	restricted_roles = list("AI","Cyborg")
	required_candidates = 1
	weight = 5
	cost = 10
	requirements = list(10,10,10,10,10,10,10,10,10,10)
	/// We should preferably not just have several Bloodsucker midrounds, as they are nerfed hard due to missing Sols.
	repeatable = FALSE

//////////////////////////////////////////////////////////////////////////////

/*
 *	# Assigning Bloodsucker status
 *
 *	Here we assign the Bloodsuckers themselves, ensuring they arent Plasmamen
 *	Also deals with Vassalization status.
 */

/datum/mind/proc/make_bloodsucker(datum/mind/bloodsucker, datum/mind/creator = null)
	var/datum/antagonist/bloodsucker/A = has_antag_datum(/datum/antagonist/bloodsucker)
	if(!A)
		to_chat(creator, "<span class='danger'>[bloodsucker] is already a Bloodsucker.</span>")
		return FALSE
	// Species Must have a HEART (Sorry Plasmamen)
	var/mob/living/carbon/human/H = bloodsucker.current
	if(!(H.dna?.species) || !(H.mob_biotypes & MOB_ORGANIC))
		to_chat(creator, "<span class='danger'>[bloodsucker]'s DNA isn't compatible!</span>")
		return FALSE
	// Create Datum: Fledgling
	// [FLEDGLING]
	if(creator)
		A = add_antag_datum(/datum/antagonist/bloodsucker)
		special_role = ROLE_BLOODSUCKER
		message_admins("[bloodsucker] has become a Bloodsucker, and was created by [creator].")
		log_admin("[bloodsucker] has become a Bloodsucker, and was created by [creator].")
	// [MASTER]
	else
		A = add_antag_datum(/datum/antagonist/bloodsucker)
		special_role = ROLE_BLOODSUCKER
	return A

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
			to_chat(creator, "<span class='danger'>[target] isn't self-aware enough to be made into a Vassal.</span>")
		return FALSE
	// Already MY Vassal
	var/datum/antagonist/vassal/V = target.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(istype(V) && V.master)
		if(V.master.owner == creator)
			if(display_warning)
				to_chat(creator, "<span class='danger'>[target] is already your loyal Vassal!</span>")
		else
			if(display_warning)
				to_chat(creator, "<span class='danger'>[target] is the loyal Vassal of another Bloodsucker!</span>")
		return FALSE
	// Already Antag or Loyal (Vamp Hunters count as antags)
	if(target.mind.enslaved_to || AmInvalidAntag(target.mind)) //!VassalCheckAntagValid(target.mind, check_antag_or_loyal)) // HAS_TRAIT(target, TRAIT_MINDSHIELD, "implant") ||
		if(display_warning)
			to_chat(creator, "<span class='danger'>[target] resists the power of your blood to dominate their mind!</span>")
		return FALSE
	return TRUE

/datum/antagonist/bloodsucker/proc/AmValidAntag(datum/mind/M)
	// No List?
	if(!islist(M.antag_datums) || M.antag_datums.len == 0)
		return FALSE
	// Am I NOT an invalid Antag? NOTE: We already excluded non-antags above. Don't worry about the "No List?" check in AmInvalidIntag()
	return !AmInvalidAntag(M)

/datum/antagonist/bloodsucker/proc/AmInvalidAntag(datum/mind/M)
	// No List?
	if(!islist(M.antag_datums) || M.antag_datums.len == 0)
		return FALSE
	// Does even ONE antag appear in this mind that isn't in the list? Then FAIL!
	for(var/datum/antagonist/antag_datum in M.antag_datums)
		if(!(antag_datum.type in vassal_allowed_antags))  // vassal_allowed_antags is a list stored in Bloodsucker's datum, above.
			//message_admins("DEBUG VASSAL: Found Invalid: [antag_datum] // [antag_datum.type]")
			return TRUE
	//message_admins("DEBUG VASSAL: Valid Antags! (total of [M.antag_datums.len])")
	// WHEN YOU DELETE THE ABOVE: Remove the 3 second timer on converting the vassal too.
	return FALSE

/datum/antagonist/bloodsucker/proc/attempt_turn_vassal(mob/living/carbon/C)
	C.silent = 0
	return make_vassal(C,owner)

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
