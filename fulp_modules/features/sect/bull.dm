/mob/living/basic/bull
	name = "bull"
	desc = "Sacred in some communities. Dinner in others."
	icon = 'fulp_modules/features/sect/earth-cult.dmi'
	icon_state = "bull"
	icon_living = "bull"
	icon_dead = "bull_dead"
	icon_gib = "cow_gib"
	gender = MALE
	mob_biotypes = MOB_ORGANIC | MOB_BEAST
	speak_emote = list("moos","moos hauntingly")
	speed = 1.1
	see_in_dark = 6
	butcher_results = list(/obj/item/food/meat/slab = 8, /obj/item/stack/sheet/leather = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	attack_sound = 'sound/weapons/punch1.ogg'
	attack_vis_effect = ATTACK_EFFECT_KICK
	health = 75
	maxHealth = 75
	gold_core_spawnable = NO_SPAWN
	blood_volume = BLOOD_VOLUME_NORMAL
	ai_controller = /datum/ai_controller/basic_controller/cow
	faction = list("earth")
	var/list/food_types = list(/obj/item/food/grown/wheat)
	var/tame_message = "lets out a happy moo"
	var/self_tame_message = "let out a happy moo"

/mob/living/basic/bull/Initialize(mapload)
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

