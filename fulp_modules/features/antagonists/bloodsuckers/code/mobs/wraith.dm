//Wraith - Hecata mob

/mob/living/basic/bloodsucker/wraith
	name = "wraith"
	real_name = "Wraith"
	desc = "An angry, tormented spirit, which looks to let out it's wrath on whoever is nearby."
	gender = PLURAL
	icon_state = "wraith"
	icon_living = "wraith"

	mob_biotypes = list(MOB_SPIRIT)
	status_flags = 0
	status_flags = CANPUSH
	movement_type = FLYING
	basic_mob_flags = DEL_ON_DEATH

	maxHealth = 30
	health = 30
	melee_damage_lower = 6
	melee_damage_upper = 6

	speak_emote = list("hisses")
	response_help_continuous = "puts their hand through"
	response_help_simple = "put your hand through"
	response_disarm_continuous = "flails at"
	response_disarm_simple = "flail at"
	response_harm_continuous = "punches"
	response_harm_simple = "punch"
	attack_verb_continuous = "metaphysically strikes"
	attack_verb_simple = "metaphysically strike"
	death_message = "withers away into nothing."

	ai_controller = /datum/ai_controller/basic_controller/wraith
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = INFINITY
	unsuitable_atmos_damage = 0

/mob/living/basic/bloodsucker/wraith/Initialize(mapload)
	ADD_TRAIT(src, TRAIT_FREE_HYPERSPACE_MOVEMENT, INNATE_TRAIT)
	. = ..()
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)

	AddElement(/datum/element/life_draining)
	AddElement(/datum/element/simple_flying)

/mob/living/basic/bloodsucker/wraith/death(gibbed)
	. = ..()
	new /obj/item/ectoplasm(src.loc)

/// Copied from '/datum/ai_controller/basic_controller/ghost' with minor alteration.
/datum/ai_controller/basic_controller/wraith
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk

	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/random_speech/faithless,
	)
