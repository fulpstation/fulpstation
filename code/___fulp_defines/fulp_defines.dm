/*
 *	Due to how DEFINES work, they have to be in a file read before the code actually using said defines
 *	Therefore, Fulp DEFINES must all be placed in this folder, despite modularity.
 */

/*
 *	Martial art Defines
 */
/// Used in hunterfu.dm
#define MARTIALART_HUNTERFU "hunterfu"
/// Used in deputy_block.dm
#define MARTIALART_DEPUTYBLOCK "deputy blocking"
/// Used in bloodsucker_life.dm
#define MARTIALART_FRENZYGRAB "frenzy grabbing"

/*
 *	Deputy Defines
 */
#define TRAIT_ENGINEERINGDEPUTY "engineeringdeputy"
#define TRAIT_MEDICALDEPUTY "medicaldeputy"
#define TRAIT_SCIENCEDEPUTY "sciencedeputy"
#define TRAIT_SUPPLYDEPUTY "supplydeputy"
#define TRAIT_SERVICEDEPUTY "servicedeputy"
/// Used to assign the Service deputy, since TG doesnt have such a thing
#define SEC_DEPT_SERVICE "Service"

/*
 *	Misc Defines
 */
/// Human sub-species defines
#define SPECIES_BEEFMAN "beefman"
#define isbeefman(A) (is_species(A,/datum/species/beefman))
/// Defines the Mentorhelp's Mentorsay button
#define COMSIG_KB_ADMIN_MSAY_DOWN "keybinding_mentor_msay_down"
///Job defines for Spawners
#define ROLE_BEEFMAN_CYTOLOGY "Beefman Cytology"
#define ROLE_BEEFMAN_STATION "Beefman Station"

/*
 *	Antag Tip Defines
 */
#define ABDUCTOR_TIPS "abductor"
#define BLOODSUCKER_TIPS "bloodsucker"
#define CHANGELING_TIPS "changeling"
#define CULTIST_TIPS "cultist"
#define HERETIC_TIPS "heretic"
#define MALF_TIPS "malf_ai"
#define MONSTERHUNTER_TIPS "monsterhunter"
#define NUKIE_TIPS "nukie"
#define REVOLUTIONARY_TIPS "revolutionary"
#define VASSAL_TIPS "vassal"

#define ANTAG_HUD_BLOODSUCKER 1
