/mob/living
	///The last image the person saw before their death.
	var/datum/picture/death_photo

/mob/living/basic/death(gibbed)
	. = ..()
	if(!(basic_mob_flags & DEL_ON_DEATH) && !gibbed)
		INVOKE_ASYNC(src, PROC_REF(take_death_photo))

/mob/living/carbon/death(gibbed)
	. = ..()
	if(!gibbed && !QDELING(src) && (mind || !istype(get_area(src), /area/station/science/xenobiology)))
		INVOKE_ASYNC(src, PROC_REF(take_death_photo))

/mob/living/Destroy()
	if(!isnull(death_photo))
		QDEL_NULL(death_photo)
	return ..()
