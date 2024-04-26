/**
 * ALL FULP AREAS GO HERE
 *
 * Sometimes we make an area that TG doesn't have
 * Instead of messing with people's minds and using some random area, we make our own.
 */

// Station/

/area/station/ai_monitored/turret_protected/ai_upload_foyer/command
	name = "\improper AI Upload Command Entrance"


/area/station/service/hydroponics/kitchen
	name = "\improper Kitchen Hydroponics"

/area/station/engineering/atmos/crystallizer
	name = "\improper Crystallizer"

/area/station/science/nanite
	name = "Nanite Lab"
	icon = 'fulp_modules/mapping/areas/icons.dmi'
	icon_state = "nanite_lab"

/area/station/service/lawoffice/upper
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

/area/station/hallway/secondary/entry/upper
	name = "\improper Upper Arrival Shuttle Hallway"
	icon = 'fulp_modules/mapping/areas/icons.dmi'
	icon_state = "upper_entry"

/area/station/hallway/secondary/entry/lower
	name = "\improper Lower Arrival Shuttle Hallway"
	icon = 'fulp_modules/mapping/areas/icons.dmi'
	icon_state = "lower_entry"

// Ruins

/area/ruin/powered/beefcyto
	name = "Research Outpost"
	icon_state = "dk_yellow"

/area/ruin/space/has_grav/powered/beef
	name = "beef station"
	icon = 'fulp_modules/mapping/areas/icons.dmi'
	icon_state = "beef_station"
	ambientsounds = list('fulp_modules/sounds/sound/ambience/beef_station.ogg')

/area/ruin/space/has_grav/powered/beef/atmos
	name = "beef station atmos"
	icon_state = "beef_station_atmos"

/area/ruin/space/has_grav/wonderland
	name = "Wonderland"
	icon_state = "green"
	ambience_index = AMBIENCE_SPOOKY
	sound_environment = SOUND_ENVIRONMENT_CAVE
	area_flags = UNIQUE_AREA | NOTELEPORT | HIDDEN_AREA | BLOCK_SUICIDE
	static_lighting = FALSE
	base_lighting_alpha = 255






/area/ruin/has_grav/prototype
	requires_power = TRUE
	outdoors = FALSE
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE

/area/ruin/has_grav/prototype/Captain
	name = "Prototype Captain's quarter"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "captain"

/area/ruin/has_grav/prototype/arrivals
	name = "Prototype Arrivals"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "entry"

/area/ruin/has_grav/prototype/hallway
	name = "Prototype Main Hallway"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "hall"

/area/ruin/has_grav/prototype/medsci
	name = "Prototype Med-Sci"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "medbay"

/area/ruin/has_grav/prototype/botany
	name = "Prototype Botany"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "hydro"

/area/ruin/has_grav/prototype/engineering
	name = "Prototype Engineering"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "engie"

/area/ruin/has_grav/prototype/solars
	name = "Prototype Solars"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "panels"

/area/ruin/has_grav/prototype/kitchen
	name = "Prototype Kitchen"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "kitchen"

/area/ruin/has_grav/prototype/brig
	name = "Prototype Brig"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "brig"

/area/ruin/has_grav/prototype/dorms
	name = "Prototype Dormitories"
	icon = 'icons/area/areas_station.dmi'
	icon_state = "dorms"
