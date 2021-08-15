

//Values for antag preferences, event roles, etc. unified here



//These are synced with the Database, if you change the values of the defines
//then you MUST update the database!
#define ROLE_SYNDICATE "Syndicate"
#define ROLE_TRAITOR "Traitor"
#define ROLE_OPERATIVE "Operative"
#define ROLE_CHANGELING "Changeling"
#define ROLE_WIZARD "Wizard"
#define ROLE_MALF "Malf AI"
#define ROLE_REV "Revolutionary"
#define ROLE_REV_HEAD "Head Revolutionary"
#define ROLE_REV_SUCCESSFUL "Victorious Revolutionary"
#define ROLE_ALIEN "Xenomorph"
#define ROLE_PAI "pAI"
#define ROLE_CULTIST "Cultist"
#define ROLE_HERETIC "Heretic"
#define ROLE_BLOB "Blob"
#define ROLE_NINJA "Space Ninja"
#define ROLE_MONKEY "Monkey"
#define ROLE_MONKEY_HELMET "Monkey Mind Magnification Helmet"
#define ROLE_ABDUCTOR "Abductor"
#define ROLE_REVENANT "Revenant"
#define ROLE_BROTHER "Blood Brother"
#define ROLE_BRAINWASHED "Brainwashed Victim"
#define ROLE_OVERTHROW "Syndicate Mutineer" //Role removed, left here for safety.
#define ROLE_HIVE "Hivemind Host" //Role removed, left here for safety.
#define ROLE_OBSESSED "Obsessed"
#define ROLE_SPACE_DRAGON "Space Dragon"
#define ROLE_SENTIENCE "Sentience Potion Spawn"
#define ROLE_PYROCLASTIC_SLIME "Pyroclastic Anomaly Slime"
#define ROLE_MIND_TRANSFER "Mind Transfer Potion"
#define ROLE_POSIBRAIN "Posibrain"
#define ROLE_DRONE "Drone"
#define ROLE_DEATHSQUAD "Deathsquad"
#define ROLE_LAVALAND "Lavaland"
#define ROLE_INTERNAL_AFFAIRS "Internal Affairs Agent"
#define ROLE_FAMILIES "Familes Antagonists"
#define ROLE_SYNDICATE_CYBERSUN "Cybersun Space Syndicate" //Ghost role syndi from Forgottenship ruin
#define ROLE_SYNDICATE_CYBERSUN_CAPTAIN "Cybersun Space Syndicate Captain" //Forgottenship captain syndie
#define ROLE_FREE_GOLEM "Free Golem" 

/// This defines the antagonists you can operate with in the settings.
/// Keys are the antagonist, values are the number of days since the player's
/// first connection in order to play.
GLOBAL_LIST_INIT(special_roles, list(
	ROLE_TRAITOR = 0,
	ROLE_BROTHER = 0,
	ROLE_OPERATIVE = 14,
	ROLE_CHANGELING = 0,
	ROLE_WIZARD = 14,
	ROLE_MALF = 0,
	ROLE_REV = 14,
	ROLE_ALIEN = 0,
	ROLE_PAI = 0,
	ROLE_CULTIST = 14,
	ROLE_BLOB = 0,
	ROLE_NINJA = 0,
	ROLE_OBSESSED = 0,
	ROLE_SPACE_DRAGON = 0,
	ROLE_MONKEY = 0,
	ROLE_REVENANT = 0,
	ROLE_ABDUCTOR = 0,
	ROLE_INTERNAL_AFFAIRS = 0,
	ROLE_SENTIENCE = 0,
	ROLE_FAMILIES = 0,
	ROLE_HERETIC = 0,
	ROLE_BLOODSUCKER = 0, // Fulpstation Bloodsuckers
	ROLE_MONSTERHUNTER = 0, // Fulpstation Bloodsuckers
))

//Job defines for what happens when you fail to qualify for any job during job selection
#define BEOVERFLOW 1
#define BERANDOMJOB 2
#define RETURNTOLOBBY 3
