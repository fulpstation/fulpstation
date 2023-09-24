/datum/action/cooldown/spell/werewolf_freedom
	name = "Freedom"
	desc = "Break out of any cuffs restraining you"
	button_icon = 'icons/hud/implants.dmi'
	button_icon_state = "freedom"
	spell_requirements = NONE

/datum/action/cooldown/spell/werewolf_freedom/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/target = cast_on
	if(!iscarbon(target))
		return FALSE

	target.uncuff()
	to_chat(owner, span_notice("You break free of your restraints!" ))
