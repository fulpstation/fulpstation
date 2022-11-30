/**
 * ALL FULP AREAS GO HERE
 *
 * Sometimes we make an area that TG doesn't have
 * Instead of messing with people's minds and using some random area, we make our own.
 */

// Station

/area/service/lawoffice/upper
	name = "\improper Upper Law Office"

/area/station/ai_monitored/turret_protected/aisat/solars
	name = "\improper AI Satellite Solars"
	icon = 'fulp_modules/mapping/areas/icons.dmi'
	icon_state = "ai_solars"

/area/station/solars/ai
	name = "\improper AI Satellite Solar Array"
	icon = 'fulp_modules/mapping/areas/icons.dmi'
	icon_state = "ai_panels"

/area/station/maintenance/department/medical/plasmaman
	name = "\improper Plasmaman Medbay"
	icon = 'fulp_modules/mapping/areas/icons.dmi'
	icon_state = "pm_medbay"

/area/station/security/brig/hallway
	name = "\improper Brig Hallway"
	icon = 'fulp_modules/mapping/areas/icons.dmi'
	icon_state = "brig_hallway"

/area/station/security/prison/safe/exterior
	name = "\improper Prison Exterior"
	icon = 'fulp_modules/mapping/areas/icons.dmi'
	icon_state = "prison_ext_safe"

// Ruins

/area/ruin/powered/beefcyto
	name = "Research Outpost"
	icon_state = "dk_yellow"

/area/ruin/space/has_grav/powered/beef
	name = "beef station"
	icon_state = "green"
	ambientsounds = list('fulp_modules/sounds/sound/ambience/beef_station.ogg')
