/mob/living/simple_animal/hostile/megafauna/red_rabbit
	name = "Jabberwocky"
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



/mob/living/simple_animal/hostile/megafauna/red_rabbit/Initialize(mapload)
	. = ..()
	var/datum/action/cooldown/mob_cooldown/projectile_attack/shotgun_blast/red_rabbit/cards = new
	var/datum/action/cooldown/mob_cooldown/red_rabbit_hole/hole = new
	var/datum/action/cooldown/mob_cooldown/rabbit_spawn/rabbit = new
	var/datum/action/cooldown/mob_cooldown/charge/rabbit/spear = new
	cards.Grant(src)
	hole.Grant(src)
	rabbit.Grant(src)
	spear.Grant(src)

/datum/action/cooldown/mob_cooldown/charge/rabbit
	destroy_objects = TRUE
	charge_past = 5
	cooldown_time = 8 SECONDS


/datum/action/cooldown/mob_cooldown/rabbit_spawn
	name = "Create Offspring"
	button_icon_state = "killer_rabbit"
	cooldown_time = 5 SECONDS
	button_icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/rabbit.dmi'
	button_icon_state = "killer_rabbit"


/datum/action/cooldown/mob_cooldown/rabbit_spawn/Activate(atom/target_atom)
	StartCooldown(360 SECONDS, 360 SECONDS)
	for(var/i in 1 to 3 )
		var/mob/living/simple_animal/hostile/killer_rabbit/rabbit = new /mob/living/simple_animal/hostile/killer_rabbit(owner.loc)
		rabbit.GiveTarget(target)
		rabbit.faction = owner.faction.Copy()
	StartCooldown()



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




/datum/action/cooldown/mob_cooldown/red_rabbit_hole
	name = "Create Rabbit Hole"
	button_icon_state = "hole_effect_button"
	cooldown_time = 5 SECONDS
	button_icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/rabbit.dmi'
	button_icon_state = "hole_effect_button"


/obj/effect/rabbit_hole
	name = "Rabbit Hole"
	icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/rabbit.dmi'
	icon_state = "hole_effect"
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE

/obj/effect/rabbit_hole/first

/obj/effect/rabbit_hole/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(fell)), 1 SECONDS)
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


/datum/action/cooldown/mob_cooldown/projectile_attack/shotgun_blast/red_rabbit
	cooldown_time = 5 SECONDS
	projectile_type = /obj/projectile/red_rabbit

/obj/projectile/red_rabbit
	name = "Red Queen"
	icon = 'fulp_modules/features/antagonists/bloodsuckers/code/monster_hunter/icons/weapons.dmi'
	icon_state = "locator"
	damage = 20
	armour_penetration = 100
	speed = 2
	eyeblur = 0
	damage_type = BRUTE
	pass_flags = PASSTABLE
	plane = GAME_PLANE


/datum/action/cooldown/mob_cooldown/red_rabbit_hole/Activate(atom/target_atom)
	StartCooldown(360 SECONDS, 360 SECONDS)
	new /obj/effect/rabbit_hole/first(target_atom)
	StartCooldown()


