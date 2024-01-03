// Removes the check for can_assign_self_objectives, since that'll always be FALSE here
/datum/antagonist/heretic/can_ascend()
	for(var/datum/objective/must_be_done as anything in objectives)
		if(!must_be_done.check_completion())
			return FALSE
	return TRUE
