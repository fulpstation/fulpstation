/mob/living/basic/bloodsucker
	icon = 'fulp_modules/icons/antagonists/bloodsuckers/bloodsucker_mobs.dmi'

	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_sound = 'sound/items/weapons/slash.ogg'

	see_in_dark = 10
	mob_size = MOB_SIZE_LARGE
	gold_core_spawnable = FALSE
	movement_type = GROUND
	faction = list(FACTION_HOSTILE, FACTION_BLOODHUNGRY)

	response_help_continuous = "touches"
	response_help_simple = "touch"
	response_disarm_continuous = "flails at"
	response_disarm_simple = "flail at"
	response_harm_continuous = "punches"
	response_harm_simple = "punch"

	var/mob/living/bloodsucker
