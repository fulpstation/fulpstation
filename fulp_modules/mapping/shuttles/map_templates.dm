/**
 * NOTE: Cargo and Emergency shuttle is added via the map's .json - The rest is done in the map itself!
 */

/**
 * CARGO
 */
/datum/map_template/shuttle/cargo/fulp/fulp // Fulpstation
	suffix = "fulp"
	name = "supply shuttle (Fulp)"

/datum/map_template/shuttle/cargo/fulp/selene // Selenestation
	suffix = "selene"
	name = "supply shuttle (Selene)"

/datum/map_template/shuttle/cargo/fulp/helio // Heliostation
	suffix = "helio"
	name = "cargo ferry (Helio)"

/**
 * ARRIVALS
 */
/datum/map_template/shuttle/arrival/fulp

/datum/map_template/shuttle/arrival/fulp/fulpstation
	suffix = "fulp"
	name = "arrival shuttle (Fulp)"

/datum/map_template/shuttle/arrival/fulp/selene
	suffix = "selene"
	name = "arrival shuttle (Selene)"

/datum/map_template/shuttle/arrival/fulp/helio
	suffix = "helio"
	name = "arrival shuttle (Helio)"

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

/**
 * EMERGENCY SHUTTLE
 */
/datum/map_template/shuttle/emergency/fulp
	suffix = "selene"
	name = "Selene Station Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 4
	description = "The standard-issue escape shuttle for models of station this large. Will get you home in moderate style."
	occupancy_limit = "50"

/datum/map_template/shuttle/emergency/fulp/helio
	suffix = "helio"
	name = "Helio Station Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 4
	description = "For when you're not quite ready to say goodbye to your home station. Big shuttle with lots of space."
	admin_notes = "Comes with an immortal barmaid and bardrone."
	occupancy_limit = "50"

/datum/map_template/shuttle/emergency/fulp/theia
	suffix = "theia"
	name = "Theia Station Emergency Shuttle"
	credit_cost = CARGO_CRATE_VALUE * 4
	description = "A mid-sized shuttle with lots of open space; equipped with all essential amenities and a coffee shop!"
	occupancy_limit = "45"

/**
 * LABOUR SHUTTLE
 */

/datum/map_template/shuttle/labour/helio
	suffix = "helio"
	name = "labour shuttle (Helio)"

/obj/docking_port/stationary/laborcamp_home/helio
	roundstart_template = /datum/map_template/shuttle/labour/helio

/datum/map_template/shuttle/labour/selene
	suffix = "selene"
	name = "labour shuttle (Selene)"
