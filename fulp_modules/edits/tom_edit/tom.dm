/mob/living/simple_animal/mouse/brown/tom/Initialize()
	. = ..()
	ai_controller = new /datum/ai_controller/dog(src)
