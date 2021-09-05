/datum/dynamic_ruleset/midround/monster_hunter
	name = "Monster Hunter Wakeup"
	antag_datum = /datum/antagonist/monsterhunter
	antag_flag = ROLE_MONSTERHUNTER
	restricted_roles = list("Cyborg", "AI", "Positronic Brain")
	enemy_roles = list("Captain", "Head of Security", "Security Officer")
	protected_roles = list(
		"Captain", "Head of Personnel", "Head of Security", "Research Director", "Chief Engineer", "Chief Medical Officer",
		"Warden", "Security Officer", "Detective", "Brig Physician", "Deputy",
		"Deputy", "Deputy (Supply)", "Deputy (Engineering)", "Deputy (Medical)", "Deputy (Science)", "Deputy (Service)",
	)
	required_enemies = list(2,2,1,1,1,1,1,0,0,0)
	required_candidates = 1
	weight = 3
	cost = 15
	requirements = list(101,101,101,80,60,50,30,20,10,10)
	repeatable = FALSE

/datum/dynamic_ruleset/midround/monster_hunter/trim_candidates()
	..()
	candidates = living_players
	for(var/mob/living/carbon/human/candidate in candidates)
		if(!candidate.getorgan(/obj/item/organ/brain) \
			|| IS_MONSTERHUNTER(candidate) \
			|| !(ROLE_MONSTERHUNTER in candidate.client?.prefs?.be_special) \
			|| !(candidate.mind.assigned_role.job_flags & JOB_CREW_MEMBER) \
			|| (candidate.mind.assigned_role.departments_bitflags & (DEPARTMENT_BITFLAG_SECURITY|DEPARTMENT_BITFLAG_COMMAND)) \
			|| candidate.stat >= HARD_CRIT \
		)
			candidates -= candidate

/datum/dynamic_ruleset/midround/monster_hunter/execute()
	if(!candidates || !candidates.len)
		return FALSE
	var/mob/living/carbon/human/H = pick_n_take(candidates)
	H.mind.add_antag_datum(/datum/antagonist/monsterhunter)
	message_admins("[ADMIN_LOOKUPFLW(H)] MONSTERHUNTER NOTICE: [H] has awoken as a Monster Hunter.")
	log_game("[key_name(H)] was made Monster Hunter by the midround ruleset.")
	return ..()
