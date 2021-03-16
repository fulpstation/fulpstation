///Vending Machines

/obj/machinery/vending/autodrobe/Initialize()
	products += list(/obj/item/clothing/shoes/clown_shoes/digitigrade = 1,
	/obj/item/clothing/shoes/sneakers/mime/digitigrade = 1)
	. = ..()

/obj/machinery/vending/clothing/Initialize()
	products += list(/obj/item/clothing/shoes/sandal/digitigrade = 1,
	/obj/item/clothing/shoes/sneakers/brown/digitigrade = 3)
	. = ..()

/obj/machinery/vending/wardrobe/sec_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/jackboots/digitigrade = 2)
	. = ..()

/obj/machinery/vending/wardrobe/engi_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/workboots/digitigrade = 3)
	. = ..()

/obj/machinery/vending/wardrobe/atmos_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/sneakers/brown/digitigrade = 1)
	. = ..()

/obj/machinery/vending/wardrobe/cargo_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/sneakers/brown/digitigrade = 1,
	/obj/item/clothing/shoes/workboots/digitigrade = 1)
	. = ..()

/obj/machinery/vending/wardrobe/robo_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/sneakers/brown/digitigrade = 1)
	. = ..()

/obj/machinery/vending/wardrobe/science_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/sneakers/brown/digitigrade = 2)
	. = ..()

/obj/machinery/vending/wardrobe/hydro_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/sneakers/brown/digitigrade = 2)
	. = ..()

/obj/machinery/vending/wardrobe/curator_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/laceup/digitigrade = 1)
	. = ..()

/obj/machinery/vending/wardrobe/bar_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/laceup/digitigrade = 1)
	. = ..()

/obj/machinery/vending/wardrobe/chef_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/sneakers/brown/digitigrade = 1)
	. = ..()

/obj/machinery/vending/wardrobe/law_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/laceup/digitigrade = 1)
	. = ..()

/obj/machinery/vending/wardrobe/chap_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/sneakers/brown/digitigrade = 1)
	. = ..()

/obj/machinery/vending/wardrobe/medi_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/sneakers/brown/digitigrade = 1)
	. = ..()

/obj/machinery/vending/wardrobe/chem_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/sneakers/brown/digitigrade = 1)
	. = ..()

/obj/machinery/vending/wardrobe/viro_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/sneakers/brown/digitigrade = 1)
	. = ..()

/obj/machinery/vending/wardrobe/det_wardrobe/Initialize()
	products += list(/obj/item/clothing/shoes/laceup/digitigrade = 1)
	. = ..()

///Lockers

/obj/structure/closet/secure_closet/engineering_chief/Initialize()
	new /obj/item/clothing/shoes/workboots/digitigrade(src)
	. = ..()
/obj/structure/closet/secure_closet/research_director/Initialize()
	new /obj/item/clothing/shoes/laceup/digitigrade(src)
	. = ..()

/obj/structure/closet/secure_closet/chief_medical/Initialize()
	new /obj/item/clothing/shoes/sneakers/brown/digitigrade(src)
	. = ..()

/obj/structure/closet/secure_closet/hop/Initialize()
	new /obj/item/clothing/shoes/sneakers/brown/digitigrade(src)
	. = ..()

/obj/structure/closet/secure_closet/hos/Initialize()
	new /obj/item/clothing/shoes/jackboots/digitigrade(src)
	. = ..()

/obj/structure/closet/secure_closet/captains/Initialize()
	new /obj/item/clothing/shoes/sneakers/brown/digitigrade(src)
	. = ..()

/obj/structure/closet/secure_closet/security/Initialize()
	new /obj/item/clothing/shoes/jackboots/digitigrade(src)
	. = ..()

/obj/structure/closet/secure_closet/medical3/Initialize()
	new /obj/item/clothing/shoes/sneakers/brown/digitigrade(src)
	. = ..()

/obj/structure/closet/wardrobe/miner/Initialize()
	new /obj/item/clothing/shoes/workboots/digitigrade(src)
	. = ..()

///Techtree

/datum/techweb_node/adv_engi/New()
	design_ids += "digimagboot-design"

///Mining Equipment Vendor

/obj/machinery/mineral/equipment_vendor/Initialize()
	prize_list += list(
			new /datum/data/mining_equipment("Digitigrate Combat Boots",	/obj/item/clothing/shoes/digicombat,							450),
			new /datum/data/mining_equipment("Digitigrade Jump Boots",		/obj/item/clothing/shoes/bhop/digitigrade,						2500),
		)
	return ..()
