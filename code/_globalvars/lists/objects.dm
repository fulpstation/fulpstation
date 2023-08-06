/// List of all cables, so that powernets don't have to look through the entire world all the time
GLOBAL_LIST_EMPTY(cable_list)

/// List of all portals
GLOBAL_LIST_EMPTY(portals)

/// List of all curtains for button tracking
GLOBAL_LIST_EMPTY(curtains)

/// List of all mechs for hostile mob target tracking
GLOBAL_LIST_EMPTY(mechas_list)

/// List of all atoms that can call the shuttle, for automatic shuttle calls when there are none.
GLOBAL_LIST_EMPTY(shuttle_caller_list)

/// List of all nukie shuttle boards, for forcing launch delay if they declare war
GLOBAL_LIST_EMPTY(syndicate_shuttle_boards)

/// List of all nav beacons indexed by stringified z level
GLOBAL_LIST_EMPTY(navbeacons)

/// List of all active teleport beacons
GLOBAL_LIST_EMPTY(teleportbeacons)

/// List of all active delivery beacons
GLOBAL_LIST_EMPTY(deliverybeacons)

/// List of all active delivery beacon locations
GLOBAL_LIST_EMPTY(deliverybeacontags)

/// List of all singularity components that exist
GLOBAL_LIST_EMPTY_TYPED(singularities, /datum/component/singularity)

/// list of all /datum/chemical_reaction datums indexed by their typepath. Use this for general lookup stuff
GLOBAL_LIST(chemical_reactions_list)
/// list of all /datum/chemical_reaction datums. Used during chemical reactions. Indexed by REACTANT types
GLOBAL_LIST(chemical_reactions_list_reactant_index)
/// list of all /datum/chemical_reaction datums. Used for the reaction lookup UI. Indexed by PRODUCT type
GLOBAL_LIST(chemical_reactions_list_product_index) /// list of all /datum/reagent datums indexed by reagent id. Used by chemistry stuff
GLOBAL_LIST_INIT(chemical_reagents_list, init_chemical_reagent_list())
/// names of reagents used by plumbing UI.
GLOBAL_LIST_INIT(chemical_name_list, init_chemical_name_list())
/// List of all reactions with their associated product and result ids. Used for reaction lookups
GLOBAL_LIST(chemical_reactions_results_lookup_list)
/// List of all reagents that are parent types used to define a bunch of children - but aren't used themselves as anything.
GLOBAL_LIST(fake_reagent_blacklist)
/// list of all /datum/tech datums indexed by id.
GLOBAL_LIST_EMPTY(tech_list)
/// list of all surgeries by name, associated with their path.
GLOBAL_LIST_INIT(surgeries_list, init_surgeries())

/// Global list of all non-cooking related crafting recipes.
GLOBAL_LIST_EMPTY(crafting_recipes)
/// This is a global list of typepaths, these typepaths are atoms or reagents that are associated with crafting recipes.
/// This includes stuff like recipe components and results.
GLOBAL_LIST_EMPTY(crafting_recipes_atoms)
/// Global list of all cooking related crafting recipes.
GLOBAL_LIST_EMPTY(cooking_recipes)
/// This is a global list of typepaths, these typepaths are atoms or reagents that are associated with cooking recipes.
/// This includes stuff like recipe components and results.
GLOBAL_LIST_EMPTY(cooking_recipes_atoms)
/// list of Rapid Construction Devices.
GLOBAL_LIST_EMPTY(rcd_list)
/// list of wallmounted intercom radios.
GLOBAL_LIST_EMPTY(intercoms_list)
/// list of all current implants that are tracked to work out what sort of trek everyone is on. Sadly not on lavaworld not implemented...
GLOBAL_LIST_EMPTY(tracked_implants)
/// list of implants the prisoner console can track and send inject commands too
GLOBAL_LIST_EMPTY(tracked_chem_implants)
/// list of all pinpointers. Used to change stuff they are pointing to all at once.
GLOBAL_LIST_EMPTY(pinpointer_list)
/// A list of all zombie_infection organs, for any mass "animation"
GLOBAL_LIST_EMPTY(zombie_infection_list)
/// List of all meteors.
GLOBAL_LIST_EMPTY(meteor_list)
/// List of active radio jammers
GLOBAL_LIST_EMPTY(active_jammers)
GLOBAL_LIST_EMPTY(ladders)
GLOBAL_LIST_EMPTY(stairs)
GLOBAL_LIST_EMPTY(janitor_devices)
GLOBAL_LIST_EMPTY(trophy_cases)
GLOBAL_LIST_EMPTY(experiment_handlers)

///This is a global list of all signs you can change an existing sign or new sign backing to, when using a pen on them.
GLOBAL_LIST_INIT(editable_sign_types, populate_editable_sign_types())

GLOBAL_LIST_EMPTY(wire_color_directory)
GLOBAL_LIST_EMPTY(wire_name_directory)

/// List of all instances of /obj/effect/mob_spawn/ghost_role in the game world
GLOBAL_LIST_EMPTY(mob_spawners)

/// List of all mobs with the "ghost_direct_control" component
GLOBAL_LIST_EMPTY(joinable_mobs)

/// List of area names of roundstart station cyborg rechargers, for the low charge/no charge cyborg screen alert tooltips.
GLOBAL_LIST_EMPTY(roundstart_station_borgcharger_areas)

/// List of area names of roundstart station mech rechargers, for the low charge/no charge mech screen alert tooltips.
GLOBAL_LIST_EMPTY(roundstart_station_mechcharger_areas)

/// Associative list of alcoholic container typepath to instances, currently used by the alcoholic quirk
GLOBAL_LIST_INIT(alcohol_containers, init_alcohol_containers())
