///List of antagonists that are considered 'Monsters' and their chance of being selected.
GLOBAL_LIST_INIT(monster_antagonist_types, list(
	/datum/antagonist/bloodsucker = 50,
	/datum/antagonist/heretic = 50,
	/datum/antagonist/changeling = 20,
))

#define MINIMUM_MONSTERS_REQUIRED 3

//gives monsterhunters an icon in the antag selection panel
/datum/dynamic_ruleset/midround/monsterhunter
	name = "Monster Hunter"
	antag_datum = /datum/antagonist/monsterhunter
	midround_ruleset_style = MIDROUND_RULESET_STYLE_HEAVY
	antag_flag = ROLE_MONSTERHUNTER
	weight = 5
	cost = 15
	protected_roles = list(
		JOB_CAPTAIN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_PRISONER,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_HEAD_OF_PERSONNEL,
		JOB_QUARTERMASTER,
		JOB_RESEARCH_DIRECTOR
	)
	restricted_roles = list(
		JOB_AI,
		JOB_CYBORG,
		ROLE_POSITRONIC_BRAIN,
	)
	required_candidates = 1
	requirements = list(10,10,10,10,10,10,10,10,10,10)


/datum/dynamic_ruleset/midround/monsterhunter/trim_candidates()
	..()
	for(var/mob/living/player in living_players)
		if(issilicon(player))
			living_players -= player
		if(is_centcom_level(player.z))
			living_players -= player
		if((player.mind?.special_role || player.mind?.antag_datums?.len))
			living_players -= player

/datum/dynamic_ruleset/midround/monsterhunter/proc/generate_monster()
	var/mob/living/monster = pick(living_players)
	if(!monster)
		return FALSE
	var/datum/antagonist/antag_type = pick_weight(GLOB.monster_antagonist_types)

	//gets the antag type without initializing it
	var/list/profession = GLOB.antag_prototypes[initial(antag_type.antagpanel_category)]
	var/datum/antagonist/specific = profession[1]

	if(!specific.enabled_in_preferences(monster.mind))
		return FALSE
	if(!monster.mind.add_antag_datum(antag_type))
		return FALSE
	assigned += monster
	living_players -= monster
	message_admins("[ADMIN_LOOKUPFLW(monster)] was selected by the [name] ruleset and has been made into a Monster.")
	log_game("DYNAMIC: [key_name(monster)] was selected by the [name] ruleset and has been made into a Monster.")
	return TRUE

/datum/dynamic_ruleset/midround/monsterhunter/ready(forced = FALSE)
	if(required_candidates > living_players.len)
		return FALSE
	//check if the list is empty
	if(!GLOB.antag_prototypes)
		GLOB.antag_prototypes = list()
		for(var/antag_type in subtypesof(/datum/antagonist))
			var/datum/antagonist/A = new antag_type
			var/cat_id = A.antagpanel_category
			if(!GLOB.antag_prototypes[cat_id])
				GLOB.antag_prototypes[cat_id] = list(A)
			else
				GLOB.antag_prototypes[cat_id] += A

	var/count = 0
	for(var/datum/antagonist/monster as anything in GLOB.antagonists)
		if(!monster.owner)
			continue
		if(GLOB.monster_antagonist_types.Find(monster.type))
			count++

	if((MINIMUM_MONSTERS_REQUIRED - count) + 1 > living_players.len)
		return FALSE
	//don't continue endlessly if you just can't do it, otherwise you'll freeze/crash the whole game.
	var/attempts
	while(count < MINIMUM_MONSTERS_REQUIRED && (attempts < 5))
		if(!generate_monster())
			attempts++
		else
			count++

	return ..()

/datum/dynamic_ruleset/midround/monsterhunter/execute()
	var/mob/player = pick(living_players)
	assigned += player
	living_players -= player
	player.mind.add_antag_datum(/datum/antagonist/monsterhunter)
	message_admins("[ADMIN_LOOKUPFLW(player)] was selected by the [name] ruleset and has been made into a Monsterhunter.")
	log_game("DYNAMIC: [key_name(player)] was selected by the [name] ruleset and has been made into a Monsterhunter.")
	return TRUE

#undef MINIMUM_MONSTERS_REQUIRED
