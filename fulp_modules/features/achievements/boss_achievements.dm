#define BOSS_MEDAL_EXILED "Exiled Killer"
#define EXILED_KING_SCORE "Exiled Killed"

/datum/award/achievement/boss/king_slayer
	name = "King Slayer"
	desc = "We eating sushi tonight"
	database_id = BOSS_MEDAL_EXILED
	icon = "service_okay"

/datum/award/score/king_score
	name = "Exiled Kings Killed"
	desc = "You've killed HOW many?"
	database_id = EXILED_KING_SCORE

#undef BOSS_MEDAL_EXILED
#undef EXILED_KING_SCORE
