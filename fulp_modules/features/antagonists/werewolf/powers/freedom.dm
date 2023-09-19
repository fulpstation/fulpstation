/datum/action/cooldown/spell/werewolf/freedom
	name = "Freedom"
	desc = "Break out of any cuffs restraining you"
	button_icon = 'icons/hud/implants.dmi'
	button_icon_state = "freedom"
	power_flags = WP_TRANSFORM_REQUIRED



/datum/action/cooldown/spell/werewolf/freedom/activate_power()
	. = ..()
	var/mob/living/carbon/target = owner
	if(!iscarbon(target))
		return FALSE
	target.uncuff()
	to_chat(owner, span_notice("You break free of your restraints!" ))
