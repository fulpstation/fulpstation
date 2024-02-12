/mob/living/carbon/can_defib()
	//You sold your soul, you can't be revived anymore.
	if(HAS_TRAIT(mind, TRAIT_HELLBOUND))
		return DEFIB_FAIL_BLACKLISTED
	return ..()

/mob/living/carbon/human/generate_death_examine_text()
	var/t_His = p_Their()
	var/t_his = p_their()
	if(mind && HAS_TRAIT(mind, TRAIT_HELLBOUND))
		return span_deadsay("[t_His] soul seems to have been ripped out of [t_his] body. Revival is impossible.")
	return ..()

/datum/reagent/medicine/strange_reagent/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	if(exposed_mob.mind && HAS_TRAIT(exposed_mob.mind, TRAIT_HELLBOUND))
		exposed_mob.visible_message(span_warning("[exposed_mob]'s body does not react..."))
		return
	return ..()
