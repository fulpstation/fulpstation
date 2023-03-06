/*ALL MOB-RELATED DEFINES THAT DON'T BELONG IN ANOTHER FILE GO HERE*/

//Misc mob defines

//Ready states at roundstart for mob/dead/new_player
#define PLAYER_NOT_READY 0
#define PLAYER_READY_TO_PLAY 1

//movement intent defines for the m_intent var
#define MOVE_INTENT_WALK "walk"
#define MOVE_INTENT_RUN "run"

//Blood levels
#define BLOOD_VOLUME_MAX_LETHAL 2150
#define BLOOD_VOLUME_EXCESS 2100
#define BLOOD_VOLUME_MAXIMUM 2000
#define BLOOD_VOLUME_SLIME_SPLIT 1120
#define BLOOD_VOLUME_NORMAL 560
#define BLOOD_VOLUME_SAFE 475
#define BLOOD_VOLUME_OKAY 336
#define BLOOD_VOLUME_BAD 224
#define BLOOD_VOLUME_SURVIVE 122

/// How efficiently humans regenerate blood.
#define BLOOD_REGEN_FACTOR 0.25

/// Temperature at which blood loss and regen stops. [/mob/living/carbon/human/proc/handle_blood]
#define BLOOD_STOP_TEMP 225

//Sizes of mobs, used by mob/living/var/mob_size
#define MOB_SIZE_TINY 0
#define MOB_SIZE_SMALL 1
#define MOB_SIZE_HUMAN 2
#define MOB_SIZE_LARGE 3
#define MOB_SIZE_HUGE 4 // Use this for things you don't want bluespace body-bagged

//Ventcrawling defines
#define VENTCRAWLER_NONE 0
#define VENTCRAWLER_NUDE 1
#define VENTCRAWLER_ALWAYS 2

//Mob bio-types flags
#define MOB_ORGANIC (1 << 0)
#define MOB_MINERAL (1 << 1)
#define MOB_ROBOTIC (1 << 2)
#define MOB_UNDEAD (1 << 3)
#define MOB_HUMANOID (1 << 4)
#define MOB_BUG (1 << 5)
#define MOB_BEAST (1 << 6)
#define MOB_EPIC (1 << 7) //megafauna
#define MOB_REPTILE (1 << 8)
#define MOB_SPIRIT (1 << 9)
#define MOB_PLANT (1 << 10)

//Lung respiration type flags
#define RESPIRATION_OXYGEN (1 << 0)
#define RESPIRATION_CO2 (1 << 1)
#define RESPIRATION_N2 (1 << 2)
#define RESPIRATION_PLASMA (1 << 3)

//Organ defines for carbon mobs
#define ORGAN_ORGANIC 1
#define ORGAN_ROBOTIC 2
#define ORGAN_MINERAL 3 // Used for the plasmaman liver

#define DEFAULT_BODYPART_ICON_ORGANIC 'icons/mob/species/human/bodyparts_greyscale.dmi'
#define DEFAULT_BODYPART_ICON_ROBOTIC 'icons/mob/augmentation/augments.dmi'

#define MONKEY_BODYPART "monkey"
#define ALIEN_BODYPART "alien"
#define LARVA_BODYPART "larva"

//Bodypart change blocking flags
///Bodypart does not get replaced during set_species()
#define BP_BLOCK_CHANGE_SPECIES (1<<0)

//Bodytype defines for how things can be worn, surgery, and other misc things.
///The limb is organic.
#define BODYTYPE_ORGANIC (1<<0)
///The limb is robotic.
#define BODYTYPE_ROBOTIC (1<<1)
///The limb fits the human mold. This is not meant to be literal, if the sprite "fits" on a human, it is "humanoid", regardless of origin.
#define BODYTYPE_HUMANOID (1<<2)
///The limb is digitigrade.
#define BODYTYPE_DIGITIGRADE (1<<3)
///The limb fits the monkey mold.
#define BODYTYPE_MONKEY (1<<4)
///The limb is snouted.
#define BODYTYPE_SNOUTED (1<<5)
///A placeholder bodytype for xeno larva, so their limbs cannot be attached to anything.
#define BODYTYPE_LARVA_PLACEHOLDER (1<<6)
///The limb is from a xenomorph.
#define BODYTYPE_ALIEN (1<<7)

// Defines for Species IDs. Used to refer to the name of a species, for things like bodypart names or species preferences.
#define SPECIES_ABDUCTOR "abductor"
#define SPECIES_ANDROID "android"
#define SPECIES_DULLAHAN "dullahan"
#define SPECIES_ETHEREAL "ethereal"
#define SPECIES_FELINE "felinid"
#define SPECIES_FLYPERSON "fly"
#define SPECIES_HUMAN "human"
#define SPECIES_JELLYPERSON "jelly"
#define SPECIES_SLIMEPERSON "slime"
#define SPECIES_LUMINESCENT "luminescent"
#define SPECIES_STARGAZER "stargazer"
#define SPECIES_LIZARD "lizard"
#define SPECIES_LIZARD_ASH "ashwalker"
#define SPECIES_LIZARD_SILVER "silverscale"
#define SPECIES_NIGHTMARE "nightmare"
#define SPECIES_MONKEY "monkey"
#define SPECIES_MOTH "moth"
#define SPECIES_MUSHROOM "mush"
#define SPECIES_PLASMAMAN "plasmaman"
#define SPECIES_PODPERSON "pod"
#define SPECIES_SHADOW "shadow"
#define SPECIES_SKELETON "skeleton"
#define SPECIES_SNAIL "snail"
#define SPECIES_VAMPIRE "vampire"
#define SPECIES_ZOMBIE "zombie"
#define SPECIES_ZOMBIE_INFECTIOUS "memezombie"
#define SPECIES_ZOMBIE_KROKODIL "krokodil_zombie"

