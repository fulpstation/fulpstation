/**
 * NOTE: Cargo and Emergency shuttle is added via the map's .json - The rest is done in the map itself!
 */

/**
 * CARGO
 */
/datum/map_template/shuttle/cargo/fulp

/datum/map_template/shuttle/cargo/fulp/selene // Selenestation
	suffix = "selene"
	name = "supply shuttle (Selene)"

/datum/map_template/shuttle/cargo/fulp/helio // Heliostation
	suffix = "helio"
	name = "cargo ferry (Helio)"

/datum/map_template/shuttle/cargo/fulp/solitaire // Solitairestation
	suffix = "solitaire"
	name = "cargo ferry (Solitaire)"

/**
 * ARRIVALS
 */
/datum/map_template/shuttle/arrival/fulp

/datum/map_template/shuttle/arrival/fulp/selene
	suffix = "selene"
	name = "arrival shuttle (Selene)"

/datum/map_template/shuttle/arrival/fulp/solitaire // Solitairestation
	suffix = "solitaire"
	name = "arrival shuttle (Solitaire)"

/**
 * MINING
 */
/datum/map_template/shuttle/mining/fulp

/datum/map_template/shuttle/mining/fulp/selene // Selenestation
	suffix = "selene"
	name = "mining shuttle (Selene)"

/**
 * FERRY
 */
/datum/map_template/shuttle/ferry/fulp
	prefix = "fulp_modules/mapping/shuttles/ferry/"

/datum/map_template/shuttle/ferry/fulp/solitaire // Solitairestation
	suffix = "solitaire"
	name = "ferry (Solitaire)"

/**
 * EMERGENCY SHUTTLE
 */
/datum/map_template/shuttle/emergency/fulp
	suffix = "selene"
	name = "Selene Station Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 4
	description = "The standard-issue escape shuttle for models of station this large. Will get you home in moderate style."
