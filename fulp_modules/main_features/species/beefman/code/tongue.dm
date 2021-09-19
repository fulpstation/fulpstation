/obj/item/organ/tongue/beef
	name = "beef tongue"
	desc = "A disgusting slob of meat mashed together to form a tongue."
	icon = 'fulp_modules/main_features/species/beefman/icons/mob/beef_tongue.dmi'
	icon_state = "beef_tongue"
	say_mod = "gurgles"
	var/static/list/languages_possible_beef = typecacheof(list(
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
		/datum/language/russian
	))

/obj/item/organ/tongue/beef/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_beef
