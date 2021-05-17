/*
 *	Due to how DEFINES work, they have to be in a file read before the code actually using said defines
 *	Therefore, Fulp DEFINES must all be placed in this folder, despite modularity.
 */

/*
 *	Role Defines, used for Antagonist jobs.
 */
/// Bloodsuckers - Defines the role for preferences
#define ROLE_BLOODSUCKER "bloodsucker"
/// Monster Hunters - Defines the role for preferences
#define ROLE_MONSTERHUNTER "monster hunter"

/*
 *	Source Trait Defines
 */
/// Source trait for Bloodsuckers/Monster Hunters/Vassals
#define BLOODSUCKER_TRAIT "bloodsucker"

/*
 *	Martial art Defines
 */
/// Used in hunterfu.dm
#define MARTIALART_HUNTERFU "hunter-fu"
/// Used in deputy_block.dm
#define MARTIALART_DEPUTYBLOCK "deputy block"

/*
 *	Bloodsucker Defines
 */
/// Your heart doesn't beat.
#define TRAIT_NOPULSE "nopulse"
/// Falsifies Health analyzers
#define TRAIT_MASQUERADE "masquerade"
/// Your body is literal room temperature. Does not make you immune to the temp.
#define TRAIT_COLDBLOODED "coldblooded"
/// Used for Bloodsucker's LifeTick() signal
#define COMSIG_LIVING_BIOLOGICAL_LIFE "biological_life"
/// Unused define, kept here in case Swain wants to use it.
#define BLOODSUCKER_LEVEL_TO_EMBRACE 3
/// Checks if the given mob is a Bloodsucker
#define IS_BLOODSUCKER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/bloodsucker))
/// Clan defines
#define CLAN_BRUJAH "Brujah Clan"
#define CLAN_NOSFERATU "Nosferatu Clan"
#define CLAN_TREMERE "Tremere Clan"
#define CLAN_VENTRUE "Ventrue Clan"

/*
 *	Deputy Defines
 */
#define TRAIT_ENGINEERINGDEPUTY "engineeringdeputy"
#define TRAIT_MEDICALDEPUTY "medicaldeputy"
#define TRAIT_SCIENCEDEPUTY "sciencedeputy"
#define TRAIT_SUPPLYDEPUTY "supplydeputy"
#define TRAIT_SERVICEDEPUTY "servicedeputy"
///Used to assign the Service deputy, since TG doesnt have such a thing (Who knows why, its great!)
#define SEC_DEPT_SERVICE "Service"

/*
 *	Misc Defines
 */
/// Human sub-species defines
#define isbeefman(A) (is_species(A,/datum/species/beefman))
/// Defines the Mentorhelp's Mentorsay button
#define COMSIG_KB_ADMIN_MSAY_DOWN "keybinding_mentor_msay_down"
