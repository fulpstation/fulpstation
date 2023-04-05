/**
 * Spawned by rabbit power
 */
/mob/living/basic/killer_rabbit
	name = "killer baby rabbit"
	desc = "A cute little rabbit, surely its harmless... right?"
	icon = 'fulp_modules/features/antagonists/monster_hunter/icons/rabbit.dmi'
	icon_state = "killer_rabbit"
	maxHealth = 5
	melee_damage_lower = 5
	melee_damage_upper = 5
	faction = list(FACTION_RABBITS)
	ai_controller = /datum/ai_controller/basic_controller/killer_rabbit
	basic_mob_flags = DEL_ON_DEATH

/mob/living/basic/killer_rabbit/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_HOSTILE_POST_ATTACKINGTARGET, PROC_REF(hostile_attackingtarget))

/mob/living/basic/killer_rabbit/proc/hostile_attackingtarget(mob/living/basic/source, atom/target, success)
	SIGNAL_HANDLER

	if(!success || !ishuman(target))
		return
	explosion(src, heavy_impact_range = 1, light_impact_range = 1, flame_range = 2)
	gib(src)

/**
 * AI controller
 */
/datum/ai_controller/basic_controller/killer_rabbit
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic(),
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk/less_walking
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/rabbit,
	)
