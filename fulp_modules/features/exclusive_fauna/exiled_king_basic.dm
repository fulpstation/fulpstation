#define BB_KING_PORTAL "BB_king_portal"
#define BB_KING_TENTACLE "BB_king_tentacle"
#define BB_KING_SURROUND_TENTACLE "BB_king_surround_tentacle"
#define BB_CHARGE_ABILITY "BB_charge_ability"
#define BOSS_MEDAL_EXILED "Exiled Killer"
#define EXILED_KING_SCORE "Exiled Killed"
#define BB_KING_TENTACLE_TRACK "BB_king_tentacle_track"

/mob/living/basic/exiled_king
	name = "exiled king"
	desc = "And what army?"
	health = 2500
	maxHealth = 2500
	attack_verb_continuous = "slaps"
	light_range = 3
	attack_verb_simple = "slap"
	attack_sound = 'sound/magic/demon_attack1.ogg'
	icon_state = "cthulu"
	icon_living = "cthulu"
	icon_dead = ""
	health_doll_icon = "cthulu"
	friendly_verb_continuous = "stares down"
	friendly_verb_simple = "stare down"
	combat_mode = TRUE
	faction = list(FACTION_MINING, FACTION_BOSS)
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = INFINITY
	icon = 'fulp_modules/features/exclusive_fauna/icons/96x96.dmi'
	speak_emote = list("gurgles")
	armour_penetration = 40
	melee_damage_lower = 15
	melee_damage_upper = 15
	speed = 4
	mob_size = MOB_SIZE_LARGE
	move_resist = INFINITY
	pixel_x = -32
	base_pixel_x = -32
	maptext_height = 96
	maptext_width = 96
	sentience_type = SENTIENCE_BOSS
	faction = list(FACTION_MINING, FACTION_BOSS)
	basic_mob_flags = DEL_ON_DEATH
	move_force = MOVE_FORCE_OVERPOWERING
	move_resist = MOVE_FORCE_OVERPOWERING
	pull_force = MOVE_FORCE_OVERPOWERING
	layer = LARGE_MOB_LAYER
	plane = GAME_PLANE_UPPER_FOV_HIDDEN
	mouse_opacity = MOUSE_OPACITY_OPAQUE
	death_message = "the mad king has felled, no longer will he suffer. "
	death_sound = 'sound/magic/enter_blood.ogg'
	ai_controller = /datum/ai_controller/basic_controller/kraken
	///achievement for killing
	var/achievement_type = /datum/award/achievement/boss/king_slayer
	///score of killings
	var/score_achievement_type = /datum/award/score/king_score


/mob/living/basic/exiled_king/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps, "Sunken Signal")
	add_traits(list(TRAIT_LAVA_IMMUNE, TRAIT_ASHSTORM_IMMUNE), INNATE_TRAIT)
	AddElement(/datum/element/simple_flying)
	AddElement(/datum/element/crusher_loot, /obj/item/crusher_trophy/kraken_eye, 100, TRUE)
	AddElement(/datum/element/death_drops, list(/obj/item/clothing/neck/cloak/squid))
	var/datum/action/cooldown/mob_cooldown/summon_portal/fishes = new(src)
	var/datum/action/cooldown/mob_cooldown/kraken_tentacle/tentacle = new(src)
	var/datum/action/cooldown/mob_cooldown/tentacle_all_directions/all_directions = new(src)
	var/datum/action/cooldown/mob_cooldown/tentacle_track/tentacle_track = new(src)
	tentacle_track.Grant(src)
	fishes.Grant(src)
	tentacle.Grant(src)
	all_directions.Grant(src)
	ai_controller.blackboard[BB_KING_TENTACLE_TRACK] = WEAKREF(tentacle_track)
	ai_controller.blackboard[BB_KING_PORTAL] = WEAKREF(fishes)
	ai_controller.blackboard[BB_KING_TENTACLE] = WEAKREF(tentacle)
	ai_controller.blackboard[BB_KING_SURROUND_TENTACLE] = WEAKREF(all_directions)

/mob/living/basic/exiled_king/death(gibbed)
	grant_achievement(achievement_type, score_achievement_type)
	return ..()




/datum/ai_controller/basic_controller/kraken
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic(),
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk/less_walking
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/cthulu_attack/tentacles,
		/datum/ai_planning_subtree/cthulu_attack/surround,
		/datum/ai_planning_subtree/cthulu_attack/portal,
		/datum/ai_planning_subtree/cthulu_attack/track_victim,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/datum/ai_planning_subtree/cthulu_attack/track_victim
	our_behavior = /datum/ai_behavior/cthulu_attack/track_victim

