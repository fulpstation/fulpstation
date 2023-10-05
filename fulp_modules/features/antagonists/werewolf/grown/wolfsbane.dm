/obj/item/seeds/poppy/wolfsbane
	name = "pack of wolf's bane seeds"
	desc = "These seeds grow into wolf's bane"
	product = /obj/item/food/grown/wolfsbane
	// species = "wolfsbane"
	plantname = "Wolf's bane plants"
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.05, /datum/reagent/toxin/aconitine = 0.2)
	mutatelist = list()
	yield = 3


/obj/item/food/grown/wolfsbane
	seed = /obj/item/seeds/poppy/wolfsbane
	name = "wolf's bane"
	desc = "A toxic plant with beautiful purple flowers. Werewolves hate this stuff."

