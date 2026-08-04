/mob/living
	///The last image the person saw before their death.
	var/datum/picture/death_photo

/mob/living/basic/death(gibbed)
	. = ..()
	//excluding mobs that'll be deleted & fauna
	if(!(basic_mob_flags & DEL_ON_DEATH) && !gibbed && !is_station_level(z))
		INVOKE_ASYNC(SSdeath_photos, TYPE_PROC_REF(/datum/controller/subsystem/death_photos, take_death_photo), src)

/mob/living/carbon/death(gibbed)
	. = ..()
	//excluding mindless xenobio deaths (expected to be monkey)
	if(!gibbed && !QDELING(src) && (mind || !istype(get_area(src), /area/station/science/xenobiology)))
		INVOKE_ASYNC(SSdeath_photos, TYPE_PROC_REF(/datum/controller/subsystem/death_photos, take_death_photo), src)

/mob/living/Destroy()
	if(!isnull(death_photo))
		QDEL_NULL(death_photo)
	return ..()