// Like species IDs, but not specifically attached a species.
#define BODYPART_ID_ALIEN "alien"
#define BODYPART_ID_ROBOTIC "robotic"
#define BODYPART_ID_DIGITIGRADE "digitigrade"
#define BODYPART_ID_LARVA "larva"
#define BODYPART_ID_PSYKER "psyker"

//See: datum/species/var/digitigrade_customization
///The species does not have digitigrade legs in generation.
#define DIGITIGRADE_NEVER 0
///The species can have digitigrade legs in generation
#define DIGITIGRADE_OPTIONAL 1
///The species is forced to have digitigrade legs in generation.
#define DIGITIGRADE_FORCED 2

///Digitigrade's prefs, used in features for legs if you're meant to be a Digitigrade.
#define DIGITIGRADE_LEGS "Digitigrade Legs"

// Health/damage defines
#define MAX_LIVING_HEALTH 100

//for determining which type of heartbeat sound is playing
///Heartbeat is beating fast for hard crit
#define BEAT_FAST 1
///Heartbeat is beating slow for soft crit
#define BEAT_SLOW 2
///Heartbeat is gone... He's dead Jim :(
#define BEAT_NONE 0

#define HUMAN_MAX_OXYLOSS 3
#define HUMAN_CRIT_MAX_OXYLOSS (SSMOBS_DT/3)

#define STAMINA_REGEN_BLOCK_TIME (10 SECONDS)

#define HEAT_DAMAGE_LEVEL_1 1 //Amount of damage applied when your body temperature just passes the 360.15k safety point
#define HEAT_DAMAGE_LEVEL_2 1.5 //Amount of damage applied when your body temperature passes the 400K point
#define HEAT_DAMAGE_LEVEL_3 4 //Amount of damage applied when your body temperature passes the 460K point and you are on fire

#define COLD_DAMAGE_LEVEL_1 0.25 //Amount of damage applied when your body temperature just passes the 260.15k safety point
#define COLD_DAMAGE_LEVEL_2 0.75 //Amount of damage applied when your body temperature passes the 200K point
#define COLD_DAMAGE_LEVEL_3 1.5 //Amount of damage applied when your body temperature passes the 120K point

//Note that gas heat damage is only applied once every FOUR ticks.
#define HEAT_GAS_DAMAGE_LEVEL_1 2 //Amount of damage applied when the current breath's temperature just passes the 360.15k safety point
#define HEAT_GAS_DAMAGE_LEVEL_2 4 //Amount of damage applied when the current breath's temperature passes the 400K point
#define HEAT_GAS_DAMAGE_LEVEL_3 8 //Amount of damage applied when the current breath's temperature passes the 1000K point

#define COLD_GAS_DAMAGE_LEVEL_1 0.5 //Amount of damage applied when the current breath's temperature just passes the 260.15k safety point
#define COLD_GAS_DAMAGE_LEVEL_2 1.5 //Amount of damage applied when the current breath's temperature passes the 200K point
#define COLD_GAS_DAMAGE_LEVEL_3 3 //Amount of damage applied when the current breath's temperature passes the 120K point

//Brain Damage defines
#define BRAIN_DAMAGE_MILD 20
#define BRAIN_DAMAGE_SEVERE 100
#define BRAIN_DAMAGE_DEATH 200

#define BRAIN_TRAUMA_MILD /datum/brain_trauma/mild
#define BRAIN_TRAUMA_SEVERE /datum/brain_trauma/severe
#define BRAIN_TRAUMA_SPECIAL /datum/brain_trauma/special
#define BRAIN_TRAUMA_MAGIC /datum/brain_trauma/magic

#define TRAUMA_RESILIENCE_BASIC 1 //Curable with chems
#define TRAUMA_RESILIENCE_SURGERY 2 //Curable with brain surgery
#define TRAUMA_RESILIENCE_LOBOTOMY 3 //Curable with lobotomy
#define TRAUMA_RESILIENCE_WOUND 4 //Curable by healing the head wound
#define TRAUMA_RESILIENCE_MAGIC 5 //Curable only with magic
#define TRAUMA_RESILIENCE_ABSOLUTE 6 //This is here to stay

//Limit of traumas for each resilience tier
#define TRAUMA_LIMIT_BASIC 3
#define TRAUMA_LIMIT_SURGERY 2
#define TRAUMA_LIMIT_WOUND 2
#define TRAUMA_LIMIT_LOBOTOMY 3
#define TRAUMA_LIMIT_MAGIC 3
#define TRAUMA_LIMIT_ABSOLUTE INFINITY

#define BRAIN_DAMAGE_INTEGRITY_MULTIPLIER 0.5

//Surgery Defines
#define BIOWARE_GENERIC "generic"
#define BIOWARE_NERVES "nerves"
#define BIOWARE_CIRCULATION "circulation"
#define BIOWARE_LIGAMENTS "ligaments"
#define BIOWARE_CORTEX "cortex"

//Health hud screws for carbon mobs
#define SCREWYHUD_NONE 0
#define SCREWYHUD_CRIT 1
#define SCREWYHUD_DEAD 2
#define SCREWYHUD_HEALTHY 3

//Health doll screws for human mobs
#define SCREWYDOLL_HEAD /obj/item/bodypart/head
#define SCREWYDOLL_CHEST /obj/item/bodypart/chest
#define SCREWYDOLL_L_ARM /obj/item/bodypart/arm/left
#define SCREWYDOLL_R_ARM /obj/item/bodypart/arm/right
#define SCREWYDOLL_L_LEG /obj/item/bodypart/leg/left
#define SCREWYDOLL_R_LEG /obj/item/bodypart/leg/right

