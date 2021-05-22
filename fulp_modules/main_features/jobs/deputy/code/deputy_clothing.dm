/// Default Deputy
/datum/outfit/job/deputy
	jobtype = /datum/job/fulp/deputy

	id_trim = /datum/id_trim/job/deputy
	uniform = /obj/item/clothing/under/rank/security/officer/mallcop
	belt = /obj/item/pda/security
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
	ears = /obj/item/radio/headset/headset_dep
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
	ears = /obj/item/radio/headset/headset_dep/med
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
		/obj/item/reagent_containers/hypospray/medipen/mutadone=2,
		/obj/item/reagent_containers/spray/pepper=1,
		/obj/item/holosign_creator/security=1,
		)
	neck = /obj/item/clothing/neck/fulptie/science
	ears = /obj/item/radio/headset/headset_dep/sci
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
		/obj/item/export_scanner=1,
		)
	head = /obj/item/clothing/head/fulpberet
	ears = /obj/item/radio/headset/headset_dep/supply
	neck = /obj/item/clothing/neck/fulptie/supply
	accessory = /obj/item/clothing/accessory/armband/cargo
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	box = null
	skillchips = list(/obj/item/skillchip/job/deputy/supply)

/// Service Deputy
/datum/outfit/job/deputy/service
	name = "Deputy - Service"

	id_trim = /datum/id_trim/job/deputy/service
	backpack_contents = list(
		/obj/item/grenade/smokebomb=1,
		/obj/item/melee/baton/loaded=1,
		/obj/item/reagent_containers/spray/pepper=1,
		/obj/item/restraints/handcuffs=1,
		/obj/item/holosign_creator/security=1,
		)
	head = /obj/item/clothing/head/fulpberet/service
	ears = /obj/item/radio/headset/headset_dep/service
	neck = /obj/item/clothing/neck/fulptie/service
	accessory = /obj/item/clothing/accessory/armband/hydro
	box = null
	skillchips = list(/obj/item/skillchip/job/deputy/service)

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
	icon = 'fulp_modules/main_features/jobs/deputy/deputy_clothing/deputy_clothes.dmi'
	worn_icon = 'fulp_modules/main_features/jobs/deputy/deputy_clothing/under_worn.dmi'

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
	icon = 'fulp_modules/main_features/jobs/deputy/deputy_clothing/ties_icons.dmi'
	worn_icon =  'fulp_modules/main_features/jobs/deputy/deputy_clothing/ties_worn.dmi'
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

/obj/item/clothing/neck/fulptie/service
	department = "service"

/// Plasmamen clothes
/obj/item/clothing/under/plasmaman/security/deputy
	icon = 'fulp_modules/main_features/jobs/deputy/deputy_clothing/deputy_clothes.dmi'
	worn_icon = 'fulp_modules/main_features/jobs/deputy/deputy_clothing/under_worn.dmi'
	name = "deputy plasma envirosuit"
	desc = "A plasmaman containment suit designed for deputies, offering a limited amount of extra protection."
	icon_state = "deputy_envirosuit"
	inhand_icon_state = "deputy_envirosuit"

/obj/item/clothing/head/helmet/space/plasmaman/security/deputy
	icon = 'fulp_modules/main_features/jobs/deputy/deputy_clothing/head_icons.dmi'
	worn_icon = 'fulp_modules/main_features/jobs/deputy/deputy_clothing/head_worn.dmi'
	name = "deputy envirosuit helmet"
	desc = "A plasmaman containment helmet designed for deputies, protecting them from being flashed and burning alive, alongside other undesirables."
	icon_state = "deputy_envirohelm"
	inhand_icon_state = "deputy_envirohelm"

/// Berets - We're using Supply as the main one over Engineering, because I dont want them inheriting rad protection.
/obj/item/clothing/head/fulpberet
	worn_icon = 'fulp_modules/main_features/jobs/deputy/deputy_clothing/head_worn.dmi'
	icon = 'fulp_modules/main_features/jobs/deputy/deputy_clothing/head_icons.dmi'
	armor = list(MELEE = 20, BULLET = 60, LASER = 10, ENERGY = 10, BOMB = 30, BIO = 10, RAD = 0, FIRE = 50, ACID = 60, WOUND = 5) /// Bulletproof helmet level
	name = "supply deputy beret"
	desc = "The headwear for only the most eagle-eyed Deputy, able to watch both Cargo and Mining. It looks like it's been reinforced due to 'Cargonian' problems."
	icon_state = "beret_supply"
	resistance_flags = ACID_PROOF | FIRE_PROOF

/obj/item/clothing/head/fulpberet/engineering
	armor = list(MELEE = 30, BULLET = 30, LASER = 25, ENERGY = 20, BOMB = 40, BIO = 100, RAD = 100, FIRE = 100, ACID = 90, WOUND = 5) // CE level
	name = "engineering deputy beret"
	desc = "Perhaps the only thing standing between the supermatter and a station-wide explosive sabotage. Comes with radiation protection."
	icon_state = "beret_engi"
	flags_1 = RAD_PROTECT_CONTENTS_1

