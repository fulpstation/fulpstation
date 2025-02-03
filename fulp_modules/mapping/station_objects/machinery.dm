#define CAMERANET_NETWORK_MONASTERY "monastery"

/obj/machinery/computer/shuttle/labor/selene
	possible_destinations = "laborcamp_home;laborcamp_away;laborcamp_perma"
	no_destination_swap = TRUE

// For Pubby's chapel

/obj/machinery/computer/security/telescreen/monastery
	name = "monastery monitor"
	desc = "A telescreen that connects to the monastery's camera network."
	network = list(CAMERANET_NETWORK_MONASTERY)
	frame_type = /obj/item/wallframe/telescreen/monastery

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/computer/security/telescreen/monastery, 32)

/obj/item/wallframe/telescreen/monastery
	name = "monastery telescreen frame"
	result_path = /obj/machinery/computer/security/telescreen/monastery

/datum/design/telescreen_monastery
	name = "Monastery Telescreen"
	id = "telescreen_monastery"
	build_type = PROTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
	)
	build_path = /obj/item/wallframe/telescreen/monastery
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MOUNTS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE
