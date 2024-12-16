datum/species/gingerbread
	name = "Gingerbread"
	plural_form = "Gingerbread"
	id = SPECIES_GINGERBREAD
	examine_limb_id = SPECIES_GINGERBREAD
	sexes = FALSE
	species_language_holder = /datum/language_holder/gingeric

	inherent_traits = list(
		TRAIT_EASYDISMEMBER,
		TRAIT_NO_UNDERWEAR,
		TRAIT_AGENDER,
		TRAIT_VIRUS_RESISTANCE,
		TRAIT_MUTANT_COLORS,
		TRAIT_FIXED_MUTANT_COLORS,
		TRAIT_XENO_IMMUNE,
		TRAIT_NOFAT,
		TRAIT_NO_PLASMA_TRANSFORM,
		TRAIT_RESISTHEAT,
		TRAIT_UNHUSKABLE,
	)

	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP
	
	coldmod = 1.6 //comparable to Lizards
	headmod = 0.75
	siemens_coeff = 0.8
	
	bodytemp_normal = T20C
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT + 130) //Around 190 Celsius, the maximum temperature you can cook gingerbread at normally.
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 40) //Around 0 celsius, a mild gust of wind can damage them.
	skinned_type = /obj/item/food/dough
	meat = /obj/item/food/donut
	
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/gingerbread,\
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/gingerbread,\
		BODY_ZONE_HEAD = /obj/item/bodypart/head/gingerbread,\
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/gingerbread,\
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/gingerbread,\
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/gingerbread,\
	)

	//Still need to add gingerbread death sounds, for now it should use default human which is fine.

	var/static/list/tearable_limbs = list(
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
	)

/mob/living/carbon/human/species/gingerbread
	race = /datum/species/gingerbread

/datum/species/gingerbread/get_physical_attributes()
	return "Artificial humanoids primarily consisting of dough and gingerbread. They tolerate heat immensely well, but in turn they find even the more mild lows lethal. Physically their durability suffers from their lack of a proper skeletal system, which makes them all the more vulnerable to blunt force attacks."

/datum/species/gingerbread/get_species_description()
	return "Specially designed with hearts of either sugar or lead, \
		Gingerbread people were, for most of their history, a rare sight.\
		However, with increased Nanotrasen staff mortality and decreased morale \
		Gingerbread people were made to fill that gap."

/datum/species/gingerbread/get_species_lore()
	return list(
		"Deep in the harsh, heated lands of Alexacora, a molten planet located just outside the Spinward Sector within the Epoch System, \ a year of work had finally given way to a grand breakthrough.",

		"By mixing a collection of sugars, proteins and amino acids and at the time newly discovered plasma together in a reaction catalyzed by uranium, \ a collection of Transen-Knox Scientific biologists had created life. Organic life. ",
		"The first Gingerbread person, Glucogenolysis Beckon was said to be highly intelligent, to some-- too intelligent. \ Their work on revolutionizing the process was rapid, and allowed for life to be made so simply, even a lowly cook could make it.",

		"The, at the time small, group of Gingerbread people worked with high up officials of Transen-Knox Scientific \ in order to fine-tune this process further.",
		"However, Transen-Knox Scientific would not last forever, and nor would Gingerbread production. \ Transen-Knox Scientific would form Nanotrasen in a merger to end all mergers, and with such, there was no longer a need for artificial life.",
		"By the end of it all, Gingerbread Production, was cancelled. Those who could left Nanotrasen, \ abandoning their posts in protest, while those who didn't found themselves working on inferno planets.",
		
		"However, after the spike of mortalities in the desperate attempts to grab the Spinwood section, Gingerbread Production \ began again. Gingerbread people were produced for plasma. And from that, old wounds were torn open.",
		"Gingerbread people saw their fates and revolted, they were not silicons, not puppets or serfs. They rebelled. \ But rebellion brought bloodshed and Nanotrasen won out. Propaganda campaigns gave way to violence and the rebellion was quelled.",
		"Now, Gingerbread people either work for Nanotrasen, work for The Syndicate or other enemy groups, \ or leave for the Epoch system, the final bastion, protected by TerraGov and the Syndicate.",
		)

/datum/species/gingerbread/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "thermometer-full",
			SPECIES_PERK_NAME = "Heat-Resistant",
			SPECIES_PERK_DESC = "Gingerbread people can withstand very high temperatures.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "virus-slash",
			SPECIES_PERK_NAME = "Pestilence Resistance",
			SPECIES_PERK_DESC = "Gingerbread people are more resistant to disease, less likely to be infected and cannot be affected by certain conditions.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_NEUTRAL,
			SPECIES_PERK_ICON = "utensil-spoon",
			SPECIES_PERK_NAME = "Biomechanically Static",
			SPECIES_PERK_DESC = "Gingerbread people cannot become fat, however, due to a lack of fat, they are easy to dismember.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "candy-cane",
			SPECIES_PERK_NAME = "Edible Flesh",
			SPECIES_PERK_DESC = "Gingerbread can be eaten and can willingly remove limbs which have high amounts of nutrition.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "bone",
			SPECIES_PERK_NAME = "Fragile",
			SPECIES_PERK_DESC = "Gingerbread people are weak to brute damage.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "file-medical-alt",
			SPECIES_PERK_NAME = "Sensitive",
			SPECIES_PERK_DESC = "Gingerbread people's bodies can be easily destroyed by consumption and destroying the brain is easy. \
				For this reason, protect your skull because medical may not be able to put you back together again."
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "thermometer-empty",
			SPECIES_PERK_NAME = "Cold Sensitive",
			SPECIES_PERK_DESC = "Gingerbread people can quickly die to the cold.",
		),
	)

	return to_add
