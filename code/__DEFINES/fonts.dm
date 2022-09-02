//FONTS: Used by Paper, PhotoCopier, PDA's Notekeeper, NewsCaster, NewsPaper, ModularComputers (and PaperBin once a year).
/// Font used by regular pens
#define PEN_FONT "Verdana"
/// Font used by fancy pens
#define FOUNTAIN_PEN_FONT "Segoe Script"
/// Font used by crayons
#define CRAYON_FONT "Comic Sans MS"
/// Font used by printers
#define PRINTER_FONT "Times New Roman"
/// Font used by charcoal pens
#define CHARCOAL_FONT "Candara"
/// Font used when signing on paper.
#define SIGNATURE_FONT "Segoe Script"

//pda fonts
#define MONO "Monospaced"
#define VT "VT323"
#define ORBITRON "Orbitron"
#define SHARE "Share Tech Mono"

GLOBAL_LIST_INIT(pda_styles, sort_list(list(MONO, VT, ORBITRON, SHARE)))

/// Emoji icon set
#define EMOJI_SET 'icons/ui_icons/emoji/emoji.dmi'
