/datum/lazy_template/deathmatch/pandamonium
	name = "Pandamonium"
	map_dir = "fulp_modules/mapping/deathmatch/maps"
	desc = "Release the beast in the panda way!"
	max_players = 16
	allowed_loadouts = list(
		/datum/outfit/deathmatch_loadout/gladiator,
		/datum/outfit/deathmatch_loadout/naked,
	)
	map_name = "pandamonium"
	key = "pandamonium"

/datum/lazy_template/deathmatch/industrial
	name = "Industrial"
	map_dir = "fulp_modules/mapping/deathmatch/maps"
	desc = "Only one of us is getting that promotion!"
	max_players = 15
	allowed_loadouts = list(
		/datum/outfit/deathmatch_loadout/worker,
		/datum/outfit/deathmatch_loadout/maintenance,
		/datum/outfit/deathmatch_loadout/guard,
		/datum/outfit/deathmatch_loadout/supervisor,
	)
	map_name = "industrial"
	key = "industrial"
