/datum/action/cooldown/spell/werewolf/transform
	name = "Transform"
	desc = "Transform into werewolf form"
	button_icon_state = "power_human"
	power_flags = WP_TOGGLED

/datum/action/cooldown/spell/werewolf/transform/activate_power()
	werewolf_datum_power.toggle_transformation()
	to_chat(usr, span_notice("transformed toggled to [werewolf_datum_power.transformed]"))
