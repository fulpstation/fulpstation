/datum/techweb_node/cafeteria_equip/New()
	. = ..()
	design_ids += list(
		"holosignprisonrestaurant",
		"prison_restaurant_portal"
	)

/datum/techweb_node/consoles/New()
	var/has_monastery = CHECK_MAP_JOB_CHANGE(JOB_CHAPLAIN, "has_monastery")
	if(has_monastery)
		design_ids += "telescreen_monastery"
	return ..()

//This exists so it can pass CI despite not existing on non-monastery maps.
/obj/item/disk/design_disk/monastery_telescreen/Initialize(mapload)
	. = ..()
	blueprints += new /datum/design/telescreen_monastery

