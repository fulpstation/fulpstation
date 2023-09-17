/datum/action/cooldown/werewolf/transform
	name = "Transform"
	desc = "Transform into werewolf form"
	button_icon_state = "power_human"
	power_flags = WP_TOGGLED
	check_flags = 0

/datum/action/cooldown/werewolf/transform/activate_power()
	werewolf_datum_power.toggle_transformation()
	to_chat(usr, span_notice("transformed toggled to [werewolf_datum_power.transformed]"))
