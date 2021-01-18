// Names
GLOBAL_LIST_INIT(russian_names, world.file2list("fulp_modules/beefman_port/strings/fulp_russian.txt")) // Backtracked from names.dm
GLOBAL_LIST_INIT(experiment_names, world.file2list("fulp_modules/beefman_port/strings/fulp_experiment.txt")) // Backtracked from names.dm
GLOBAL_LIST_INIT(beefman_names, world.file2list("fulp_modules/beefman_port/strings/fulp_beefman.txt")) // Backtracked from names.dm

// Taken from flavor_misc.dm, as used by ethereals  (color_list_ethereal)
GLOBAL_LIST_INIT(color_list_beefman, list("Very Rare" = "d93356", "Rare" = "da2e4a", "Medium Rare" = "e73f4e", "Medium" = "f05b68", "Medium Well" = "e76b76", "Well Done" = "d36b75" ))

// Taken from _HELPERS/mobs.dm, and assigned in global_lists.dm! (This is where we assign sprite_accessories(.dm) to the list, by name)
GLOBAL_LIST_INIT(eyes_beefman, list("Capers", "Cloves", "Olives", "Peppercorns" ))
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
