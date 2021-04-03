/obj/machinery/vending/wallmed
	name = "\improper NanoMed"
	desc = "Wall-mounted Medical Equipment dispenser."
	icon_state = "wallmed"
	icon_deny = "wallmed-deny"
	density = FALSE
	products = list(/obj/item/reagent_containers/syringe = 3,
		            /obj/item/reagent_containers/pill/patch/libital = 5,
					/obj/item/reagent_containers/pill/patch/aiuri = 5,
					/obj/item/reagent_containers/pill/multiver = 2,
					/obj/item/reagent_containers/medigel/libital = 2,
					/obj/item/reagent_containers/medigel/aiuri = 2,
					/obj/item/reagent_containers/medigel/sterilizine = 1,
					/obj/item/healthanalyzer/wound = 2,
					/obj/item/stack/medical/bone_gel/four = 2)
	contraband = list(/obj/item/reagent_containers/pill/tox = 2,
	                  /obj/item/reagent_containers/pill/morphine = 2,
	                  /obj/item/storage/box/gum/happiness = 1)
	refill_canister = /obj/item/vending_refill/wallmed
	default_price = PAYCHECK_HARD //Double the medical price due to being meant for public consumption, not player specfic
	extra_price = PAYCHECK_HARD * 1.5
	payment_department = ACCOUNT_MED
	tiltable = FALSE
	light_mask = "wallmed-light-mask"

/obj/item/vending_refill/wallmed
	machine_name = "NanoMed"
	icon_state = "refill_medical"
