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

	ai_controller = /datum/ai_controller/basic_controller/ghost
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
