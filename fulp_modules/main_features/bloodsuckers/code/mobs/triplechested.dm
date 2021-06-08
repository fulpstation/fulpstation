/mob/living/simple_animal/hostile/retaliate/tzimisce/triplechested
	name = "flesh abomination"
	icon_state = "tarantula"
	icon_living = "tarantula"
	icon_dead = "tarantula_dead"
	maxHealth = 175
	health = 175
	melee_damage_lower = 35
	melee_damage_upper = 40
	obj_damage = 100
	speed = 1
	move_to_delay = 8
	mob_size = MOB_SIZE_LARGE
	damage_coeff = list(BRUTE = 0.5, BURN = 2, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 1)
	tzimisce_examinestring = "This type of creature is very slow and chunky, taken down easily by burn damage. \
	They're able to throw bodies, can move in no gravity and move faster on tiles with gibs."
	observer_examinestring = "This is a flesh creature made by a Tzimisce bloodsucker. \
	It's very slow, but can cause a lot of damage and even throw bodies."

/mob/living/simple_animal/hostile/retaliate/tzimisce/triplechested/mob_negates_gravity()
	return TRUE
