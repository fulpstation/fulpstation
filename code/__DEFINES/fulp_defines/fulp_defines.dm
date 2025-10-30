/**
 * # DEFINES
 *
 * Due to how DEFINES work, they ALWAYS have to be read FIRST.
 * Therefore, Fulp defines must all be placed in this folder, despite modularity.
 */


/**
 * # MARTIAL ARTS
 */
//Used in velvet_fu.dm
#define MARTIALART_VELVETFU "velvetfu"
//Used in bloodsucker_life.dm
#define MARTIALART_FRENZYGRAB "frenzy grabbing"

/**
 * # SPECIES
 */
///Job define for the Beefmen Cytology (Icemoon) Spawner
#define ROLE_BEEFMAN_CYTOLOGY "Beefman Cytology Scientist"
///Job define for the Beefmen Station (Space) Spawner
#define ROLE_BEEFMAN_STATION "Beefman Station Inhabitant"

/**
 * # MISC
 */
///Bullet Caliber for Joel's gun, used in 'joel_gun.dm'
#define CALIBER_C22 ".c22"

///Infiltrator employer defines
#define INFILTRATOR_FACTION_CORPORATE_CLIMBER "Corporate Climber"
#define INFILTRATOR_FACTION_ANIMAL_RIGHTS_CONSORTIUM "Animal Rights Consortium"
#define INFILTRATOR_FACTION_GORLEX_MARAUDERS "Gorlex Marauders"
#define INFILTRATOR_FACTION_SELF "S.E.L.F"

///monsterhunter signals
#define COMSIG_RABBIT_FOUND "rabbit_found"
#define COMSIG_GAIN_INSIGHT "gain_insight"
#define COMSIG_BEASTIFY "beastify"

///Define for the "Rabbits" faction.
#define FACTION_RABBITS "rabbits"
///Define for the "Bloodhungry"/bloodsucker monster faction.
#define FACTION_BLOODHUNGRY "bloodhungry"

///Define for the Syndicate Engineer Ruin, used in 'syndicate_engineer.dm"
#define ROLE_SYNDICATE_ENGINEER "Syndicate Engineer"

///Defines for "Alert Level Deltaww"
#define SEC_LEVEL_DELTAWW 4
#define ALERT_COEFF_DELTAWW 255 //This alert level should only be temporary; might as well mess with everyone.

///Defines for "Ghost Kitchen" diner ghost spawners
#define ROLE_GHOST_CHEF "All-American Chef"
#define ROLE_GHOST_COOK "All-American Cook"
#define ROLE_GHOST_REGULAR "Fake Health Inspector"

/// Define for the atmospherics chamber on the beefman space station ruin.
#define ATMOS_GAS_MONITOR_BEEF_MIX "govyadina mix"

///Define for the diner ghost role's z-level restriction component.
///This does NOT work with the regular "stationstuck" component.
#define PIZZAFICATION "pizzafy"

/// Define for the beefman cytology ghost role's z-level restriction component.
/// This does NOT work with the regular "stationstuck" component.
#define MEATIFICATION "meatify"