//Threshold levels for beauty for humans
#define BEAUTY_LEVEL_HORRID -66
#define BEAUTY_LEVEL_BAD -33
#define BEAUTY_LEVEL_DECENT 33
#define BEAUTY_LEVEL_GOOD 66
#define BEAUTY_LEVEL_GREAT 100

//Moods levels for humans
#define MOOD_HAPPY4 15
#define MOOD_HAPPY3 10
#define MOOD_HAPPY2 6
#define MOOD_HAPPY1 2
#define MOOD_NEUTRAL 0
#define MOOD_SAD1 -3
#define MOOD_SAD2 -7
#define MOOD_SAD3 -15
#define MOOD_SAD4 -20

//Moods levels for humans
#define MOOD_LEVEL_HAPPY4 9
#define MOOD_LEVEL_HAPPY3 8
#define MOOD_LEVEL_HAPPY2 7
#define MOOD_LEVEL_HAPPY1 6
#define MOOD_LEVEL_NEUTRAL 5
#define MOOD_LEVEL_SAD1 4
#define MOOD_LEVEL_SAD2 3
#define MOOD_LEVEL_SAD3 2
#define MOOD_LEVEL_SAD4 1

//Sanity values for humans
#define SANITY_MAXIMUM 150
#define SANITY_GREAT 125
#define SANITY_NEUTRAL 100
#define SANITY_DISTURBED 75
#define SANITY_UNSTABLE 50
#define SANITY_CRAZY 25
#define SANITY_INSANE 0

//Sanity levels for humans
#define SANITY_LEVEL_GREAT 1
#define SANITY_LEVEL_NEUTRAL 2
#define SANITY_LEVEL_DISTURBED 3
#define SANITY_LEVEL_UNSTABLE 4
#define SANITY_LEVEL_CRAZY 5
#define SANITY_LEVEL_INSANE 6

//Nutrition levels for humans
#define NUTRITION_LEVEL_FAT 600
#define NUTRITION_LEVEL_FULL 550
#define NUTRITION_LEVEL_WELL_FED 450
#define NUTRITION_LEVEL_FED 350
#define NUTRITION_LEVEL_HUNGRY 250
#define NUTRITION_LEVEL_STARVING 150

#define NUTRITION_LEVEL_START_MIN 250
#define NUTRITION_LEVEL_START_MAX 400

//Disgust levels for humans
#define DISGUST_LEVEL_MAXEDOUT 150
#define DISGUST_LEVEL_DISGUSTED 75
#define DISGUST_LEVEL_VERYGROSS 50
#define DISGUST_LEVEL_GROSS 25

//Used as an upper limit for species that continuously gain nutriment
#define NUTRITION_LEVEL_ALMOST_FULL 535

//Charge levels for Ethereals
#define ETHEREAL_CHARGE_NONE 0
#define ETHEREAL_CHARGE_LOWPOWER 400
#define ETHEREAL_CHARGE_NORMAL 1000
#define ETHEREAL_CHARGE_ALMOSTFULL 1500
#define ETHEREAL_CHARGE_FULL 2000
#define ETHEREAL_CHARGE_OVERLOAD 2500
#define ETHEREAL_CHARGE_DANGEROUS 3000


#define CRYSTALIZE_COOLDOWN_LENGTH (120 SECONDS)
#define CRYSTALIZE_PRE_WAIT_TIME (40 SECONDS)
#define CRYSTALIZE_DISARM_WAIT_TIME (120 SECONDS)
#define CRYSTALIZE_HEAL_TIME (60 SECONDS)

#define BRUTE_DAMAGE_REQUIRED_TO_STOP_CRYSTALIZATION 30

#define CRYSTALIZE_STAGE_ENGULFING 100 //Cant use second defines
#define CRYSTALIZE_STAGE_ENCROACHING 300 //In switches
#define CRYSTALIZE_STAGE_SMALL 600 //Because they're not static

//Slime evolution threshold. Controls how fast slimes can split/grow
#define SLIME_EVOLUTION_THRESHOLD 10

//Slime extract crossing. Controls how many extracts is required to feed to a slime to core-cross.
#define SLIME_EXTRACT_CROSSING_REQUIRED 10

//Slime commands defines
#define SLIME_FRIENDSHIP_FOLLOW 3 //Min friendship to order it to follow
#define SLIME_FRIENDSHIP_STOPEAT 5 //Min friendship to order it to stop eating someone
#define SLIME_FRIENDSHIP_STOPEAT_NOANGRY 7 //Min friendship to order it to stop eating someone without it losing friendship
#define SLIME_FRIENDSHIP_STOPCHASE 4 //Min friendship to order it to stop chasing someone (their target)
#define SLIME_FRIENDSHIP_STOPCHASE_NOANGRY 6 //Min friendship to order it to stop chasing someone (their target) without it losing friendship
#define SLIME_FRIENDSHIP_STAY 3 //Min friendship to order it to stay
#define SLIME_FRIENDSHIP_ATTACK 8 //Min friendship to order it to attack

//Sentience types, to prevent things like sentience potions from giving bosses sentience
#define SENTIENCE_ORGANIC 1
#define SENTIENCE_ARTIFICIAL 2
#define SENTIENCE_HUMANOID 3
#define SENTIENCE_MINEBOT 4
#define SENTIENCE_BOSS 5

//Mob AI Status
#define POWER_RESTORATION_OFF 0
#define POWER_RESTORATION_START 1
#define POWER_RESTORATION_SEARCH_APC 2
#define POWER_RESTORATION_APC_FOUND 3

//Hostile simple animals
//If you add a new status, be sure to add a list for it to the simple_animals global in _globalvars/lists/mobs.dm
#define AI_ON 1
#define AI_IDLE 2
#define AI_OFF 3
#define AI_Z_OFF 4

