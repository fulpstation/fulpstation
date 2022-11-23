GLOBAL_LIST_EMPTY(wonderland_marks)

/datum/map_template/wonderland
	name = "Wonderland"
	mappath = "fulp_modules/mapping/custom/wonderland.dmm"

/obj/effect/mob_spawn/corpse/rabbit
	mob_type = /mob/living/simple_animal/rabbit
	icon = 'icons/mob/simple/rabbit.dmi'
	icon_state = "rabbit_white_dead"


/obj/effect/landmark/wonderland_mark
	name = "Wonderland landmark"
	icon_state = "x"

/obj/effect/landmark/wonderchess_mark
	name = "Wonderchess landmark"
	icon_state = "x"

/obj/effect/landmark/wonderland_mark/Initialize(mapload)
	. = ..()
	GLOB.wonderland_marks[name] = src


/obj/effect/landmark/wonderchess_mark/Initialize(mapload)
	. = ..()
	GLOB.wonderland_marks[name] = src


/obj/structure/chess/redqueen
	name = "\improper Red Queen"
	desc = "What is this doing here?"
	icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/rabbit.dmi'
	icon_state = "red_queen"
