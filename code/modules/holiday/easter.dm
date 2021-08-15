/datum/round_event_control/easter
	name = "Easter Eggselence"
	holidayID = EASTER
	typepath = /datum/round_event/easter
	weight = -1
	max_occurrences = 1
	earliest_start = 0 MINUTES

/datum/round_event/easter/announce(fake)
	priority_announce(pick("Hip-hop into Easter!","Find some Bunny's stash!","Today is National 'Hunt a Wabbit' Day.","Be kind, give Chocolate Eggs!"))


/datum/round_event_control/rabbitrelease
	name = "Release the Rabbits!"
	holidayID = EASTER
	typepath = /datum/round_event/rabbitrelease
	weight = 5
	max_occurrences = 10

/datum/round_event/rabbitrelease/announce(fake)
	priority_announce("Unidentified furry objects detected coming aboard [station_name()]. Beware of Adorable-ness.", "Fluffy Alert", ANNOUNCER_ALIENS)


/datum/round_event/rabbitrelease/start()
	for(var/obj/effect/landmark/R in GLOB.landmarks_list)
		if(R.name != "blobspawn")
			if(prob(35))
				if(isspaceturf(R.loc))
					new /mob/living/simple_animal/rabbit/space(R.loc)
				else
					new /mob/living/simple_animal/rabbit(R.loc)

/mob/living/simple_animal/rabbit
	name = "\improper rabbit"
	desc = "The hippiest hop around."
	gender = PLURAL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	health = 15
	maxHealth = 15
	icon = 'icons/mob/easter.dmi'
	icon_state = "rabbit_white"
	icon_living = "rabbit_white"
	icon_dead = "rabbit_white_dead"
	speak = list("Hop into Easter!","Come get your eggs!","Prizes for everyone!")
	speak_emote = list("sniffles","twitches")
	emote_hear = list("hops.")
	emote_see = list("hops around","bounces up and down")
	butcher_results = list(/obj/item/food/meat/slab = 1)
	can_be_held = TRUE
	density = FALSE
	speak_chance = 2
	turns_per_move = 3
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	gold_core_spawnable = FRIENDLY_SPAWN
	///passed to animal_variety component as the prefix icon.
	var/icon_prefix = "rabbit"
	///passed to egg_layer component as how many eggs it starts out as able to lay.
	var/initial_egg_amount = 10

/mob/living/simple_animal/rabbit/Initialize()
	. = ..()
	AddElement(/datum/element/pet_bonus, "hops around happily!")
	AddElement(/datum/element/animal_variety, icon_prefix, pick("brown","black","white"), TRUE)
	var/list/feed_messages = list("[p_they()] nibbles happily.", "[p_they()] noms happily.")
	var/eggs_added_from_eating = rand(1, 4)
	var/max_eggs_held = 8
	AddComponent(/datum/component/egg_layer,\
		/obj/item/food/egg/loaded,\
		list(/obj/item/food/grown/carrot),\
		feed_messages,\
		list("hides an egg.","scampers around suspiciously.","begins making a huge racket.","begins shuffling."),\
		initial_egg_amount,\
		eggs_added_from_eating,\
		max_eggs_held\
	)

/mob/living/simple_animal/rabbit/empty //top hats summon these kinds of rabbits instead of the normal kind
	initial_egg_amount = 0

/mob/living/simple_animal/rabbit/space
	icon_state = "s_rabbit_white"
	icon_living = "s_rabbit_white"
	icon_dead = "s_rabbit_white_dead"
	icon_prefix = "s_rabbit"
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	unsuitable_atmos_damage = 0

//Easter Baskets
/obj/item/storage/basket/easter
	name = "Easter Basket"

/obj/item/storage/basket/easter/Initialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.set_holdable(list(/obj/item/food/egg, /obj/item/food/chocolateegg, /obj/item/food/boiledegg))

/obj/item/storage/basket/easter/proc/countEggs()
	cut_overlays()
	add_overlay("basket-grass")
	add_overlay("basket-egg[min(contents.len, 5)]")

/obj/item/storage/basket/easter/Exited(atom/movable/gone, direction)
	. = ..()
	countEggs()

/obj/item/storage/basket/easter/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	countEggs()

//Bunny Suit
/obj/item/clothing/head/bunnyhead
	name = "Easter Bunny Head"
	icon_state = "bunnyhead"
	inhand_icon_state = "bunnyhead"
	desc = "Considerably more cute than 'Frank'."
	slowdown = -0.3
	clothing_flags = THICKMATERIAL | SNUG_FIT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/suit/bunnysuit
	name = "Easter Bunny Suit"
	desc = "Hop Hop Hop!"
	icon_state = "bunnysuit"
	inhand_icon_state = "bunnysuit"
	slowdown = -0.3
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

