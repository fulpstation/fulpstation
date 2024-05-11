/datum/species/cthonic
	name = "Cthonic"
	plural_form = "Cthonics"
	id = SPECIES_CTHONIC
	examine_limb_id = SPECIES_CTHONIC
	sexes = FALSE
	mutant_bodyparts = list(
		"legs" = "Normal Legs",
	)
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_MOVE_FLYING,
		TRAIT_NO_UNDERWEAR,
		TRAIT_AGENDER,
		TRAIT_FIXED_HAIRCOLOR,
		TRAIT_GENELESS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutantheart = /obj/item/organ/internal/heart/fly
	mutantlungs = /obj/item/organ/internal/lungs/fly
	mutantliver = /obj/item/organ/internal/liver/fly
	mutantstomach = /obj/item/organ/internal/stomach/fly
	mutantappendix = /obj/item/organ/internal/appendix/fly
	mutant_organs = list(/obj/item/organ/internal/fly, /obj/item/organ/internal/fly/groin)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	damage_modifier = -25 // 25% More damage

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/cthonic,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/cthonic,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/cthonic,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/cthonic,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/cthonic,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/cthonic,
	)
	death_sound = 'sound/voice/lizard/deathsound.ogg'


/mob/living/carbon/human/species/cthonic
	race = /datum/species/cthonic

/// Lore and shit

/datum/species/cthonic/get_physical_attributes()
	return "something about taking damage and flying?"

/datum/species/cthonic/get_species_description()
	return "The cthonic are a species  \
		that are pretty much just mind flayers \
		but keeping with the tradition of naming things stupidly"

/datum/species/cthonic/get_species_lore()
	return list(
		"these little bitches are alien fish people but really just mindflayers",

		"hell yeah time to write some lore I guess. \
		lore lore lore c'mon joyce you love writing lore",
	)
