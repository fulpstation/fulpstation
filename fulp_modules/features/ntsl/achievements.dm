#define FULP_ACHIEVEMENTS_SET 'fulp_modules/icons/achievements/achievements.dmi'

/datum/award/achievement/jobs/poly_silent
	name = "Silence Bird!"
	desc = "As a network admin create a script that mutes poly"
	database_id = MEDAL_BAD_BIRD
	icon = FULP_ACHIEVEMENTS_SET
	icon_state = "bird_silent"

/datum/award/achievement/jobs/poly_loud
	name = "Embrace The Bird!"
	desc = "As a network admin create a script that makes poly LOUD"
	database_id = MEDAL_GOOD_BIRD
	icon = FULP_ACHIEVEMENTS_SET
	icon_state = "bird_loud"

#undef FULP_ACHIEVEMENTS_SET
