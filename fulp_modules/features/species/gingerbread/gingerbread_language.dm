/datum/language/gingeric
	name = "Gingeric"
	desc = "A smooth and springy language used by Gingerbread people."
	key = "r"
	space_chance = 35
	syllables = list(
		"glyco", "gluco", "glu", "lact", "ose", "ase", "tri", "glyceri", "de", "adeno", "sine", "phos", "phate", "fate", "sno", "fal",
        "fruct", "six", "di", "sacc", "ride", "e", "gal", "act", "malt", "arti", "ficial", "sweet", "faux", "neutr", "ition",
        "radio", "fluoro", "organo", "sugar", "pos", "itron", "emis", "sion", "topo", "logy", "activ", "lea", "d", "s",
	)
	icon = "fulp_modules/icons/species/gingerbread.dmi"
    icon_state - "gingeric" 
	default_priority = 90

	default_name_syllable_min = 4
	default_name_syllable_max = 7

/datum/language/gingeric/get_random_name(
	gender = NEUTER,
	name_count = default_name_count,
	syllable_min = default_name_syllable_min,
	syllable_max = default_name_syllable_max,
	force_use_syllables = FALSE,
)
	if(force_use_syllables)
		return ..()

	return "[pick(GLOB.gingerbread_prefix)][pick(GLOB.gingerbread_first)] [pick(GLOB.gingerbread_last)]"

/datum/language_holder/gingeric
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/gingeric = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/gingeric = list(LANGUAGE_ATOM),
	)
