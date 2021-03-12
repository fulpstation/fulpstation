/obj/machinery/vending/games/Initialize()
    products += list(/obj/item/toy/plush/batong = 3)
    . = ..()

/obj/machinery/vending/tool/Initialize()
	contraband += list(/obj/item/toy/plush/supermatter = 1)
	. = ..()