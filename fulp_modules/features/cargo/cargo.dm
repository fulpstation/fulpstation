//Put all modular Fulp cargo crates in this folder.

//Halloween
/datum/supply_pack/goody/halloween_beacon
	name = "Halloween Beacon"
	desc = "Contains one halloween beacon used for bluespace costume delivery. Guaranteed to get you spooky!"
	cost = PAYCHECK_MEDIUM * 2
	contains = list(/obj/item/choice_beacon/halloween)

//Costume packs
/datum/supply_pack/goody/clown_costume
	name = "Clown Costume"
	desc = "Supply the station's wannabe clown with their equipment and costume! Contains a full clown outfit along with a bike horn."
	cost = PAYCHECK_MEDIUM * 2
	contains = list(
		/obj/item/bikehorn,
		/obj/item/clothing/mask/gas/clown_hat,
		/obj/item/clothing/shoes/clown_shoes,
		/obj/item/clothing/under/rank/civilian/clown,
		/obj/item/storage/backpack/clown,
	)

/datum/supply_pack/goody/mime_costume
	name = "Mime Costume"
	desc = "Supply the station's wannabe mime with their equipment and costume! Contains a full mime outfit along with a bottle of nothing."
	cost = PAYCHECK_MEDIUM * 2
	contains = list(
		/obj/item/clothing/gloves/color/white,
		/obj/item/clothing/head/frenchberet,
		/obj/item/clothing/mask/gas/mime,
		/obj/item/clothing/shoes/sneakers/black,
		/obj/item/clothing/suit/toggle/suspenders,
		/obj/item/clothing/under/rank/civilian/mime,
		/obj/item/reagent_containers/food/drinks/bottle/bottleofnothing,
		/obj/item/storage/backpack/mime,
	)

//Brig Physician

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
	new /obj/item/clothing/head/fulpberet/brigphysician(src)
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

//Toys

/datum/supply_pack/costumes_toys/fnaf_plushies
	name = "Five Nights at Freddy's Plushy Crate"
	desc = "A crate featuring the iconic Freddy and Chica from the Five Night's at Freddy's series."
	cost = CARGO_CRATE_VALUE * 2
	contains = list(
		/obj/item/toy/plush/freddy,
		/obj/item/toy/plush/chica,
	)
	crate_name = "five nights at freddy's plushy crate"