/obj/item/clothing/head/fulpberet/medical
	armor = list(MELEE = 30, BULLET = 30, LASER = 25, ENERGY = 20, BOMB = 10, BIO = 100, RAD = 60, FIRE = 60, ACID = 75, WOUND = 5) // CMO level
	name = "medical deputy beret"
	desc = "This proud white-blue beret is a welcome sight when the greytide descends on chemistry, or just used as a bio hood."
	icon_state = "beret_medbay"

/obj/item/clothing/head/fulpberet/science
	armor = list(MELEE = 30, BULLET = 30, LASER = 25, ENERGY = 20, BOMB = 100, BIO = 100, RAD = 60, FIRE = 60, ACID = 80, WOUND = 5) // RD level
	name = "science deputy beret"
	desc = "This loud purple beret screams 'Dont mess with his matter manipulator!'. Fairly bomb resistant."
	icon_state = "beret_science"

/obj/item/clothing/head/fulpberet/service
	armor = list(MELEE = 40, BULLET = 50, LASER = 50, ENERGY = 60, BOMB = 50, BIO = 100, RAD = 50, FIRE = 100, ACID = 100, WOUND = 15) // Captain level
	name = "service deputy beret"
	desc = "The beret of the one able to defeat the Chef in his own kitchen."
	icon_state = "beret_service"

/// Headsets - Base + Engineering
/obj/item/radio/headset/headset_dep
	icon = 'fulp_modules/main_features/jobs/deputy/deputy_clothing/radio.dmi'
	worn_icon = 'icons/mob/clothing/ears.dmi'
	worn_icon_state = "sec_headset_alt"

	name = "engineering bowman headset"
	desc = "The best way to stay alert of any possible sabotage."
	icon_state = "eng_headset"
	keyslot = new /obj/item/encryptionkey/headset_eng

/obj/item/radio/headset/headset_dep/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/// Medical
/obj/item/radio/headset/headset_dep/med
	name = "medical bowman headset"
	desc = "Looks a little worn out from all the chemistry explosions."
	icon_state = "med_headset"
	keyslot = new /obj/item/encryptionkey/headset_med

/// Science
/obj/item/radio/headset/headset_dep/sci
	name = "science bowman headset"
	desc = "Suddenly turns off when the Research Director starts yelling Malf."
	icon_state = "sci_headset"
	keyslot = new /obj/item/encryptionkey/headset_sci

/// Supply
/obj/item/radio/headset/headset_dep/supply
	name = "supply bowman headset"
	desc = "Looks half destroyed, probably from all the Cargonia attempts."
	icon_state = "cargo_headset"
	keyslot = new /obj/item/encryptionkey/headset_cargo

/// Service
/obj/item/radio/headset/headset_dep/service
	name = "service bowman headset"
	desc = "For the one constantly recieving calls from the Law office to Botany, Service comms are the most well organized."
	icon_state = "service_headset"
	keyslot = new /obj/item/encryptionkey/headset_service

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

/*
 *	Deputies are meant to get NOGUNS trait.
 *	Lore-wise reason is that they are privately-owned, and trained by non-NT folk.
 *	These folk believe professionalism and the way people look at you, is more important than efficiency.
 *	No one wants to see a deputy with a gun, so they're trained in not using it.
 *
 *	Actual reason why is balance and to prevent powergaming.
 */

/// Engineering Skillchip
/obj/item/skillchip/job/deputy/engineering
	deputy = "3NG1N3ER1N9"
	department = "Engineering"
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
	auto_traits = list(TRAIT_SCIENCEDEPUTY, TRAIT_NOGUNS) /// No bonus here, they get a Mutadone medipen instead.

/area/science
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_SCIENCEDEPUTY

/// Supply Skillchip
/obj/item/skillchip/job/deputy/supply
	deputy = "5UPP1Y"
	department = "Cargo"
	auto_traits = list(TRAIT_SUPPLYDEPUTY, TRAIT_NOGUNS) /// No bonus here, they get an armor vest instead.

/area/cargo
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_SUPPLYDEPUTY

/// Service Skillchip
/obj/item/skillchip/job/deputy/service
	deputy = "S5RV1C3"
	department = "Service"
	auto_traits = list(TRAIT_SERVICEDEPUTY, TRAIT_NOGUNS, TRAIT_SUPERMATTER_SOOTHER) /// Psychologist bonus without the hallucination protection.

/area/service
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_SERVICEDEPUTY

/// Mood buff from being within your department.
/datum/mood_event/deputy_helpful
	description = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_change = 5

/// Used for Science Deputies and Brig doctor's Chemical kit.
/obj/item/reagent_containers/hypospray/medipen/mutadone
	name = "mutadone medipen"
	desc = "Contains a chemical that will remove all of an injected target's mutations."
	icon_state = "atropen"
	inhand_icon_state = "atropen"
	base_icon_state = "atropen"
	volume = 10
	amount_per_transfer_from_this = 10
	list_reagents = list(/datum/reagent/medicine/mutadone = 10)
