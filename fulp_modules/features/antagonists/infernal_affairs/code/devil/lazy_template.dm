/datum/lazy_template/devil_cell
	key = LAZY_TEMPLATE_DEVIL_CELL
	map_dir = "fulp_modules/mapping/lazy_templates"
	map_name = "devil_cell"

///Global list of all landmarks that sacrificed people are sent to for temporary holding onto.
GLOBAL_LIST_EMPTY(devil_cell_landmark)

/// Lardmarks meant to designate where people who's souls are collected by a devil are sent for waiting.
/obj/effect/landmark/devil_cell
	name = "devil cell landmark"
	icon_state = "x"

/obj/effect/landmark/devil_cell/Initialize(mapload)
	. = ..()
	GLOB.devil_cell_landmark += src

/obj/effect/landmark/devil_cell/Destroy()
	GLOB.devil_cell_landmark -= src
	return ..()
