//Editing surgery tray to hold the death watch.
/datum/storage/surgery_tray/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(can_hold + /obj/item/death_watch, cant_hold, exception_hold)

//Editing morgue tray to have the death watch on roundstart.
/obj/item/surgery_tray/full/morgue/Initialize(mapload, effect_spawner)
	starting_items += list(/obj/item/death_watch)
	return ..()
