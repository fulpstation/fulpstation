/// Default Deputy
/datum/outfit/job/deputy
	jobtype = /datum/job/fulp/deputy

	id_trim = /datum/id_trim/job/deputy
	uniform = /obj/item/clothing/under/rank/security/officer/mallcop
	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/headset_sec/alt
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/assembly/flash/handheld
	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec

	box = /obj/item/storage/box/survival
	implants = list(/obj/item/implant/mindshield)

/// Engineering Deputy
/datum/outfit/job/deputy/engineering
	name = "Deputy - Engineering"

	id_trim = /datum/id_trim/job/deputy/engineering
	backpack_contents = list(
		/obj/item/grenade/smokebomb=1,
		/obj/item/melee/baton/loaded=1,
		/obj/item/reagent_containers/spray/pepper=1,
		/obj/item/restraints/handcuffs=1,
		/obj/item/holosign_creator/security=1,
		)
	head = /obj/item/clothing/head/fulpberet/engineering
	neck = /obj/item/clothing/neck/fulptie/engineering
	accessory = /obj/item/clothing/accessory/armband/engine
	box = null // This is to prevent getting double the boxes.
	skillchips = list(/obj/item/skillchip/job/deputy/engineering)

/// Medical Deputy
/datum/outfit/job/deputy/medical
	name = "Deputy - Medical"

	id_trim = /datum/id_trim/job/deputy/medical
	backpack_contents = list(
		/obj/item/grenade/smokebomb=1,
		/obj/item/melee/baton/loaded=1,
		/obj/item/reagent_containers/spray/pepper=1,
		/obj/item/restraints/handcuffs=1,
		/obj/item/holosign_creator/security=1,
		)
	head = /obj/item/clothing/head/fulpberet/medical
	neck = /obj/item/clothing/neck/fulptie/medical
	accessory = /obj/item/clothing/accessory/armband/medblue
	box = null
	skillchips = list(/obj/item/skillchip/job/deputy/medical)

/// Science Deputy
/datum/outfit/job/deputy/science
	name = "Deputy - Science"

	id_trim = /datum/id_trim/job/deputy/science
	backpack_contents = list(
		/obj/item/grenade/smokebomb=1,
		/obj/item/melee/baton/loaded=1,
		/obj/item/restraints/handcuffs=1,
		/obj/item/reagent_containers/hypospray/medipen/mutadone=1,
		/obj/item/reagent_containers/spray/pepper=1,
		/obj/item/holosign_creator/security=1,
		)
	neck = /obj/item/clothing/neck/fulptie/science
	head = /obj/item/clothing/head/fulpberet/science
	accessory = /obj/item/clothing/accessory/armband/science
	box = null
	skillchips = list(/obj/item/skillchip/job/deputy/science)

/// Supply Deputy
/datum/outfit/job/deputy/supply
	name = "Deputy - Supply"

	id_trim = /datum/id_trim/job/deputy/supply
	backpack_contents = list(
		/obj/item/grenade/smokebomb=1,
		/obj/item/melee/baton/loaded=1,
		/obj/item/reagent_containers/spray/pepper=1,
		/obj/item/restraints/handcuffs=1,
		/obj/item/holosign_creator/security=1,
		)
	head = /obj/item/clothing/head/fulpberet
	neck = /obj/item/clothing/neck/fulptie/supply
	accessory = /obj/item/clothing/accessory/armband/cargo
	box = null
	skillchips = list(/obj/item/skillchip/job/deputy/supply)

/// Plasmamen Datum
/datum/outfit/plasmaman/deputy
	name = "Deputy Plasmaman"

	head = /obj/item/clothing/head/helmet/space/plasmaman/security/deputy
	uniform = /obj/item/clothing/under/plasmaman/security/deputy
	gloves = /obj/item/clothing/gloves/color/plasmaman/white

/// Beefmen Datum
/datum/outfit/job/deputy/beefman
	uniform = /obj/item/clothing/under/bodysash/deputy

/// Shirt
/obj/item/clothing/under/rank/security/officer/mallcop
	name = "deputy shirt"
	desc = "An awe-inspiring tactical shirt-and-pants combo; because safety never takes a holiday."
	icon_state = "mallcop"
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/deputy_clothes.dmi'
	worn_icon = 'fulp_modules/jobs/deputy/deputy_clothing/under_worn.dmi'

/obj/item/clothing/under/rank/security/officer/mallcop/skirt
	name = "deputy skirt"
	desc = "An awe-inspiring tactical shirt-and-skirt combo; because safety never takes a holiday."
	icon_state = "mallcop_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	fitted = FEMALE_UNIFORM_TOP

/// Ties
/obj/item/clothing/neck/fulptie
	name = "departmental tie"
	desc = "A tie showing off the department colors of a deputy."
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/ties_icons.dmi'
	worn_icon =  'fulp_modules/jobs/deputy/deputy_clothing/ties_worn.dmi'
	icon_state = "supply_tie"
	inhand_icon_state = ""	//no inhands
	w_class = WEIGHT_CLASS_SMALL
	custom_price = PAYCHECK_EASY
	var/department

/obj/item/clothing/neck/fulptie/Initialize()
	. = ..()
	if(department)
		name = "[department] tie"
		desc = "A tie showing off that the user belongs to the [department] department."
		icon_state = "[department]_tie"

/obj/item/clothing/neck/fulptie/engineering
	department = "engineering"

/obj/item/clothing/neck/fulptie/medical
	department = "medical"

/obj/item/clothing/neck/fulptie/science
	department = "science"

