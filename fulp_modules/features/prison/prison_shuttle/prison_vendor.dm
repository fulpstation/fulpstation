/obj/machinery/vending/hydroseeds/prison
	name = "\improper Prison MegaSeed Servitor"
	desc = "When you need seeds fast!"
	product_slogans = "THIS'S WHERE TH' SEEDS LIVE! GIT YOU SOME!;Hands down the best seed selection on the station!;Also certain mushroom varieties available, more for experts! Get certified today!"
	product_ads = "We like plants!;Grow some crops!;Grow, baby, growww!;Aw h'yeah son!"
	icon_state = "seeds"
	panel_type = "panel2"
	light_mask = "seeds-light-mask"
	products = list(
		/obj/item/seeds/ambrosia = 3,
		/obj/item/seeds/berry = 3,
		/obj/item/seeds/cabbage = 3,
		/obj/item/seeds/carrot = 3,
		/obj/item/seeds/chanter = 3,
		/obj/item/seeds/chili = 3,
		/obj/item/seeds/corn = 3,
		/obj/item/seeds/eggplant = 3,
		/obj/item/seeds/korta_nut = 3,
		/obj/item/seeds/onion = 3,
		/obj/item/seeds/potato = 3,
		/obj/item/seeds/poppy = 3,
		/obj/item/seeds/wheat/rice = 3,
		/obj/item/seeds/tomato = 3,
		/obj/item/seeds/watermelon = 3,
		/obj/item/seeds/wheat = 3,
	)
	contraband = list(
		/obj/item/seeds/amanita = 2,
		/obj/item/seeds/nettle = 2,
		/obj/item/seeds/plump = 2,
		/obj/item/seeds/reishi = 2,
		/obj/item/seeds/starthistle = 2,
	)
	premium = list(
		/obj/item/seeds/ambrosia/deus = 1
	)
	refill_canister = /obj/item/vending_refill/hydroseeds/prison
	default_price = PAYCHECK_PRISONER
	extra_price = PAYCHECK_ASSISTANT
	payment_department = ACCOUNT_PRS

/obj/item/vending_refill/hydroseeds/prison
	machine_name = "Prison MegaSeed Servitor"
	icon_state = "refill_plant"
