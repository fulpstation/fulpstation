/*
 *	Due to how DEFINES work, they have to be in a file read before the code actually using said defines
 *	Therefore, Fulp DEFINES must all be placed in this folder, despite modularity.
 */

/*
 *	Martial art Defines
 */
/// Used in hunterfu.dm
#define MARTIALART_HUNTERFU "hunterfu"
/// Used in velvet_fu.dm
#define MARTIALART_VELVETFU "velvetfu"
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
/// Defines the bullet type for Joel's gun, used in joel_gun.dm
#define CALIBER_C22 ".c22"
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
///Antag Tips - Abductors
#define ABDUCTOR_TIPS "abductor"
///Antag Tips - Bloodsuckers
#define BLOODSUCKER_TIPS "bloodsucker"
///Antag Tips - Changelings
#define CHANGELING_TIPS "changeling"
///Antag Tips - Cultists
#define CULTIST_TIPS "cultist"
///Antag Tips - Heretics
#define HERETIC_TIPS "heretic"
///Antag Tips - Imposter Wizard
#define IMPOSTER_TIPS "imposter"
///Antag Tips - Malfunctional AIs
#define MALF_TIPS "malf_ai"
///Antag Tips - Monster Hunters
#define MONSTERHUNTER_TIPS "monsterhunter"
///Antag Tips - Nuclear Operatives
#define NUKIE_TIPS "nukie"
///Antag Tips - Revolutionaries
#define REVOLUTIONARY_TIPS "revolutionary"
///Antag Tips - Traitor
#define TRAITOR_TIPS "traitor"
///Antag Tips - Vassals
#define VASSAL_TIPS "vassal"
///Antag Tips - Wizard Apprentice
#define WIZARD_APPRENTICE_TIPS "wiz_apprentice"
///Antag Tips - Wizard
#define WIZARD_TIPS "wizard"
