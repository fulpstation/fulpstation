/datum/preference/choiced/tail_felinid
	savefile_key = "feature_human_tail" //savefile keys cannot be changed, blame whoever named them this way.
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	can_randomize = FALSE
	relevant_external_organ = /obj/item/organ/external/tail/cat

/datum/preference/choiced/tail_felinid/init_possible_values()
	return assoc_to_keys_features(SSaccessories.tails_list_felinid)

/datum/preference/choiced/tail_felinid/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["tail_cat"] = value

/datum/preference/choiced/tail_felinid/create_default_value()
	var/datum/sprite_accessory/tails/felinid/cat/tail = /datum/sprite_accessory/tails/felinid/cat
	return initial(tail.name)

/datum/preference/choiced/felinid_ears
	savefile_key = "feature_human_ears" //savefile keys cannot be changed, blame whoever named them this way.
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	can_randomize = FALSE
	relevant_external_organ = /obj/item/organ/internal/ears/cat

/datum/preference/choiced/felinid_ears/init_possible_values()
	return assoc_to_keys_features(SSaccessories.ears_list)

/datum/preference/choiced/felinid_ears/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["ears"] = value

/datum/preference/choiced/felinid_ears/create_default_value()
	return /datum/sprite_accessory/ears/cat::name
