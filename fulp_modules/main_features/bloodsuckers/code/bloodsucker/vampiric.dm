/datum/language/vampiric
	name = "Blah-Sucker"
	desc = "The native language of the Bloodsucker elders, learned intuitively by Fledglings as they pass from death into immortality."
	key = "b"
	space_chance = 40
	default_priority = 90

	flags = TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	syllables = list(
		"luk","cha","no","kra","pru","chi","busi","tam","pol","spu","och",
		"umf","ora","stu","si","ri","li","ka","red","ani","lup","ala","pro",
		"to","siz","nu","pra","ga","ump","ort","a","ya","yach","tu","lit",
		"wa","mabo","mati","anta","tat","tana","prol",
		"tsa","si","tra","te","ele","fa","inz",
		"nza","est","sti","ra","pral","tsu","ago","esch","chi","kys","praz",
		"froz","etz","tzil",
		"t'","k'","t'","k'","th'","tz'"
		)

	icon_state = "bloodsucker"
	icon = 'fulp_modules/main_features/bloodsuckers/icons/vampiric.dmi'

/// You can only speak vampiric, but understand common too.
/datum/language_holder/vampiric_mob
	understood_languages = list(
	/datum/language/vampiric = list(LANGUAGE_ATOM),
	/datum/language/common = list(LANGUAGE_ATOM))
	spoken_languages = list(/datum/language/vampiric = list(LANGUAGE_ATOM))
