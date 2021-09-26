// Taken from ethereals (color_list_ethereal)
GLOBAL_LIST_INIT(color_list_beefman, list(
	"Very Rare" = "d93356",
	"Rare" = "da2e4a",
	"Medium Rare" = "e73f4e",
	"Medium" = "f05b68",
	"Medium Well" = "e76b76",
	"Well Done" = "d36b75",
	))

// Taken from _HELPERS/mobs.dm
GLOBAL_LIST_INIT(eyes_beefman, list(
	"Capers",
	"Cloves",
	"Olives",
	"Peppercorns",
	))

GLOBAL_LIST_INIT(mouths_beefman, list(
	"Frown1",
	"Frown2",
	"Grit1",
	"Grit2",
	"Smile1",
	"Smile2",
	))


// PROSTHETICS	//
/mob/living/proc/getBruteLoss_nonProsthetic()
	return getBruteLoss()

/mob/living/proc/getFireLoss_nonProsthetic()
	return getFireLoss()

/mob/living/carbon/getBruteLoss_nonProsthetic()
	var/amount = 0
	for(var/obj/item/bodypart/BP in bodyparts)
		if (BP.status < BODYPART_ROBOTIC)
			amount += BP.brute_dam
	return amount

/mob/living/carbon/getFireLoss_nonProsthetic()
	var/amount = 0
	for(var/obj/item/bodypart/BP in bodyparts)
		if (BP.status < BODYPART_ROBOTIC)
			amount += BP.burn_dam
	return amount

/*
 *	# Names
 *
 *	Global lists of all names used by Beefmen.
 *	This isn't a string file because otherwise they would have to be placed in the strings folder to not fail checks.
 */

GLOBAL_LIST_INIT(russian_names, list(
	"Ivanov",
	"Smirnov",
	"Kuznetsov",
	"Popov",
	"Vasiliev",
	"Petrov",
	"Sokolov",
	"Mikhailov",
	"Fedorov",
	"Morozov",
	"Volkov",
	"Alexeev",
	"Lebedev",
	"Semenov",
	"Egorov",
	"Pavlov",
	"Kozlov",
	"Stepanov",
	"Nikolaev",
	"Orlov",
	"Traktor",
	"Romanov",
	"Ruchkin",
	"Rykov",
	"Putilov",
	"Plisetsky",
	"Pervak",
	"Patrushev",
	"Nemtsov",
	"Noskov",
	"Morenov",
	"Maksudov",
	"Levkin",
	"Luzhkov",
	"Lukashenko",
	"Kazak",
	"Korablin",
	"Zyomin",
	"Zhidkov",
	"Zhurov",
	"Yesipov",
	"Dyogtev",
	"Gagolin",
	"Gagarin",
	"Varennikov",
	"Vorontsov",
	"Blazhenov",
	"Bondarchuk",
	"Baburin",
	"Akhremenko",
	"Antonovich",
	"Alyokhin",
	"Igumnov",
	"Zykov",
	"Sergeyev",
	"Statnik",
	"Suvorov",
	"Timoshenko",
	"Trufanov",
	"Uglitsky",
	"Usachyov",
	"Fomenkov",
	"Fyodorov",
	"Khlebnikov",
	"Khromov",
	"Tsvetnov",
	"Tsirinsky",
	"Shchepkin",
	"Engovatov",
	"Yumatov",
	"Yushkov",
	"Yakubovich",
	"Ambamov",
	"Anatoly",
	"Alekzandrov",
	"Andreev",
	"Aparin",
	"Asimov",
	"Raidenovich",
	"Raikov",
	"Volgin",
	"Bakunin",
	"Kropotkin",
	"Rasputin",
	"Lenin",
	"Stalin",
	"Kruschev",
	"Gorbachov",
	"Beletsky",
	"Borschinov",
	"Chekov",
	"Chernov",
	"Dolseivski",
	"Dmitriev",
	"Dubinsky",
	"Dimitry",
	"Gregaren",
	"Stakhanov",
	"Kalashnikov",
	"Krakow",
	"Maxim",
	"Mirsky",
	"Molotov",
	"Orlov",
	"Plotkin",
	"Slavinski",
	"Vinsky",
	"Volski",
	"Zakharov",

))
GLOBAL_LIST_INIT(experiment_names, list(
	"Experiment",
	"Attempt",
	"Subject",
	"Test",
	"Examination",
	"Operation",
	"Protocol",
	"Failure",
	"Reject",
	"Study",
	"Trial",
	"Observation",
	"Sample",
	"Case",
	"Exhibit",
	"Specimen",
	"Prototype",
	"Type",
	"Version",
	"Strand",
	"SCP",
))

GLOBAL_LIST_INIT(beef_names, list(
	"Steak",
	"Tartare",
	"Ribeye",
	"Sirloin",
	"Round",
	"Skirt",
	"Loin",
	"Shank",
	"Lean",
	"Marble",
	"Blue",
	"Hanger",
	"Flank",
	"Tongue",
	"Cheek",
	"Porterhouse",
	"Chop",
	"Grill",
	"Sear",
	"Broil",
	"Fry",
))
