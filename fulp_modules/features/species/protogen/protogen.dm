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
	features["tail_protogen"] = pick(GLOB.tails_list_protogen)
	features["snout_protogen"] = pick(GLOB.snouts_list_protogen)
	features["antennae_protogen"] = pick(GLOB.antennae_list_protogen)
	return features

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
	return "Suited with a visor and a full set of robotic organs, these critters are useful for most, if not all station jobs and can adapt to different workplaces efficiently. \
	That said, an EMP will devastate them if they come into contact with one."

/datum/species/protogen/get_species_description()
	return "The protogen are a cybernetically-augmented species meant for long space ventures,  \
		hired by Nanotrasen in a collaborative effort due to their workplace efficiency and \
		their main directive of obtaining knowledge through intergalactic exploration."

/datum/species/protogen/get_species_lore()
	return list(
		"Not much is known about this species, due to their very recent arrival on Nanotrasen vessels.",

		"Crewmembers have reported that these new coworkers have been very helpful and \"eager to assist\". \
		Their presence has alerted the remarks from technophobes, and although they raise some valid concerns due to the mysterious aura surrounding \
		the species and their origins, it is nonetheless a very debated topic if they should stay or not.",
	)
