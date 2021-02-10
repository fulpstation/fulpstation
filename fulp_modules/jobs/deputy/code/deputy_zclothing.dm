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

//Plasmamen
/datum/outfit/plasmaman/deputy
	name = "Plasmaman Deputy"

	head = /obj/item/clothing/head/helmet/space/plasmaman/security
	uniform = /obj/item/clothing/under/plasmaman/security
	gloves = /obj/item/clothing/gloves/color/plasmaman/black

//Shirt
/obj/item/clothing/under/rank/security/mallcop
	name = "deputy shirt"
	desc = "An awe-inspiring tactical shirt-and-pants combo; because safety never takes a holiday."
	icon_state = "mallcop"
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/deputy_clothes.dmi'
	worn_icon = 'fulp_modules/jobs/deputy/deputy_clothing/under_worn.dmi'
	armor = list(MELEE = 10, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 30, ACID = 30, WOUND = 10)
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	strip_delay = 50
	alt_covers_chest = TRUE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	can_adjust = TRUE

/obj/item/clothing/under/rank/security/mallcop/skirt
	name = "deputy skirt"
	desc = "An awe-inspiring tactical shirt-and-skirt combo; because safety never takes a holiday."
	icon_state = "mallcop_skirt"
	body_parts_covered = CHEST|GROIN|ARMS

//Berets - Clown shoes will be used to give them mood benefits for their department
/obj/item/clothing/head/fulpberet
	armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 60, BIO = 0, RAD = 0, FIRE = 60, ACID = 60) // Same as crusader armor, because this is the Deputy's holy clothing
	worn_icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_worn.dmi'
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_icons.dmi'

/obj/item/clothing/head/fulpberet/supply
	name = "supply deputy beret"
	desc = "The headwear for only the most eagle-eyed Deputy, able to watch both Cargo and Mining."
	icon_state = "beret_supply"
//list(typesof(/area/quartermaster))

/obj/item/clothing/head/fulpberet/engineering
	name = "engineering deputy beret"
	desc = "Perhaps the only thing standing between the supermatter and a station-wide explosive sabotage."
	icon_state = "beret_engi"
//list(typesof(/area/engine))

/obj/item/clothing/head/fulpberet/medical
	name = "medical deputy beret"
	desc = "This proud white-blue beret is a welcome sight when the greytide descends on chemistry."
	icon_state = "beret_medbay"
//list(typesof(/area/medical))

/obj/item/clothing/head/fulpberet/science
	name = "science deputy beret"
	desc = "This loud purple beret screams 'Dont mess with his matter manipulator!'"
	icon_state = "beret_science"
//list(typesof(/area/science))

//Base Deputy Skillchip
/obj/item/skillchip/job/deputy
	name = "D3PU7Y skillchip"
	desc = "You think Deputies learn this stuff naturally?"
	skill_icon = "sitemap"
	var/deputy
	var/department

/obj/item/skillchip/job/deputy/Initialize()
	. = ..()
	if(deputy)
		name = "[deputy]-D3PUT7 skillchip"
	if(department)
		skill_name = "[department] Deputy"
		skill_description = "Recognizes [department] as their home, and has a greater fighting advantage while in it."
		activate_message = "<span class='notice'>You suddenly feel safe in [department].</span>"
		deactivate_message = "<span class='notice'>[department] no longer feels safe.</span>"

//Supply Deputy Skillchip
/obj/item/skillchip/job/deputy/supply
	deputy = "5UPP1Y"
	department = "Cargo"
	auto_traits = list(TRAIT_SUPPLYDEPUTY)

//Engineering Deputy Skillchip
/obj/item/skillchip/job/deputy/engineering
	deputy = "3NG1N3ER1N9"
	department = "Engineering"
	auto_traits = list(TRAIT_ENGINEERINGDEPUTY)

//Medical Deputy Skillchip
/obj/item/skillchip/job/deputy/medical
	deputy = "M3D1C4L"
	department = "Medbay"
	auto_traits = list(TRAIT_MEDICALDEPUTY)

//Science Deputy Skillchip
/obj/item/skillchip/job/deputy/science
	deputy = "5C1ENC3"
	department = "Science"
	auto_traits = list(TRAIT_SCIENCEDEPUTY)