//The range at which a mob should wake up if you spawn into the z level near it
#define MAX_SIMPLEMOB_WAKEUP_RANGE 5

//determines if a mob can smash through it
#define ENVIRONMENT_SMASH_NONE 0
#define ENVIRONMENT_SMASH_STRUCTURES 1 //crates, lockers, ect
#define ENVIRONMENT_SMASH_WALLS 2 //walls
#define ENVIRONMENT_SMASH_RWALLS 3 //rwalls

#define NO_SLIP_WHEN_WALKING (1<<0)
#define SLIDE (1<<1)
#define GALOSHES_DONT_HELP (1<<2)
#define SLIDE_ICE (1<<3)
#define SLIP_WHEN_CRAWLING (1<<4) //clown planet ruin

#define MAX_CHICKENS 50

///Flags used by the flags parameter of electrocute act.

///Makes it so that the shock doesn't take gloves into account.
#define SHOCK_NOGLOVES (1 << 0)
///Used when the shock is from a tesla bolt.
#define SHOCK_TESLA (1 << 1)
///Used when an illusion shocks something. Makes the shock deal stamina damage and not trigger certain secondary effects.
#define SHOCK_ILLUSION (1 << 2)
///The shock doesn't stun.
#define SHOCK_NOSTUN (1 << 3)
/// No default message is sent from the shock
#define SHOCK_SUPPRESS_MESSAGE (1 << 4)

#define INCORPOREAL_MOVE_BASIC 1 /// normal movement, see: [/mob/living/var/incorporeal_move]
#define INCORPOREAL_MOVE_SHADOW 2 /// leaves a trail of shadows
#define INCORPOREAL_MOVE_JAUNT 3 /// is blocked by holy water/salt

#define SHADOW_SPECIES_LIGHT_THRESHOLD 0.2

#define COOLDOWN_UPDATE_SET_MELEE "set_melee"
#define COOLDOWN_UPDATE_ADD_MELEE "add_melee"
#define COOLDOWN_UPDATE_SET_RANGED "set_ranged"
#define COOLDOWN_UPDATE_ADD_RANGED "add_ranged"
#define COOLDOWN_UPDATE_SET_ENRAGE "set_enrage"
#define COOLDOWN_UPDATE_ADD_ENRAGE "add_enrage"
#define COOLDOWN_UPDATE_SET_SPAWN "set_spawn"
#define COOLDOWN_UPDATE_ADD_SPAWN "add_spawn"
#define COOLDOWN_UPDATE_SET_HELP "set_help"
#define COOLDOWN_UPDATE_ADD_HELP "add_help"
#define COOLDOWN_UPDATE_SET_DASH "set_dash"
#define COOLDOWN_UPDATE_ADD_DASH "add_dash"
#define COOLDOWN_UPDATE_SET_TRANSFORM "set_transform"
#define COOLDOWN_UPDATE_ADD_TRANSFORM "add_transform"
#define COOLDOWN_UPDATE_SET_CHASER "set_chaser"
#define COOLDOWN_UPDATE_ADD_CHASER "add_chaser"
#define COOLDOWN_UPDATE_SET_ARENA "set_arena"
#define COOLDOWN_UPDATE_ADD_ARENA "add_arena"

// Offsets defines

#define OFFSET_UNIFORM "uniform"
#define OFFSET_ID "id"
#define OFFSET_GLOVES "gloves"
#define OFFSET_GLASSES "glasses"
#define OFFSET_EARS "ears"
#define OFFSET_SHOES "shoes"
#define OFFSET_S_STORE "s_store"
#define OFFSET_FACEMASK "mask"
#define OFFSET_HEAD "head"
#define OFFSET_FACE "face"
#define OFFSET_BELT "belt"
#define OFFSET_BACK "back"
#define OFFSET_SUIT "suit"
#define OFFSET_NECK "neck"

//MINOR TWEAKS/MISC
#define AGE_MIN 17 //youngest a character can be
#define AGE_MAX 85 //oldest a character can be
#define AGE_MINOR 20 //legal age of space drinking and smoking
#define WIZARD_AGE_MIN 30 //youngest a wizard can be
#define APPRENTICE_AGE_MIN 29 //youngest an apprentice can be
#define SHOES_SLOWDOWN 0 //How much shoes slow you down by default. Negative values speed you up
#define SHOES_SPEED_SLIGHT SHOES_SLOWDOWN - 1 // slightest speed boost to movement
#define POCKET_STRIP_DELAY (4 SECONDS) //time taken to search somebody's pockets
#define DOOR_CRUSH_DAMAGE 15 //the amount of damage that airlocks deal when they crush you

#define HUNGER_FACTOR 0.05 //factor at which mob nutrition decreases
#define ETHEREAL_CHARGE_FACTOR 0.8 //factor at which ethereal's charge decreases per second
/// How much nutrition eating clothes as moth gives and drains
#define CLOTHING_NUTRITION_GAIN 15
#define REAGENTS_METABOLISM 0.2 //How many units of reagent are consumed per second, by default.
#define REAGENTS_EFFECT_MULTIPLIER (REAGENTS_METABOLISM / 0.4) // By defining the effect multiplier this way, it'll exactly adjust all effects according to how they originally were with the 0.4 metabolism

// Eye protection
#define FLASH_PROTECTION_HYPER_SENSITIVE -2
#define FLASH_PROTECTION_SENSITIVE -1
#define FLASH_PROTECTION_NONE 0
#define FLASH_PROTECTION_FLASH 1
#define FLASH_PROTECTION_WELDER 2

// Roundstart trait system

#define MAX_QUIRKS 6 //The maximum amount of quirks one character can have at roundstart

// AI Toggles
#define AI_CAMERA_LUMINOSITY 5
#define AI_VOX // Comment out if you don't want VOX to be enabled and have players download the voice sounds.

