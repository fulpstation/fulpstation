/obj/machinery/computer/arcade/Initialize()
	. = ..()
	if(GLOB.arcade_prize_pool)
		GLOB.arcade_prize_pool += list(/obj/item/toy/plush/batong = 1)
	///code made by Jhon fucking Willard.
