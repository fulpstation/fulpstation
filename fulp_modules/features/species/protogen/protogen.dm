/datum/species/protogen
	name = "Protogen"
	plural_form = "Protofriends"
	id = SPECIES_PROTOGEN
	examine_limb_id = SPECIES_PROTOGEN
	mutant_bodyparts = list(
		"legs" = "Normal Legs",
	)
	external_organs = list(
		/obj/item/organ/external/snout/protogen = "Bolted",
		/obj/item/organ/external/tail/protogen = "Shark",
		/obj/item/organ/external/protogen_antennae = "Default",
	)
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_TACKLING_TAILED_DEFENDER,
	)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	meat = /obj/item/food/meat/slab/human/mutant/lizard
	mutantbrain = /obj/item/organ/internal/brain/cybernetic
	mutanttongue = /obj/item/organ/internal/tongue/robot
	mutantstomach = /obj/item/organ/internal/stomach/cybernetic/surplus
	mutantappendix = null
	mutantheart = /obj/item/organ/internal/heart/cybernetic/surplus
	mutantliver = /obj/item/organ/internal/liver/cybernetic/surplus
	mutantlungs = /obj/item/organ/internal/lungs/cybernetic/surplus
	mutanteyes = /obj/item/organ/internal/eyes/robotic
	mutantears = /obj/item/organ/internal/ears/cybernetic
	species_language_holder = /datum/language_holder/synthetic
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	damage_modifier = -25 // 25% More damage

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/protogen,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/protogen,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/robot/protogen,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/robot/protogen,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/protogen,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/protogen,
	)
	digitigrade_customization = DIGITIGRADE_OPTIONAL
	death_sound = 'sound/voice/borg_deathsound.ogg'

/datum/species/protogen/check_roundstart_eligible()
	if(check_holidays(APRIL_FOOLS))
		return TRUE
	return ..()

/datum/species/protogen/randomize_features()
	var/list/features = ..()
	features["tail_protogen"] = pick(SSaccessories.tails_list_protogen)
	features["snout_protogen"] = pick(SSaccessories.snouts_list_protogen)
	features["antennae_protogen"] = pick(SSaccessories.antennae_list_protogen)
	return features

/datum/species/protogen/handle_mutant_bodyparts(mob/living/carbon/human/source, forced_colour)
	..()
	var/list/bodyparts_to_add = mutant_bodyparts.Copy()
	var/list/relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	var/list/standing = list()

	source.remove_overlay(BODY_BEHIND_LAYER)
	source.remove_overlay(BODY_ADJ_LAYER)
	source.remove_overlay(BODY_FRONT_LAYER)

	if(!mutant_bodyparts || HAS_TRAIT(source, TRAIT_INVISIBLE_MAN))
		return

	var/obj/item/bodypart/head/noggin = source.get_bodypart(BODY_ZONE_HEAD)


	if(mutant_bodyparts["ears"])
		if(!source.dna.features["ears"] || source.dna.features["ears"] == "None" || source.head && (source.head.flags_inv & HIDEHAIR) || (source.wear_mask && (source.wear_mask.flags_inv & HIDEHAIR)) || !noggin || IS_ROBOTIC_LIMB(noggin))
			bodyparts_to_add -= "ears"

	if(!bodyparts_to_add)
		return

	var/g = (source.physique == FEMALE) ? "f" : "m"

	for(var/layer in relevent_layers)
		var/layertext = mutant_bodyparts_layertext(layer)

		for(var/bodypart in bodyparts_to_add)
			var/datum/sprite_accessory/accessory
			switch(bodypart)
				if("tail_protogen")
					accessory = SSaccessories.tails_list_protogen[source.dna.features["tail_protogen"]]
				if("snout_protogen")
					accessory = SSaccessories.snouts_list_protogen[source.dna.features["snout_protogen"]]
				if("antennae_protogen")
					accessory = SSaccessories.antennae_list_protogen[source.dna.features["antennae_protogen"]]

			if(!accessory || accessory.icon_state == "none")
				continue

			var/mutable_appearance/accessory_overlay = mutable_appearance(accessory.icon, layer = -layer)

			if(accessory.gender_specific)
				accessory_overlay.icon_state = "[g]_[bodypart]_[accessory.icon_state]_[layertext]"
			else
				accessory_overlay.icon_state = "m_[bodypart]_[accessory.icon_state]_[layertext]"

			if(accessory.em_block)
				accessory_overlay.overlays += emissive_blocker(accessory_overlay.icon, accessory_overlay.icon_state, source, accessory_overlay.alpha)

			if(accessory.center)
				accessory_overlay = center_image(accessory_overlay, accessory.dimension_x, accessory.dimension_y)

			if(!(HAS_TRAIT(source, TRAIT_HUSK)))
				if(!forced_colour)
					switch(accessory.color_src)
						if(MUTANT_COLOR)
							accessory_overlay.color = fixed_mut_color || source.dna.features["mcolor"]
						if(HAIR_COLOR)
							accessory_overlay.color = get_fixed_hair_color(source) || source.hair_color
						if(FACIAL_HAIR_COLOR)
							accessory_overlay.color = get_fixed_hair_color(source) || source.facial_hair_color
						if(EYE_COLOR)
							accessory_overlay.color = source.eye_color_left
				else
					accessory_overlay.color = forced_colour
			standing += accessory_overlay

			if(accessory.hasinner)
				var/mutable_appearance/inner_accessory_overlay = mutable_appearance(accessory.icon, layer = -layer)
				if(accessory.gender_specific)
					inner_accessory_overlay.icon_state = "[g]_[bodypart]inner_[accessory.icon_state]_[layertext]"
				else
					inner_accessory_overlay.icon_state = "m_[bodypart]inner_[accessory.icon_state]_[layertext]"

				if(accessory.center)
					inner_accessory_overlay = center_image(inner_accessory_overlay, accessory.dimension_x, accessory.dimension_y)

				standing += inner_accessory_overlay

		source.overlays_standing[layer] = standing.Copy()
		standing = list()

	source.apply_overlay(BODY_BEHIND_LAYER)
	source.apply_overlay(BODY_ADJ_LAYER)
	source.apply_overlay(BODY_FRONT_LAYER)

/datum/species/protogen/prepare_human_for_preview(mob/living/carbon/human/human)
	human.dna.features["mcolor"] = "#b7b4ab"
	human.dna.features["snout_protogen"] = "Bolted"
	human.dna.features["antennae_protogen"] = "Default"
	human.eye_color_left = "#ffffff"
	human.eye_color_right = "#ffffff"
	human.update_body(is_creating = TRUE)

/mob/living/carbon/human/species/protogen
	race = /datum/species/protogen

/// Lore and shit

/datum/species/protogen/get_physical_attributes()
	return "Suited with a visor and a full set of robotic organs, these critters are useful for most, if not all, station jobs and can adapt to different workplaces efficiently. \
	That said, an EMP will devastate them if they come into contact with one."

/datum/species/protogen/get_species_description()
	return "The protogen are a cybernetically-augmented species optimized for long space ventures.  \
		They were hired by Nanotrasen in a collaborative effort thanks to their workplace efficiency and \
		their innate motivation to obtain knowledge through intergalactic exploration."

/datum/species/protogen/get_species_lore()
	return list(
		"Not much is known about this species, due to their very recent arrival on Nanotrasen vessels.",

		"Crewmembers have reported that their new coworkers have been very helpful and \"eager to assist\". \
		Despite this, the protogens' presence has garnered harsh criticism regarding the mysterious aura surrounding \
		the species and their origins. Their employment continues to be a hotly debated topic on Nanotrasen stations.",
	)
