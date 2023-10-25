/world/AVerbsDefault()
	var/list/verbs = ..()
	verbs.Add(
		/client/proc/reload_mentors,
	)
	return list
