/mob/living/simple_animal/hostile/megafauna/red_rabbit
	name = "Red Rabbit"
	desc = "Servant of the moon."
	health = 500
	maxHealth = 500
	icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/red_rabbit.dmi'
	icon_state = "red_rabbit"
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'sound/magic/demon_attack1.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	speak_emote = list("roars")
	armour_penetration = 40
	melee_damage_lower = 40
	melee_damage_upper = 40
	vision_range = 9
	aggro_vision_range = 18
	speed = 6
	move_to_delay = 6
	rapid_melee = 8
	melee_queue_distance = 18
	ranged = TRUE
	pixel_x = -16
	base_pixel_x = -16
	gps_name = "Bloodmoon Signal"
	del_on_death = TRUE
	loot = list()
	butcher_results = list()
	wander = FALSE
	blood_volume = BLOOD_VOLUME_NORMAL
	death_message = "succumbs to the moonlight."
	death_sound = 'sound/effects/gravhit.ogg'
	footstep_type = FOOTSTEP_MOB_HEAVY
	attack_action_types = list(/datum/action/innate/megafauna_attack/rabbit_spawn,
							   /datum/action/innate/megafauna_attack/charge,
							   /datum/action/innate/megafauna_attack/shockwave_scream)
