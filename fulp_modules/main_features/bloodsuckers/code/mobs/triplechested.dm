/mob/living/simple_animal/hostile/retaliate/tzimisce_triplechested
	name = "flesh abomination"
	desc = "It's a very disturbing abomination. Is it looking at you?"
	icon = 'icons/mob/animal.dmi' // Placeholder until actual sprite
	icon_state = "tarantula"
	icon_living = "tarantula"
	icon_dead = "tarantula_dead"
	maxHealth = 175
	health = 175
	melee_damage_lower = 35
	melee_damage_upper = 40
	melee_damage_type = BURN
	obj_damage = 100
	attack_verb_continuous = list("claws", "slashes")
	attack_verb_simple = list("claw", "slash")
	speed = 1
	turns_per_move = 5
	see_in_dark = 4
	move_to_delay = 8
	mob_size = MOB_SIZE_LARGE
	attack_vis_effect = ATTACK_EFFECT_CLAW
	initial_language_holder = /datum/language_holder/vampiric_mob
	damage_coeff = list(BRUTE = 0.5, BURN = 2, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 1)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)

/mob/living/simple_animal/hostile/retaliate/tzimisce_triplechested/mob_negates_gravity()
	return TRUE

/mob/living/simple_animal/hostile/retaliate/tzimisce_triplechested/examine(mob/user)
	. = ..()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	if(isobserver(user))
		. += {"<span class='cult'>This is a monster created by a Tzimisce Bloodsucker.</span>"}
		. += {"<span class='cult'>It's very slow, but can cause a lot of damage and even throw bodies.</span>"}
	if(bloodsuckerdatum)
		if(bloodsuckerdatum.my_clan == CLAN_TZIMISCE)
			. += {"<span class='cult'>These are grotesque creatures composed of our victims.</span>"}
			. += {"<span class='cult'>This type of creature is very slow and chunky, taken down easily by burn damage.</span>"}
			. += {"<span class='cult'>They're able to throw bodies, can move in no gravity and move faster on tiles with gibs.</span>"}
		else
			. += {"<span class='cult'>This is a creature made by a Tzimisce bloodsucker.</span>"}
			. += {"<span class='cult'>They are resistant to attacks, and their claws do piercing burn damage to us.</span>"}
