/datum/controller/subsystem/shuttle
	/// The current prison shuttle's mobile docking port.
	var/obj/docking_port/mobile/prison/prison_shuttle
	///The stationary docking port, verifying we actually have a prison shuttle this round.
	var/obj/docking_port/stationary/prison/prison_stationary_shuttle

/datum/controller/subsystem/shuttle/Initialize(timeofday)
	. = ..()
	if(prison_stationary_shuttle)
		addtimer(CALLBACK(src, .proc/start_permabrig), 8 MINUTES, TIMER_UNIQUE)

/datum/controller/subsystem/shuttle/proc/start_permabrig()
	SSpermabrig.flags &= ~SS_NO_FIRE
	SSpermabrig.fire()

#define SHUTTLE_DISPOSALS "prison_disposals"
//#define SHUTTLE_MAIL "Mail Shuttle"
#define SHUTTLE_BAR "prison_bar"
#define SHUTTLE_KITCHEN "prison_kitchen"
//#define SHUTTLE_PLATE_PRESS "Plate Pressing Shuttle"
//#define SHUTTLE_CLEANUP "Cleanup Shuttle"
#define SHUTTLE_XENOBIOLOGY "prison_xenobio"
//#define SHUTTLE_ROBOTICS "Robotics Shuttle"
//#define SHUTTLE_ENGINEERING "Engineering Shuttle"

/**
 * Prison subsystem
 */

SUBSYSTEM_DEF(permabrig)
	name = "Permabrig"
	priority = FIRE_PRIORITY_PROCESS
	flags = SS_BACKGROUND | SS_NO_INIT | SS_NO_FIRE

	//timer between intercom alerts
	wait = 15 SECONDS //1 MINUTES

	///Cooldown for next shuttle to arrive
	COOLDOWN_DECLARE(shuttle_cooldown)
	///Min time between new visits
	var/min_time_between_shuttles = 8 MINUTES
	///Max time between new visits
	var/max_time_between_shuttles = 10 MINUTES
	///The shuttle currently loaded.
	var/datum/map_template/shuttle/prison/loaded_shuttle
	///Types of shuttle that will dock, each with a specific task to do
	var/list/shuttle_types = list(
		SHUTTLE_DISPOSALS,
		//Sorting through mail and sending them in the proper tube
//		SHUTTLE_MAIL,
		SHUTTLE_BAR,
		SHUTTLE_KITCHEN
		//Pressing a stack of plates
//		SHUTTLE_PLATE_PRESS,
		//Clean up a messy shuttle
//		SHUTTLE_CLEANUP,
		SHUTTLE_XENOBIOLOGY,
		//Building a small Bot
//		SHUTTLE_ROBOTICS,
		//Repair a certain thing (floors, platings, tables)
//		SHUTTLE_ENGINEERING,
	)

/datum/controller/subsystem/permabrig/fire(resumed)
	if(!COOLDOWN_FINISHED(src, shuttle_cooldown))
		for(var/obj/item/radio/intercom/prison/broadcasters as anything in GLOB.prison_broadcasters)
			broadcasters.say("[round(COOLDOWN_TIMELEFT(src, shuttle_cooldown) / 600)] minutes until the permabrig shuttle [SSshuttle.prison_shuttle ? "leaves. Ensure the current objective has been completed before it departs." : "arrives"]")
			return
	COOLDOWN_START(src, shuttle_cooldown, rand(min_time_between_shuttles, max_time_between_shuttles))
	if(!SSshuttle.prison_shuttle)
		check_shuttle_start_condition()
		return
	check_shuttle_end_condition()

/datum/controller/subsystem/permabrig/proc/check_shuttle_start_condition()
	SSshuttle.unload_preview()
	var/list/valid_shuttle_templates = list()
	for(var/shuttle_id in SSmapping.shuttle_templates)
		var/datum/map_template/shuttle/template = SSmapping.shuttle_templates[shuttle_id]
		if(shuttle_id in shuttle_types)
			valid_shuttle_templates += template
	loaded_shuttle = pick(valid_shuttle_templates)
	SSshuttle.action_load(loaded_shuttle, SSshuttle.prison_stationary_shuttle, replace = TRUE)

	for(var/obj/item/radio/intercom/prison/broadcasters as anything in GLOB.prison_broadcasters)
		broadcasters.say("The permabrig shuttle has now docked! Please complete the objective as soon as possible!")

/datum/controller/subsystem/permabrig/proc/check_shuttle_end_condition()
	loaded_shuttle.check_end_shuttle()

	var/datum/bank_account/prison_account = SSeconomy.get_dep_account(ACCOUNT_PRISON)
	var/message
	if(!prison_account)
		CRASH("Subsystem [src] tried to add [loaded_shuttle.objective_price] to a non existant prison account!")

	//Did we complete the objective?
	switch(loaded_shuttle.objective_status)
		if(PERMABRIG_SHUTTLE_OBJECTIVE_SUCCESS)
			prison_account.adjust_money(loaded_shuttle.objective_price)
			message = "Shuttle successfully left with the objective! [loaded_shuttle.objective_price] has been deposited into the Prison budget."
		if(PERMABRIG_SHUTTLE_OBJECTIVE_FAILURE)
			prison_account.adjust_money(-loaded_shuttle.objective_price)
			message = "Shuttle failed to leave with the objective. [loaded_shuttle.objective_price] has been deducted from the Prison budget."

	for(var/obj/item/radio/intercom/prison/broadcasters as anything in GLOB.prison_broadcasters)
		broadcasters.say("[message]")

	SSshuttle.prison_shuttle.jumpToNullSpace()

//#undef SHUTTLE_ENGINEERING
//#undef SHUTTLE_ROBOTICS
#undef SHUTTLE_XENOBIOLOGY
//#undef SHUTTLE_CLEANUP
//#undef SHUTTLE_PLATE_PRESS
#undef SHUTTLE_KITCHEN
#undef SHUTTLE_BAR
//#undef SHUTTLE_MAIL
#undef SHUTTLE_DISPOSALS