// /obj/item/bodypart on_mob_life() retval flag
#define BODYPART_LIFE_UPDATE_HEALTH (1<<0)

#define MAX_REVIVE_FIRE_DAMAGE 180
#define MAX_REVIVE_BRUTE_DAMAGE 180

#define DEFAULT_BRUTE_EXAMINE_TEXT "bruising"
#define DEFAULT_BURN_EXAMINE_TEXT "burns"
#define DEFAULT_CLONE_EXAMINE_TEXT "cellular damage"

#define ROBOTIC_BRUTE_EXAMINE_TEXT "denting"
#define ROBOTIC_BURN_EXAMINE_TEXT "charring"

// If a mob has a higher threshold than this, the icon shown will be increased to the big fire icon.
#define MOB_BIG_FIRE_STACK_THRESHOLD 3

#define GRAB_PIXEL_SHIFT_PASSIVE 6
#define GRAB_PIXEL_SHIFT_AGGRESSIVE 12
#define GRAB_PIXEL_SHIFT_NECK 16

#define PULL_PRONE_SLOWDOWN 1.5
#define HUMAN_CARRY_SLOWDOWN 0.35

//Flags that control what things can spawn species (whitelist)
//Badmin magic mirror
#define MIRROR_BADMIN (1<<0)
//Standard magic mirror (wizard)
#define MIRROR_MAGIC (1<<1)
//Pride ruin mirror
#define MIRROR_PRIDE (1<<2)
//Race swap wizard event
#define RACE_SWAP (1<<3)
//ERT spawn template (avoid races that don't function without correct gear)
#define ERT_SPAWN (1<<4)
//xenobio black crossbreed
#define SLIME_EXTRACT (1<<5)
//Wabbacjack staff projectiles
#define WABBAJACK (1<<6)

// Randomization keys for calling wabbajack with.
// Note the contents of these keys are important, as they're displayed to the player
// Ex: (You turn into a "monkey", You turn into a "xenomorph")
#define WABBAJACK_MONKEY "monkey"
#define WABBAJACK_ROBOT "robot"
#define WABBAJACK_SLIME "slime"
#define WABBAJACK_XENO "xenomorph"
#define WABBAJACK_HUMAN "humanoid"
#define WABBAJACK_ANIMAL "animal"

// Reasons a defibrilation might fail
#define DEFIB_POSSIBLE (1<<0)
#define DEFIB_FAIL_SUICIDE (1<<1)
#define DEFIB_FAIL_HUSK (1<<2)
#define DEFIB_FAIL_TISSUE_DAMAGE (1<<3)
#define DEFIB_FAIL_FAILING_HEART (1<<4)
#define DEFIB_FAIL_NO_HEART (1<<5)
#define DEFIB_FAIL_FAILING_BRAIN (1<<6)
#define DEFIB_FAIL_NO_BRAIN (1<<7)
#define DEFIB_FAIL_NO_INTELLIGENCE (1<<8)
#define DEFIB_FAIL_BLACKLISTED (1<<9)
#define DEFIB_NOGRAB_AGHOST (1<<10)

// Bit mask of possible return values by can_defib that would result in a revivable patient
#define DEFIB_REVIVABLE_STATES (DEFIB_FAIL_NO_HEART | DEFIB_FAIL_FAILING_HEART | DEFIB_FAIL_HUSK | DEFIB_FAIL_TISSUE_DAMAGE | DEFIB_FAIL_FAILING_BRAIN | DEFIB_POSSIBLE)

#define SLEEP_CHECK_DEATH(X, A) \
	sleep(X); \
	if(QDELETED(A)) return; \
	if(ismob(A)) { \
		var/mob/sleep_check_death_mob = A; \
		if(sleep_check_death_mob.stat == DEAD) return; \
	}


#define DOING_INTERACTION(user, interaction_key) (LAZYACCESS(user.do_afters, interaction_key))
#define DOING_INTERACTION_LIMIT(user, interaction_key, max_interaction_count) ((LAZYACCESS(user.do_afters, interaction_key) || 0) >= max_interaction_count)
#define DOING_INTERACTION_WITH_TARGET(user, target) (LAZYACCESS(user.do_afters, target))
#define DOING_INTERACTION_WITH_TARGET_LIMIT(user, target, max_interaction_count) ((LAZYACCESS(user.do_afters, target) || 0) >= max_interaction_count)

// recent examine defines
/// How long it takes for an examined atom to be removed from recent_examines. Should be the max of the below time windows
#define RECENT_EXAMINE_MAX_WINDOW (2 SECONDS)
/// If you examine the same atom twice in this timeframe, we call examine_more() instead of examine()
#define EXAMINE_MORE_WINDOW (1 SECONDS)
/// If you examine another mob who's successfully examined you during this duration of time, you two try to make eye contact. Cute!
#define EYE_CONTACT_WINDOW (2 SECONDS)
/// If you yawn while someone nearby has examined you within this time frame, it will force them to yawn as well. Tradecraft!
#define YAWN_PROPAGATION_EXAMINE_WINDOW (2 SECONDS)

/// How far away you can be to make eye contact with someone while examining
#define EYE_CONTACT_RANGE 5


#define SILENCE_RANGED_MESSAGE (1<<0)

/// Returns whether or not the given mob can succumb
#define CAN_SUCCUMB(target) (HAS_TRAIT(target, TRAIT_CRITICAL_CONDITION) && !HAS_TRAIT(target, TRAIT_NODEATH))

// Body position defines.
/// Mob is standing up, usually associated with lying_angle value of 0.
#define STANDING_UP 0
/// Mob is lying down, usually associated with lying_angle values of 90 or 270.
#define LYING_DOWN 1

