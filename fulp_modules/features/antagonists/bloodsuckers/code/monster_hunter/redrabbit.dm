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
	armour_penetration = 25
	melee_damage_lower = 25
	melee_damage_upper = 25
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
	attack_action_types = list(/datum/action/innate/megafauna_attack/rabbit_spawn, /datum/action/innate/megafauna_attack/red_rabbit_hole)
	COOLDOWN_DECLARE(birth_cooldown)


/mob/living/simple_animal/hostile/megafauna/red_rabbit/OpenFire(target)
	var/place = get_turf(target)
	update_cooldowns(list(COOLDOWN_UPDATE_SET_MELEE = 5 SECONDS, COOLDOWN_UPDATE_SET_RANGED = 10 SECONDS))
	if(client)
		switch(chosen_attack)
			if(1)
				birth_rabbit()
			if(2)
				new /obj/effect/rabbit_hole/first(place)
		return

/datum/action/innate/megafauna_attack/rabbit_spawn
	name = "Create Offspring"
	button_icon_state = "killer_rabbit"
	chosen_message = "Create killer white rabbits to target your enemy."
	chosen_attack_num = 1

	icon_icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/rabbit.dmi'
	button_icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/rabbit.dmi'

/mob/living/simple_animal/hostile/megafauna/red_rabbit/proc/birth_rabbit(target) //pregnancy RP
	if(!COOLDOWN_FINISHED(src, birth_cooldown))
		return
	COOLDOWN_START(src, birth_cooldown, 30 SECONDS)
	visible_message(span_boldwarning("The Red Rabbit screams in agony!"))
	for(var/i in 3 to 5 )
		var/mob/living/simple_animal/hostile/killer_rabbit/rabbit = new /mob/living/simple_animal/hostile/killer_rabbit(loc)
		rabbit.GiveTarget(target)
		rabbit.faction = faction.Copy()


/mob/living/simple_animal/hostile/killer_rabbit
	name = "Killer baby rabbit"
	desc = "A cute little rabbit, surely its harmless... right?"
	icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/rabbit.dmi'
	icon_state = "killer_rabbit"
	maxHealth = 5
	melee_damage_lower = 5
	melee_damage_upper = 5

/mob/living/simple_animal/hostile/killer_rabbit/AttackingTarget()
	var/mob/living/carbon/human
	if(iscarbon(target))
		human = target
	else
		return
	if(human)
		explosion(src,heavy_impact_range = 1, light_impact_range = 1, flame_range = 2)




/datum/action/innate/megafauna_attack/red_rabbit_hole
	name = "Create Rabbit Hole"
	button_icon_state = "hole_effect_button"
	chosen_message = "Drop your enemies into the wonderland."
	chosen_attack_num = 2

	icon_icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/rabbit.dmi'
	button_icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/rabbit.dmi'


/obj/effect/rabbit_hole
	name = "Rabbit Hole"
	icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/rabbit.dmi'
	icon_state = "hole_effect"
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE

/obj/effect/rabbit_hole/first

/obj/effect/rabbit_hole/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, .proc/fell), 1 SECONDS)
	QDEL_IN(src, 4 SECONDS)

/obj/effect/rabbit_hole/proc/fell()
	for(var/mob/living/carbon/human/man in loc)
		if(man.stat == DEAD)
			continue
		visible_message(span_danger("[man] falls into the rabbit hole!"))
		man.Knockdown(5 SECONDS)
		man.adjustBruteLoss(20)


/obj/effect/rabbit_hole/first/Initialize(mapload, new_spawner)
	. = ..()
	var/list/directions = GLOB.cardinals.Copy()
	for(var/i in 1 to 4)
		var/spawndir = pick_n_take(directions)
		var/turf/hole = get_step(src, spawndir)
		if(hole)
			new /obj/effect/rabbit_hole(hole)
