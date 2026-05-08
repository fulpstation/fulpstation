/// Returns TRUE if the number of "crewmember" minds is lower than 'lowpop_count' (defaults to 20).
/proc/at_lowpop(lowpop_count = 20 as num)
	var/crew_count = length(get_crewmember_minds())
	if(!crew_count)
		return TRUE

	if(crew_count <= lowpop_count)
		return TRUE
	return FALSE
