// We set Fulp shuttles to use our prefix instead - Selene is our base just beacuse they have them all.
// NOTE: Cargo and Emergency shuttle is added via the map's .json - The rest is done in the map itself!

/// Cargo
/datum/map_template/shuttle/cargo/fulp
	prefix = "fulp_modules/mapping/shuttles/cargo/"
	suffix = "selene"
	name = "supply shuttle (Selene)"

/datum/map_template/shuttle/cargo/fulp/helio // Heliostation
	suffix = "helio"
	name = "cargo ferry (Helio)"

/datum/map_template/shuttle/cargo/fulp/solitaire // Solitairestation
	suffix = "solitaire"
	name = "cargo ferry (Solitaire)"

/datum/map_template/shuttle/cargo/fulp/eos // eosstation
	suffix = "eos"
	name = "cargo ferry (Eos)"


/// Arrival
/datum/map_template/shuttle/arrival/fulp
	prefix = "fulp_modules/mapping/shuttles/arrival/"
	suffix = "selene"
	name = "arrival shuttle (Selene)"

/datum/map_template/shuttle/arrival/fulp/solitaire // Solitairestation
	prefix = "fulp_modules/mapping/shuttles/arrival/"
	suffix = "solitaire"
	name = "arrival shuttle (Solitaire)"

/// Mining
/datum/map_template/shuttle/mining/fulp
	prefix = "fulp_modules/mapping/shuttles/mining/"
	suffix = "selene"
	name = "mining shuttle (Selene)"

/// Ferry
/datum/map_template/shuttle/ferry/fulp // Solitairestation
	prefix = "fulp_modules/mapping/shuttles/ferry/"
	suffix = "solitaire"
	name = "ferry (Solitaire)"

/// Emergency
/datum/map_template/shuttle/emergency/fulp
	prefix = "fulp_modules/mapping/shuttles/evac/"
	suffix = "selene"
	name = "Selene Station Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 4
	description = "The standard-issue escape shuttle for models of station this large. Will get you home in moderate style."
