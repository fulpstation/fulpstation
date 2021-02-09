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

//Shirt
/obj/item/clothing/under/rank/security/mallcop
	name = "deputy shirt"
	desc = "An awe-inspiring tactical shirt-and-pants combo; because safety never takes a holiday."
	mob_overlay_icon = 'fulp_modules/jobs/deputy/deputy_clothing/under_worn.dmi'
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/under_icons.dmi'
	icon_state = "mallcop"
	strip_delay = 50
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	fulp_item = TRUE

//Berets
/obj/item/clothing/head/beret/sec/engineering
	name = "engineering deputy beret"
	desc = "Perhaps the only thing standing between the supermatter and a station-wide explosive sabotage."
	mob_overlay_icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_worn.dmi'
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_icons.dmi'
	icon_state = "beret_engi"
	fulp_item = TRUE

/obj/item/clothing/head/beret/sec/medical
	name = "medical deputy beret"
	desc = "This proud white-blue beret is a welcome sight when the greytide descends on chemistry."
	mob_overlay_icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_worn.dmi'
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_icons.dmi'
	icon_state = "beret_medbay"
	fulp_item = TRUE

/obj/item/clothing/head/beret/sec/science
	name = "science deputy beret"
	desc = "This loud purple beret screams 'Dont mess with his matter manipulator!'"
	mob_overlay_icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_worn.dmi'
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_icons.dmi'
	icon_state = "beret_science"
	fulp_item = TRUE

/obj/item/clothing/head/beret/sec/supply
	name = "supply deputy beret"
	desc = "The headwear for only the most eagle-eyed Deputy, able to watch both Cargo and Mining."
	mob_overlay_icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_worn.dmi'
	icon = 'fulp_modules/jobs/deputy/deputy_clothing/head_icons.dmi'
	icon_state = "beret_supply"
	fulp_item = TRUE

//Supply Skillchip
/obj/item/skillchip/job/supply_deputy
	name = "5UPP1Y-DEPUTY skillchip"
	desc = "Do you think Deputies know this naturally?"
	auto_traits = list(SUPPLY_DEPUTY)
	skill_name = "Supply Deputy"
	skill_description = "Recognizes Supply as their home, and has a greater fighting advantage while in it."
	skill_icon = "sitemap"
	activate_message = "<span class='notice'>You suddenly feel safe in Cargo.</span>"
	deactivate_message = "<span class='notice'>Cargo no longer feels safe.</span>"

/obj/item/skillchip/job/supply_deputy/Initialize()
	. = ..()
	var/list/valid_areas = list(/area/maintenance/department/cargo)
	if(!is_type_in_list(get_area(H), valid_areas))
		return FALSE
	return ..()

/obj/item/skillchip/job/supply_deputy/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	ADD_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, src)

/obj/item/skillchip/job/supply_deputy/on_deactivate(mob/living/carbon/user, silent = FALSE)
	REMOVE_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, src)
	return ..()

//Engineering Skillchip
/obj/item/skillchip/job/engineering_deputy
	name = "3NG1N3ER1N9-DEPUTY skillchip"
	desc = "Do you think Deputies know this naturally?"
	auto_traits = list(ENGINEERING_DEPUTY)
	skill_name = "Engineering Deputy"
	skill_description = "Recognizes Engineering as their home, and has a greater fighting advantage while in it."
	skill_icon = "sitemap"
	activate_message = "<span class='notice'>You suddenly feel safe in Engineering.</span>"
	deactivate_message = "<span class='notice'>Engineering no longer feels safe.</span>"

/obj/item/skillchip/job/engineering_deputy/Initialize()
	. = ..()
	var/list/valid_areas = list(/area/engine/engineering)
	if(!is_type_in_list(get_area(H), valid_areas))
		return FALSE
	return ..()

/obj/item/skillchip/job/engineering_deputy/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	ADD_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, src)

/obj/item/skillchip/job/engineering_deputy/on_deactivate(mob/living/carbon/user, silent = FALSE)
	REMOVE_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, src)
	return ..()

//Medical Skillchip
/obj/item/skillchip/job/medical_deputy
	name = "M3D1C4L-DEPUTY skillchip"
	desc = "Do you think Deputies know this naturally?"
	auto_traits = list(MEDICAL_DEPUTY)
	skill_name = "Medical Deputy"
	skill_description = "Recognizes Medbay as their home, and has a greater fighting advantage while in it."
	skill_icon = "sitemap"
	activate_message = "<span class='notice'>You suddenly feel safe in Medical.</span>"
	deactivate_message = "<span class='notice'>Medical no longer feels safe.</span>"

/obj/item/skillchip/job/medical_deputy/Initialize()
	. = ..()
	var/list/valid_areas = list(/area/medical)
	if(!is_type_in_list(get_area(H), valid_areas))
		return FALSE
	return ..()

/obj/item/skillchip/job/medical_deputy/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	ADD_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, src)

/obj/item/skillchip/job/medical_deputy/on_deactivate(mob/living/carbon/user, silent = FALSE)
	REMOVE_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, src)
	return ..()

//Science Skillchip
/obj/item/skillchip/job/science_deputy
	name = "5C1ENC3-DEPUTY skillchip"
	desc = "Do you think Deputies know this naturally?"
	auto_traits = list(SCIENCE_DEPUTY)
	skill_name = "Science Deputy"
	skill_description = "Recognizes Science as their home, and has a greater fighting advantage while in it."
	skill_icon = "sitemap"
	activate_message = "<span class='notice'>You suddenly feel safe in Science.</span>"
	deactivate_message = "<span class='notice'>Science no longer feels safe.</span>"

/obj/item/skillchip/job/science_deputy/Initialize()
	. = ..()
	var/list/valid_areas = list(/area/science)
	if(!is_type_in_list(get_area(H), valid_areas))
		return FALSE
	return ..()

/obj/item/skillchip/job/science_deputy/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	ADD_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, src)

/obj/item/skillchip/job/sciencce_deputy/on_deactivate(mob/living/carbon/user, silent = FALSE)
	REMOVE_TRAIT(user, BLOCKS_SHOVE_KNOCKDOWN, src)
	return ..()
