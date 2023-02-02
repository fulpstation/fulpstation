#define COMSIG_MOB_DEATH "mob death"

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
		range = 4, \
		brute_heal = 0.4, \
		burn_heal = 0.4, \
		blood_heal = 0.4, \
		simple_heal = 0.8, \
		requires_visibility = FALSE, \
		limit_to_trait = TRAIT_SPIRITUAL, \
		healing_color = COLOR_VERY_DARK_LIME_GREEN, \
	)
	AddElement(/datum/element/movement_turf_changer, /turf/open/floor/grass)

/mob/living/basic/cow/bull/big
	name = "giant aurochs"
	desc = "A mythological bull from long-lost folklore. How it got here is anyone's guess."
	icon = 'fulp_modules/features/sect/96x96.dmi'
	icon_state = "aurochs"
	icon_living = "aurochs"
	icon_dead = "aurochs_dead"
	gender = MALE
	butcher_results = list(/obj/item/food/meat/slab = 15, /obj/item/stack/sheet/leather = 3)
	health = 750
	maxHealth = 750
	gold_core_spawnable = NO_SPAWN
	blood_volume = BLOOD_VOLUME_NORMAL
	ai_controller = /datum/ai_controller/basic_controller/cow
	faction = list("earth")


/mob/living/basic/cow/bull/big/Initialize(mapload)
	. = ..()
	SEND_SIGNAL(src, COMSIG_LIVING_DEATH)
	AddComponent( \
		/datum/component/aura_healing, \
		range = 5, \
		brute_heal = 0.6, \
		burn_heal = 0.6, \
		blood_heal = 0.6, \
		simple_heal = 1.6, \
		requires_visibility = FALSE, \
		limit_to_trait = TRAIT_SPIRITUAL, \
		healing_color = COLOR_VERY_DARK_LIME_GREEN, \
	)


GLOBAL_DATUM(great_aurochs, /mob/living/basic/cow/bull/big)

/obj/item/organ/internal/heart/cybernetic/earth/proc/aurochs_death()
    //var/obj/item/organ/internal/heart/cybernetic/earth/earth_heart
    if(!owner|| owner.stat == DEAD)
        return

    if(ishuman(owner))
        to_chat(owner, span_danger("You feel a splitting pain in your head, and are struck with a wave of nausea. You cannot hear the hivemind anymore!"))
        owner.emote("scream")
        owner.Paralyze(100)

    owner.adjust_jitter(1 MINUTES)
    owner.adjust_confusion(30 SECONDS)
    owner.adjust_stutter(1 MINUTES)







/mob/living/basic/cow/bull/big/death(gibbed)
    if(stat == DEAD)
        return

    . = ..()

/mob/living/basic/cow/bull/big/death(gibbed)

    for(var/mob/living/carbon/C in GLOB.alive_mob_list)
        if(C == src)
            continue
        var/obj/item/organ/internal/heart/cybernetic/earth/earth = C.getorgan(/obj/item/organ/internal/heart/cybernetic/earth)
        if(istype(earth))
            earth.aurochs_death()

    return ..()
