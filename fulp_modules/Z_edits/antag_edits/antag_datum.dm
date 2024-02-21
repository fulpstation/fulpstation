// Removing self-assigning objectives until we have a policy on that
/datum/antagonist/New()
	..()
	can_assign_self_objectives = FALSE

