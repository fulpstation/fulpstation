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
