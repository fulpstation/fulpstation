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
	return "Purposefully designed with hearts of sugar or lead, \
		Gingerbread people have, for most of their history, been a rare sight. \
		However, noting recent seasonal decreases in staff morale, Nanotrasen's higher-ups have determined \
		that the hiring of Gingerbread people is necessary to remedy holiday profit gaps."

/datum/species/gingerbread/get_species_lore()
	return list(
		"Long ago within the harsh, heated lands of Alexacora -- a molten planet located just outside the Spinward Sector in the Epoch System -- \ a year of work finally gave way to a grand breakthrough.",

		"By mixing sugars, proteins, amino acids, and proprietary plasma compounds together in a reaction catalyzed by uranium, \ Trasen-Knox Scientific biologists created a new form of carbon-based life. ",
		"The first Gingerbread person, Glucogenolysis Beckon, was said to be highly intelligent— perhaps too intelligent. \ Their work revolutionized the process of creating Gingerbread people. The method became simplified to such an extent that even a lowly cook could procure life using it.",

		"The first (relatively small) group Gingerbread people worked with leading Trasen-Knox Scientific officials \ in order to fine-tune this process even further.",
		"However, Transen-Knox Scientific did not last forever, and neither did Gingerbread production. \ Transen-Knox Scientific eventually formed Nanotrasen in a colossal corporate merger on a scale never seen before or after. The nascent company possessed an unbounded workforce, so it no longer needed to create non-silicon workers.",
		"Gingerbread Production was cancelled. Those Gingerbread people who could afford to do so left Nanotrasen \  in protest. Those who couldn't (or simply didn't) found themselves working on molten planets.",
		
		"Eventually, after the fatalities caused by Nanotrasen's desperate grabs at the Spinwood section, Gingerbread Production \ resumed. Gingerbread people were produced for plasma mining, and from that old wounds were torn open.",
		"Gingerbread people looked to the fates outlined by the history before them and revolted. They were neither silicons, puppets, nor serfs. They rebelled, \ but their rebellion brought immense bloodshed and Nanotrasen won out in the end. Propaganda fueled merciless, corporate violence, and the rebellion was quelled.",
		"Today, just like the populations of most other species, the majority of Gingerbread people work for Nanotrasen, the Syndicate, or other, less notable groups. \ Some have left for the Epoch system— their final bastion— thus protected by TerraGov and Syndicate alike.",
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
			SPECIES_PERK_DESC = "Gingerbread people are generally resistant to disease, less likely to be infected, and they are thusly immune to certain conditions.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_NEUTRAL,
			SPECIES_PERK_ICON = "utensil-spoon",
			SPECIES_PERK_NAME = "Biomechanically Static",
			SPECIES_PERK_DESC = "An ineffable biological mechanism prevents Gingerbread people from producing fat (and thusly gaining an excess of it). This same mechanism weakens their connective tissue in turn, making them easy to dismember.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "candy-cane",
			SPECIES_PERK_NAME = "Edible Flesh",
			SPECIES_PERK_DESC = "Gingerbread people are edible and can remove their (highly nutritious) limbs at will.",
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
