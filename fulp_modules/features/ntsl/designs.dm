/datum/design/board/traffic
	name = "Traffic Console"
	desc = "Allows for the construction of Traffic Control Console."
	id = "s_traffic"
	build_path = /obj/item/circuitboard/computer/comm_traffic
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_TELECOMMS
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE

/datum/techweb_node/telecomms/New()
	. = ..()
	design_ids += list(
		"s_traffic",
	)

