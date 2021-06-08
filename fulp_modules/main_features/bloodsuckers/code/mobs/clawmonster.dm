/mob/living/simple_animal/hostile/retaliate/tzimisce/clawmonster
	name = "clawed monster"
	icon_state = "tarantula"
	icon_living = "tarantula"
	icon_dead = "tarantula_dead"
	maxHealth = 100
	health = 100
	melee_damage_lower = 20
	melee_damage_upper = 25
	speed = 0.5
	damage_coeff = list(BRUTE = 0.3, BURN = 0.9, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 1)
	tzimisce_examinestring = "This type of creature is slow, but compensates by being able to slow down targets with a projectile."
	observer_examinestring = "This is a monster with a clawed hand created by a Tzimisce Bloodsucker. \
	It's relatively tough, and can launch a slowing projectile."
