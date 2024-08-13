/area/deathmatch
	name = "Deathmatch Arena"
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	area_flags = UNIQUE_AREA | NOTELEPORT | ABDUCTOR_PROOF | EVENT_PROTECTED | QUIET_LOGS

/area/deathmatch/fullbright
	static_lighting = FALSE
	base_lighting_alpha = 255

/obj/effect/landmark/deathmatch_player_spawn
	name = "Deathmatch Player Spawner"

/area/deathmatch/teleport //Prevent access to cross-z teleportation in the map itself (no wands of safety/teleportation scrolls). Cordons should prevent same-z teleportations outside of the arena.
	area_flags = UNIQUE_AREA | ABDUCTOR_PROOF | EVENT_PROTECTED | QUIET_LOGS
