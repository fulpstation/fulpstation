/**
 * # FULP GLOBAL VARS
 *
 * Why is this here?
 * Because stuff like `GLOBAL_LIST_INIT` isn't DEFINED on TG until the /code/ folder
 * Because, due to some god-forsaken reason, either `GLOBAL_LIST_INIT` defined in Fulp folders causes TG's 'create and destroy' to fail.
 */

// JOBS //
// This list is used in job_integration.dm to assign jobs their HUD Icons. When adding new jobs, add them to this list. //
GLOBAL_LIST_INIT(fulp_job_assignments, list(
	JOB_BRIG_PHYSICIAN,
	JOB_DEPUTY,
	JOB_DEPUTY_SUP,
	JOB_DEPUTY_ENG,
	JOB_DEPUTY_MED,
	JOB_DEPUTY_SCI,
	JOB_DEPUTY_SRV,
))

// PRISON //
GLOBAL_LIST_INIT(important_prison_messages, list(
	"Requisition form for equipment destined for rescue of personnel on-board of high-security containment station #S-2912 in Spinward Periphery approved by the NANOTRASEN commission of funds for outside sectors. As requested, a full set of tools, a toolbelt and a spare envirosuit will be shipped for the cost of 5780 credits from the 6000 credits tri-mensual budget designated for emergencies. Request for a pair of insulated gloves denied due to lack of funds, consider taking precautions when assessing the risks tied to air redistribution and shocked grilles. -Central Command Officer - Cargo Department, Ld. Peter",
	"OK I cann barely write this but my hand is stuck insdie a getmore vedning machine aand if I let go I lose the cheesie honkers tell me what to do boss -Central Command Intern, L.B Jess Jr.",
	"The Syndicate has started some experimental research regarding humanoid shapeshifting. There are rumors that this technology will be field tested on a Nanotrasen station for infiltration purposes. Be advised that support personel may also be deployed to defend these shapeshifters. Trust nobody - suspect everybody. Do not announce this to the crew, as paranoia may spread and inhibit workplace efficiency. -Central Command Officer - Security Department, Sgt. Winters",
	"I can't stress this enough we really need you guys to send us guns, we have vampires all over the place enslaving even our most loyal crew members and your ideas of welding down vents and throwing them in the chapel ain't doing shit. We have been telling you about these vampires for the past twenty someting correspondances so do your job and ship us these weapons and stop calling us racists. -Central Command Officer - Religious Department, St. Hunk",
	"It's Syndicate recruiting season. Be alert for potential Syndicate infiltrators, but also watch out for disgruntled employees trying to defect. Unlike Nanotrasen, the Syndicate prides itself in teamwork and will only recruit pairs that share a brotherly trust. -Central Command Officer, Communications Interception Department, M. Turing",
	"The NANOTRASEN Scientific & Technical Inovation department would like to remind the crew of the RTL-607734 transport vessel that following last month's D-notice, it will be strictly forbidden to use the limited permissible time for NTnet activities to research cartoon drawings of rumored 'cloning accident aftermaths'. -Central Command Officer - Chief Medical Department, Md. Joyce",
	"Although more specific threats are commonplace, you should always remain vigilant for Syndicate agents aboard your station. Syndicate communications have implied that many	Nanotrasen employees are Syndicate agents with hidden memories that may be activated at a moment's notice, so it's possible that these agents might not even know their positions. -Central Command Officer - Brainwashing Department, Rd. Howard",
	"Listen boss, we've been stranded in this course toward the system's sun for the past like 6 months now, I beg you, once more, to give us an advance in our budget. It wasn't our intention to let the clown place three hundred and fifty-eight 'Five Night at Freddys Plushy Crate' orders and we deeply apologize but we really do need credits for fuel right now. -Central Command Intern - Cargo Department, CT. Oliver-In-Training",
	"Central Command would like to remind you that our members are composed entirely of paid volunteers who work to make Nanotrasen a welcoming company to all species. While it is okay to express frustration with flypeople's odd vomiting habits, doing so in a way that is aggressive or harassing will result in a harsh punishment. If you harass crew members because of their species, expect consequences to come as a result of your actions or your issue to be discarded. -Central Command Commander - Server Rules And Policy Department, Min. Ad",
	"Cybersun Industries has announced that they have successfully raided a high-security library. The library contained a very dangerous book that was shown to posses anomalous properties. We suspect that the book has been copied over, Stay vigilant! -Central Command Librarian, Akena",
	"Czes of the R&D Toward Marketing division reporting. Setting up production and shipping lines for envirosuits was already a pain in the neck but you guys must be crazy if you think we can expand this to digitigrade boots. Why don't you guys at Construction just start making windows out of plastic or some kind of transparent rubber that won't cut people's feet the moment they get damaged? That'd be like a thousand times more cost effective. -Central Command Construction Worker, Screw Sr.",
	"Employee unrest has spiked in recent weeks, with several attempted mutinies on heads of staff. Some crew have been observed using flashbulb devices to blind their colleagues, who then follow their orders without question and work towards dethroning departmental leaders. Watch for behavior such as this with caution. If the crew attempts a mutiny, you and your heads of staff are fully authorized to execute them using lethal weaponry. -Central Command Commander, Security Department, Amadeus",
	"Dispatch for the captain's office of vessel Echo Sunflower 12: We do not appreciate you building your experimental artillery with its drum pointed toward our most prized military outpost 'as a joke' and to 'watch this troll'. Expect severe repercussions within the next few months. -Central Command Watchtower, Mason",

))

// MENTORS //
GLOBAL_PROTECT(mentor_verbs)

GLOBAL_LIST_INIT(mentor_verbs, list(
	/client/proc/cmd_mentor_say,
))

// MUSIC //
GLOBAL_LIST_INIT(credits_music, list(
	'fulp_modules/sounds/sound/credits/fulp_piano.ogg' = 50,
	'fulp_modules/sounds/sound/credits/fulp_piano_old.ogg' = 20,
	//Made by Mokoshotar (@mokoshotar#9428)
	'fulp_modules/sounds/sound/credits/shuttlesent.ogg' = 30,
))

// FULP BANS //
GLOBAL_LIST_INIT(fulp_ban_list, list(
	"Antagonist Positions" = list(
		ROLE_BLOODSUCKER,
		ROLE_MONSTERHUNTER,
		ROLE_INTERNAL_AFFAIRS,
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
	"Frown",
	"Dissapointed",
	"Grit",
	"Gritting Smile",
	"Smile",
	"Smirk",
))

GLOBAL_LIST_INIT(beefmen_traumas, list(
	"Strangers" = /datum/brain_trauma/mild/phobia/strangers,
	"Hallucinations" = /datum/brain_trauma/mild/hallucinations,
	"Ocky Icky" = /datum/brain_trauma/mild/phobia/ocky_icky,
	"Hypnotic Stupor" = /datum/brain_trauma/severe/hypnotic_stupor,
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
