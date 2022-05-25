/**
 *	# Machine Init
 *
 *	This is for all the machine Initialize() calls to change any TG machine without an edit.
 */

//SecTech
/obj/machinery/vending/security/Initialize(mapload)
	products += list(
		/obj/item/bodycam_upgrade = 6, // Used in body_camera.dm
	)
	contraband += list(
		/obj/item/gun/ballistic/revolver/joel = 1, // Used in joel_gun.dm
	)
	return ..()

/obj/machinery/vending/wardrobe/engi_wardrobe/Initialize(mapload)
	contraband += list(
		/obj/item/toy/plush/supermatter = 2,
	)
	return ..()

///Library Toy vendor
/obj/machinery/vending/games/Initialize(mapload)
	products += list(
		/obj/item/toy/plush/batong = 3, //Used in toys.dm
		/obj/item/toy/plush/pico = 1, // Used in toys.dm
	)
	return ..()

