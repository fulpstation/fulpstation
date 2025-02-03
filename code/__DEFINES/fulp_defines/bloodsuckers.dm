///Uncomment this to enable testing of Bloodsucker features (such as vassalizing people with a mind instead of a client).
//#define BLOODSUCKER_TESTING

/// You have special interactions with Bloodsuckers
#define TRAIT_BLOODSUCKER_HUNTER "bloodsucker_hunter"

/**
 * Blood-level defines
 */
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

/**
 * Vassal defines
 */
///If someone passes all checks and can be vassalized
#define VASSALIZATION_ALLOWED 0
///If someone has to accept vassalization
#define VASSALIZATION_DISLOYAL 1
///If someone is not allowed under any circimstances to become a Vassal
#define VASSALIZATION_BANNED 2

/**
 * Cooldown defines
 * Used in Cooldowns Bloodsuckers use to prevent spamming
 */
///Spam prevention for healing messages.
#define BLOODSUCKER_SPAM_HEALING (15 SECONDS)
///Span prevention for Sol Masquerade messages.
#define BLOODSUCKER_SPAM_MASQUERADE (60 SECONDS)

///Span prevention for Sol messages.
#define BLOODSUCKER_SPAM_SOL (30 SECONDS)

/**
 * Clan defines
 */
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
#define DISCORDANT_VASSAL "discordant_vassal"

/**
 * Power defines
 */
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
/// This Power can be purchased by Tremere Bloodsuckers, who starts with the base versions of them and must upgrade from there.
#define TREMERE_CAN_BUY (1<<2)
/// This Power can be purchased by Vassals
#define VASSAL_CAN_BUY (1<<3)
/// This Power is exclusive to Brujah Bloodsuckers, who will gain them upon joining Brujah.
#define BRUJAH_DEFAULT_POWER (1<<4)

/// This Power is a Toggled Power
#define BP_AM_TOGGLE (1<<0)
/// This Power is a Single-Use Power
#define BP_AM_SINGLEUSE (1<<1)
/// This Power has a Static cooldown
#define BP_AM_STATIC_COOLDOWN (1<<2)
/// This Power doesn't cost bloot to run while unconscious
#define BP_AM_COSTLESS_UNCONSCIOUS (1<<3)
/// This Power has a cooldown that is more dynamic than a typical Bloodsucker power
#define BP_AM_VERY_DYNAMIC_COOLDOWN (1<<4)

/**
 * Sol signals & Defines
 */
#define COMSIG_SOL_RANKUP_BLOODSUCKERS "comsig_sol_rankup_bloodsuckers"
#define COMSIG_SOL_RISE_TICK "comsig_sol_rise_tick"
#define COMSIG_SOL_NEAR_START "comsig_sol_near_start"
#define COMSIG_SOL_END "comsig_sol_end"
///Sent when a warning for Sol is meant to go out: (danger_level, vampire_warning_message, vassal_warning_message)
#define COMSIG_SOL_WARNING_GIVEN "comsig_sol_warning_given"
///Called on a Bloodsucker's Lifetick.
#define COMSIG_BLOODSUCKER_ON_LIFETICK "comsig_bloodsucker_on_lifetick"

#define DANGER_LEVEL_FIRST_WARNING 1
#define DANGER_LEVEL_SECOND_WARNING 2
#define DANGER_LEVEL_THIRD_WARNING 3
#define DANGER_LEVEL_SOL_ROSE 4
#define DANGER_LEVEL_SOL_ENDED 5

/**
 * Clan defines
 *
 * This is stuff that is used solely by Clans for clan-related activity.
 */
///Drinks blood the normal Bloodsucker way.
#define BLOODSUCKER_DRINK_NORMAL "bloodsucker_drink_normal"
///Drinks blood but is snobby, refusing to drink from mindless
#define BLOODSUCKER_DRINK_SNOBBY "bloodsucker_drink_snobby"
///Drinks blood from disgusting creatures without Humanity consequences.
#define BLOODSUCKER_DRINK_INHUMANELY "bloodsucker_drink_imhumanely"

/**
 * Role defines
 */
#define ROLE_BLOODSUCKER "Bloodsucker"
#define ROLE_VAMPIRICACCIDENT "Vampiric Accident"
#define ROLE_BLOODSUCKERBREAKOUT "Bloodsucker Breakout"
#define ROLE_MONSTERHUNTER "Monster Hunter"
#define ROLE_INFILTRATOR "Infiltrator"

/**
 * Miscellaneous defines
 *
 * (Defines for things too trivial to warrant their own category so we'll just call them "misc".)
 */
/// The attack bonus added to the punch damage of the Brujah clan's favorite vassals.
#define BRUJAH_FAVORITE_VASSAL_ATTACK_BONUS 4
