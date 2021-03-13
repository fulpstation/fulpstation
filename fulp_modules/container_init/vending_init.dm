/obj/machinery/vending/games/Initialize()
    products += list(/obj/item/toy/plush/batong = 3)
    . = ..()

/obj/machinery/vending/wardrobe/engi_wardrobe/Initialize()
	contraband += list(/obj/item/toy/plush/supermatter = 2)
	. = ..()
