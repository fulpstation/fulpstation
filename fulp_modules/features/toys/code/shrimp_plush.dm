/datum/mood_event/shrimp_rice
	description = "I can't believe a shrimp fried this rice!"
	mood_change = 3
	timeout = 2 MINUTES

/obj/item/toy/plush/shrimp/Destroy()
	. = ..()
	if(fried_rice)
		UnregisterSignal(fried_rice, COMSIG_FOOD_EATEN)

/obj/item/toy/plush/shrimp/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(proximity_flag && has_fried)
		return

	if(user.mind.assigned_role.title != JOB_COOK)
		return

	if(!istype(target, /obj/item/food))
		return

	var/obj/item/food/target_food = target
	if(!findtext(initial(target.name), "fried rice"))
		return

	RegisterSignal(target_food, COMSIG_FOOD_EATEN, PROC_REF(on_eaten))
	has_fried = TRUE
	fried_rice = target_food
	balloon_alert(user, "fried rice!")


/obj/item/toy/plush/shrimp/proc/on_eaten(atom/source, mob/living/eater, mob/feeder, bitecount, bite_consumption)
	SIGNAL_HANDLER
	if(!istype(eater))
		return

	eater.add_mood_event("shrimp_fried_rice", /datum/mood_event/shrimp_rice)
