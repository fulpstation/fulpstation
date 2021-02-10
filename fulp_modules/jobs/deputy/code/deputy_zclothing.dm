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

/obj/item/clothing/under/rank/security/mallcop/skirt
	name = "deputy skirt"
	desc = "An awe-inspiring tactical shirt-and-pants combo; because safety never takes a holiday."
	icon_state = "mallcop_skirt"
	armor = list(MELEE = 10, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 30, ACID = 30, WOUND = 10)
	body_parts_covered = CHEST|GROIN|ARMS

//Berets
/obj/item/clothing/head/fulpberet/sec/engineering
	name = "engineering deputy beret"
	desc = "Perhaps the only thing standing between the supermatter and a station-wide explosive sabotage."
	worn_icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_worn.dmi'
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_icons.dmi'
	icon_state = "beret_engi"

/obj/item/clothing/head/fulpberet/sec/medical
	name = "medical deputy beret"
	desc = "This proud white-blue beret is a welcome sight when the greytide descends on chemistry."
	worn_icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_worn.dmi'
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_icons.dmi'
	icon_state = "beret_medbay"

/obj/item/clothing/head/fulpberet/sec/science
	name = "science deputy beret"
	desc = "This loud purple beret screams 'Dont mess with his matter manipulator!'"
	worn_icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_worn.dmi'
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_icons.dmi'
	icon_state = "beret_science"

/obj/item/clothing/head/fulpberet/sec/supply
	name = "supply deputy beret"
	desc = "The headwear for only the most eagle-eyed Deputy, able to watch both Cargo and Mining."
	worn_icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_worn.dmi'
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_icons.dmi'
	icon_state = "beret_supply"

//Supply Deputy Skillchip
/obj/item/skillchip/job/supply_deputy
	name = "5UPP1Y-DEPUTY skillchip"
	desc = "Do you think Deputies know this naturally?"
	auto_traits = list(TRAIT_SUPPLYDEPUTY)
	skill_name = "Supply Deputy"
	skill_description = "Recognizes Supply as their home, and has a greater fighting advantage while in it."
	skill_icon = "sitemap"
	activate_message = "<span class='notice'>You suddenly feel safe in Cargo.</span>"
	deactivate_message = "<span class='notice'>Cargo no longer feels safe.</span>"

/obj/item/skillchip/job/supply_deputy/Initialize(mapload, is_removable = FALSE)
	. = ..()

	var/list/valid_areas = list(typesof(/area/quartermaster))
	if(!is_type_in_list(get_area(user), valid_areas))
		return FALSE

/obj/item/skillchip/job/supply_deputy/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()

	ADD_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, make_temporary = TRUE)

/obj/item/skillchip/job/supply_deputy/on_deactivate(mob/living/carbon/user, silent = FALSE)
	REMOVE_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, make_temporary = TRUE)

	return ..()

//Engineering Deputy Skillchip
/obj/item/skillchip/job/engineering_deputy
	name = "3NG1N3ER1N9-DEPUTY skillchip"
	desc = "Do you think Deputies know this naturally?"
	auto_traits = list(TRAIT_ENGINEERINGDEPUTY)
	skill_name = "Engineering Deputy"
	skill_description = "Recognizes Engineering as their home, and has a greater fighting advantage while in it."
	skill_icon = "sitemap"
	activate_message = "<span class='notice'>You suddenly feel safe in Engineering.</span>"
	deactivate_message = "<span class='notice'>Engineering no longer feels safe.</span>"

/obj/item/skillchip/job/engineering_deputy/Initialize(mapload, is_removable = FALSE)
	. = ..()

	var/list/valid_areas = list(typesof(/area/engine))
	if(!is_type_in_list(get_area(user), valid_areas))
		return FALSE

/obj/item/skillchip/job/engineering_deputy/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()

	ADD_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, make_temporary = TRUE)

/obj/item/skillchip/job/engineering_deputy/on_deactivate(mob/living/carbon/user, silent = FALSE)
	REMOVE_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, make_temporary = TRUE)

	return ..()

//Medical Deputy Skillchip
/obj/item/skillchip/job/medical_deputy
	name = "M3D1C4L-DEPUTY skillchip"
	desc = "Do you think Deputies know this naturally?"
	auto_traits = list(TRAIT_MEDICALDEPUTY)
	skill_name = "Medical Deputy"
	skill_description = "Recognizes Medbay as their home, and has a greater fighting advantage while in it."
	skill_icon = "sitemap"
	activate_message = "<span class='notice'>You suddenly feel safe in Medical.</span>"
	deactivate_message = "<span class='notice'>Medical no longer feels safe.</span>"

/obj/item/skillchip/job/medical_deputy/Initialize(mapload, is_removable = FALSE)
	. = ..()

	var/list/valid_areas = list(typesof(/area/medical))
	if(!is_type_in_list(get_area(user), valid_areas))
		return FALSE

/obj/item/skillchip/job/medical_deputy/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()

	ADD_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, make_temporary = TRUE)

/obj/item/skillchip/job/medical_deputy/on_deactivate(mob/living/carbon/user, silent = FALSE)
	REMOVE_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, make_temporary = TRUE)

	return ..()

//Science Deputy Skillchip
/obj/item/skillchip/job/science_deputy
	name = "5C1ENC3-DEPUTY skillchip"
	desc = "Do you think Deputies know this naturally?"
	auto_traits = list(TRAIT_SCIENCEDEPUTY)
	skill_name = "Science Deputy"
	skill_description = "Recognizes Science as their home, and has a greater fighting advantage while in it."
	skill_icon = "sitemap"
	activate_message = "<span class='notice'>You suddenly feel safe in Science.</span>"
	deactivate_message = "<span class='notice'>Science no longer feels safe.</span>"

/obj/item/skillchip/job/science_deputy/Initialize(mapload, is_removable = FALSE)
	. = ..()

	var/list/valid_areas =list(typesof(/area/science))
	if(!is_type_in_list(get_area(user), valid_areas))
		return FALSE

/obj/item/skillchip/job/science_deputy/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()

	ADD_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, make_temporary = TRUE)

/obj/item/skillchip/job/science_deputy/on_deactivate(mob/living/carbon/user, silent = FALSE)
	REMOVE_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, make_temporary = TRUE)

	return ..()
