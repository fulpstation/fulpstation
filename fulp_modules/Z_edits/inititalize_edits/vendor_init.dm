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

	// CAS removal.
	var/list/card_category = product_categories[1]
	var/list/card_category_products = card_category["products"]
	for(var/obj/item/toy/cards/deck/our_deck as anything in card_category_products)
		if(ispath(our_deck, /obj/item/toy/cards/deck/cas))
			card_category_products.Remove(our_deck)

	return ..()

