/obj/item/food/burger/catburger
	name = "Catburger	"
	desc = "Finally those catpeople are worth something!"
	icon = 'fulp_modules/things/food/icon/food.dmi'
	icon_state = "catburger"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/protein = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("bun" = 4, "meat" = 2, "cat" = 2)
	foodtypes = GRAIN | MEAT | GROSS

/obj/item/food/bread/sausage
	name = "sausagebread loaf"
	desc = "Dont think about it"
	icon = 'fulp_modules/things/food/icon/food.dmi'
	icon_state = "sausagebread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 10, /datum/reagent/consumable/nutriment/protein = 12)
	tastes = list("bread" = 10, "meat" = 10)
	foodtypes = GRAIN | MEAT

/obj/item/food/bread/sausage/MakeProcessable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/breadslice/sausage, 5, 30)

/obj/item/food/breadslice/sausage
	name = "sausagebread slice"
	desc = "A slice of delicious sausagebread."
	icon = 'fulp_modules/things/food/icon/food.dmi'
	icon_state = "sausagebreadslice"
	foodtypes = GRAIN | MEAT
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/nutriment/protein = 2.4)
	tastes = list("bread" = 10, "meat" = 10)

/obj/item/food/eggssausage
	name = "egg with sausage"
	desc = "Better than a single fried egg."
	icon = 'fulp_modules/things/food/icon/food.dmi'
	icon_state = "eggsausage"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 8, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/nutriment = 4)
	foodtypes = MEAT | FRIED | BREAKFAST
	tastes = list("egg" = 4, "meat" = 4)
