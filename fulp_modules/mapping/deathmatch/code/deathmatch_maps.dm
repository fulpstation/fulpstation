/datum/lazy_template/deathmatch/fulp
	map_dir = "fulp_modules/mapping/deathmatch/maps"

/datum/lazy_template/deathmatch/pandamonium
	name = "Pandamonium"
	desc = "Release the beast in the panda way!"
	max_players = 16
	allowed_loadouts = list(
		/datum/outfit/deathmatch_loadout/gladiator,
		/datum/outfit/deathmatch_loadout/naked,
	)
	map_name = "pandamonium"
	key = "pandamonium"

/datum/lazy_template/deathmatch/heliocentric
	name = "Heliocentric"
	desc = "Nostalgic five-tile wide hallways."
	max_players = 15
	allowed_loadouts = list(
		/datum/outfit/deathmatch_loadout/assistant,
		/datum/outfit/deathmatch_loadout/naked,
	)
	map_name = "heliocentric"
	key = "heliocentric"
