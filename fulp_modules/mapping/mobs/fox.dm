/mob/living/simple_animal/pet/fox/ventcrawl

/mob/living/simple_animal/pet/fox/ventcrawl/Initialize()
	. = ..()

	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
