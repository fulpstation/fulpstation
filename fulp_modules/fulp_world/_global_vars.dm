/**
 * # FULP GLOBAL VARS
 *
 * Why is this here?
 * Because stuff like `GLOBAL_LIST_INIT` isn't DEFINED on TG until the /code/ folder
 * Because, due to some god-forsaken reason, either `GLOBAL_LIST_INIT` defined in Fulp folders causes TG's 'create and destroy' to fail.
 */

// MENTORS //
GLOBAL_PROTECT(mentor_verbs)

GLOBAL_LIST_INIT(mentor_verbs, list(
	/client/proc/cmd_mentor_say,
	/client/proc/mentor_requests,
))

// MUSIC //
GLOBAL_LIST_INIT(credits_music, list(
	'fulp_modules/sounds/credits/fulp_piano.ogg' = 50,
	'fulp_modules/sounds/credits/fulp_piano_old.ogg' = 20,
	//Made by Mokoshotar (@mokoshotar#9428)
	'fulp_modules/sounds/credits/shuttlesent.ogg' = 30,
))

// FULP BANS //
GLOBAL_LIST_INIT(fulp_ban_list, list(
	"Antagonist Positions" = list(
		ROLE_BLOODSUCKER,
		ROLE_MONSTERHUNTER,
		ROLE_INFILTRATOR,
	),
))

// SPECIES //
// Taken from ethereals (color_list_ethereal)
GLOBAL_LIST_INIT(color_list_beefman, list(
	BEEF_COLOR_VERY_RARE = "#d93356",
	BEEF_COLOR_RARE = "#da2e4a",
	BEEF_COLOR_MEDIUM_RARE = "#e73f4e",
	BEEF_COLOR_MEDIUM = "#f05b68",
	BEEF_COLOR_MEDIUM_WELL = "#e76b76",
	BEEF_COLOR_WELL_DONE = "#d36b75",
))

// Taken from _HELPERS/mobs.dm
GLOBAL_LIST_INIT(eyes_beefman, list(
	BEEF_EYES_CAPERS,
	BEEF_EYES_CLOVES,
	BEEF_EYES_OLIVES,
	BEEF_EYES_PEPPERCORNS,
))

GLOBAL_LIST_INIT(mouths_beefman, list(
	BEEF_MOUTH_FROWN,
	BEEF_MOUTH_DISSAPOINTED,
	BEEF_MOUTH_GRIT,
	BEEF_MOUTH_GRITTING_SMILE,
	BEEF_MOUTH_SMILE,
	BEEF_MOUTH_SMIRK,
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

GLOBAL_LIST_EMPTY(tails_list_protogen)
GLOBAL_LIST_EMPTY(snouts_list_protogen)
GLOBAL_LIST_EMPTY(antennae_list_protogen)
