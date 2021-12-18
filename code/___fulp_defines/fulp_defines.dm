/**
 * # DEFINES
 *
 * Due to how DEFINES work, they ALWAYS have to be read FIRST.
 * Therefore, Fulp defines must all be placed in this folder, despite modularity.
 */


/**
 * # MARTIAL ARTS
 */

//Used in hunterfu.dm
#define MARTIALART_HUNTERFU "hunterfu"
//Used in velvet_fu.dm
#define MARTIALART_VELVETFU "velvetfu"
//Used in deputy_block.dm
#define MARTIALART_DEPUTYBLOCK "deputy blocking"
//Used in bloodsucker_life.dm
#define MARTIALART_FRENZYGRAB "frenzy grabbing"


/*
 * # DEPUTIES
 */
#define TRAIT_ENGINEERINGDEPUTY "engineeringdeputy"
#define TRAIT_MEDICALDEPUTY "medicaldeputy"
#define TRAIT_SCIENCEDEPUTY "sciencedeputy"
#define TRAIT_SUPPLYDEPUTY "supplydeputy"
#define TRAIT_SERVICEDEPUTY "servicedeputy"
///Service deputy's assigned department
#define SEC_DEPT_SERVICE "Service"


/**
 * # SPECIES
 */
///Beefmen Species define
#define SPECIES_BEEFMAN "beefman"
///Check if we are indeed a Beefman
#define isbeefman(A) (is_species(A, /datum/species/beefman))
///Job define for the Beefmen Cytology (Icemoon) Spawner
#define ROLE_BEEFMAN_CYTOLOGY "Beefman Cytology"
///Job define for the Beefmen Station (Space) Spawner
#define ROLE_BEEFMAN_STATION "Beefman Station"


/**
 * # ANTAG TIPS
 */
///Abductors
#define ABDUCTOR_TIPS "abductor"
///Bloodsuckers
#define BLOODSUCKER_TIPS "bloodsucker"
///Changelings
#define CHANGELING_TIPS "changeling"
///Cultists
#define CULTIST_TIPS "cultist"
///Heretics
#define HERETIC_TIPS "heretic"
///Malfunctional AIs
#define MALF_TIPS "malf_ai"
///Monster Hunters
#define MONSTERHUNTER_TIPS "monsterhunter"
///Nuclear Operatives
#define NUKIE_TIPS "nukie"
///Revolutionaries
#define REVOLUTIONARY_TIPS "revolutionary"
///Traitors
#define TRAITOR_TIPS "traitor"
///Vassals
#define VASSAL_TIPS "vassal"
///Wizards
#define WIZARD_TIPS "wizard"
///Wizard Apprentices
#define WIZARD_APPRENTICE_TIPS "wiz_apprentice"
///Imposter Wizard
#define WIZ_IMPOSTER_TIPS "imposter"


/**
 * # MISC
 */

///Bullet Caliber for Joel's gun, used in 'joel_gun.dm'
#define CALIBER_C22 ".c22"

///Mentorsay's keybind being pressed.
#define COMSIG_KB_ADMIN_MSAY_DOWN "keybinding_mentor_msay_down"
