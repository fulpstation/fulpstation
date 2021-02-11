//Headsets
/obj/item/radio/headset/headset_sec/department/engi
	keyslot = new /obj/item/encryptionkey/headset_sec
	keyslot2 = new /obj/item/encryptionkey/headset_eng

/obj/item/radio/headset/headset_sec/department/supply
	keyslot = new /obj/item/encryptionkey/headset_sec
	keyslot2 = new /obj/item/encryptionkey/headset_cargo

/obj/item/radio/headset/headset_sec/department/med
	keyslot = new /obj/item/encryptionkey/headset_sec
	keyslot2 = new /obj/item/encryptionkey/headset_med

/obj/item/radio/headset/headset_sec/department/sci
	keyslot = new /obj/item/encryptionkey/headset_sec
	keyslot2 = new /obj/item/encryptionkey/headset_sci

//Supply Deputy Datum
/datum/outfit/job/deputy/supply
	name = "Deputy - Supply"
	jobtype = /datum/job/fulp/deputy
//	neck = /obj/item/clothing/neck/fulptie/supply -- Uncomment when sprites are made, in deputy_zclothing.dm
	ears = /obj/item/radio/headset/headset_sec/department/supply
	head = /obj/item/clothing/head/fulpberet/supply
	accessory = /obj/item/clothing/accessory/armband/cargo
	skillchips = list(/obj/item/skillchip/job/deputy/supply)

//Engineering Deputy Datum
/datum/outfit/job/deputy/engineering
	name = "Deputy - Engineering"
	jobtype = /datum/job/fulp/deputy
//	neck = /obj/item/clothing/neck/fulptie/engineering -- Uncomment when sprites are made, in deputy_zclothing.dm
	ears = /obj/item/radio/headset/headset_sec/department/engi
	head = /obj/item/clothing/head/fulpberet/engineering
	accessory = /obj/item/clothing/accessory/armband/engine
	skillchips = list(/obj/item/skillchip/job/deputy/engineering)

//Medical Deputy Datum
/datum/outfit/job/deputy/medical
	name = "Deputy - Medical"
	jobtype = /datum/job/fulp/deputy
//	neck = /obj/item/clothing/neck/fulptie/medical -- Uncomment when sprites are made, in deputy_zclothing.dm
	ears = /obj/item/radio/headset/headset_sec/department/med
	head = /obj/item/clothing/head/fulpberet/medical
	accessory = /obj/item/clothing/accessory/armband/medblue
	skillchips = list(/obj/item/skillchip/job/deputy/medical)

//Science Deputy Datum
/datum/outfit/job/deputy/science
	name = "Deputy - Science"
	jobtype = /datum/job/fulp/deputy
//	neck = /obj/item/clothing/neck/fulptie/science -- Uncomment when sprites are made, in deputy_zclothing.dm
	ears = /obj/item/radio/headset/headset_sec/department/sci
	head = /obj/item/clothing/head/fulpberet/science
	accessory = /obj/item/clothing/accessory/armband/science
	skillchips = list(/obj/item/skillchip/job/deputy/science)

//Plasmamen Datum
/datum/outfit/plasmaman/deputy
	name = "Plasmaman Deputy - Unassigned"
	head = /obj/item/clothing/head/helmet/space/plasmaman/security // Placeholder until actual sprites are made, commented out code below is the real suit
	uniform = /obj/item/clothing/under/plasmaman/security // Placeholder until actual sprites are made, commented out code below is the real suit
	gloves = /obj/item/clothing/gloves/color/plasmaman/black // When sprite are made, this should likely be changed to fit it. Best to be white, like the bartender's.
//	head = /obj/item/clothing/head/helmet/space/plasmaman/security/deputy
//	uniform = /obj/item/clothing/under/plasmaman/security/deputy

//Beefmen Datum
/datum/outfit/job/deputy/beefman
	name = "Beefman Deputy - Unassigned"
	uniform = /obj/item/clothing/under/bodysash/deputy

//Shirt
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

/* -- These can be uncommented when proper sprites are done for them
//Ties
/obj/item/clothing/neck/fulptie
	name = "departmental tie"
	desc = "A tie showing off the department colors of a deputy."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "bluetie"
	inhand_icon_state = ""	//no inhands
	w_class = WEIGHT_CLASS_SMALL
	custom_price = PAYCHECK_EASY
	var/department

/obj/item/clothing/neck/fulptie/Initialize()
	. = ..()
	if(department)
		name = "[department] tie"
		icon_state = "[department]_tie"

/obj/item/clothing/neck/fulptie/supply
	department = "supply"

/obj/item/clothing/neck/fulptie/engineering
	department = "engineering"

/obj/item/clothing/neck/fulptie/medical
	department = "medical"

/obj/item/clothing/neck/fulptie/science
	department = "science"
*/

