//Wraith - Hecata mob

/mob/living/simple_animal/hostile/bloodsucker/wraith
	name = "wraith"
	real_name = "Wraith"
	desc = "An angry, tormented spirit, which looks to let out it's wrath on whoever is nearby."
	gender = PLURAL
	icon_state = "wraith"
	icon_living = "wraith"
	mob_biotypes = list(MOB_SPIRIT)
	maxHealth = 30
	health = 30
	speak_emote = list("hisses")
	emote_hear = list("wails.","screeches.")
	response_help_continuous = "puts their hand through"
	response_help_simple = "put your hand through"
	response_disarm_continuous = "flails at"
	response_disarm_simple = "flail at"
	response_harm_continuous = "punches"
	response_harm_simple = "punch"
	speak_chance = 1
	melee_damage_lower = 6
	melee_damage_upper = 6
	attack_verb_continuous = "metaphysically strikes"
	attack_verb_simple = "metaphysically strike"
	minbodytemp = 0
	maxbodytemp = INFINITY
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	status_flags = 0
	status_flags = CANPUSH
	movement_type = FLYING
	loot = list(/obj/item/ectoplasm)
	death_message = "withers away into nothing."

/mob/living/simple_animal/hostile/bloodsucker/wraith/Initialize(mapload)
	ADD_TRAIT(src, TRAIT_FREE_HYPERSPACE_MOVEMENT, INNATE_TRAIT)
	. = ..()
	AddElement(/datum/element/life_draining)
	AddElement(/datum/element/simple_flying)
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)

/mob/living/simple_animal/hostile/bloodsucker/wraith/death(gibbed)
	REMOVE_TRAIT(src, TRAIT_FREE_HYPERSPACE_MOVEMENT, INNATE_TRAIT)
	qdel(src) //Del on death for some reason doesn't work, might be due to previous code preventing it for /bloodsucker mobs.
	..()