/datum/ai_behavior/cthulu_attack/track_victim
	action_cooldown = 20 SECONDS
	ability_key = BB_KING_TENTACLE_TRACK
/datum/ai_planning_subtree/cthulu_attack/tentacles
	our_behavior = /datum/ai_behavior/cthulu_attack/tentacle

/datum/ai_behavior/cthulu_attack/tentacle
	action_cooldown = 4 SECONDS
	ability_key = BB_KING_TENTACLE

/datum/ai_planning_subtree/cthulu_attack/portal
	our_behavior = /datum/ai_behavior/cthulu_attack/portal

/datum/ai_behavior/cthulu_attack/portal
	action_cooldown = 20 SECONDS
	ability_key = BB_KING_PORTAL
	validate_conditions = TRUE

/datum/ai_planning_subtree/cthulu_attack/surround
	our_behavior = /datum/ai_behavior/cthulu_attack/surround

/datum/ai_behavior/cthulu_attack/surround
	action_cooldown = 10 SECONDS
	ability_key = BB_KING_SURROUND_TENTACLE

/datum/ai_planning_subtree/cthulu_attack
	var/datum/ai_behavior/our_behavior = /datum/ai_behavior/cthulu_attack

/datum/ai_planning_subtree/cthulu_attack/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if (QDELETED(target))
		return
	if(!target)
		return
	controller.queue_behavior(our_behavior, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)

/datum/ai_behavior/cthulu_attack
	behavior_flags =  AI_BEHAVIOR_MOVE_AND_PERFORM | AI_BEHAVIOR_KEEP_MOVE_TARGET_ON_FINISH | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 15
	var/ability_key
	var/validate_conditions = FALSE