///How much a mob's sprite should be moved when they're lying down
#define PIXEL_Y_OFFSET_LYING -6

///Define for spawning megafauna instead of a mob for cave gen
#define SPAWN_MEGAFAUNA "bluh bluh huge boss"

///Squash flags. For squashable element

///Whether or not the squashing requires the squashed mob to be lying down
#define SQUASHED_SHOULD_BE_DOWN (1<<0)
///Whether or not to gib when the squashed mob is moved over
#define SQUASHED_SHOULD_BE_GIBBED (1<<0)

/*
 * Defines for "AI emotions", allowing the AI to expression emotions
 * with status displays via emotes.
 */

#define AI_EMOTION_VERY_HAPPY "Very Happy"
#define AI_EMOTION_HAPPY "Happy"
#define AI_EMOTION_NEUTRAL "Neutral"
#define AI_EMOTION_UNSURE "Unsure"
#define AI_EMOTION_CONFUSED "Confused"
#define AI_EMOTION_SAD "Sad"
#define AI_EMOTION_BSOD "BSOD"
#define AI_EMOTION_BLANK "Blank"
#define AI_EMOTION_PROBLEMS "Problems?"
#define AI_EMOTION_AWESOME "Awesome"
#define AI_EMOTION_FACEPALM "Facepalm"
#define AI_EMOTION_THINKING "Thinking"
#define AI_EMOTION_FRIEND_COMPUTER "Friend Computer"
#define AI_EMOTION_DORFY "Dorfy"
#define AI_EMOTION_BLUE_GLOW "Blue Glow"
#define AI_EMOTION_RED_GLOW "Red Glow"

/// Throw modes, defines whether or not to turn off throw mode after
#define THROW_MODE_DISABLED 0
#define THROW_MODE_TOGGLE 1
#define THROW_MODE_HOLD 2

//Saves a proc call, life is suffering. If who has no targets_from var, we assume it's just who
#define GET_TARGETS_FROM(who) (who.targets_from ? who.get_targets_from() : who)

//defines for grad_color and grad_styles list access keys
#define GRADIENT_HAIR_KEY 1
#define GRADIENT_FACIAL_HAIR_KEY 2
//Keep up to date with the highest key value
#define GRADIENTS_LEN 2

// /datum/sprite_accessory/gradient defines
#define GRADIENT_APPLIES_TO_HAIR (1<<0)
#define GRADIENT_APPLIES_TO_FACIAL_HAIR (1<<1)

// Height defines
// - They are numbers so you can compare height values (x height < y height)
// - They do not start at 0 for futureproofing
// - They skip numbers for futureproofing as well
// Otherwise they are completely arbitrary
#define HUMAN_HEIGHT_DWARF 2
#define HUMAN_HEIGHT_SHORTEST 4
#define HUMAN_HEIGHT_SHORT 6
#define HUMAN_HEIGHT_MEDIUM 8
#define HUMAN_HEIGHT_TALL 10
#define HUMAN_HEIGHT_TALLEST 12

/// Assoc list of all heights, cast to strings, to """"tuples"""""
/// The first """tuple""" index is the upper body offset
/// The second """tuple""" index is the lower body offset
GLOBAL_LIST_INIT(human_heights_to_offsets, list(
	"[HUMAN_HEIGHT_DWARF]" = list(-5, -4),
	"[HUMAN_HEIGHT_SHORTEST]" = list(-2, -1),
	"[HUMAN_HEIGHT_SHORT]" = list(-1, -1),
	"[HUMAN_HEIGHT_MEDIUM]" = list(0, 0),
	"[HUMAN_HEIGHT_TALL]" = list(1, 1),
	"[HUMAN_HEIGHT_TALLEST]" = list(2, 2),
))

// Mob Overlays Indexes
/// Total number of layers for mob overlays
/// KEEP THIS UP-TO-DATE OR SHIT WILL BREAK
/// Also consider updating layers_to_offset
#define TOTAL_LAYERS 33
/// Mutations layer - Tk headglows, cold resistance glow, etc
#define MUTATIONS_LAYER 33
/// Mutantrace features (tail when looking south) that must appear behind the body parts
#define BODY_BEHIND_LAYER 32
/// Layer for bodyparts that should appear behind every other bodypart - Mostly, legs when facing WEST or EAST
#define BODYPARTS_LOW_LAYER 31
/// Layer for most bodyparts, appears above BODYPARTS_LOW_LAYER and below BODYPARTS_HIGH_LAYER
#define BODYPARTS_LAYER 30
/// Mutantrace features (snout, body markings) that must appear above the body parts
#define BODY_ADJ_LAYER 29
/// Underwear, undershirts, socks, eyes, lips(makeup)
#define BODY_LAYER 28
/// Mutations that should appear above body, body_adj and bodyparts layer (e.g. laser eyes)
#define FRONT_MUTATIONS_LAYER 27
/// Damage indicators (cuts and burns)
#define DAMAGE_LAYER 26
/// Jumpsuit clothing layer
#define UNIFORM_LAYER 25
/// ID card layer
#define ID_LAYER 24
/// ID card layer (might be deprecated)
#define ID_CARD_LAYER 23
/// Layer for bodyparts that should appear above every other bodypart - Currently only used for hands
#define BODYPARTS_HIGH_LAYER 22
/// Gloves layer
#define GLOVES_LAYER 21
/// Shoes layer
#define SHOES_LAYER 20
/// Ears layer (Spessmen have ears? Wow)
#define EARS_LAYER 19
/// Suit layer (armor, coats, etc.)
#define SUIT_LAYER 18
/// Glasses layer
#define GLASSES_LAYER 17
/// Belt layer
#define BELT_LAYER 16 //Possible make this an overlay of somethign required to wear a belt?
/// Suit storage layer (tucking a gun or baton underneath your armor)
#define SUIT_STORE_LAYER 15
/// Neck layer (for wearing ties and bedsheets)
#define NECK_LAYER 14
/// Back layer (for backpacks and equipment on your back)
#define BACK_LAYER 13
/// Hair layer (mess with the fro and you got to go!)
#define HAIR_LAYER 12 //TODO: make part of head layer?
/// Facemask layer (gas masks, breath masks, etc.)
#define FACEMASK_LAYER 11
/// Head layer (hats, helmets, etc.)
#define HEAD_LAYER 10
/// Handcuff layer (when your hands are cuffed)
#define HANDCUFF_LAYER 9
/// Legcuff layer (when your feet are cuffed)
#define LEGCUFF_LAYER 8
/// Hands layer (for the actual hand, not the arm... I think?)
#define HANDS_LAYER 7
/// Body front layer. Usually used for mutant bodyparts that need to be in front of stuff (e.g. cat ears)
#define BODY_FRONT_LAYER 6
/// Special body layer that actually require to be above the hair (e.g. lifted welding goggles)
#define ABOVE_BODY_FRONT_GLASSES_LAYER 5
/// Special body layer for the rare cases where something on the head needs to be above everything else (e.g. flowers)
#define ABOVE_BODY_FRONT_HEAD_LAYER 4
/// Bleeding wound icons
#define WOUND_LAYER 3
/// Blood cult ascended halo layer, because there's currently no better solution for adding/removing
#define HALO_LAYER 2
/// Fire layer when you're on fire
#define FIRE_LAYER 1

