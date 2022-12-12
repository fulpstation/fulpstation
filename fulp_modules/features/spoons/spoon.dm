/obj/item/retractor/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/edible, \
		initial_reagents = list(/datum/reagent/iron = 1), \
		food_flags = FOOD_FINGER_FOOD, \
		foodtypes = RAW, \
		tastes = list("metal" = 2, "stupid" = 1), \
		bite_consumption = 1, \
		on_consume = CALLBACK(src, .proc/on_consume), \
	)

///:] - gives color if you're naive (like a clown).
/obj/item/retractor/proc/on_consume(mob/living/eater, mob/living/feeder)
	eater.manual_emote("smiles like :]")
	if(HAS_TRAIT(eater, TRAIT_NAIVE))
		eater.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY)
		eater.add_atom_colour(COLOR_VIVID_YELLOW, TEMPORARY_COLOUR_PRIORITY)
		eater.set_light_color(eater.color)
		addtimer(CALLBACK(src, .proc/remove_colors, eater), 15 SECONDS)

///Removes all colors
/obj/item/retractor/proc/remove_colors(mob/living/eater)
	eater.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY)
	eater.set_light_color(null)
