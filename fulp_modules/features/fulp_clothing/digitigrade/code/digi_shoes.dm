///Laceups

/obj/item/clothing/shoes/laceup/digitigrade
	name = "digitigrade laceup shoes"
	desc = "Shoes for only the coldest-blooded of lawyers."
	flags_inv = FULL_DIGITIGRADE
	icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_shoes.dmi'
	icon_state = "digi_laceups"
	worn_icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_feet.dmi'

///Workboots

/obj/item/clothing/shoes/workboots/digitigrade
	name = "digitigrade workboots"
	desc = "Nanotrasen-issue Engineering lace-up work boots for the hardworking lizardfolk."
	flags_inv = FULL_DIGITIGRADE
	icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_shoes.dmi'
	icon_state = "digi_workboots"
	worn_icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_feet.dmi'

///Combat Boots

/obj/item/clothing/shoes/digicombat
	name = "digitigrade combat boots"
	desc = "Robust combat boots especially for lizardmen. Perfect for walking over piled human corpses."
	flags_inv = FULL_DIGITIGRADE
	icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_shoes.dmi'
	icon_state = "digi_combats"
	worn_icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_feet.dmi'
	resistance_flags = FIRE_PROOF
	permeability_coefficient = 0.05
	body_parts_covered = LEG_LEFT|LEG_RIGHT
	armor = list("melee" = 15, "bullet" = 15, "laser" = 15, "energy" = 15, "bomb" = 20, "bio" = 5, "rad" = 0, "fire" = 40, "acid" = 20)

///Jackboots

/obj/item/clothing/shoes/jackboots/digitigrade
	name = "digitigrade jackboots"
	desc = "Nanotrasen-issue lizard Security combat boots for lizard combat scenarios or lizard combat situations."
	flags_inv = FULL_DIGITIGRADE
	icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_shoes.dmi'
	icon_state = "digi_jackboots"
	worn_icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_feet.dmi'

///Clown Shoes

/obj/item/clothing/shoes/clown_shoes/digitigrade
	name = "digitigrade clown shoes"
	desc = "Shoes of the sort made famous by acclaimed lizardman clown Pies-The-Janitor. Ctrl-click to toggle waddle dampeners."
	flags_inv = FULL_DIGITIGRADE
	icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_shoes.dmi'
	icon_state = "digi_clown"
	worn_icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_feet.dmi'

///Sandals

/obj/item/clothing/shoes/sandal/digitigrade
	name = "digitigrade sandals"
	desc = "Snugly fitting sandals for smugly dressed lizardfolk."
	flags_inv = FULL_DIGITIGRADE
	icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_shoes.dmi'
	icon_state = "digi_wizard"
	worn_icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_feet.dmi'

///Generic Shoes

/obj/item/clothing/shoes/brown/digitigrade
	name = "digitigrade brown shoes"
	desc = "A pair of digitigrade brown shoes. Shame they don't come in more colours."
	flags_inv = FULL_DIGITIGRADE
	icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_shoes.dmi'
	icon_state = "digi_brown"
	worn_icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_feet.dmi'

///Magboots

/obj/item/clothing/shoes/magboots/digitigrade
	name = "digitigrade magboots"
	desc = "A custom-made variant set of magnetic boots, intended to ensure lizardfolk can safely perform EVA."
	flags_inv = FULL_DIGITIGRADE
	icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_shoes.dmi'
	icon_state = "digi_magboots0"
	magboot_state = "digi_magboots"
	worn_icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_feet.dmi'

/datum/design/digi_magboots
	name = "Digitigrade Magnetic Boots"
	desc = "A custom-made variant set of magnetic boots, intended to ensure lizardfolk can safely perform EVA."
	id = "digi_magboots"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 4500, /datum/material/silver = 1500, /datum/material/gold = 2500)
	build_path = /obj/item/clothing/shoes/magboots/digitigrade
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING

///Mime Shoes

/obj/item/clothing/shoes/mime/digitigrade
	name = "digitigrade mime shoes"
	desc = "For the quiestest of lizardfolk."
	flags_inv = FULL_DIGITIGRADE
	icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_shoes.dmi'
	icon_state = "digi_mime"
	worn_icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_feet.dmi'

///Jump Boots

/obj/item/clothing/shoes/bhop/digitigrade
	name = "digitigrade jump boots"
	desc = "A specialized pair of combat boots with a built-in propulsion system for rapid foward movement. Customized for Digitigrade lizards."
	flags_inv = FULL_DIGITIGRADE
	icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_shoes.dmi'
	icon_state = "digi_jumpboots"
	worn_icon = 'fulp_modules/features/fulp_clothing/digitigrade/icons/digi_feet.dmi'
	resistance_flags = FIRE_PROOF
	permeability_coefficient = 0.05
