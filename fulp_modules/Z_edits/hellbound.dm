/mob/living/carbon/can_defib()
	//You sold your soul, you can't be revived anymore.
	if(HAS_TRAIT(mind, TRAIT_HELLBOUND))
		return DEFIB_FAIL_BLACKLISTED
	return

/mob/living/carbon/human/generate_death_examine_text()
	var/t_His = p_Their()
	var/t_his = p_their()
	if(mind && HAS_TRAIT(mind, TRAIT_HELLBOUND))
		return span_deadsay("[t_His] soul seems to have been ripped out of [t_his] body. Revival is impossible.")
	return ..()

/datum/reagent/medicine/strange_reagent/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	if(HAS_TRAIT(exposed_mob.mind, TRAIT_HELLBOUND))
		return
	return ..()

/*
/mob/dead/observer/Initialize(mapload)
	. = ..()
	var/mob/body = loc
	if(ismob(body))
		if(HAS_TRAIT(body.mind, TRAIT_HELLBOUND)) // transfer if the body was killed due to suicide
			can_reenter_corpse = FALSE
*/
