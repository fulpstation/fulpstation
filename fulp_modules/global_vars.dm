/* This file is for any Fulp-related global lists. */

// JOBS //

/// This list is used in job_integration.dm to assign jobs their HUD Icons. When adding new jobs, add them to this list.
GLOBAL_LIST_INIT(fulp_job_assignments, list(
	"Brig Physician",
	"Deputy",
	"Supply Deputy",
	"Engineering Deputy",
	"Medical Deputy",
	"Science Deputy",
	"Service Deputy",
))

// MENTORS //

GLOBAL_PROTECT(mentor_verbs)

GLOBAL_LIST_INIT(mentor_verbs, list(
	/client/proc/cmd_mentor_say,
))

// MUSIC //

// For the credits music, the number associated is its relative weight,
GLOBAL_LIST_INIT(credits_music, list(
	'fulp_modules/sounds/sound/credits/fulp_piano.ogg' = 50,
	'fulp_modules/sounds/sound/credits/fulp_piano_old.ogg' = 20,
	//Made by Mokoshotar (@mokoshotar#9428)
	'fulp_modules/sounds/sound/credits/shuttlesent.ogg' = 30,
))

// SPECIES BANS //

GLOBAL_LIST_INIT(fulp_ban_list, list(
	"Fulp Race Bans" = list(
		SPECIES_FELINE,
		SPECIES_MOTH,
		SPECIES_ETHEREAL,
		SPECIES_PLASMAMAN,
		SPECIES_LIZARD,
		SPECIES_BEEFMAN,
	),
	"Antagonist Positions" = list(
		ROLE_BLOODSUCKER,
		ROLE_MONSTERHUNTER,
	),
))

// SPECIES //

// Taken from ethereals (color_list_ethereal)
GLOBAL_LIST_INIT(color_list_beefman, list(
	"Very Rare" = "#d93356",
	"Rare" = "#da2e4a",
	"Medium Rare" = "#e73f4e",
	"Medium" = "#f05b68",
	"Medium Well" = "#e76b76",
	"Well Done" = "#d36b75",
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
