/datum/species/android/protogen
	name = "Protogen"
	plural_form = "Protogens"
	id = SPECIES_PROTOGEN
	say_mod = "beeps"
	species_traits = list(NOBLOOD, NO_DNA_COPY, NOTRANSSTING, NOEYESPRITES)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOMETABOLISM,
		TRAIT_RESISTHEAT,
		TRAIT_NOBREATH,
		TRAIT_RADIMMUNE,
		TRAIT_GENELESS,
		TRAIT_PIERCEIMMUNE,
		TRAIT_NOHUNGER,
		TRAIT_LIMBATTACHMENT,
		TRAIT_NOCLONELOSS,
	)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	payday_modifier = 0.75
	meat = null
	damage_overlay_type = "synth"
	species_language_holder = /datum/language_holder/synthetic
	limbs_id = "protogen"
	turn_limbs = FALSE
	use_skintones = FALSE
	sexes = FALSE
	brutemod = 1.25
	burnmod = 1.25

/datum/species/android/protogen/check_roundstart_eligible()
	return TRUE

/datum/species/android/protogen/get_species_description()
	return "Nanotrasen-built Protogens are the latest creation \
		Originally invented to perform small tasks, they can now \
		fully commit to entire jobs!"

/datum/species/android/protogen/get_species_lore()
	return list(
		"Robotic furries, there's not much else needed to know.",
	)

/datum/species/android/protogen/cargo
	name = "LOADER Protogen"
	id = "loader"
	limbs_id = "loader"

/datum/species/android/protogen/medical
	name = "CARE Protogen"
	id = "medical"
	limbs_id = "medical"

/datum/species/android/protogen/science
	name = "THINK Protogen"
	id = "science"
	limbs_id = "science"

/datum/species/android/protogen/security
	name = "HOUND Protogen"
	id = "security"
	limbs_id = "security"