#define UPPER_BODY "upper body"
#define LOWER_BODY "lower body"
#define NO_MODIFY "do not modify"

/// Used for human height overlay adjustments
/// Certain standing overlay layers shouldn't have a filter applied and should instead just offset by a pixel y
/// This list contains all the layers that must offset, with its value being whether it's a part of the upper half of the body (TRUE) or not (FALSE)
GLOBAL_LIST_INIT(layers_to_offset, list(
	// Weapons commonly cross the middle of the sprite so they get cut in half by the filter
	"[HANDS_LAYER]" = LOWER_BODY,
	// Very tall hats will get cut off by filter
	"[HEAD_LAYER]" = UPPER_BODY,
	// Hair will get cut off by filter
	"[HAIR_LAYER]" = UPPER_BODY,
	// Long belts (sabre sheathe) will get cut off by filter
	"[BELT_LAYER]" = LOWER_BODY,
	// Everything below looks fine with or without a filter, so we can skip it and just offset
	// (In practice they'd be fine if they got a filter but we can optimize a bit by not.)
	"[GLASSES_LAYER]" = UPPER_BODY,
	"[ABOVE_BODY_FRONT_GLASSES_LAYER]" = UPPER_BODY, // currently unused
	"[ABOVE_BODY_FRONT_HEAD_LAYER]" = UPPER_BODY, // only used for head stuff
	"[GLOVES_LAYER]" = LOWER_BODY,
	"[HALO_LAYER]" = UPPER_BODY, // above the head
	"[HANDCUFF_LAYER]" = LOWER_BODY,
	"[ID_CARD_LAYER]" = UPPER_BODY, // unused
	"[ID_LAYER]" = UPPER_BODY,
	"[FACEMASK_LAYER]" = UPPER_BODY,
	// These two are cached, and have their appearance shared(?), so it's safer to just not touch it
	"[MUTATIONS_LAYER]" = NO_MODIFY,
	"[FRONT_MUTATIONS_LAYER]" = NO_MODIFY,
	// These DO get a filter, I'm leaving them here as reference,
	// to show how many filters are added at a glance
	// BACK_LAYER (backpacks are big)
	// BODYPARTS_HIGH_LAYER (arms)
	// BODY_ADJ_LAYER (external organs like wings)
	// BODY_BEHIND_LAYER (external organs like wings)
	// BODY_FRONT_LAYER (external organs like wings)
	// DAMAGE_LAYER (full body)
	// FIRE_LAYER (full body)
	// UNIFORM_LAYER (full body)
	// WOUND_LAYER (full body)
))

//Bitflags for the layers a bodypart overlay can draw on (can be drawn on multiple layers)
/// Draws overlay on the BODY_FRONT_LAYER
#define EXTERNAL_FRONT (1 << 0)
/// Draws overlay on the BODY_ADJ_LAYER
#define EXTERNAL_ADJACENT (1 << 1)
/// Draws overlay on the BODY_BEHIND_LAYER
#define EXTERNAL_BEHIND (1 << 2)
/// Draws organ on all EXTERNAL layers
#define ALL_EXTERNAL_OVERLAYS EXTERNAL_FRONT | EXTERNAL_ADJACENT | EXTERNAL_BEHIND

// Bitflags for external organs restylability
/// This organ allows restyle through plant restyling (like secateurs)
#define EXTERNAL_RESTYLE_PLANT (1 << 1)
/// This organ allows restyling with flesh restyling stuff (surgery or something idk)
#define EXTERNAL_RESTYLE_FLESH (1 << 2)
/// This organ allows restyling with enamel restyling (like a fucking file or something?). It's for horns and shit
#define EXTERNAL_RESTYLE_ENAMEL (1 << 3)

//Mob Overlay Index Shortcuts for alternate_worn_layer, layers
//Because I *KNOW* somebody will think layer+1 means "above"
//IT DOESN'T OK, IT MEANS "UNDER"
/// The layer underneath the suit
#define UNDER_SUIT_LAYER (SUIT_LAYER+1)
/// The layer underneath the head (for hats)
#define UNDER_HEAD_LAYER (HEAD_LAYER+1)

