/*
 *	Due to how DEFINES work, they have to be in a file read before the code actually using said defines
 *	Therefore, Fulp DEFINES must all be placed in this folder, despite modularity.
 */

/*
 *	Role Defines, used for Antagonist jobs.
 */
/// Bloodsuckers - Defines the role for preferences
#define ROLE_BLOODSUCKER "Bloodsucker"
/// Monster Hunters - Defines the role for preferences
#define ROLE_MONSTERHUNTER "Monster Hunter"

/*
 *	Source Trait Defines
 */
/// Source trait for Bloodsuckers/Monster Hunters/Vassals
#define BLOODSUCKER_TRAIT "bloodsucker"

/*
 *	Martial art Defines
 */
/// Used in hunterfu.dm
#define MARTIALART_HUNTERFU "hunterfu"
/// Used in deputy_block.dm
#define MARTIALART_DEPUTYBLOCK "deputyblock"
/// Used in bloodsucker_life.dm
#define MARTIALART_FRENZYGRAB "FrenzyGrab"

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
/// Antagonist checks
#define IS_BLOODSUCKER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/bloodsucker))
#define IS_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal))
#define IS_MONSTERHUNTER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/monsterhunter))
/* Clan defines
*/
/// More prone to Frenzy & Brawn/Punches deal more damage
#define CLAN_BRUJAH "Brujah Clan"
/// Can't use Masquerade, gets Bad Back quirk, Disfigured Trait & Gains the ability to Ventcrawl.
#define CLAN_NOSFERATU "Nosferatu Clan"
/// Weaker to HunterFu, burns in the Chapel, Can mutate their Vassals (who cannot be deconverted via Mindshielding) & Can revive dead people via the Persuasion Rack.
#define CLAN_TREMERE "Tremere Clan"
/// Cant drink blood out of mindless mobs, cant rank up, instead ranks their favorite vassal up.
#define CLAN_VENTRUE "Ventrue Clan"
/// Constant hallucinations & Bluespace Prophet traumas - Beefmen cannot join this.
#define CLAN_MALKAVIAN "Malkavian Clan"
/* Clan defines
*/
#define TREMERE_SKELETON "Skeleton Pirate"
#define TREMERE_ZOMBIE "Zombie - Revives"
#define TREMERE_HUSK "Husk - Drinks all their Blood"
#define TREMERE_BAT "Bat - Chance to give them Bat form"

/*
 *	Deputy Defines
 */
#define TRAIT_ENGINEERINGDEPUTY "engineeringdeputy"
#define TRAIT_MEDICALDEPUTY "medicaldeputy"
#define TRAIT_SCIENCEDEPUTY "sciencedeputy"
#define TRAIT_SUPPLYDEPUTY "supplydeputy"
#define TRAIT_SERVICEDEPUTY "servicedeputy"
/// Used to assign the Service deputy, since TG doesnt have such a thing (Who knows why, its great!)
#define SEC_DEPT_SERVICE "Service"

/*
 *	Misc Defines
 */
/// Human sub-species defines
#define isbeefman(A) (is_species(A,/datum/species/beefman))
/// Defines the Mentorhelp's Mentorsay button
#define COMSIG_KB_ADMIN_MSAY_DOWN "keybinding_mentor_msay_down"

/*
 *	Antag Tip Defines NOTE: Monster hunter, bloodsucker and vassal don't have any HTMLs! Willard will have to add them in.
 */
#define ABDUCTOR_TIPS "abductor"
#define BLOODSUCKER_TIPS "bloodsucker"
#define CHANGELING_TIPS "changeling"
#define CULTIST_TIPS "cultist"
#define HERETIC_TIPS "heretic"
#define IMPOSTER_TIPS "imposter"
#define MALF_TIPS "malf_ai"
#define MONSTERHUNTER_TIPS "monsterhunter"
#define NUKIE_TIPS "nukie"
#define REVOLUTIONARY_TIPS "revolutionary"
#define TRAITOR_TIPS "traitor"
#define VASSAL_TIPS "vassal"
#define WIZARD_APPRENTICE_TIPS "wiz_apprentice"
#define WIZARD_TIPS "wizard"
