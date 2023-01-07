/mob/living/basic/cow/bull
	name = "bull"
	desc = "Sacred in some communities. Dinner in others."
	icon = 'fulp_modules/features/sect/earth-cult.dmi'
	icon_state = "bull"
	icon_living = "bull"
	icon_dead = "bull_dead"
	gender = MALE
	butcher_results = list(/obj/item/food/meat/slab = 8, /obj/item/stack/sheet/leather = 1)
	health = 75
	maxHealth = 75
	gold_core_spawnable = NO_SPAWN
	blood_volume = BLOOD_VOLUME_NORMAL
	ai_controller = /datum/ai_controller/basic_controller/cow
	faction = list("earth")

/mob/living/basic/cow/bull/udder_component()
    return

/mob/living/basic/cow/bull/Initialize(mapload)
	. = ..()

	AddComponent( \
		/datum/component/aura_healing, \
		range = 5, \
		brute_heal = 0.4, \
		burn_heal = 0.4, \
		blood_heal = 0.4, \
		simple_heal = 1.2, \
		requires_visibility = FALSE, \
		limit_to_trait = TRAIT_SPIRITUAL, \
		healing_color = COLOR_VERY_DARK_LIME_GREEN, \
	)
	AddElement(/datum/element/movement_turf_changer, /turf/open/floor/grass)