//Plasmaman clothes, commented out until sprites are made.
/*
/obj/item/clothing/under/plasmaman/security/deputy
	icon = 'icons/obj/clothing/under/plasmaman.dmi'
	worn_icon = 'icons/mob/clothing/under/plasmaman.dmi'
	name = "deputy plasma envirosuit"
	desc = "A plasmaman containment suit designed for deputies, offering a limited amount of extra protection."
	icon_state = "security_envirosuit"
	inhand_icon_state = "security_envirosuit"

/obj/item/clothing/head/helmet/space/plasmaman/security/deputy
	icon = 'icons/obj/clothing/under/plasmaman.dmi'
	worn_icon = 'icons/mob/clothing/under/plasmaman.dmi'
	name = "deputy envirosuit helmet"
	desc = "A plasmaman containment helmet designed for deputies, protecting them from being flashed and burning alive, alongside other undesirables."
	icon_state = "security_envirohelm"
	inhand_icon_state = "security_envirohelm"
*/

//Berets
/obj/item/clothing/head/fulpberet
	armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 60, BIO = 0, RAD = 0, FIRE = 60, ACID = 60) // Same as Chaplain armor, it's the Deputy's holy beret.
	worn_icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_worn.dmi'
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_icons.dmi'

/obj/item/clothing/head/fulpberet/supply
	name = "supply deputy beret"
	desc = "The headwear for only the most eagle-eyed Deputy, able to watch both Cargo and Mining."
	icon_state = "beret_supply"

/obj/item/clothing/head/fulpberet/engineering
	name = "engineering deputy beret"
	desc = "Perhaps the only thing standing between the supermatter and a station-wide explosive sabotage."
	icon_state = "beret_engi"

/obj/item/clothing/head/fulpberet/medical
	name = "medical deputy beret"
	desc = "This proud white-blue beret is a welcome sight when the greytide descends on chemistry."
	icon_state = "beret_medbay"

/obj/item/clothing/head/fulpberet/science
	name = "science deputy beret"
	desc = "This loud purple beret screams 'Dont mess with his matter manipulator!'"
	icon_state = "beret_science"

//Base Skillchip
/obj/item/skillchip/job/deputy
	name = "D3PU7Y skillchip"
	desc = "You think Deputies learn this stuff naturally?"
	skill_icon = "sitemap"
	var/deputy
	var/department
	var/datum/martial_art/deputygrab/style

/obj/item/skillchip/job/deputy/Initialize()
	. = ..()
	if(deputy)
		name = "[deputy]-D3PUT7 skillchip"
	if(department)
		skill_name = "[department] Deputy"
		skill_description = "Recognizes [department] as their home, and has a greater fighting advantage while in it."
		activate_message = "<span class='notice'>You suddenly feel safe in [department].</span>"
		deactivate_message = "<span class='notice'>[department] no longer feels safe.</span>"
	style = new

/obj/item/skillchip/job/deputy/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	style.teach(user, make_temporary = TRUE)

/obj/item/skillchip/job/deputy/on_deactivate(mob/living/carbon/user, silent = FALSE)
	style.remove(user)
	return ..()

//Supply Skillchip
/obj/item/skillchip/job/deputy/supply
	deputy = "5UPP1Y"
	department = "Cargo"
	auto_traits = list(TRAIT_SUPPLYDEPUTY, TRAIT_NOGUNS) // Deputies aren't trained to use guns

/* -- These must be commented out until the next TG update when they're adding mood_trait! THESE ARE NOT TESTED EITHER. DONT JUST UNCOMMENT AND GO ABOUT YOUR DAY
/area/quartermaster
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_SUPPLYDEPUTY
*/

//Engineering Skillchip
/obj/item/skillchip/job/deputy/engineering
	deputy = "3NG1N3ER1N9"
	department = "Engineering"
	auto_traits = list(TRAIT_ENGINEERINGDEPUTY, TRAIT_NOGUNS) // Deputies aren't trained to use guns

/* -- These must be commented out until the next TG update when they're adding mood_trait! THESE ARE NOT TESTED EITHER. DONT JUST UNCOMMENT AND GO ABOUT YOUR DAY
/area/engine
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_ENGINEERINGDEPUTY
*/

//Medical Skillchip
/obj/item/skillchip/job/deputy/medical
	deputy = "M3D1C4L"
	department = "Medbay"
	auto_traits = list(TRAIT_MEDICALDEPUTY, TRAIT_NOGUNS) // Deputies aren't trained to use guns

/* -- These must be commented out until the next TG update when they're adding mood_trait! THESE ARE NOT TESTED EITHER. DONT JUST UNCOMMENT AND GO ABOUT YOUR DAY
/area/medical
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_MEDICALDEPUTY
*/

//Science Skillchip
/obj/item/skillchip/job/deputy/science
	deputy = "5C1ENC3"
	department = "Science"
	auto_traits = list(TRAIT_SCIENCEDEPUTY, TRAIT_NOGUNS) // Deputies aren't trained to use guns

/* -- These must be commented out until the next TG update when they're adding mood_trait! THESE ARE NOT TESTED EITHER. DONT JUST UNCOMMENT AND GO ABOUT YOUR DAY
/area/science
	mood_bonus = 5
	mood_message = "<span class='nicegreen'>I love helping out my department!</span>\n"
	mood_trait = TRAIT_SCIENCEDEPUTY
*/
