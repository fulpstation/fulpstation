/datum/action/cooldown/spell/pointed/projectile/fireball/hellish
	name = "Hellfire"
	background_icon_state = "bg_demon"
	overlay_icon_state = "ab_goldborder"

	school = SCHOOL_FORBIDDEN
	invocation = "W'lc'me 'o th' f're' pi's!"
	invocation_type = INVOCATION_SHOUT

	cooldown_time = 8 SECONDS
	spell_requirements = NONE

	projectile_type = /obj/projectile/magic/fireball/infernal

/obj/projectile/magic/fireball/infernal
	name = "infernal fireball"
	exp_heavy = -1
	exp_light = -1
	exp_flash = 4
	exp_fire = 5
