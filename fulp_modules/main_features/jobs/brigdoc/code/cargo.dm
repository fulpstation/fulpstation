/*
Contains:
	- Cargo crate supply datums for brig physician clothing.
	- Duffelbags that store brig physician clothing.
*/

/datum/supply_pack/security/brigdoc_clothing
	name = "Brig Physician Clothing Kit"
	desc = "A beginner kit for aspiring brig physicians. Comes with a jumpsuit, jumpskirt, labcoat, jackboots and beret. Medical sunglasses not included, comes with a medical HUD to compensate. Requires Security access to open."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/storage/backpack/duffelbag/sec/brigdoc_equipment)
	crate_type = /obj/structure/closet/crate/secure
	crate_name = "brig physician clothing crate"

/datum/supply_pack/security/brigdoc_clothing_plasmaman
	name = "Brig Physician Plasmaman Clothing Kit"
	desc = "A clothing kit for plasmamen brig physicians. Comes with an envirosuit, an envirohelmet, labcoat, jackboots, white envirogloves and a medical HUD. Requires Security access to open."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/storage/backpack/duffelbag/sec/brigdoc_equipment_plasma)
	crate_type = /obj/structure/closet/crate/secure
	crate_name = "brig physician plasmaman clothing crate"

/obj/item/storage/backpack/duffelbag/sec/brigdoc_equipment
	name = "brig physician clothing kit"
	desc = "A large duffel bag for holding extra supplies - this one's purpose seems to be to hold clothing."

/obj/item/storage/backpack/duffelbag/sec/brigdoc_equipment/PopulateContents()
	new /obj/item/clothing/head/beret/sec/medical(src)
	new /obj/item/clothing/suit/toggle/labcoat/armored(src)
	new /obj/item/clothing/under/rank/medical/brigdoc(src)
	new /obj/item/clothing/under/rank/medical/brigdoc/skirt(src)
	new /obj/item/clothing/glasses/hud/health(src)
	new /obj/item/clothing/shoes/jackboots(src)

/obj/item/storage/backpack/duffelbag/sec/brigdoc_equipment_plasma
	name = "brig physician plasmaman clothing kit"

/obj/item/storage/backpack/duffelbag/sec/brigdoc_equipment_plasma/PopulateContents()
	new /obj/item/clothing/head/helmet/space/plasmaman/brigdoc(src)
	new /obj/item/clothing/suit/toggle/labcoat/armored(src)
	new /obj/item/clothing/gloves/color/plasmaman/white(src)
	new /obj/item/clothing/under/plasmaman/brigdoc(src)
	new /obj/item/clothing/glasses/hud/health(src)
	new /obj/item/clothing/shoes/jackboots(src)
