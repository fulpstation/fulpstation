/datum/preference/choiced/beefman_color
	savefile_key = "feature_beefcolor"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Beefman color"
	should_generate_icons = TRUE

/datum/preference/choiced/beefman_color/init_possible_values()
	var/list/values = list()

	var/icon/beefman_base = icon('fulp_modules/main_features/beefmen/icons/mob/beefman_bodyparts.dmi', "beefman_head")
	beefman_base.Blend(icon('fulp_modules/main_features/beefmen/icons/mob/beefman_bodyparts.dmi', "beefman_chest"), ICON_OVERLAY)
	beefman_base.Blend(icon('fulp_modules/main_features/beefmen/icons/mob/beefman_bodyparts.dmi', "beefman_l_arm"), ICON_OVERLAY)
	beefman_base.Blend(icon('fulp_modules/main_features/beefmen/icons/mob/beefman_bodyparts.dmi', "beefman_r_arm"), ICON_OVERLAY)

	var/icon/eyes = icon('icons/mob/human_face.dmi', "eyes")
	eyes.Blend(COLOR_BLACK, ICON_MULTIPLY)
	beefman_base.Blend(eyes, ICON_OVERLAY)

	beefman_base.Scale(64, 64)
	beefman_base.Crop(15, 64, 15 + 31, 64 - 31)

	for(var/name in GLOB.color_list_beefman)
		var/color = GLOB.color_list_beefman[name]

		var/icon/icon = new(beefman_base)
		icon.Blend("#[color]", ICON_MULTIPLY)
		values[name] = icon

	return values

/datum/preference/choiced/beefman_color/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["beefcolor"] = GLOB.color_list_beefman[value]

/*
/datum/preference/choiced/lizard_frills
	savefile_key = "feature_lizard_frills"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Frills"
	should_generate_icons = TRUE

/datum/preference/choiced/lizard_frills/init_possible_values()
	return generate_lizard_side_shots(GLOB.frills_list, "frills")

/datum/preference/choiced/lizard_frills/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["frills"] = value


	READ_FILE(S["feature_beefeyes"], features["beefeyes"])
	READ_FILE(S["feature_beefmouth"], features["beefmouth"])
*/
