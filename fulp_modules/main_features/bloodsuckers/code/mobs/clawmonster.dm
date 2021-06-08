/mob/living/simple_animal/hostile/retaliate/tzimisce_clawmonster
	name = "clawed monster"
	desc = "It's a very disturbing abomination. Is it looking at you?"
	icon = 'icons/mob/animal.dmi' // Placeholder until actual sprite
	icon_state = "tarantula"
	icon_living = "tarantula"
	icon_dead = "tarantula_dead"
	maxHealth = 100
	health = 100
	melee_damage_lower = 20
	melee_damage_upper = 25
	melee_damage_type = BURN
	attack_verb_continuous = list("claws", "slashes")
	attack_verb_simple = list("claw", "slash")
	speed = 0.5
	turns_per_move = 5
	see_in_dark = 4
	attack_vis_effect = ATTACK_EFFECT_CLAW
	initial_language_holder = /datum/language_holder/vampiric_mob
	damage_coeff = list(BRUTE = 0.3, BURN = 0.9, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 1)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)

/mob/living/simple_animal/hostile/retaliate/tzimisce_clawmonster/examine(mob/user)
	. = ..()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	if(isobserver(user))
		. += {"<span class='cult'>This is a monster with a clawed hand created by a Tzimisce Bloodsucker.</span>"}
		. += {"<span class='cult'>It claws at its victims, and can launch a slowing projectile.</span>"}
	if(bloodsuckerdatum)
		if(bloodsuckerdatum.my_clan == CLAN_TZIMISCE)
			. += {"<span class='cult'>These are grotesque creatures composed of our victims.</span>"}
			. += {"<span class='cult'>This type of creature is slow, but compensates by being able to slow down targets with a projectile.</span>"}
		else
			. += {"<span class='cult'>This is a creature made by a Tzimisce bloodsucker.</span>"}
			. += {"<span class='cult'>They are resistant to attacks, and their claws do piercing burn damage to us.</span>"}
