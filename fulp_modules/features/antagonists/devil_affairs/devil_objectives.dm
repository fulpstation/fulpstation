/datum/objective/assassinate/internal
	///Have we already eliminated this target?
	var/stolen = FALSE

/datum/objective/assassinate/internal/update_explanation_text()
	..()
	if(target && target.current)
		explanation_text = "Assassinate [target.name], the [!target_role_type ? target.assigned_role.title : target.special_role]."
	else
		explanation_text = "Assassinate [target.name], who has been obliterated."
