//rune colors, for easy reference
#define RUNE_COLOR_TALISMAN "#0000FF"
#define RUNE_COLOR_TELEPORT "#551A8B"
#define RUNE_COLOR_OFFER "#FFFFFF"
#define RUNE_COLOR_DARKRED "#7D1717"
#define RUNE_COLOR_MEDIUMRED "#C80000"
#define RUNE_COLOR_BURNTORANGE "#CC5500"
#define RUNE_COLOR_RED "#FF0000"
#define RUNE_COLOR_EMP "#4D94FF"
#define RUNE_COLOR_SUMMON "#00FF00"

//blood magic
#define MAX_BLOODCHARGE 4
#define RUNELESS_MAX_BLOODCHARGE 1
/// percent before rise
#define CULT_RISEN 0.2
/// percent before ascend
#define CULT_ASCENDENT 0.4
#define BLOOD_HALBERD_COST 150
#define BLOOD_BARRAGE_COST 300
#define BLOOD_BEAM_COST 500
#define IRON_TO_CONSTRUCT_SHELL_CONVERSION 50
//screen locations
#define DEFAULT_BLOODSPELLS "6:-29,4:-2"
#define DEFAULT_BLOODTIP "14:6,14:27"
#define DEFAULT_TOOLTIP "6:-29,5:-2"
//misc
#define SOULS_TO_REVIVE 3
#define BLOODCULT_EYE "#FF0000"
//soulstone & construct themes
#define THEME_CULT "cult"
#define THEME_WIZARD "wizard"
#define THEME_HOLY "holy"

/// Defines for cult item_dispensers.
#define PREVIEW_IMAGE "preview"
#define OUTPUT_ITEMS "output"

/// The global Nar'sie that the cult's summoned
GLOBAL_DATUM(cult_narsie, /obj/narsie)

// Used in determining which cinematic to play when cult ends
#define CULT_VICTORY_MASS_CONVERSION 2
#define CULT_FAILURE_NARSIE_KILLED 1
#define CULT_VICTORY_NUKE 0
