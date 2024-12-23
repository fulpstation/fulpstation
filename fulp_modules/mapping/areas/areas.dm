/**
 * ALL FULP AREAS GO HERE
 *
 * Sometimes we make an area that TG doesn't have
 * Instead of messing with people's minds and using some random area, we make our own.
 */

/// == Station == ///

/area/station/ai_monitored/turret_protected/ai_upload_foyer/command
	name = "\improper AI Upload Command Entrance"


/area/station/service/hydroponics/kitchen
	name = "\improper Kitchen Hydroponics"

/area/station/engineering/atmos/crystallizer
	name = "\improper Crystallizer"

/area/station/science/nanite
	name = "Nanite Lab"
	icon = 'fulp_modules/icons/mapping/areas.dmi'
	icon_state = "nanite_lab"

/area/station/service/lawoffice/upper
	name = "\improper Upper Law Office"

/area/station/ai_monitored/turret_protected/aisat/solars
	name = "\improper AI Satellite Solars"
	icon = 'fulp_modules/icons/mapping/areas.dmi'
	icon_state = "ai_solars"

/area/station/solars/ai
	name = "\improper AI Satellite Solar Array"
	icon = 'fulp_modules/icons/mapping/areas.dmi'
	icon_state = "ai_panels"

/area/station/maintenance/department/medical/plasmaman
	name = "\improper Plasmaman Medbay"
	icon = 'fulp_modules/icons/mapping/areas.dmi'
	icon_state = "pm_medbay"

/area/station/security/brig/hallway
	name = "\improper Brig Hallway"
	icon = 'fulp_modules/icons/mapping/areas.dmi'
	icon_state = "brig_hallway"

/area/station/security/prison/safe/exterior
	name = "\improper Prison Exterior"
	icon = 'fulp_modules/icons/mapping/areas.dmi'
	icon_state = "prison_ext_safe"

/area/station/hallway/secondary/entry/upper
	name = "\improper Upper Arrival Shuttle Hallway"
	icon = 'fulp_modules/icons/mapping/areas.dmi'
	icon_state = "upper_entry"

/area/station/hallway/secondary/entry/lower
	name = "\improper Lower Arrival Shuttle Hallway"
	icon = 'fulp_modules/icons/mapping/areas.dmi'
	icon_state = "lower_entry"

/area/station/maintenance/department/security/dungeon
	name = "\improper Dungeon"

/area/station/maintenance/aft/backrooms
	name = "\improper Auxiliary Backrooms"

/area/station/hallway/secondary/exit/escape_pod/secondary
	name = "\improper Auxiliary Pod Array"

/area/station/security/courtroom/courthouse
	name = "\improper Station Courthouse"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/station/command/heads_quarters/captain/private/panicbunker
	name = "\improper Panic Bunker"
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED
	ambience_index = AMBIENCE_DANGER

/area/station/maintenance/department/cargo/mining
	name = "\improper Mining Maintenance"

/// == Ruins == ///

/area/ruin/powered/beefcyto
	name = "Research Outpost"
	icon_state = "dk_yellow"

// -- Beefstation ruin start -- //

/area/ruin/space/has_grav/beef
	name = "beef station"
	icon = 'fulp_modules/icons/mapping/areas.dmi'
	icon_state = "beef_station"
	ambientsounds = list('fulp_modules/sounds/ambience/beef_station.ogg')
	flags_1 = NONE

/area/ruin/space/has_grav/beef/atmos
	name = "beef station atmospherics"
	icon_state = "beef_station_atmos"
	ambientsounds = null
	ambience_index = AMBIENCE_ENGI

/area/ruin/space/has_grav/beef/kitchen
	name = "beef station kitchen"
	icon_state = "beef_kitchen"

/area/ruin/space/has_grav/beef/cold_room
	name = "beef station cold room"
	icon_state = "beef_cold_room"
	ambientsounds = null //See comment below

/area/ruin/space/has_grav/beef/beef_ball_room
	name = "beef station ball room"
	icon_state = "beef_ball_room"
	ambientsounds = null //To prevent the ambient music from playing over jukebox music.

/area/ruin/space/has_grav/beef/beef_restroom
	name = "beef station restroom"
	icon_state = "beef_rest_room"
	ambientsounds = null //See comment above

/area/ruin/space/has_grav/beef/security
	name = "beef station brig"
	icon_state = "beef_security"

/area/ruin/space/has_grav/beef/medical
	name = "beef station infirmary"
	icon_state = "beef_medical"
	ambientsounds = null
	ambience_index = AMBIENCE_MEDICAL

/area/ruin/space/has_grav/beef/hyrdroponics
	name = "beef station hydroponics"
	icon_state = "beef_hydro"

/area/ruin/space/has_grav/beef/library
	name = "beef station library"
	icon_state = "beef_library"

/area/ruin/space/has_grav/beef/beef_bar
	name = "beef station bar"
	icon_state = "beef_bar"

/area/ruin/space/has_grav/beef/beef_entertainment_center
	name = "beef station fun center"
	icon_state = "beef_fun"

/area/ruin/space/has_grav/beef/beef_entrance
	name = "beef station entrance"
	icon_state = "beef_entry"

/area/ruin/space/has_grav/beef/beef_storage
	name = "beef station hidden storage"
	icon_state = "beef_storage"

// - Beefstation ruin end - //

/area/ruin/space/has_grav/disco_shrine
	name = "Disco Shrine"
	icon = 'fulp_modules/icons/mapping/areas.dmi'
	icon_state = "disco_shrine"
	base_lighting_alpha = 128
	base_lighting_color = "#AA00FF"
	flags_1 = NONE

/area/ruin/space/has_grav/cateor_shrine
	name = "Cateor Shrine"
	icon = 'fulp_modules/icons/mapping/areas.dmi'
	icon_state = "cateor_shrine"
	base_lighting_alpha = 128
	base_lighting_color = "#FF00D4"

/area/ruin/space/has_grav/wonderland
	name = "Wonderland"
	icon_state = "green"
	ambience_index = AMBIENCE_SPOOKY
	sound_environment = SOUND_ENVIRONMENT_CAVE
	area_flags = UNIQUE_AREA | NOTELEPORT | HIDDEN_AREA | BLOCK_SUICIDE
	base_lighting_alpha = 128
	base_lighting_color = "#FFDD77"

/area/ruin/space/has_grav/wonderchess
	name = "Wonderland Chess Board"
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
	icon = 'icons/area/areas_station.dmi'

/area/ruin/has_grav/prototype/Captain
	name = "Prototype Captain's quarter"
	icon_state = "captain"

/area/ruin/has_grav/prototype/arrivals
	name = "Prototype Arrivals"
	icon_state = "entry"

/area/ruin/has_grav/prototype/hallway
	name = "Prototype Main Hallway"
	icon_state = "hall"

/area/ruin/has_grav/prototype/medsci
	name = "Prototype Med-Sci"
	icon_state = "medbay"

/area/ruin/has_grav/prototype/botany
	name = "Prototype Botany"
	icon_state = "hydro"

/area/ruin/has_grav/prototype/engineering
	name = "Prototype Engineering"
	icon_state = "engie"

/area/ruin/has_grav/prototype/solars
	name = "Prototype Solars"
	icon_state = "panels"

/area/ruin/has_grav/prototype/kitchen
	name = "Prototype Kitchen"
	icon_state = "kitchen"

/area/ruin/has_grav/prototype/brig
	name = "Prototype Brig"
	icon_state = "brig"

/area/ruin/has_grav/prototype/dorms
	name = "Prototype Dormitories"
	icon_state = "dorms"