//AND -1 MEANS "ABOVE", OK?, OK!?!
/// The layer above shoes
#define ABOVE_SHOES_LAYER (SHOES_LAYER-1)
/// The layer above mutant body parts
#define ABOVE_BODY_FRONT_LAYER (BODY_FRONT_LAYER-1)

/// If gravity must be present to perform action (can't use pens without gravity)
#define NEED_GRAVITY (1<<0)
/// If reading is required to perform action (can't read a book if you are illiterate)
#define NEED_LITERACY (1<<1)
/// If lighting must be present to perform action (can't heal someone in the dark)
#define NEED_LIGHT (1<<2)
/// If other mobs (monkeys, aliens, etc) can perform action (can't use computers if you are a monkey)
#define NEED_DEXTERITY (1<<3)
/// If hands are required to perform action (can't use objects that require hands if you are a cyborg)
#define NEED_HANDS (1<<4)
/// If telekinesis is forbidden to perform action from a distance (ex. canisters are blacklisted from telekinesis manipulation)
#define FORBID_TELEKINESIS_REACH (1<<5)
/// If silicons are allowed to perform action from a distance (silicons can operate airlocks from far away)
#define ALLOW_SILICON_REACH (1<<6)
/// If resting on the floor is allowed to perform action (pAIs can play music while resting)
#define ALLOW_RESTING (1<<7)

/// The default mob sprite size (used for shrinking or enlarging the mob sprite to regular size)
#define RESIZE_DEFAULT_SIZE 1

/// Get the client from the var
#define CLIENT_FROM_VAR(I) (ismob(I) ? I:client : (istype(I, /client) ? I : (istype(I, /datum/mind) ? I:current?:client : null)))

/// The mob will vomit a green color
#define VOMIT_TOXIC 1
/// The mob will vomit a purple color
#define VOMIT_PURPLE 2

/// Possible value of [/atom/movable/buckle_lying]. If set to a different (positive-or-zero) value than this, the buckling thing will force a lying angle on the buckled.
#define NO_BUCKLE_LYING -1

// Flags for fully_heal().

/// Special flag that means this heal is an admin heal and goes above and beyond
/// Note, this includes things like removing suicide status and handcuffs / legcuffs, use with slight caution.
#define HEAL_ADMIN (1<<0)
/// Heals all brute damage.
#define HEAL_BRUTE (1<<1)
/// Heals all burn damage.
#define HEAL_BURN (1<<2)
/// Heals all toxin damage, slime people included.
#define HEAL_TOX (1<<3)
/// Heals all oxyloss.
#define HEAL_OXY (1<<4)
/// Heals all cellular damage.
#define HEAL_CLONE (1<<5)
/// Heals all stamina damage.
#define HEAL_STAM (1<<6)
/// Restore all limbs to their initial state.
#define HEAL_LIMBS (1<<7)
/// Heals all organs from failing. If done as a part of an admin heal, will instead restore all organs to their initial state.
#define HEAL_ORGANS (1<<8)
/// Removes all wounds.
#define HEAL_WOUNDS (1<<9)
/// Removes all brain traumas, not including permanent ones.
#define HEAL_TRAUMAS (1<<10)
/// Removes all reagents present.
#define HEAL_ALL_REAGENTS (1<<11)
/// Removes all non-positive diseases.
#define HEAL_NEGATIVE_DISEASES (1<<12)
/// Restores body temperature back to nominal.
#define HEAL_TEMP (1<<13)
/// Restores blood levels to normal.
#define HEAL_BLOOD (1<<14)
/// Removes all non-positive mutations (neutral included).
#define HEAL_NEGATIVE_MUTATIONS (1<<15)
/// Removes status effects with this flag set that also have remove_on_fullheal = TRUE.
#define HEAL_STATUS (1<<16)
/// Same as above, removes all CC related status effects with this flag set that also have remove_on_fullheal = TRUE.
#define HEAL_CC_STATUS (1<<17)
/// Deletes any restraints on the mob (handcuffs / legcuffs)
#define HEAL_RESTRAINTS (1<<18)

/// Combination flag to only heal the main damage types.
#define HEAL_DAMAGE (HEAL_BRUTE|HEAL_BURN|HEAL_TOX|HEAL_OXY|HEAL_CLONE|HEAL_STAM)
/// Combination flag to only heal things messed up things about the mob's body itself.
#define HEAL_BODY (HEAL_LIMBS|HEAL_ORGANS|HEAL_WOUNDS|HEAL_TRAUMAS|HEAL_BLOOD|HEAL_TEMP)
/// Combination flag to heal negative things affecting the mob.
#define HEAL_AFFLICTIONS (HEAL_NEGATIVE_DISEASES|HEAL_NEGATIVE_MUTATIONS|HEAL_ALL_REAGENTS|HEAL_STATUS|HEAL_CC_STATUS)

/// Full heal that isn't admin forced
#define HEAL_ALL ~(HEAL_ADMIN|HEAL_RESTRAINTS)
/// Heals everything and is as strong as / is an admin heal
#define ADMIN_HEAL_ALL ALL

/// Checking flags for [/mob/proc/can_read()]
#define READING_CHECK_LITERACY (1<<0)
#define READING_CHECK_LIGHT (1<<1)

/// In dynamic human icon gen we don't replace the held item.
#define NO_REPLACE 0

/// Flags for whether you can heal yourself or not or only
#define HEALING_TOUCH_ANYONE "healing_touch_anyone"
#define HEALING_TOUCH_NOT_SELF "healing_touch_not_self"
#define HEALING_TOUCH_SELF_ONLY "healing_touch_self_only"

/// Default minimum body temperature mobs can exist in before taking damage
#define NPC_DEFAULT_MIN_TEMP 250
/// Default maximum body temperature mobs can exist in before taking damage
#define NPC_DEFAULT_MAX_TEMP 350
