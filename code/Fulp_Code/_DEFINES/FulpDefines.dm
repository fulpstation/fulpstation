// TRAITS
#define TRAIT_COLDBLOODED		"coldblooded"	// Your body is literal room temperature. Does not make you immune to the temp.
#define TRAIT_NONATURALHEAL		"nonaturalheal"	// Only Admins can heal you. NOTHING else does it unless it's given the god tag.
#define TRAIT_NORUNNING			"norunning"		// You walk!
#define TRAIT_NOMARROW			"nomarrow"		// You don't make blood.
#define TRAIT_NOPULSE			"nopulse"		// You don't pump blood.

// MISSING REF
/obj/item/circuitboard/machine/vr_sleeper
	var/whydoesthisexist = "because somebody fucked up putting this on TG, and vr_sleeper.dm is pointing to an object that was never defined. Here it is as a temp ref, so we can compile."

 Names
GLOBAL_LIST_INIT(russian_names, world.file2list("strings/names/fulp_russian.txt")) // Backtracked from names.dm
GLOBAL_LIST_INIT(experiment_names, world.file2list("strings/names/fulp_experiment.txt")) // Backtracked from names.dm

// Taken from flavor_misc.dm, as used by ethereals  (color_list_ethereal)
GLOBAL_LIST_INIT(color_list_beefman, list("Very Rare" = "d93356", "Rare" = "da2e4a", "Medium Rare" = "e73f4e", "Medium" = "f05b68", "Medium Well" = "e76b76", "Well Done" = "d36b75" ))

// Taken from _HELPERS/mobs.dm, and assigned in global_lists.dm! (This is where we assign sprite_accessories(.dm) to the list, by name)
GLOBAL_LIST_EMPTY(eyes_beefman)//, list( "Peppercorns", "Capers", "Olives" ))
GLOBAL_LIST_EMPTY(mouths_beefman)//, list( "Smile1", "Smile2", "Frown1", "Frown2", "Grit1", "Grit2" ))