/datum/ai_behavior/cthulu_attack/setup(datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if (QDELETED(target))
		return FALSE
	if (!isliving(target))
		return FALSE

/datum/ai_behavior/cthulu_attack/perform(seconds_per_tick, datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	var/mob/living/basic/basic_mob = controller.pawn
	var/atom/target = controller.blackboard[target_key]
	if (QDELETED(target))
		return
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]

	if(!targetting_datum.can_attack(basic_mob, target))
		finish_action(controller, FALSE, target_key)
		return

	var/atom/hiding_target = targetting_datum.find_hidden_mobs(basic_mob, target) //If this is valid, theyre hidden in something!
	var/atom/final_target = hiding_target ? hiding_target : target

	if(!can_see(basic_mob, final_target, required_distance))
		finish_action(controller, FALSE, target_key)
		return

	controller.blackboard[hiding_location_key] = WEAKREF(hiding_target)

	var/datum/weakref/ability_weakref = controller.blackboard[ability_key]
	var/datum/action/cooldown/mob_cooldown/ability = ability_weakref?.resolve()
	if(isnull(ability))
		return
	if(validate_conditions)
		if(!check_conditions(basic_mob, final_target)) //conditions before we execute the ability
			return
		alter_ability(ability, basic_mob) //how the ability is altered depending on conditions

	ability.Activate(final_target)


/datum/ai_behavior/cthulu_attack/proc/alter_ability(ability, mob/living/basic_mob)
	return

/datum/ai_behavior/cthulu_attack/proc/check_conditions(mob/living/basic_mob, atom/final_target)
	return TRUE

/datum/ai_behavior/cthulu_attack/portal/alter_ability(ability, mob/living/basic_mob)
	var/datum/action/cooldown/mob_cooldown/summon_portal/portal = ability
	if(basic_mob.health <= basic_mob.maxHealth / 2)
		portal.creature = /mob/living/basic/carp/cthulu/mega
		portal.number_of_mobs = 2

	else
		portal.creature = /mob/living/basic/carp/cthulu
		portal.number_of_mobs = 2

	if(prob(50))
		portal.creature = /mob/living/basic/vanguard
		portal.number_of_mobs = 1

	return


/datum/action/cooldown/mob_cooldown/tentacle_track
	name = "Tentacle Track"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "sniper_zoom"
	desc = "Tentacles will chase your victim for some time."
	cooldown_time = 0 SECONDS
	///what abomination are we spawning
	var/number_of_tentacles = 5
	///type of tentacle we are summoning
	var/tentacle = /obj/effect/kraken_arm/track

/datum/action/cooldown/mob_cooldown/tentacle_track/Activate(atom/target_atom)
	StartCooldown(360 SECONDS, 360 SECONDS)
	INVOKE_ASYNC(src, PROC_REF(track_tentacle), target_atom)
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/tentacle_track/proc/track_tentacle(atom/target_atom)
	if(!isliving(target_atom))
		return
	var/mob/living/victim = target_atom
	for(var/i in 1 to number_of_tentacles)
		var/turf/locale = get_turf(victim)
		new tentacle(locale)
		sleep(3 SECONDS)


/datum/action/cooldown/mob_cooldown/summon_portal
	name = "Summon Army"
	button_icon = 'icons/obj/carp_rift.dmi'
	button_icon_state = "carp_rift_carpspawn"
	desc = "Summon your army to defend you."
	cooldown_time = 0 SECONDS
	///what abomination are we spawning
	var/creature = /mob/living/basic/carp/cthulu
	///how many
	var/number_of_mobs = 2

/datum/action/cooldown/mob_cooldown/summon_portal/Activate(atom/target_atom)
	StartCooldown(360 SECONDS, 360 SECONDS)
	create_portal()
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/summon_portal/proc/create_portal()
	var/list/directions = GLOB.cardinals.Copy()
	for(var/i in 1 to 2)
		var/spawndir = pick_n_take(directions)
		var/turf/place = get_step(owner, spawndir)
		var/dense_check = FALSE
		for(var/atom/content in place)
			if(content.density)
				dense_check = TRUE
				break
		if(dense_check)
			continue
		var/obj/structure/cthulu_rift/portal = new(place, number_of_mobs, creature)
		portal.squid = WEAKREF(owner)

/obj/structure/cthulu_rift
	name = "cthulu's rift"
	desc = "gateway for the King's army."
	armor_type = /datum/armor/structure_carp_rift
	max_integrity = 500
	icon = 'icons/obj/carp_rift.dmi'
	icon_state = "carp_rift_carpspawn"
	light_color = LIGHT_COLOR_PURPLE
	light_range = 10
	anchored = TRUE
	density = FALSE
	///how many mobs are we spawning
	var/number_of_mobs = 2
	///our overlord
	var/datum/weakref/squid
	///type of creature we are spawning
	var/creature = /mob/living/basic/carp/cthulu

/obj/structure/cthulu_rift/Initialize(mapload, number, create)
	. = ..()
	number_of_mobs = number
	creature = create
	START_PROCESSING(SSfastprocess, src)

/obj/structure/cthulu_rift/process(seconds_per_tick)
	var/mob/living/overlord = squid?.resolve()
	if(!overlord)
		qdel(src)
		return
	if(number_of_mobs <= 0)
		qdel(src)
		return
	if(SPT_PROB(60, seconds_per_tick))
		new creature(loc, overlord)
		number_of_mobs = number_of_mobs - 1

/obj/structure/cthulu_rift/Destroy()
	STOP_PROCESSING(SSobj, src)
	squid = null
	return ..()

/mob/living/basic/carp/cthulu
	health = 50
	maxHealth = 50
	mob_size = MOB_SIZE_LARGE
	///our overlord
	var/datum/weakref/leader
	melee_damage_lower = 5
	speed = 5
	melee_damage_upper = 5

/mob/living/basic/carp/cthulu/mega
	name = "overlord's commander"
	desc = "Higher ranked soldiers of the King's army."
	icon = 'icons/mob/simple/broadMobs.dmi'
	icon_state = "megacarp_greyscale"
	icon_living = "megacarp_greyscale"
	icon_dead = "megacarp_dead_greyscale"
	greyscale_config = /datum/greyscale_config/carp_mega
	icon_gib = "megacarp_gib"
	health = 70
	maxHealth = 70
	mob_size = MOB_SIZE_LARGE


/mob/living/basic/carp/cthulu/Initialize(mapload, mob/living/overlord)
	. = ..()
	if(overlord)
		leader = WEAKREF(overlord)
		faction = overlord.faction.Copy()
	RegisterSignal(src, COMSIG_LIVING_DEATH, PROC_REF(damage_overlord))
	QDEL_IN(src, 20 SECONDS)

/mob/living/basic/carp/cthulu/proc/damage_overlord()
	SIGNAL_HANDLER
	var/mob/living/overlord = leader?.resolve()
	if(!overlord)
		return
	overlord.apply_damage(maxHealth)
	var/datum/status_effect/crusher_damage/damage = src.has_status_effect(/datum/status_effect/crusher_damage)
	var/datum/status_effect/crusher_damage/overlord_damage = overlord.has_status_effect(/datum/status_effect/crusher_damage)

	if(damage && !overlord_damage)
		overlord_damage = overlord.apply_status_effect(/datum/status_effect/crusher_damage)

	if(damage)
		overlord_damage.total_damage += damage.total_damage

	leader= null

/datum/action/cooldown/mob_cooldown/kraken_tentacle
	name = "kraken tentacle"
	button_icon = 'fulp_modules/features/exclusive_fauna/icons/effect.dmi'
	button_icon_state = "squidarm"
	desc = "Unleash tentacles towards the target."
	cooldown_time = 0 SECONDS

/datum/action/cooldown/mob_cooldown/kraken_tentacle/Activate(atom/target_atom)
	StartCooldown(360 SECONDS, 360 SECONDS)
	INVOKE_ASYNC(src, PROC_REF(attack_sequence), target_atom)
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/kraken_tentacle/proc/attack_sequence(atom/target)
	if(!target)
		return
	var/turf/ranged_turfs = get_ranged_target_turf_direct(owner, target, 15, 0)
	var/list/turfs = (get_line(owner, ranged_turfs) - get_turf(owner))
	for(var/turf/singular in turfs)
		if(isclosedturf(singular))
			break
		var/direction = get_dir(owner, target)
		var/check_existing_arm = FALSE
		for(var/obj/effect/kraken_arm/arm in singular)
			check_existing_arm = TRUE
			break
		if(!check_existing_arm)
			new /obj/effect/kraken_arm/original(singular, direction)
		sleep(0.175 SECONDS)

/obj/effect/kraken_arm
	name = "kraken arm"
	icon = 'fulp_modules/features/exclusive_fauna/icons/effect.dmi'
	icon_state = "squidarm"
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	var/static/list/unaffected_types = typecacheof(list(
		/mob/living/basic/exiled_king,
		/mob/living/basic/carp/cthulu,
		/mob/living/basic/carp/cthulu/mega,
	))
	///damage we apply
	var/damage = 10
	///delay before damage
	var/delay_time = 0.05

/obj/effect/kraken_arm/track
	icon = 'fulp_modules/features/exclusive_fauna/icons/effect_track.dmi'
	icon_state = "kraken_tentacle_2"
	delay_time = 1.5

/obj/effect/kraken_arm/track/fell()
	playsound(get_turf(src), 'sound/effects/meteorimpact.ogg', 100, TRUE)
	..()

/obj/effect/kraken_arm/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(fell)), delay_time)
	QDEL_IN(src, 2 SECONDS)

