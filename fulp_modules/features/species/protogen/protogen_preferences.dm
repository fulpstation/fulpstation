//Tail
/datum/preference/choiced/protogen_tail
	savefile_key = "feature_protogen_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_external_organ = /obj/item/organ/external/tail/protogen

/datum/preference/choiced/protogen_tail/init_possible_values()
	return assoc_to_keys_features(SSaccessories.tails_list_protogen)

/datum/preference/choiced/protogen_tail/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["tail_protogen"] = value

/datum/preference/choiced/protogen_tail/create_default_value()
	var/datum/sprite_accessory/tails/protogen/synthliz/tail = /datum/sprite_accessory/tails/protogen/synthliz
	return initial(tail.name)

//Snout
/datum/preference/choiced/protogen_snout
	savefile_key = "feature_protogen_snout"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_external_organ = /obj/item/organ/external/snout/protogen

/datum/preference/choiced/protogen_snout/init_possible_values()
	return assoc_to_keys_features(SSaccessories.snouts_list_protogen)

/datum/preference/choiced/protogen_snout/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["snout_protogen"] = value


//Antennae
/datum/preference/choiced/protogen_antennae
	savefile_key = "feature_protogen_antennae"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_external_organ = /obj/item/organ/external/protogen_antennae

/datum/preference/choiced/protogen_antennae/init_possible_values()
	return assoc_to_keys_features(SSaccessories.antennae_list_protogen)

/datum/preference/choiced/protogen_antennae/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["antennae_protogen"] = value
