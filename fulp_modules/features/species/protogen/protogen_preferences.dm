//Tail
/datum/preference/choiced/species_feature/protogen_tail
	savefile_key = "feature_protogen_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_organ = /obj/item/organ/tail/protogen

//Snout
/datum/preference/choiced/species_feature/protogen_snout
	savefile_key = "feature_protogen_snout"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Protogen Snout"
	relevant_organ = /obj/item/organ/snout/protogen
	should_generate_icons = TRUE

/datum/preference/choiced/species_feature/protogen_snout/icon_for(value)
	return generate_lizard_side_shot(get_accessory_for_value(value), "snout_protogen", include_snout = FALSE)

//Antennae
/datum/preference/choiced/species_feature/protogen_antennae
	savefile_key = "feature_protogen_antennae"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Protogen Antennae"
	relevant_organ = /obj/item/organ/protogen_antennae
	should_generate_icons = TRUE

/datum/preference/choiced/species_feature/protogen_antennae/icon_for(value)
	var/static/datum/universal_icon/proto_head

	if (isnull(proto_head))
		proto_head = uni_icon('fulp_modules/icons/species/mob/protogen_bodyparts.dmi', "protogen_head")
		proto_head.blend_icon(uni_icon(/obj/item/organ/eyes/robotic::eye_icon, "[/obj/item/organ/eyes/robotic::eye_icon_state]_l"), ICON_OVERLAY)
		proto_head.blend_icon(uni_icon(/obj/item/organ/eyes/robotic::eye_icon, "[/obj/item/organ/eyes/robotic::eye_icon_state]_r"), ICON_OVERLAY)

	var/datum/sprite_accessory/antennae = get_accessory_for_value(value)

	var/datum/universal_icon/icon_with_antennae = proto_head.copy()
	if(antennae.icon_state != "None")
		icon_with_antennae.blend_icon(uni_icon(antennae.icon, "m_antennae_protogen_[antennae.icon_state]_ADJ"), ICON_OVERLAY)
	icon_with_antennae.scale(64, 64)
	icon_with_antennae.crop(15, 64 - 31, 15 + 31, 64)

	return icon_with_antennae
