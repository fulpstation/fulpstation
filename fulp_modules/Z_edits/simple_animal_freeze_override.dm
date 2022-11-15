/datum/unit_test/simple_animal_freeze/Run()
	allowed_types += list(
		/mob/living/simple_animal/hostile/guardian/punch/timestop,
		/mob/living/simple_animal/hostile/gorilla/albino,
		/mob/living/simple_animal/hostile/devil/arch_devil,
		/mob/living/simple_animal/hostile/devil,
		/mob/living/simple_animal/pet/fox/ventcrawl,
		/mob/living/simple_animal/deer/ventcrawl,
	)
	return ..()
