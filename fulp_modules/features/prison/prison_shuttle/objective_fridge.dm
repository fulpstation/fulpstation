/obj/machinery/smartfridge/prison
	name = "smart prison storage"
	desc = "A refrigerated storage unit to place your objective."
	flags_1 = NODECONSTRUCT_1
	///This ship's current objective
	var/obj/item/station_objective
	///How many objectives have to be done for this objective to be "complete"
	var/objectives_required = 1
	///Whether we completed the objective yet or not
	var/objective_completed = FALSE
	///Whether we prevent parent from saying things upon load() and dispense()
	var/no_text = FALSE
	///Randomly selected objective is chosen from this list
	var/list/possible_objectives = list()

/obj/machinery/smartfridge/prison/examine(mob/user)
	. = ..()
	if(station_objective)
		. += span_notice("The fridge indicates[objectives_required > 1 ? " [objectives_required] of" : ""] [station_objective.name] is its objective.")

/obj/machinery/smartfridge/prison/Initialize(mapload)
	. = ..()
	station_objective = pick(possible_objectives)

/obj/machinery/smartfridge/prison/accept_check(obj/item/inserted_object)
	if(!istype(inserted_object, station_objective))
		say("This item is not allowed! Only [station_objective.name] count towards your objective!")
		return FALSE
	return TRUE

/obj/machinery/smartfridge/prison/load(obj/item/inserted_object)
	if(no_text)
		return ..()
	if(objective_completed)
		say("You have already completed the objective!")
		return
	objectives_required--
	if(!objectives_required)
		say("Objective completed! Thank you for your work, Prisoner!")
		SEND_SIGNAL(SSpermabrig.loaded_shuttle, COMSIG_PRISON_OBJECTIVE_COMPLETED)
		objective_completed = TRUE
	return ..()

/obj/machinery/smartfridge/prison/dispense(obj/item/inserted_object, mob/user)
	if(no_text)
		return ..()
	objectives_required++
	if(objectives_required)
		say("Objective removed! Objective no longer considered completed.")
		SEND_SIGNAL(SSpermabrig.loaded_shuttle, COMSIG_PRISON_OBJECTIVE_FAILED)
		objective_completed = FALSE
	return ..()

/**
 * # Xenobiology shuttle
 */
/obj/machinery/smartfridge/prison/xenobiology
	name = "smart prison slime extract storage"
	desc = "A refrigerated storage unit to place your objective slime extract."
	possible_objectives = list(
		/obj/item/slime_extract/orange,
		/obj/item/slime_extract/purple,
		/obj/item/slime_extract/blue,
		/obj/item/slime_extract/metal,
		/obj/item/slime_extract/yellow,
		/obj/item/slime_extract/silver,
	)

/**
 * # Bar shuttle
 */
/obj/machinery/smartfridge/prison/bar
	name = "smart prison drink storage"
	var/datum/reagent/drink_objective
	possible_objectives = list(
		/datum/reagent/consumable/ethanol/quadruple_sec,
		/datum/reagent/consumable/ethanol/bloody_mary,
		/datum/reagent/consumable/ethanol/irishcarbomb,
		/datum/reagent/consumable/ethanol/screwdrivercocktail,
		/datum/reagent/consumable/ethanol/syndicatebomb,
		/datum/reagent/consumable/ethanol/pruno,
	)

/obj/machinery/smartfridge/prison/bar/examine(mob/user)
	. = ..()
	if(drink_objective)
		. += span_notice("The fridge indicates[objectives_required > 1 ? " [objectives_required] of" : ""] [initial(drink_objective.name)] is its objective.")

/obj/machinery/smartfridge/prison/bar/Initialize(mapload)
	. = ..()
	drink_objective = pick(possible_objectives)
	station_objective = null

/obj/machinery/smartfridge/prison/bar/accept_check(obj/item/inserted_object)
	if(!istype(inserted_object, /obj/item/reagent_containers/food/drinks))
		say("Only drinks with at least [VENUE_BAR_MINIMUM_REAGENTS] units of [initial(drink_objective.name)] count towards your objective!")
		return FALSE
	var/obj/item/reagent_containers/food/drinks/potential_drink = inserted_object
	if(!potential_drink.reagents.has_reagent(drink_objective, VENUE_BAR_MINIMUM_REAGENTS))
		say("Only drinks with at least [VENUE_BAR_MINIMUM_REAGENTS] units of [initial(drink_objective.name)] count towards your objective!")
		return FALSE
	return TRUE

/**
 * # Disposals shuttle
 */
/obj/machinery/smartfridge/prison/disposal
	name = "important documents storage"
	objectives_required = 3
	no_text = TRUE
	possible_objectives = list(
		/obj/item/paper,
	)

/obj/machinery/smartfridge/prison/disposal/load(obj/item/inserted_object)
	if(istype(inserted_object, /obj/item/paper/prison_paperwork))
		objectives_required--

	playsound(src, 'sound/machines/ping.ogg', 20, TRUE)
	if(!objectives_required)
		SEND_SIGNAL(SSpermabrig.loaded_shuttle, COMSIG_PRISON_OBJECTIVE_COMPLETED)
		objective_completed = TRUE
	return ..()

/obj/machinery/smartfridge/prison/disposal/dispense(obj/item/inserted_object, mob/user)
	if(istype(inserted_object, /obj/item/paper/prison_paperwork))
		objectives_required++
	if(objectives_required)
		objective_completed = FALSE
	return ..()
