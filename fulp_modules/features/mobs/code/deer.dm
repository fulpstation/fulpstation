/mob/living/simple_animal/deer/ventcrawl

/mob/living/simple_animal/deer/ventcrawl/Initialize()
	. = ..()

	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
