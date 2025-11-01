//////////////////////////////////////////////
//                                          //
//        ROUNDSTART BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/roundstart/bloodsucker
	name = "Bloodsuckers"
	config_tag = "Roundstart Bloodsuckers"
	pref_flag = ROLE_BLOODSUCKER
	preview_antag_datum = /datum/antagonist/bloodsucker
	blacklisted_roles = list(
		JOB_HEAD_OF_PERSONNEL,
		JOB_RESEARCH_DIRECTOR,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_QUARTERMASTER,
	)
	weight = 5

/datum/dynamic_ruleset/roundstart/bloodsucker/get_always_blacklisted_roles()
	return ..() | JOB_CURATOR

/datum/dynamic_ruleset/roundstart/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	bloodsuckerdatum.bloodsucker_level_unspent = rand(2,3)

//////////////////////////////////////////////
//                                          //
//          MIDROUND BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/from_living/bloodsucker
	name = "Vampiric Accident"
	config_tag = "Midround Bloodsucker"
	preview_antag_datum = /datum/antagonist/bloodsucker
	pref_flag = ROLE_VAMPIRICACCIDENT
	jobban_flag = ROLE_BLOODSUCKER
	ruleset_flags = RULESET_HIGH_IMPACT
	weight = 5
	blacklisted_roles = list(
		JOB_HEAD_OF_PERSONNEL,
		JOB_RESEARCH_DIRECTOR,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_QUARTERMASTER,
	)
	repeatable = FALSE

/datum/dynamic_ruleset/midround/from_living/bloodsucker/is_valid_candidate(mob/candidate, client/candidate_client)
	if(!is_station_level(candidate.z))
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_living/bloodsucker/get_always_blacklisted_roles()
	return ..() | JOB_CURATOR

/datum/dynamic_ruleset/midround/from_living/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	bloodsuckerdatum.bloodsucker_level_unspent = rand(2,3)



//////////////////////////////////////////////
//                                          //
//          LATEJOIN BLOODSUCKER            //
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/latejoin/bloodsucker
	name = "Bloodsucker Breakout"
	config_tag = "Latejoin Bloodsucker"
	preview_antag_datum = /datum/antagonist/bloodsucker
	jobban_flag = ROLE_BLOODSUCKER
	pref_flag = ROLE_BLOODSUCKERBREAKOUT
	blacklisted_roles = list(
		JOB_HEAD_OF_PERSONNEL,
		JOB_RESEARCH_DIRECTOR,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_QUARTERMASTER,
	)
	weight = 5

/datum/dynamic_ruleset/latejoin/bloodsucker/get_always_blacklisted_roles()
	return ..() | JOB_CURATOR

/datum/dynamic_ruleset/latejoin/bloodsucker/assign_role(datum/mind/candidate)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = candidate.add_antag_datum(/datum/antagonist/bloodsucker)
	bloodsuckerdatum.bloodsucker_level_unspent = rand(2,3)