/obj/effect/kraken_arm/proc/fell()
	for(var/mob/living/man in loc)
		if(man.type in unaffected_types)
			continue
		if(man.stat == DEAD)
			continue
		visible_message(span_danger("[man] gets smashed by the tentacles!"))
		man.apply_damage(damage, BRUTE, wound_bonus = CANT_WOUND)
	for(var/obj/destroyed in loc)
		if(istype(destroyed, /obj/structure) || istype(destroyed, /obj/machinery))
			destroyed.take_damage(200, BRUTE, MELEE, 1)

/obj/effect/kraken_arm/original

/obj/effect/kraken_arm/original/Initialize(mapload, direction)
	. = ..()
	var/list/directions  = get_adjacent_directions(direction)
	for(var/location in directions)
		var/turf/place = get_step(src, location)
		if(isclosedturf(place))
			continue
		var/check_existing_arm = FALSE
		for(var/obj/effect/kraken_arm/arm in place)
			check_existing_arm = TRUE
			break
		if(!check_existing_arm)
			new /obj/effect/kraken_arm(place)

/obj/effect/kraken_arm/original/proc/get_adjacent_directions(direction)
	var/list/direcs
	if(direction & NORTH || direction & SOUTH)
		direcs = list(EAST, WEST)
	if(direction & SOUTHWEST || direction & NORTHEAST)
		direcs = list(NORTHWEST, SOUTHEAST)
	if(direction & NORTHWEST || direction & SOUTHEAST)
		direcs = list(NORTHEAST, SOUTHWEST)
	if(direction & EAST || direction & WEST)
		direcs = list(NORTH, SOUTH)
	return direcs

