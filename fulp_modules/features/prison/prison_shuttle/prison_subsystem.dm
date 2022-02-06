/datum/controller/subsystem/shuttle
	/// The current prison shuttle's mobile docking port.
	var/obj/docking_port/mobile/prison/prison_shuttle
	///The stationary docking port, verifying we actually have a prison shuttle this round.
	var/obj/docking_port/stationary/prison/prison_stationary_shuttle

/datum/controller/subsystem/shuttle/Initialize(timeofday)
	. = ..()
	if(prison_stationary_shuttle)
		SSpermabrig.flags &= ~SS_NO_FIRE

#define PERMABRIG_SHUTTLE_OBJECTIVE_SUCCESS "Permabrig Success"
#define PERMABRIG_SHUTTLE_OBJECTIVE_FAILURE "Permabrig Failure"
#define PERMABRIG_SHUTTLE_OBJECTIVE_NEUTRAL "Permabrig Neutral"

#define SHUTTLE_DISPOSALS "Disposals Shuttle"
#define SHUTTLE_MAIL "Mail Shuttle"
#define SHUTTLE_BAR "Bar Shuttle"
#define SHUTTLE_PLATE_PRESS "Plate Pressing Shuttle"
#define SHUTTLE_CLEANUP "Cleanup Shuttle"
#define SHUTTLE_XENOBIOLOGY /datum/map_template/shuttle/prison/xenobiology
#define SHUTTLE_ROBOTICS "Robotics Shuttle"
#define SHUTTLE_ENGINEERING "Engineering Shuttle"


/**
 * Prison subsystem
 */

SUBSYSTEM_DEF(permabrig)
	name = "Permabrig"
	init_order = INIT_ORDER_SHUTTLE
	priority = FIRE_PRIORITY_PROCESS
	flags = SS_BACKGROUND | SS_NO_INIT | SS_NO_FIRE

	//wait a while because there's a cooldown regardless
	wait = 30 SECONDS

	///Cooldown for next shuttle to arrive
	COOLDOWN_DECLARE(shuttle_cooldown)
	///Min time between new visits
	var/min_time_between_shuttles = 2 MINUTES
	///Max time between new visits
	var/max_time_between_shuttles = 3 MINUTES
	///Was the shuttle objective completed?
	var/objective_status = PERMABRIG_SHUTTLE_OBJECTIVE_NEUTRAL
	///How much money is this objective worth? Gain on completion, lose on failure.
	var/objective_price = 500
	///Where players get dropped off if found on the shuttle after it departs.
	var/dropoff_area = /area/security/prison
	///Types of shuttle that will dock, each with a specific task to do
	var/list/shuttle_types = list(
		//Sorting through disposals and confiscating important items
//		SHUTTLE_DISPOSALS = 20,
		//Sorting through mail and sending them in the proper tube
//		SHUTTLE_MAIL = 20,
		//Making a certain drink
//		SHUTTLE_BAR = 15,
		//Pressing a stack of plates
//		SHUTTLE_PLATE_PRESS = 15,
		//Clean up a messy shuttle
//		SHUTTLE_CLEANUP = 15,
		//Getting a certain slime extract
		SHUTTLE_XENOBIOLOGY = 10,
		//Building a small Bot
//		SHUTTLE_ROBOTICS = 10,
		//Repair a certain thing (floors, platings, tables)
//		SHUTTLE_ENGINEERING = 5,
	)

/datum/controller/subsystem/permabrig/fire(resumed)
	if(!COOLDOWN_FINISHED(src, shuttle_cooldown) || prob(30)) //small chance CC forgets and gives you another 30 seconds.
		return
	COOLDOWN_START(src, shuttle_cooldown, rand(min_time_between_shuttles, max_time_between_shuttles))
	if(!SSshuttle.prison_shuttle)
		check_shuttle_start_condition()
		return
	check_shuttle_end_condition()

