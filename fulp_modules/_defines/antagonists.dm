///Uncomment this to enable testing of Bloodsucker features (such as vassalizing people with a mind instead of a client).
//#define BLOODSUCKER_TESTING

/**
 * BLOODSUCKER DEFINES
 */


/// You have special interactions with Bloodsuckers
#define TRAIT_BLOODSUCKER_HUNTER "bloodsucker_hunter"

/// Determines Bloodsucker regeneration rate
#define BS_BLOOD_VOLUME_MAX_REGEN 700
/// Cost to torture someone halfway, in blood. Called twice for full cost
#define TORTURE_BLOOD_HALF_COST 8
/// Cost to convert someone after successful torture, in blood
#define TORTURE_CONVERSION_COST 50
/// Once blood is this low, will enter Frenzy
#define FRENZY_MINIMUM_THRESHOLD_ENTER 25
///Amount of blood on TOP of your frenzy limit you need to EXIT frenzy.
#define FRENZY_EXTRA_BLOOD_NEEDED 50

///If someone passes all checks and can be vassalized
#define VASSALIZATION_ALLOWED 0
///If someone has to accept vassalization
#define VASSALIZATION_DISLOYAL 1
///If someone is not allowed under any circimstances to become a Vassal
#define VASSALIZATION_BANNED 2

///Spam prevention for healing messages.
#define BLOODSUCKER_SPAM_HEALING (15 SECONDS)
///Span prevention for Sol Masquerade messages.
#define BLOODSUCKER_SPAM_MASQUERADE (60 SECONDS)
///Span prevention for Sol messages.
#define BLOODSUCKER_SPAM_SOL (30 SECONDS)

#define CLAN_NONE "Caitiff"
#define CLAN_BRUJAH "Brujah Clan"
#define CLAN_TOREADOR "Toreador Clan"
#define CLAN_NOSFERATU "Nosferatu Clan"
#define CLAN_TREMERE "Tremere Clan"
#define CLAN_GANGREL "Gangrel Clan"
#define CLAN_VENTRUE "Ventrue Clan"
#define CLAN_MALKAVIAN "Malkavian Clan"
#define CLAN_TZIMISCE "Tzimisce Clan"
#define CLAN_VASSAL "your Master"

#define TREMERE_VASSAL "tremere_vassal"
#define FAVORITE_VASSAL "favorite_vassal"
#define REVENGE_VASSAL "revenge_vassal"

/// This Power can't be used in Torpor
#define BP_CANT_USE_IN_TORPOR (1<<0)
/// This Power can't be used in Frenzy.
#define BP_CANT_USE_IN_FRENZY (1<<1)
/// This Power can't be used with a stake in you
#define BP_CANT_USE_WHILE_STAKED (1<<2)
/// This Power can't be used while incapacitated
#define BP_CANT_USE_WHILE_INCAPACITATED (1<<3)
/// This Power can't be used while unconscious
#define BP_CANT_USE_WHILE_UNCONSCIOUS (1<<4)

/// This Power can be purchased by Bloodsuckers
#define BLOODSUCKER_CAN_BUY (1<<0)
/// This is a Default Power that all Bloodsuckers get.
#define BLOODSUCKER_DEFAULT_POWER (1<<1)
/// This Power can be purchased by Tremere Bloodsuckers
#define TREMERE_CAN_BUY (1<<2)
/// This Power can be purchased by Vassals
#define VASSAL_CAN_BUY (1<<3)

/// This Power is a Toggled Power
#define BP_AM_TOGGLE (1<<0)
/// This Power is a Single-Use Power
#define BP_AM_SINGLEUSE (1<<1)
/// This Power has a Static cooldown
#define BP_AM_STATIC_COOLDOWN (1<<2)
/// This Power doesn't cost bloot to run while unconscious
#define BP_AM_COSTLESS_UNCONSCIOUS (1<<3)

///Signal sent when Sol is at the period to rank all valid Bloodsuckers up.
#define COMSIG_SOL_RANKUP_BLOODSUCKERS "comsig_sol_rankup_bloodsuckers"
///Signal sent when Sol rises,
#define COMSIG_SOL_RISE_TICK "comsig_sol_rise_tick"
///Signal sent when Sol is about to start.
#define COMSIG_SOL_NEAR_START "comsig_sol_near_start"
///Signal sent when Sol ends.
#define COMSIG_SOL_END "comsig_sol_end"
///Signal sent when a warning for Sol is meant to go out: (danger_level, vampire_warning_message, vassal_warning_message)
#define COMSIG_SOL_WARNING_GIVEN "comsig_sol_warning_given"
///Signal sent to trigger a Bloodsucker's Lifetick.
#define COMSIG_BLOODSUCKER_ON_LIFETICK "comsig_bloodsucker_on_lifetick"

#define DANGER_LEVEL_FIRST_WARNING 1
#define DANGER_LEVEL_SECOND_WARNING 2
#define DANGER_LEVEL_THIRD_WARNING 3
#define DANGER_LEVEL_SOL_ROSE 4
#define DANGER_LEVEL_SOL_ENDED 5

///Clan drinks blood the normal Bloodsucker way.
#define BLOODSUCKER_DRINK_NORMAL "bloodsucker_drink_normal"
///Clan drinks blood but is snobby, refusing to drink from mindless
#define BLOODSUCKER_DRINK_SNOBBY "bloodsucker_drink_snobby"
///Clan drinks blood from disgusting creatures without Humanity consequences.
#define BLOODSUCKER_DRINK_INHUMANELY "bloodsucker_drink_imhumanely"

#define ROLE_BLOODSUCKER "Bloodsucker"
#define ROLE_VAMPIRICACCIDENT "Vampiric Accident"
#define ROLE_BLOODSUCKERBREAKOUT "Bloodsucker Breakout"
#define ROLE_MONSTERHUNTER "Monster Hunter"


/**
 * INFILTRATOR DEFINES
 */

#define ROLE_INFILTRATOR "Infiltrator"

/**
 * DEVIL DEFINES
 */

///How many souls a Devil needs to 'Ascend'.
#define DEVIL_SOULS_TO_ASCEND 8

///How many contracts a devil can have signed max.
#define DEVIL_MAX_CONTRACTS 4

#define ROLE_INFERNAL_AFFAIRS "Infernal Affairs Agent"
#define ROLE_INFERNAL_AFFAIRS_DEVIL "Devil"