/obj/item/clothing/neck/fulptie/supply
	department = "supply"

/// Plasmamen clothes
/obj/item/clothing/under/plasmaman/security/deputy
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/deputy_clothes.dmi'
	worn_icon = 'fulp_modules/jobs/deputy/deputy_clothing/under_worn.dmi'
	name = "deputy plasma envirosuit"
	desc = "A plasmaman containment suit designed for deputies, offering a limited amount of extra protection."
	icon_state = "deputy_envirosuit"
	inhand_icon_state = "deputy_envirosuit"

/obj/item/clothing/head/helmet/space/plasmaman/security/deputy
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_icons.dmi'
	worn_icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_worn.dmi'
	name = "deputy envirosuit helmet"
	desc = "A plasmaman containment helmet designed for deputies, protecting them from being flashed and burning alive, alongside other undesirables."
	icon_state = "deputy_envirohelm"
	inhand_icon_state = "deputy_envirohelm"

/// Berets
/obj/item/clothing/head/fulpberet
	worn_icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_worn.dmi'
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_icons.dmi'
	armor = list(MELEE = 20, BULLET = 60, LASER = 10, ENERGY = 10, BOMB = 30, BIO = 10, RAD = 0, FIRE = 50, ACID = 60, WOUND = 5) /// Bulletproof helmet level
	name = "supply deputy beret"
	desc = "The headwear for only the most eagle-eyed Deputy, able to watch both Cargo and Mining. It looks like it's been reinforced due to 'Cargonian' problems."
	icon_state = "beret_supply"
	resistance_flags = ACID_PROOF | FIRE_PROOF

/obj/item/clothing/head/fulpberet/engineering
	armor = list(MELEE = 30, BULLET = 30, LASER = 25, ENERGY = 20, BOMB = 40, BIO = 100, RAD = 100, FIRE = 100, ACID = 90, WOUND = 5) /// CE level
	name = "engineering deputy beret"
	desc = "Perhaps the only thing standing between the supermatter and a station-wide explosive sabotage. Comes with radiation protection."
	icon_state = "beret_engi"
	flags_1 = RAD_PROTECT_CONTENTS_1

/obj/item/clothing/head/fulpberet/medical
	armor = list(MELEE = 30, BULLET = 30, LASER = 25, ENERGY = 20, BOMB = 10, BIO = 100, RAD = 60, FIRE = 60, ACID = 75, WOUND = 5) /// CMO level
	name = "medical deputy beret"
	desc = "This proud white-blue beret is a welcome sight when the greytide descends on chemistry, or just used as a bio hood."
	icon_state = "beret_medbay"

/obj/item/clothing/head/fulpberet/science
	armor = list(MELEE = 30, BULLET = 30, LASER = 25, ENERGY = 20, BOMB = 100, BIO = 100, RAD = 60, FIRE = 60, ACID = 80, WOUND = 5) /// RD level
	name = "science deputy beret"
	desc = "This loud purple beret screams 'Dont mess with his matter manipulator!'. Fairly bomb resistant."
	icon_state = "beret_science"

/// Base Skillchip
/obj/item/skillchip/job/deputy
	name = "D3PU7Y skillchip"
	desc = "You think they learn this stuff naturally?"
	skill_icon = "sitemap"
	var/deputy
	var/department
	var/datum/martial_art/deputyblock/style

/obj/item/skillchip/job/deputy/Initialize()
	. = ..()
	if(deputy)
		name = "[deputy]-D3PU7Y skillchip"
	if(department)
		skill_name = "[department] deputy"
		skill_description = "Recognizes [department] as their home, making them feel happy in it, and tends to be harsher on criminals with their grabs."
		activate_message = "<span class='notice'>You suddenly feel safe in [department].</span>"
		deactivate_message = "<span class='notice'>[department] no longer feels safe.</span>"
	style = new

/obj/item/skillchip/job/deputy/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	style.teach(user, TRUE)

/obj/item/skillchip/job/deputy/on_deactivate(mob/living/carbon/user, silent = FALSE)
	style.remove(user)
	return ..()

/// Engineering Skillchip
/obj/item/skillchip/job/deputy/engineering
	deputy = "3NG1N3ER1N9"
	department = "Engineering" /// Deputies aren't trained to use guns.
	auto_traits = list(TRAIT_ENGINEERINGDEPUTY, TRAIT_NOGUNS, TRAIT_SUPERMATTER_MADNESS_IMMUNE) /// Engineering deputies on their way to arrest the SM

/area/engineering
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_ENGINEERINGDEPUTY

/// Medical Skillchip
/obj/item/skillchip/job/deputy/medical
	deputy = "M3D1C4L"
	department = "Medbay"
	auto_traits = list(TRAIT_MEDICALDEPUTY, TRAIT_NOGUNS, TRAIT_QUICK_CARRY) /// Medical deputies on their way to arrest dead bodies?

/area/medical
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_MEDICALDEPUTY

/// Science Skillchip
/obj/item/skillchip/job/deputy/science
	deputy = "5C1ENC3"
	department = "Science"
	auto_traits = list(TRAIT_SCIENCEDEPUTY, TRAIT_NOGUNS)

/area/science
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_SCIENCEDEPUTY

/// Supply Skillchip
/obj/item/skillchip/job/deputy/supply
	deputy = "5UPP1Y"
	department = "Cargo"
	auto_traits = list(TRAIT_SUPPLYDEPUTY, TRAIT_NOGUNS)

/area/cargo
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_SUPPLYDEPUTY

/// Mood buff from being within your department.
/datum/mood_event/deputy_helpful
	description = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_change = 5

