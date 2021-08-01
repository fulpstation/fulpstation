//The Gold One
/obj/item/clothing/head/hardhat/golden_punk
	name = "Guy-Manuel Helmet"
	desc = "Give life back to music!"
	icon = 'fulp_modules/features/halloween_event/costumes_2020/daft_frank_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/daft_frank_worn.dmi'
	icon_state = "hardhat0_guy"
	on = FALSE
	hat_type = "guy"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, RAD = 0, FIRE = 0, ACID = 0, WOUND = 0)
	resistance_flags = null
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES

//The Silver One
/obj/item/clothing/head/hardhat/silver_punk
	name = "Thomas Helmet"
	desc = "Reminds you of touch..."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/daft_frank_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/daft_frank_worn.dmi'
	icon_state = "hardhat0_thomas"
	on = FALSE
	hat_type = "thomas"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, RAD = 0, FIRE = 0, ACID = 0, WOUND = 0)
	resistance_flags = null
	clothing_flags = SNUG_FIT
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/under/sparky
	name = "The suit"
	desc = "Harder, Better, Faster, Stronger!"
	icon = 'fulp_modules/features/halloween_event/costumes_2020/daft_frank_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/daft_frank_worn.dmi'
	icon_state = "the_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	fitted = FEMALE_UNIFORM_FULL
	has_sensor = HAS_SENSORS
	random_sensor = TRUE
	can_adjust = FALSE

/obj/item/clothing/gloves/daft_golden
	name = "insert name here"
	desc = "A pair of sparky golden gloves."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/daft_frank_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/daft_frank_worn.dmi'
	icon_state = "golden_gloves"

/obj/item/clothing/gloves/daft_silver
	name = "insert name here"
	desc = "A pair of sparky silver gloves."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/daft_frank_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/daft_frank_worn.dmi'
	icon_state = "silver_gloves"

/obj/item/storage/box/halloween/edition_20/daft_box
	theme_name = "2020's Daft Punk Duo"
	illustration = "daft"

/obj/item/storage/box/halloween/edition_20/daft_box/PopulateContents()
	new /obj/item/clothing/head/hardhat/golden_punk(src)
	new /obj/item/clothing/head/hardhat/silver_punk(src)
	new /obj/item/clothing/gloves/daft_golden(src)
	new /obj/item/clothing/gloves/daft_silver(src)
	new /obj/item/instrument/eguitar(src)
	new /obj/item/instrument/piano_synth(src)

	for(var/i in 1 to 2)
		new /obj/item/clothing/under/sparky(src)
		new /obj/item/clothing/shoes/sneakers/cyborg(src)

/obj/item/storage/box/halloween/edition_20/daft_box/golden
	theme_name = "2020's Daft Punk Golden"

/obj/item/storage/box/halloween/edition_20/daft_box/golden/PopulateContents()
	new /obj/item/clothing/head/hardhat/golden_punk(src)
	new /obj/item/clothing/gloves/daft_golden(src)
	new /obj/item/instrument/eguitar(src)
	new /obj/item/clothing/under/sparky(src)
	new /obj/item/clothing/shoes/sneakers/cyborg(src)

/obj/item/storage/box/halloween/edition_20/daft_box/silver
	theme_name = "2020's Daft Punk Silver"

/obj/item/storage/box/halloween/edition_20/daft_box/silver/PopulateContents()
	new /obj/item/clothing/head/hardhat/silver_punk(src)
	new /obj/item/clothing/gloves/daft_silver(src)
	new /obj/item/instrument/piano_synth(src)
	new /obj/item/clothing/under/sparky(src)
	new /obj/item/clothing/shoes/sneakers/cyborg(src)
