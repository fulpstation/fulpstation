// We set Fulp shuttles to use our prefix instead - Selene is our base just beacuse they have them all.

/// Cargo
/datum/map_template/shuttle/cargo/fulp
	prefix = "fulp_modules/mapping/shuttles/cargo/"
	suffix = "cargo_selene"
	name = "supply shuttle (Selene)"

/datum/map_template/shuttle/cargo/fulp/helio // Heliostation
	suffix = "cargo_helio"
	name = "cargo ferry (Helio)"

/// Arrival
/datum/map_template/shuttle/arrival/fulp
	prefix = "fulp_modules/mapping/shuttles/arrival/"
	suffix = "arrival_selene"
	name = "arrival shuttle (Selene)"

/// Emergency
/datum/map_template/shuttle/emergency/fulp
	prefix = "fulp_modules/mapping/shuttles/evac/"
	suffix = "emergency_selene"
	name = "Selene Station Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 4
	description = "The standard-issue escape shuttle for models of station this large. Will get you home in moderate style."

/// Mining
/datum/map_template/shuttle/mining/fulp
	prefix = "fulp_modules/mapping/shuttles/mining/"
	suffix = "mining_selene"
	name = "mining shuttle (Selene)"

