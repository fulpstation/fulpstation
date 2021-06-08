/mob/living/simple_animal/hostile/retaliate/tzimisce
	name = "flesh abomination"
	desc = "It's a very disturbing abomination. Is it looking at you?"
	icon = 'icons/mob/animal.dmi' // Placeholder until actual sprite
	icon_state = "tarantula"
	icon_living = "tarantula"
	icon_dead = "tarantula_dead"
	melee_damage_type = BURN
	attack_verb_continuous = list("claws", "slashes")
	attack_verb_simple = list("claw", "slash")
	turns_per_move = 5
	see_in_dark = 4
	attack_vis_effect = ATTACK_EFFECT_CLAW
	initial_language_holder = /datum/language_holder/vampiric_mob
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)

	/// What the Tzimisce sees upon examining the monster.
	var/tzimisce_examinestring
	/// What an observer sees upon examining the monster.
	var/observer_examinestring

/mob/living/simple_animal/hostile/retaliate/tzimisce/examine(mob/user)
	. = ..()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	if(isobserver(user))
		. += {"<span class='cult'>[observer_examinestring]</span>"}
	if(bloodsuckerdatum)
		if(bloodsuckerdatum.my_clan == CLAN_TZIMISCE)
			. += {"<span class='cult'>These are grotesque creatures composed of our victims.</span>"}
			. += {"<span class='cult'>[tzimisce_examinestring]</span>"}
		else
			. += {"<span class='cult'>This is a creature made by a Tzimisce bloodsucker.</span>"}
			. += {"<span class='cult'>They are resistant to brute attacks, and their claws do piercing burn damage to us.</span>"}
