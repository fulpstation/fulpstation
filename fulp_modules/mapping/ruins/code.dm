/**
 * # Ruins
 *
 * We're setting all Fulp-only ruins to use our prefixes instead
 * This way, we can modularly and easily add as many ruins as we want
 * This makes TGU's easier on us, since we have less files to worry about.
 *
 * Note: Maps must be placed in the general icemoon/lavaland/space folder,
 * rather than the folder with the spawner's code.
 */

/datum/map_template/ruin/icemoon/fulp
	prefix = "fulp_modules/mapping/ruins/icemoon/"

/datum/map_template/ruin/icemoon/underground/fulp
	prefix = "fulp_modules/mapping/ruins/icemoon/"

/datum/map_template/ruin/lavaland/fulp
	prefix = "fulp_modules/mapping/ruins/lavaland/"

/datum/map_template/ruin/space/fulp
	prefix = "fulp_modules/mapping/ruins/space/"
