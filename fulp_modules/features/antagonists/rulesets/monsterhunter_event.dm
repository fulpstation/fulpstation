///List of antagonists that are considered 'Monsters' and their chance of being selected.
GLOBAL_LIST_INIT(monster_antagonist_types, list(
	/datum/antagonist/bloodsucker,
	/datum/antagonist/heretic,
	/datum/antagonist/changeling,
))

#define MINIMUM_MONSTERS_REQUIRED 2

//gives monsterhunters an icon in the antag selection panel
/datum/dynamic_ruleset/midround/from_living/monsterhunter
	name = "Monster Hunter"
	preview_antag_datum = /datum/antagonist/monsterhunter
	pref_flag = ROLE_MONSTERHUNTER
	weight = 8
	blacklisted_roles = list(
		JOB_HEAD_OF_PERSONNEL,
		JOB_RESEARCH_DIRECTOR,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_QUARTERMASTER,
	)
	repeatable = FALSE

/datum/dynamic_ruleset/midround/from_living/monsterhunter/is_valid_candidate(mob/candidate, client/candidate_client)
	if(!is_station_level(candidate.z) || (length(candidate.mind?.special_roles) || candidate.mind?.antag_datums?.len))
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_living/monsterhunter/assign_role(datum/mind/candidate)
	candidate.add_antag_datum(/datum/antagonist/monsterhunter)

/datum/dynamic_ruleset/midround/from_living/monsterhunter/can_be_selected()
	var/count = 0
	for(var/datum/antagonist/monster as anything in GLOB.antagonists)
		if(!monster.owner)
			continue
		if(!monster.owner.current)
			continue
		if(monster.owner.current.stat == DEAD)
			continue
		if(GLOB.monster_antagonist_types.Find(monster.type))
			count++

	if(MINIMUM_MONSTERS_REQUIRED > count)
		return FALSE

	return ..()

#undef MINIMUM_MONSTERS_REQUIRED
