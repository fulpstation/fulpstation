/// Use in fish tables to denote miss chance.
#define FISHING_DUD "dud"

#define FISHING_BAIT_TRAIT "fishing_bait"
#define BASIC_QUALITY_BAIT_TRAIT "removes_felinids_pr"
#define GOOD_QUALITY_BAIT_TRAIT "adds_bitcoin_miner_pr"
#define GREAT_QUALITY_BAIT_TRAIT "perspective_walls_pr"

// Baseline fishing difficulty levels
#define FISHING_DEFAULT_DIFFICULTY 15

/// Difficulty modifier when bait is fish's favorite
#define FAV_BAIT_DIFFICULTY_MOD -5
/// Difficulty modifier when bait is fish's disliked
#define DISLIKED_BAIT_DIFFICULTY_MOD 15


#define FISH_TRAIT_MINOR_DIFFICULTY_BOOST 5

// These define how the fish will behave in the minigame
#define FISH_AI_DUMB "dumb"
#define FISH_AI_ZIPPY "zippy"
#define FISH_AI_SLOW "slow"

#define ADDITIVE_FISHING_MOD "additive"
#define MULTIPLICATIVE_FISHING_MOD "multiplicative"

// These defines are intended for use to interact with fishing hooks when going
// through the fishing rod, and not the hook itself. They could probably be
// handled differently, but for now that's how they work. It's grounds for
// a future refactor, however.
/// Fishing hook trait that signifies that it's shiny. Useful for fishes
/// that care about shiner hooks more.
#define FISHING_HOOK_SHINY (1 << 0)
/// Fishing hook trait that's used to make the bait more weighted, for the
/// fishing minigame itself.
#define FISHING_HOOK_WEIGHTED (1 << 1)

#define FISHING_LINE_CLOAKED (1 << 0)
#define FISHING_LINE_REINFORCED (1 << 1)
#define FISHING_LINE_BOUNCY (1 << 2)

#define FISHING_SPOT_PRESET_BEACH "beach"
#define FISHING_SPOT_PRESET_LAVALAND_LAVA "lavaland lava"
#define FISHING_SPOT_PRESET_CHASM "chasm"

#define FISHING_MINIGAME_RULE_HEAVY_FISH "heavy"
#define FISHING_MINIGAME_RULE_WEIGHTED_BAIT "weighted"
#define FISHING_MINIGAME_RULE_LIMIT_LOSS "limit_loss"

/// The default additive value for fishing hook catch weight modifiers.
#define FISHING_DEFAULT_HOOK_BONUS_ADDITIVE 0
/// The default multiplicative value for fishing hook catch weight modifiers.
#define FISHING_DEFAULT_HOOK_BONUS_MULTIPLICATIVE 1
