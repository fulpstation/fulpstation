/*
 *	Due to how DEFINES work, they have to be in a file read before the code actually using said defines
 *	Therefore, Fulp DEFINES must all be placed in this folder, despite modularity.
 */

/// Role defines
#define ROLE_BLOODSUCKER "bloodsucker" // Bloodsuckers - Defines the role for preferences
#define ROLE_MONSTERHUNTER "monster hunter" // Monster Hunters - Defines the role for preferences

/// Source Traits
#define BLOODSUCKER_TRAIT "bloodsucker" // Source trait for Bloodsuckers/Monster Hunters/Vassals

/// Human sub-species defines
#define isbeefman(A) (is_species(A,/datum/species/beefman))

/// Martial art defines
#define MARTIALART_HUNTERFU "hunter-fu"
#define MARTIALART_DEPUTYBLOCK "deputy block"

/// Bloodsucker defines
#define TRAIT_NORUNNING "norunning" // You walk!
#define TRAIT_NOPULSE "nopulse" // Your heart doesn't beat.
#define TRAIT_MASQUERADE "masquerade" // Falsifies Health analyzers
#define TRAIT_COLDBLOODED "coldblooded"	// Your body is literal room temperature. Does not make you immune to the temp.
#define COMSIG_LIVING_BIOLOGICAL_LIFE "biological_life" // Used for Bloodsucker's LifeTick() signal
#define BLOODSUCKER_LEVEL_TO_EMBRACE 3

/// Deputy defines
#define TRAIT_ENGINEERINGDEPUTY "engineeringdeputy"
#define TRAIT_MEDICALDEPUTY "medicaldeputy"
#define TRAIT_SCIENCEDEPUTY "sciencedeputy"
#define TRAIT_SUPPLYDEPUTY "supplydeputy"
#define TRAIT_SERVICEDEPUTY "servicedeputy"
///Used to assign the Service deputy, since TG doesnt have such a thing (Who knows why, its great!)
#define SEC_DEPT_SERVICE "Service"

/// Mentorhelp defines
#define COMSIG_KB_ADMIN_MSAY_DOWN "keybinding_mentor_msay_down"
