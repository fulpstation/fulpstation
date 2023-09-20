/datum/action/cooldown/spell/werewolf_transform
	name = "Transform"
	desc = "Transform into werewolf form"
	button_icon_state = "power_human"
	spell_requirements = NONE

/datum/action/cooldown/spell/werewolf_transform/cast(atom/cast_on)
	SEND_SIGNAL(cast_on, COMSIG_WEREWOLF_TRANSFORM_CAST)
	..()
