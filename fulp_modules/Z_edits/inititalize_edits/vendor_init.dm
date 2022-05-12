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

/// Mining Equipment Vendor
/obj/machinery/mineral/equipment_vendor/Initialize(mapload)
	prize_list += list(
		new /datum/data/mining_equipment("Digitigrate Combat Boots", /obj/item/clothing/shoes/digicombat, 450),
		new /datum/data/mining_equipment("Digitigrade Jump Boots", /obj/item/clothing/shoes/bhop/digitigrade, 2500),
	)
	return ..()
