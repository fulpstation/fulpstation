///Whether a mob is a Bloodsucker
#define IS_BLOODSUCKER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/bloodsucker))
///Whether a mob is a Vassal
#define IS_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal))

///Check if we are indeed a Beefman
#define isbeefman(A) (is_species(A, /datum/species/beefman))
