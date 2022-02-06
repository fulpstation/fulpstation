/**
 * # Xenobiology shuttle
 */
/obj/machinery/smartfridge/extract/prison
	name = "smart prison slime extract storage"
	desc = "A refrigerated storage unit to place your objective slime extract."
	flags_1 = NODECONSTRUCT_1
	var/objective_completed = FALSE
	///This slime fridge's current objective
	var/obj/item/slime_extract/slime_objective
	///List of all slimes you can obtain as your objective
	var/list/possible_slimes = list(
		/obj/item/slime_extract/orange,
		/obj/item/slime_extract/purple,
		/obj/item/slime_extract/blue,
		/obj/item/slime_extract/metal,
		/obj/item/slime_extract/yellow,
		/obj/item/slime_extract/silver,
	)

/obj/machinery/smartfridge/extract/prison/Initialize(mapload)
	. = ..()
	slime_objective = pick(possible_slimes)

/obj/machinery/smartfridge/extract/prison/examine(mob/user)
	. = ..()
	if(slime_objective)
		. += span_notice("The fridge indicates the slime objective is [slime_objective.name].")

/obj/machinery/smartfridge/extract/prison/accept_check(obj/item/inserted_object)
	if(!istype(inserted_object, slime_objective))
		say("This item is not allowed! Only [slime_objective.name] extracts count towards your objective!")
		return FALSE
	return TRUE

/obj/machinery/smartfridge/extract/prison/load(obj/item/O)
	if(objective_completed)
		say("You have already completed the objective!")
		return
	say("Objective completed! Thank you for your work, Prisoner!")
	SEND_SIGNAL(SSpermabrig.loaded_shuttle, COMSIG_PRISON_OBJECTIVE_COMPLETED)
	objective_completed = TRUE
	return ..()

/obj/machinery/smartfridge/extract/prison/dispense(obj/item/O, mob/M)
	say("Objective removed! Objective no longer considered completed.")
	SEND_SIGNAL(SSpermabrig.loaded_shuttle, COMSIG_PRISON_OBJECTIVE_FAILED)
	objective_completed = FALSE
	return ..()