//Bunny bag!
/obj/item/storage/backpack/satchel/bunnysatchel
	name = "Easter Bunny Satchel"
	desc = "Good for your eyes."
	icon_state = "satchel_carrot"
	inhand_icon_state = "satchel_carrot"

//Egg prizes and egg spawns!
/obj/item/food/egg
	var/containsPrize = FALSE

/obj/item/food/egg/loaded
	containsPrize = TRUE

/obj/item/food/egg/loaded/Initialize()
	. = ..()
	var/eggcolor = pick("blue","green","mime","orange","purple","rainbow","red","yellow")
	icon_state = "egg-[eggcolor]"

/obj/item/food/egg/proc/dispensePrize(turf/where)
	var/prize_list = list(/obj/item/clothing/head/bunnyhead,
		/obj/item/clothing/suit/bunnysuit,
		/obj/item/storage/backpack/satchel/bunnysatchel,
		/obj/item/food/grown/carrot,
		/obj/item/toy/balloon,
		/obj/item/toy/gun,
		/obj/item/toy/sword,
		/obj/item/toy/talking/ai,
		/obj/item/toy/talking/owl,
		/obj/item/toy/talking/griffin,
		/obj/item/toy/minimeteor,
		/obj/item/toy/clockwork_watch,
		/obj/item/toy/toy_xeno,
		/obj/item/toy/foamblade,
		/obj/item/toy/plush/carpplushie,
		/obj/item/toy/redbutton,
		/obj/item/toy/windup_toolbox,
		/obj/item/clothing/head/collectable/rabbitears
		) + subtypesof(/obj/item/toy/mecha)
	var/won = pick(prize_list)
	new won(where)
	new/obj/item/food/chocolateegg(where)

/obj/item/food/egg/attack_self(mob/user)
	..()
	if(containsPrize)
		to_chat(user, span_notice("You unwrap [src] and find a prize inside!"))
		dispensePrize(get_turf(user))
		containsPrize = FALSE
		qdel(src)

//Easter Recipes + food
/obj/item/food/hotcrossbun
	name = "hot cross bun"
	desc = "The cross represents the Assistants that died for your sins."
	icon_state = "hotcrossbun"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/sugar = 1)
	foodtypes = SUGAR | GRAIN | BREAKFAST
	tastes = list("pastry" = 1, "easter" = 1)
	bite_consumption = 2

/datum/crafting_recipe/food/hotcrossbun
	name = "Hot Cross Bun"
	reqs = list(
		/obj/item/food/breadslice/plain = 1,
		/datum/reagent/consumable/sugar = 1
	)
	result = /obj/item/food/hotcrossbun

	subcategory = CAT_BREAD

/datum/crafting_recipe/food/briochecake
	name = "Brioche cake"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/datum/reagent/consumable/sugar = 2
	)
	result = /obj/item/food/cake/brioche
	subcategory = CAT_MISCFOOD

/obj/item/food/scotchegg
	name = "scotch egg"
	desc = "A boiled egg wrapped in a delicious, seasoned meatball."
	icon_state = "scotchegg"
	bite_consumption = 3
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)

/datum/crafting_recipe/food/scotchegg
	name = "Scotch egg"
	reqs = list(
		/datum/reagent/consumable/salt = 1,
		/datum/reagent/consumable/blackpepper = 1,
		/obj/item/food/boiledegg = 1,
		/obj/item/food/meatball = 1
	)
	result = /obj/item/food/scotchegg
	subcategory = CAT_EGG

/datum/crafting_recipe/food/mammi
	name = "Mammi"
	reqs = list(
		/obj/item/food/bread/plain = 1,
		/obj/item/food/chocolatebar = 1,
		/datum/reagent/consumable/milk = 5
	)
	result = /obj/item/food/soup/mammi
	subcategory = CAT_MISCFOOD

/obj/item/food/chocolatebunny
	name = "chocolate bunny"
	desc = "Contains less than 10% real rabbit!"
	icon_state = "chocolatebunny"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/coco = 2, /datum/reagent/consumable/nutriment/vitamin = 1)

/datum/crafting_recipe/food/chocolatebunny
	name = "Chocolate bunny"
	reqs = list(
		/datum/reagent/consumable/sugar = 2,
		/obj/item/food/chocolatebar = 1
	)
	result = /obj/item/food/chocolatebunny
	subcategory = CAT_MISCFOOD
