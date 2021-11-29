/**
 * Role defines
 */
#define ROLE_BLOODSUCKER "Bloodsucker"
#define ROLE_VAMPIRICACCIDENT "Vampiric Accident"
#define ROLE_BLOODSUCKERBREAKOUT "Bloodsucker Breakout"
#define ROLE_MONSTERHUNTER "Monster Hunter"
#define IS_BLOODSUCKER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/bloodsucker))
#define IS_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal))
#define IS_MONSTERHUNTER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/monsterhunter))


/**
 * Traits
 */
/// Your heart doesn't beat
#define TRAIT_NOPULSE "nopulse"
/// Falsifies Health analyzer blood levels
#define TRAIT_MASQUERADE "masquerade"
/// Your body is literal room temperature. Does not make you immune to the temp
#define TRAIT_COLDBLOODED "coldblooded"


/**
 * Bloodsucker defines
 */
/// Determines Bloodsucker regeneration rate
#define BS_BLOOD_VOLUME_MAX_REGEN 700
/// Cost to torture someone, in blood
#define TORTURE_BLOOD_COST "15"
/// Cost to convert someone after successful torture, in blood
#define TORTURE_CONVERSION_COST "50"
/// Deals with constant processes off of LifeTick()
#define COMSIG_LIVING_BIOLOGICAL_LIFE "biological_life"
/// Once blood is this low, will enter Frenzy
#define FRENZY_THRESHOLD_ENTER 25
/// Once blood is this high, will exit Frenzy
#define FRENZY_THRESHOLD_EXIT 250
/// You have special interactions with Bloodsuckers
#define TRAIT_BLOODSUCKER_HUNTER "bloodsucker_hunter"


/**
 * Cooldown defines
 * Used in Cooldowns Bloodsuckers use to prevent spamming
 */
///Spam prevention for healing messages
#define BLOODSUCKER_SPAM_HEALING (15 SECONDS)
///Span prevention for Sol messages
#define BLOODSUCKER_SPAM_SOL (30 SECONDS)

/**
 * Source traits
 */
/// Source trait for Bloodsuckers-related traits
#define BLOODSUCKER_TRAIT "bloodsucker_trait"
/// Source trait during a Frenzy
#define FRENZY_TRAIT "frenzy_trait"


/**
 * Status effect defines
 */
#define STATUS_EFFECT_MASQUERADE /datum/status_effect/masquerade
#define STATUS_EFFECT_FRENZY /datum/status_effect/frenzy


/**
 * Clan defines
 */
#define CLAN_NONE "No Clan"
#define CLAN_BRUJAH "Brujah Clan"
#define CLAN_NOSFERATU "Nosferatu Clan"
#define CLAN_TREMERE "Tremere Clan"
#define CLAN_VENTRUE "Ventrue Clan"
#define CLAN_MALKAVIAN "Malkavian Clan"
// Flavortext-only clans
#define CLAN_TOREADOR "Toreador Clan"
#define CLAN_GANGREL "Gangrel Clan"

/**
 * Power defines
 */
/// This Power can't be used in Torpor
#define BP_CANT_USE_IN_TORPOR (1<<0)
/// This Power can't be used in Frenzy unless you're part of Brujah
#define BP_CANT_USE_IN_FRENZY (1<<1)
/// This Power can't be used with a stake in you
#define BP_CANT_USE_WHILE_STAKED (1<<2)
/// This Power can't be used while incapacitated
#define BP_CANT_USE_WHILE_INCAPACITATED (1<<3)
/// This Power can't be used while unconscious
#define BP_CANT_USE_WHILE_UNCONSCIOUS (1<<4)

/// This Power can be purchased by Bloodsuckers
#define BLOODSUCKER_CAN_BUY (1<<0)
/// This Power can be purchased by Vassals
#define VASSAL_CAN_BUY (1<<1)
/// This Power can be purchased by Monster Hunters
#define HUNTER_CAN_BUY (1<<2)

/// This Power is a Toggled Power
#define BP_AM_TOGGLE (1<<0)
/// This Power is a Single-Use Power
#define BP_AM_SINGLEUSE (1<<1)
/// This Power has a Static cooldown
#define BP_AM_STATIC_COOLDOWN (1<<2)
/// This Power doesn't cost bloot to run while unconscious
#define BP_AM_COSTLESS_UNCONSCIOUS (1<<3)

/**
 * Misc defines
 */
/// Whether we have succesfully hidden out blood level
#define BLOODSUCKER_HIDE_BLOOD "hide_blood_volume"
/// 1 tile down
#define ui_blood_display "WEST:6,CENTER-1:0"
/// 2 tiles down
#define ui_vamprank_display "WEST:6,CENTER-2:-5"
/// 6 pixels to the right, zero tiles & 5 pixels DOWN.
#define ui_sunlight_display "WEST:6,CENTER-0:0"
