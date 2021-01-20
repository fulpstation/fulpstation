/datum/objective/escape/escape_with_identity/is_valid_target(possible_target)
	var/list/datum/mind/owners = get_owners()
	for(var/datum/mind/M in owners)
		if(!M)
			continue
		var/datum/antagonist/changeling/changeling = M.has_antag_datum(/datum/antagonist/changeling)
		if(!changeling)
			continue
		var/datum/mind/T = possible_target
		if(!istype(T) || isIPC(T.current))
			return FALSE
	return TRUE
