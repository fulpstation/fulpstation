/obj/machinery/computer/arcade/Initialize()
	. = ..()
	if(GLOB.arcade_prize_pool)
	///add item below to add it to the prize pool
		GLOB.arcade_prize_pool += list(
		/obj/item/toy/plush/batong = 1)
