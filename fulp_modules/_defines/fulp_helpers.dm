///Whether a mob is a Bloodsucker
#define IS_BLOODSUCKER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/bloodsucker))
///Whether a mob is a Vassal
#define IS_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal))
///Whether a mob is a Monster Hunter
#define IS_MONSTERHUNTER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/monsterhunter))

///Check if we are indeed a Beefman
#define isbeefman(A) (is_species(A, /datum/species/beefman))
