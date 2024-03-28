/datum/dimension_theme/meat/fool_heretic

/datum/dimension_theme/meat/fool_heretic/replace_object(obj/object)
	//transforming everything was causing some trouble so this is the cheap solution
	if (istype(object, /obj/structure/window))
		transform_window(object)
		return
