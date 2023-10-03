/datum/movespeed_modifier/werewolf_rush
	multiplicative_slowdown = -0.30 // Werewolf already has a base movespeed buff, so this adds onto it

/datum/action/cooldown/spell/werewolf_rush
	name = "Rush"
	desc = "Gain a speed boost and ignore damage slowdown, but you won't be able to attack or use your hands for the duration."
	cooldown_time = 30 SECONDS
	spell_requirements = NONE
	var/activated = FALSE

/datum/action/cooldown/spell/werewolf_rush/can_cast_spell(feedback)
	if(activated)
		return FALSE
	return ..()


/datum/action/cooldown/spell/werewolf_rush/before_cast(atom/cast_on)
	. = ..()
	return SPELL_NO_IMMEDIATE_COOLDOWN

/datum/action/cooldown/spell/werewolf_rush/cast(mob/living/carbon/caster)
	caster.add_movespeed_modifier(/datum/movespeed_modifier/werewolf_rush)
	caster.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	ADD_TRAIT(caster, TRAIT_HANDS_BLOCKED, WEREWOLF_TRAIT)
	activated = TRUE
	addtimer(CALLBACK(src, PROC_REF(deactivate), caster), WP_RUSH_DURATION)
	return ..()

/datum/action/cooldown/spell/werewolf_rush/proc/deactivate(mob/living/carbon/caster)
	caster.remove_movespeed_modifier(/datum/movespeed_modifier/werewolf_rush)
	caster.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	REMOVE_TRAIT(caster, TRAIT_HANDS_BLOCKED, WEREWOLF_TRAIT)
	activated = FALSE
	StartCooldown()
