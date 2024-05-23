/obj/structure/ore_vent/boss/Initialize(mapload)
	defending_mobs += /mob/living/basic/exiled_king
	return ..()


/obj/structure/ore_vent/boss/examine(mob/user)
	. = ..()
	if(summoned_boss == /mob/living/basic/exiled_king)
		.[length(.)] = span_notice("A mass of tentacles is etched onto the side of the vent.")

