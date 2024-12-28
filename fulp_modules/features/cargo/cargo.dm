//Put all modular Fulp cargo crates in this folder.

// Medipens
/datum/supply_pack/security/mutadone_medipen
	name = "Emergency Mutadone Kit"
	desc = "Contains one Mutadone medipen for instant genetic removal. Best used for hulks."
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(/obj/item/reagent_containers/hypospray/medipen/mutadone)

//Halloween
/datum/supply_pack/goody/halloween_beacon
	name = "Halloween Beacon"
	desc = "Contains one halloween beacon used for bluespace costume delivery. Guaranteed to get you spooky!"
	cost = CARGO_CRATE_VALUE * 0.5
	contains = list(/obj/item/choice_beacon/halloween)

//Costume packs
/datum/supply_pack/goody/clown_costume
	name = "Clown Costume"
	desc = "Supply the station's wannabe clown with their equipment and costume! Contains a full clown outfit along with a bike horn."
	cost = CARGO_CRATE_VALUE
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
	cost = CARGO_CRATE_VALUE
	contains = list(
		/obj/item/clothing/gloves/color/white,
		/obj/item/clothing/head/frenchberet,
		/obj/item/clothing/mask/gas/mime,
		/obj/item/clothing/shoes/sneakers/black,
		/obj/item/clothing/suit/toggle/suspenders,
		/obj/item/clothing/under/rank/civilian/mime,
		/obj/item/reagent_containers/cup/glass/bottle/bottleofnothing,
		/obj/item/storage/backpack/mime,
	)

//Toys

/datum/supply_pack/costumes_toys/fnaf_plushies
	name = "Five Nights at Freddy's Plushy Crate"
	desc = "A crate featuring the iconic four animatronics from the Five Night's at Freddy's series."
	cost = CARGO_CRATE_VALUE * 2
	contains = list(
		/obj/item/toy/plush/animatronic,
		/obj/item/toy/plush/animatronic/chica,
		/obj/item/toy/plush/animatronic/foxy,
		/obj/item/toy/plush/animatronic/bonnie,
	)
	crate_name = "five nights at freddy's plushy crate"

/datum/supply_pack/goody/shrimpplush
	name = "Shrimp Plushie"
	desc = "It really is just that shrimple."
	cost = PAYCHECK_CREW * 4
	contains = list(/obj/item/toy/plush/shrimp)

/datum/supply_pack/goody/phosplush
	name = "Phosphophyllite Plushie"
	desc = "A lone drop broken through the stillness, causing infinity \n\
		to start wavering. Plush fibers contain trace amounts of actual \n\
		gemstone, guaranteed acid-resistant in at least twenty-six sectors."
	cost = PAYCHECK_CREW * 6
	contains = list(/obj/item/toy/plush/phos)
