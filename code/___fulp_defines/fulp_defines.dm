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


/*
 *	Beefmen defines
 */

/// Taken from flavor_misc.dm, as used by ethereals (color_list_ethereal)
GLOBAL_LIST_INIT(color_list_beefman, list("Very Rare" = "d93356", "Rare" = "da2e4a", "Medium Rare" = "e73f4e", "Medium" = "f05b68", "Medium Well" = "e76b76", "Well Done" = "d36b75"))

/// Taken from _HELPERS/mobs.dm, and assigned in global_lists.dm! (This is where we assign sprite_accessories(.dm) to the list, by name)
GLOBAL_LIST_INIT(eyes_beefman, list("Capers", "Cloves", "Olives", "Peppercorns"))
GLOBAL_LIST_INIT(mouths_beefman, list("Frown1", "Frown2", "Grit1", "Grit2",  "Smile1", "Smile2"))

		// PROSTHETICS	//

/mob/living/proc/getBruteLoss_nonProsthetic()
	return getBruteLoss()

/mob/living/proc/getFireLoss_nonProsthetic()
	return getFireLoss()

/mob/living/carbon/getBruteLoss_nonProsthetic()
	var/amount = 0
	for(var/obj/item/bodypart/BP in bodyparts)
		if (BP.status < 2)
			amount += BP.brute_dam
	return amount

/mob/living/carbon/getFireLoss_nonProsthetic()
	var/amount = 0
	for(var/obj/item/bodypart/BP in bodyparts)
		if (BP.status < 2)
			amount += BP.burn_dam
	return amount
