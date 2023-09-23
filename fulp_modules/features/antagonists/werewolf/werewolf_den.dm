/// Returns TRUE if the werewolf can make their den here
// TODO: inform the user of why it's invalid
/datum/antagonist/werewolf/proc/is_valid_den_area(area/potential_den)
	if(potential_den.outdoors)
		to_chat(owner.current, span_warning("You can't make your den outside!"))
		return FALSE
	var/datum/antagonist/werewolf/ww_datum = is_werewolf_den(potential_den)
	if(ww_datum)
		if(ww_datum == src)
			to_chat(owner.current, span_warning("You've already claimed this area as your den!"))
			return FALSE
		to_chat(owner.current, span_warning("This area has been claimed by another werewolf!"))
		return FALSE
	return TRUE

/datum/antagonist/werewolf/proc/claim_area_as_den(area/potential_den)
	if(!is_valid_den_area(potential_den))
		return FALSE

	// Create the new den area
	werewolf_den_area = potential_den