/obj/effect/kraken_arm/original/fell()
	playsound(get_turf(src), 'sound/effects/meteorimpact.ogg', 100, TRUE)
	..()


/datum/action/cooldown/mob_cooldown/tentacle_all_directions
	name = "All direction tentacles"
	button_icon = 'fulp_modules/features/exclusive_fauna/icons/effect.dmi'
	button_icon_state = "squidarm"
	desc = "Allows you to shoot fire in all directions."
	cooldown_time = 0 SECONDS
	///list of directions our tentacles spawn in
	var/list/offsets = list(45,-45,90,-90,180,-180,225,-225)

/datum/action/cooldown/mob_cooldown/tentacle_all_directions/Activate(atom/target_atom)
	StartCooldown(360 SECONDS, 360 SECONDS)
	attack_sequence(target_atom)
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/tentacle_all_directions/proc/attack_sequence(atom/target)
	for(var/offset in offsets)
		INVOKE_ASYNC(src, PROC_REF(throw_tentacles), target, offset)

/datum/action/cooldown/mob_cooldown/tentacle_all_directions/proc/throw_tentacles(atom/target, offset)
	var/turf/target_turf = get_turf_in_angle(offset, owner.loc , 15)
	var/list/turfs = get_line(owner.loc, target_turf)
	for(var/turf/singular in turfs)
		if(isclosedturf(singular))
			break
		var/check_existing_arm = FALSE
		for(var/obj/effect/kraken_arm/arm in singular)
			check_existing_arm = TRUE
			break
		if(!check_existing_arm)
			new /obj/effect/kraken_arm(singular)
		playsound(singular, 'sound/effects/meteorimpact.ogg', 100, TRUE)
		sleep(0.1 SECONDS)


/mob/living/basic/vanguard
	name = "king's vanguard"
	desc = "Vanguard of the king's army."
	icon = 'fulp_modules/features/exclusive_fauna/icons/64x64.dmi'
	icon_state = "vanguard"
	icon_living = "vanguard"
	icon_dead = "vanguard"
	icon_gib = "vanguard"
	health_doll_icon = "vanguard"
	basic_mob_flags = DEL_ON_DEATH
	mob_size = MOB_SIZE_LARGE
	speed = 1
	maxHealth = 200
	health = 200
	melee_damage_lower = 8
	melee_damage_upper = 12
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	faction = list(FACTION_HOSTILE)
	mob_size = MOB_SIZE_LARGE
	speak_emote = list("polls")
	death_message = "crumbles to ashes!"
	ai_controller = /datum/ai_controller/basic_controller/vanguard
	///the charge ability
	var/datum/action/cooldown/mob_cooldown/charge/vanguard/charge_ability
	///our leader
	var/datum/weakref/leader


/mob/living/basic/vanguard/Initialize(mapload, mob/living/overlord)
	. = ..()
	if(overlord)
		leader = WEAKREF(overlord)
		faction = overlord.faction.Copy()
	charge_ability = new /datum/action/cooldown/mob_cooldown/charge/vanguard(src)
	charge_ability.Grant(src)
	ai_controller.blackboard[BB_CHARGE_ABILITY] = WEAKREF(charge_ability)
	QDEL_IN(src, 5 SECONDS)

/mob/living/basic/vanguard/Destroy()
	charge_ability.Remove(src)
	return ..()

/datum/action/cooldown/mob_cooldown/charge/vanguard
	charge_damage = 20
	charge_delay = 0.7 SECONDS

/datum/ai_controller/basic_controller/vanguard
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic(),
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk/less_walking
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/ram_target,
	)

/datum/ai_planning_subtree/ram_target
	var/datum/ai_behavior/ram/ram_behavior = /datum/ai_behavior/ram

