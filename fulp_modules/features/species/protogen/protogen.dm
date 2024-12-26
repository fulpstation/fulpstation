/datum/species/protogen
	name = "Protogen"
	plural_form = "Protofriends"
	id = SPECIES_PROTOGEN
	examine_limb_id = SPECIES_PROTOGEN
	mutant_organs = list(
		/obj/item/organ/snout/protogen = "Bolted",
		/obj/item/organ/tail/protogen = "Shark",
		/obj/item/organ/protogen_antennae = "Default",
	)
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_TACKLING_TAILED_DEFENDER,
	)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	meat = /obj/item/food/meat/slab/human/mutant/lizard
	mutantbrain = /obj/item/organ/brain/cybernetic
	mutanttongue = /obj/item/organ/tongue/robot
	mutantstomach = /obj/item/organ/stomach/cybernetic/surplus
	mutantappendix = null
	mutantheart = /obj/item/organ/heart/cybernetic/surplus
	mutantliver = /obj/item/organ/liver/cybernetic/surplus
	mutantlungs = /obj/item/organ/lungs/cybernetic/surplus
	mutanteyes = /obj/item/organ/eyes/robotic
	mutantears = /obj/item/organ/ears/cybernetic
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
	death_sound = 'sound/mobs/non-humanoids/cyborg/borg_deathsound.ogg'

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
