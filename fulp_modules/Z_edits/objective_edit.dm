//devils can take their loved one's souls and be together forever ever after.
/datum/objective/protect/check_completion()
	if((target.current in GLOB.infernal_affair_manager.stored_humans) && owner.has_antag_datum(/datum/antagonist/devil))
		return TRUE
	return ..()
