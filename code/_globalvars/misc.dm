GLOBAL_VAR_INIT(admin_notice, "") // Admin notice that all clients see when joining the server

GLOBAL_VAR_INIT(timezoneOffset, 0) // The difference betwen midnight (of the host computer) and 0 world.ticks.

GLOBAL_VAR_INIT(year, time2text(world.realtime,"YYYY"))
GLOBAL_VAR_INIT(year_integer, text2num(year)) // = 2013???

	// For FTP requests. (i.e. downloading runtime logs.)
	// However it'd be ok to use for accessing attack logs and such too, which are even laggier.
GLOBAL_VAR_INIT(fileaccess_timer, 0)

GLOBAL_DATUM_INIT(data_core, /datum/datacore, new)

GLOBAL_VAR_INIT(CELLRATE, 0.002)  // conversion ratio between a watt-tick and kilojoule
GLOBAL_VAR_INIT(CHARGELEVEL, 0.001) // Cap for how fast cells charge, as a percentage-per-tick (.001 means cellcharge is capped to 1% per second)

GLOBAL_LIST_EMPTY(powernets)

GLOBAL_VAR_INIT(bsa_unlock, FALSE) //BSA unlocked by head ID swipes

GLOBAL_LIST_EMPTY(player_details) // ckey -> /datum/player_details

///All currently running polls held as datums
GLOBAL_LIST_EMPTY(polls)
GLOBAL_PROTECT(polls)

///All poll option datums of running polls
GLOBAL_LIST_EMPTY(poll_options)
GLOBAL_PROTECT(poll_options)

GLOBAL_VAR_INIT(internal_tick_usage, 0.2 * world.tick_lag)

GLOBAL_VAR_INIT(glowshrooms, 0)

/// If drones are blacklisted from certain sensitive machines
GLOBAL_VAR_INIT(drone_machine_blacklist_enabled, TRUE)
