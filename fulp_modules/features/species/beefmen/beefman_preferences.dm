// Color
/datum/preference/choiced/beefman_color
	savefile_key = "feature_beef_color"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Beefman color"
	should_generate_icons = TRUE

/datum/preference/choiced/beefman_color/init_possible_values()
	return assoc_to_keys(GLOB.color_list_beefman)

/datum/preference/choiced/beefman_color/icon_for(value)
	var/icon/beefman_base = icon('fulp_modules/icons/species/mob/beefman_bodyparts.dmi', "beefman_head")
	beefman_base.Blend(icon('fulp_modules/icons/species/mob/beefman_bodyparts.dmi', "beefman_chest"), ICON_OVERLAY)
	beefman_base.Blend(icon('fulp_modules/icons/species/mob/beefman_bodyparts.dmi', "beefman_l_arm"), ICON_OVERLAY)
	beefman_base.Blend(icon('fulp_modules/icons/species/mob/beefman_bodyparts.dmi', "beefman_r_arm"), ICON_OVERLAY)

	var/icon/eyes = icon('icons/mob/human/human_face.dmi', "eyes")
	eyes.Blend(COLOR_BLACK, ICON_MULTIPLY)
	beefman_base.Blend(eyes, ICON_OVERLAY)

	beefman_base.Scale(64, 64)
	beefman_base.Crop(15, 64, 15 + 31, 64 - 31)
	var/color = GLOB.color_list_beefman[value]

	var/icon/icon = new(beefman_base)
	icon.Blend("[color]", ICON_MULTIPLY)

	return icon

/datum/preference/choiced/beefman_color/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["beef_color"] = GLOB.color_list_beefman[value]

// Eyes
/datum/preference/choiced/beefman_eyes
	savefile_key = "feature_beef_eyes"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Beefman Eyes"
	should_generate_icons = TRUE
	relevant_body_markings = /datum/bodypart_overlay/simple/body_marking/beefman_eyes

/datum/preference/choiced/beefman_eyes/init_possible_values()
	return assoc_to_keys(SSaccessories.eyes_beefman_list)

/datum/preference/choiced/beefman_eyes/icon_for(value)
	var/icon/beef_head = icon('fulp_modules/icons/species/mob/beefman_bodyparts.dmi', "beefman_head")
	beef_head.Blend("#d93356", ICON_MULTIPLY) // Make it red at least

	var/datum/sprite_accessory/eyes = SSaccessories.eyes_beefman_list[value]

	var/icon/icon_with_eye = new(beef_head)
	icon_with_eye.Blend(icon('fulp_modules/icons/species/mob/beefman_bodyparts.dmi', "m_beef_eyes_[eyes.icon_state]_ADJ"), ICON_OVERLAY)
	icon_with_eye.Scale(64, 64)
	icon_with_eye.Crop(15, 64, 15 + 31, 64 - 31)

	return icon_with_eye

/datum/preference/choiced/beefman_eyes/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["beef_eyes"] = value

// Mouth
/datum/preference/choiced/beefman_mouth
	savefile_key = "feature_beef_mouth"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Beefman Mouth"
	should_generate_icons = TRUE
	relevant_body_markings = /datum/bodypart_overlay/simple/body_marking/beefman_mouth

/datum/preference/choiced/beefman_mouth/init_possible_values()
	return assoc_to_keys(SSaccessories.mouths_beefman_list)

/datum/preference/choiced/beefman_mouth/icon_for(value)
	var/icon/beef_head = icon('fulp_modules/icons/species/mob/beefman_bodyparts.dmi', "beefman_head")
	beef_head.Blend("#d93356", ICON_MULTIPLY) // Make it red at least

	var/datum/sprite_accessory/mouths = SSaccessories.mouths_beefman_list[value]

	var/icon/icon_with_mouth = new(beef_head)
	icon_with_mouth.Blend(icon('fulp_modules/icons/species/mob/beefman_bodyparts.dmi', "m_beef_mouth_[mouths.icon_state]_ADJ"), ICON_OVERLAY)
	icon_with_mouth.Scale(64, 64)
	icon_with_mouth.Crop(15, 64, 15 + 31, 64 - 31)

	return icon_with_mouth

/datum/preference/choiced/beefman_mouth/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["beef_mouth"] = value