/datum/controller/subsystem/permabrig/proc/check_shuttle_start_condition()
	var/loaded_shuttle = pick_weight(shuttle_types)
	SSshuttle.prison_shuttle = new(SSshuttle.action_load(loaded_shuttle, SSshuttle.prison_stationary_shuttle, replace = TRUE))
	RegisterSignal(SSshuttle.prison_shuttle, COMSIG_PRISON_OBJECTIVE_COMPLETED, .proc/complete_objective)
	for(var/obj/item/radio/intercom/broadcaster_perma/broadcasters in GLOB.prison_broadcasters)
		broadcasters.say("The permabrig shuttle has now docked! Please complete the objective as soon as possible!")

/datum/controller/subsystem/permabrig/proc/check_shuttle_end_condition()
	UnregisterSignal(SSshuttle.prison_shuttle, COMSIG_PRISON_OBJECTIVE_COMPLETED)
	SSshuttle.prison_shuttle.intoTheSunset()
	var/obj/docking_port/mobile/prison/shuttle = SSshuttle.prison_shuttle
	QDEL_IN(shuttle, 10 SECONDS)

	var/list/area/shuttle/shuttle_areas = SSshuttle.prison_shuttle.shuttle_areas
	//Kick everyone off
	for(var/turf/open/floor/shuttle_turf in shuttle_areas)
		for(var/mob/passenger in shuttle_turf.get_all_contents())
			to_chat(passenger, span_notice("You fell off the shuttle!"))
			passenger.forceMove(pick(GLOB.areas_by_type[dropoff_area]))

	var/datum/bank_account/prison_account = SSeconomy.get_dep_account(ACCOUNT_PRISON)
	var/message
	if(!prison_account)
		CRASH("Subsystem [src] tried to add [objective_price] to a non existant prison account!")

	//Did we complete the objective?
	switch(objective_status)
		if(PERMABRIG_SHUTTLE_OBJECTIVE_SUCCESS)
			prison_account.adjust_money(objective_price)
			message = "Shuttle successfully left with the objective! [objective_price] has been deposited into the Prison account."
		if(PERMABRIG_SHUTTLE_OBJECTIVE_FAILURE || PERMABRIG_SHUTTLE_OBJECTIVE_NEUTRAL)
			prison_account.adjust_money(-objective_price)
			message = "Shuttle failed to leave with the objective. [objective_price] has been deducted from the Prison account."

	for(var/obj/item/radio/intercom/broadcaster_perma/broadcasters in GLOB.prison_broadcasters)
		broadcasters.say("[message]")

/**
 * complete_objective
 *
 * Sets the objective as completed, unless you've already failed it.
 */
/datum/controller/subsystem/permabrig/proc/complete_objective()
	SIGNAL_HANDLER
	if(objective_status == PERMABRIG_SHUTTLE_OBJECTIVE_FAILURE)
		return
	objective_status = PERMABRIG_SHUTTLE_OBJECTIVE_SUCCESS

/**
 * fail_objective
 *
 * Sets the objective to fail, unless you've already completed it.
 */
/datum/controller/subsystem/permabrig/proc/fail_objective()
	SIGNAL_HANDLER
	if(objective_status == PERMABRIG_SHUTTLE_OBJECTIVE_SUCCESS)
		return
	objective_status = PERMABRIG_SHUTTLE_OBJECTIVE_FAILURE

#undef SHUTTLE_ENGINEERING
#undef SHUTTLE_ROBOTICS
#undef SHUTTLE_XENOBIOLOGY
#undef SHUTTLE_CLEANUP
#undef SHUTTLE_PLATE_PRESS
#undef SHUTTLE_BAR
#undef SHUTTLE_MAIL
#undef SHUTTLE_DISPOSALS

#undef PERMABRIG_SHUTTLE_OBJECTIVE_SUCCESS
#undef PERMABRIG_SHUTTLE_OBJECTIVE_FAILURE
