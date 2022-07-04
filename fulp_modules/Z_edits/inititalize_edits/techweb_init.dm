/datum/techweb_node/emp_basic/New() // Prisoner restaurant stuff
	design_ids += list(
		"holosignprisonrestaurant",
		"prison_restaurant_portal",
	)

/datum/design/pistol_rubber
	name = "Pistol Magazine (9mm Rubber)"
	desc = "Magazine used in pistols, this one holds non-lethal rounds."
	id = "9mm_rubber"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 10000)
	build_path = /obj/item/ammo_box/magazine/m9mm/rubber
	category = list("Ammo")
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/apspistol_rubber
	name = "Stechkin APS Pistol Magazine (9mm Rubber)"
	desc = "Magazine used in stechkin machine pistols, this one holds non-lethal rounds."
	id = "9mm_apsrubber"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/magazine/m9mm_aps/rubber
	category = list("Ammo")
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
