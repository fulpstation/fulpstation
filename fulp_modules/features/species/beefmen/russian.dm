/datum/language/russian
	name = "Space Russian"
	desc = "An archaic terrestrial language still spoken in Space Russia."
	key = "2"
	sentence_chance = 5
	space_chance = 50
	syllables = list(
		"bly", "bor", "cy", "da", "ko", "et", "sa", "gop", "grad", "kov",
		"ski", "vok", "nik", "cyka", "ka", "kor", "yov", "suk", "grad",
		"kov", "blyat", "vod", "ka",
	)
	icon = 'fulp_modules/features/species/icons/russian_language.dmi'
	icon_state = "commie"
	default_priority = 90
	flags = TONGUELESS_SPEECH

/datum/language_holder/russian
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/russian = list(LANGUAGE_ATOM))
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/russian = list(LANGUAGE_ATOM))

/obj/item/organ/tongue/beefman
	name = "meaty tongue"
	desc = "A meaty and thick muscle typically found in Beefmen."
	icon = 'fulp_modules/features/species/icons/mob/beef_tongue.dmi'
	icon_state = "beef_tongue"
	say_mod = "gurgles"
	taste_sensitivity = 15
	modifies_speech = TRUE
	languages_native = list(/datum/language/russian)
	var/static/list/languages_possible_meat = typecacheof(list(
		/datum/language/common,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/piratespeak,
		/datum/language/moffic,
		/datum/language/sylvan,
		/datum/language/shadowtongue,
		/datum/language/terrum,
		/datum/language/nekomimetic,
		/datum/language/russian,
		/datum/language/buzzwords,
	))

/obj/item/organ/tongue/beefman/Initialize(mapload)
    . = ..()
    languages_possible = languages_possible_meat
