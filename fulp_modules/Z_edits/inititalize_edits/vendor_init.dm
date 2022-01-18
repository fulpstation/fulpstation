/**
 *	# Machine Init
 *
 *	This is for all the machine Initialize() calls to change any TG machine without an edit.
 */

/obj/machinery/vending/autodrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/clown_shoes/digitigrade = 1,
		/obj/item/clothing/shoes/mime/digitigrade = 1,
	)
	. = ..()

/obj/machinery/vending/clothing/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/sandal/digitigrade = 1,
		/obj/item/clothing/shoes/brown/digitigrade = 3,
	)
	. = ..()

/obj/machinery/vending/wardrobe/sec_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/jackboots/digitigrade = 2,
	)
	. = ..()

//SecTech
/obj/machinery/vending/security/Initialize(mapload)
	products += list(
		/obj/item/bodycam_upgrade = 6, // Used in body_camera.dm
	)
	contraband += list(
		/obj/item/gun/ballistic/revolver/joel = 1, // Used in joel_gun.dm
	)
	. = ..()

/obj/machinery/vending/wardrobe/engi_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/workboots/digitigrade = 3,
	)
	contraband += list(
		/obj/item/toy/plush/supermatter = 2,
	)
	. = ..()

/obj/machinery/vending/wardrobe/atmos_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/brown/digitigrade = 1,
	)
	. = ..()

/obj/machinery/vending/wardrobe/cargo_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/brown/digitigrade = 1,
		/obj/item/clothing/shoes/workboots/digitigrade = 1,
	)
	. = ..()

/obj/machinery/vending/wardrobe/robo_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/brown/digitigrade = 1,
	)
	. = ..()

/obj/machinery/vending/wardrobe/science_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/brown/digitigrade = 2,
	)
	. = ..()

/obj/machinery/vending/wardrobe/hydro_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/brown/digitigrade = 2,
	)
	. = ..()

/obj/machinery/vending/wardrobe/curator_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/laceup/digitigrade = 1,
	)
	. = ..()

/obj/machinery/vending/wardrobe/bar_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/laceup/digitigrade = 1,
	)
	. = ..()

/obj/machinery/vending/wardrobe/chef_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/brown/digitigrade = 1,
	)
	. = ..()

/obj/machinery/vending/wardrobe/law_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/laceup/digitigrade = 1,
	)
	. = ..()

/obj/machinery/vending/wardrobe/chap_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/brown/digitigrade = 1,
	)
	. = ..()

/obj/machinery/vending/wardrobe/medi_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/brown/digitigrade = 1,
	)
	. = ..()

/obj/machinery/vending/wardrobe/chem_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/brown/digitigrade = 1,
	)
	. = ..()

/obj/machinery/vending/wardrobe/viro_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/brown/digitigrade = 1,
	)
	. = ..()

/obj/machinery/vending/wardrobe/det_wardrobe/Initialize(mapload)
	products += list(
		/obj/item/clothing/shoes/laceup/digitigrade = 1,
	)
	. = ..()

///Library Toy vendor
/obj/machinery/vending/games/Initialize(mapload)
	products += list(
		/obj/item/toy/plush/batong = 3, //Used in toys.dm
		/obj/item/toy/plush/pico = 1, // Used in toys.dm
	)
	. = ..()

/// Mining Equipment Vendor
/obj/machinery/mineral/equipment_vendor/Initialize(mapload)
	prize_list += list(
		new /datum/data/mining_equipment("Digitigrate Combat Boots", /obj/item/clothing/shoes/digicombat, 450),
		new /datum/data/mining_equipment("Digitigrade Jump Boots", /obj/item/clothing/shoes/bhop/digitigrade, 2500),
	)
	. = ..()