/datum/ai_planning_subtree/ram_target/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!target || QDELETED(target))
		return
	controller.queue_behavior(ram_behavior, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_behavior/ram
	action_cooldown = 0.6 SECONDS
	behavior_flags =  AI_BEHAVIOR_MOVE_AND_PERFORM
	required_distance = 15

/datum/ai_behavior/ram/setup(datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if (QDELETED(target))
		return FALSE
	if (!isliving(target))
		return FALSE

/datum/ai_behavior/ram/perform(seconds_per_tick, datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	var/mob/living/basic/basic_mob = controller.pawn
	var/atom/target = controller.blackboard[target_key]
	if (QDELETED(target))
		return FALSE
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]

	if(!targetting_datum.can_attack(basic_mob, target))
		finish_action(controller, FALSE, target_key)
		return

	var/atom/hiding_target = targetting_datum.find_hidden_mobs(basic_mob, target) //If this is valid, theyre hidden in something!
	var/atom/final_target = hiding_target ? hiding_target : target

	if(!can_see(basic_mob, final_target, required_distance))
		finish_action(controller, FALSE, target_key)
		return

	controller.blackboard[hiding_location_key] = WEAKREF(hiding_target)

	var/datum/weakref/ability_weakref = controller.blackboard[BB_CHARGE_ABILITY]
	var/datum/action/cooldown/mob_cooldown/charge_ability = ability_weakref?.resolve()
	if(isnull(charge_ability))
		return

	charge_ability.Activate(final_target)

/datum/ai_behavior/basic_ranged_attack/finish_action(datum/ai_controller/controller, succeeded, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	if(!succeeded)
		controller.blackboard -= target_key
		return

/obj/item/clothing/neck/cloak/squid
	name = "squid cloak"
	desc = "It's all slimey and gooey..."
	icon_state = "squid_cloak"
	icon = 'fulp_modules/features/exclusive_fauna/icons/item_loot.dmi'
	worn_icon = 'fulp_modules/features/exclusive_fauna/icons/item_loot_worn.dmi'
	resistance_flags = FIRE_PROOF
	worn_icon_state = "squid_cloak"
	armor_type = /datum/armor/squid_cloak

/datum/armor/squid_cloak
	melee = 5
	bullet = 5
	laser = 5
	energy = 5
	bomb = 5
	fire = 5
	acid = 5

/datum/award/achievement/boss/king_slayer
	name = "King Slayer"
	desc = "We eating sushi tonight"
	database_id = BOSS_MEDAL_EXILED
	icon = "service_okay"


/datum/award/score/king_score
	name = "Exiled Kings Killed"
	desc = "You've killed HOW many?"
	database_id = EXILED_KING_SCORE


///stolen code from megafauna.dm to grant achievements
/mob/living/basic/exiled_king/proc/grant_achievement(medaltype, scoretype, list/grant_achievement = list())
	if(!achievement_type || (flags_1 & ADMIN_SPAWNED_1) || !SSachievements.achievements_enabled)
		return FALSE
	if(!grant_achievement.len)
		for(var/mob/living/L in view(7,src))
			grant_achievement += L
	for(var/mob/living/L in grant_achievement)
		if(L.stat || !L.client)
			continue
		L.add_mob_memory(/datum/memory/megafauna_slayer, antagonist = src)
		L.client.give_award(/datum/award/achievement/boss/boss_killer, L)
		L.client.give_award(achievement_type, L)
		L.client.give_award(/datum/award/score/boss_score, L)
		L.client.give_award(score_achievement_type, L)
	return TRUE
/obj/item/crusher_trophy/kraken_eye
	name = "kraken's eye"
	icon = 'fulp_modules/features/exclusive_fauna/icons/item_loot.dmi'
	icon_state = "squid_eye"
	desc = "A kraken's eye, how vile..."
	denied_type = /obj/item/crusher_trophy/kraken_eye
	///item ability that handles the effect
	var/datum/action/cooldown/mob_cooldown/tentacle_track/trophy/ability


/obj/effect/kraken_arm/track/trophy
	damage = 25
	delay_time = 0.5

/datum/action/cooldown/mob_cooldown/tentacle_track/trophy
	owner_has_control = FALSE

/obj/item/crusher_trophy/kraken_eye/Initialize(mapload)
	. = ..()
	ability = new()

/obj/item/crusher_trophy/kraken_eye/Destroy(force)
	. = ..()
	QDEL_NULL(ability)

/obj/item/crusher_trophy/kraken_eye/add_to(obj/item/kinetic_crusher/crusher, mob/living/user)
	. = ..()
	if(.)
		crusher.add_item_action(ability)

/obj/item/crusher_trophy/kraken_eye/remove_from(obj/item/kinetic_crusher/crusher, mob/living/user)
	. = ..()
	crusher.remove_item_action(ability)

/obj/item/crusher_trophy/kraken_eye/effect_desc()
	return "mark detonation launches tentacles from the ground that damage the enemy."

/obj/item/crusher_trophy/kraken_eye/on_mark_detonation(mob/living/target, mob/living/user)
	ability.InterceptClickOn(user, null, target)
