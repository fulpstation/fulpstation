/datum/controller/subsystem/shuttle
	/// The current prison shuttle's mobile docking port.
	var/obj/docking_port/mobile/prison/prison_shuttle
	///The stationary docking port, verifying we actually have a prison shuttle this round.
	var/obj/docking_port/stationary/prison/prison_stationary_shuttle

/datum/controller/subsystem/shuttle/Initialize(timeofday)
	. = ..()
	if(!prison_stationary_shuttle)
		SSpermabrig.flags |= SS_NO_FIRE

#define SHUTTLE_DISPOSALS "prison_disposals"
#define SHUTTLE_MAIL "prison_mailroom"
#define SHUTTLE_BAR "prison_bar"
#define SHUTTLE_KITCHEN "prison_kitchen"
#define SHUTTLE_BOTANY "prison_botany"
#define SHUTTLE_PLATE_PRESS "prison_platepress"
#define SHUTTLE_CLEANUP "prison_cleaning"
#define SHUTTLE_XENOBIOLOGY "prison_xenobio"

#define SHUTTLE_MIN_TIME (5.1 MINUTES)
#define SHUTTLE_MAX_TIME (6.1 MINUTES)
#define SHUTTLE_DELAY_TIME (8.1 MINUTES)

/**
 * Prison subsystem
 */
SUBSYSTEM_DEF(permabrig)
	name = "Permabrig"
	priority = FIRE_PRIORITY_PROCESS
	flags = SS_BACKGROUND

	//timer between intercom alerts
	wait = 1 MINUTES

	///The shuttle currently loaded.
	var/datum/map_template/shuttle/prison/loaded_shuttle
	///Cooldown for next shuttle to arrive
	COOLDOWN_DECLARE(shuttle_cooldown)
	///Types of shuttle that will dock, each with a specific task to do
	var/list/shuttle_types = list(
		SHUTTLE_DISPOSALS,
		SHUTTLE_MAIL,
		SHUTTLE_BAR,
		SHUTTLE_KITCHEN,
		SHUTTLE_BOTANY,
		SHUTTLE_PLATE_PRESS,
		SHUTTLE_CLEANUP,
		SHUTTLE_XENOBIOLOGY,
	)

/datum/controller/subsystem/permabrig/fire(resumed)
	if(!COOLDOWN_FINISHED(src, shuttle_cooldown))
		for(var/obj/item/radio/intercom/prison/broadcasters as anything in GLOB.prison_broadcasters)
			broadcasters.say("[round(COOLDOWN_TIMELEFT(src, shuttle_cooldown) / 600)] minutes until the permabrig shuttle [loaded_shuttle ? "leaves. Ensure the current objective has been completed before it departs." : "arrives"]")
		return
	if(!loaded_shuttle)
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
	COOLDOWN_START(src, shuttle_cooldown, rand(SHUTTLE_MIN_TIME, SHUTTLE_MAX_TIME))
	loaded_shuttle = pick(valid_shuttle_templates)
	SSshuttle.action_load(loaded_shuttle, SSshuttle.prison_stationary_shuttle, replace = TRUE)
	loaded_shuttle.special_start_objective()
	for(var/obj/item/radio/intercom/prison/broadcasters as anything in GLOB.prison_broadcasters)
		playsound(broadcasters, 'sound/machines/dotprinter.ogg', 20, TRUE)
		broadcasters.say("The permabrig shuttle has now docked! Please standby for your incoming message from Central Command...")
		broadcasters.say("[loaded_shuttle.explanation_text]")

/datum/controller/subsystem/permabrig/proc/check_shuttle_end_condition()
	loaded_shuttle.check_end_shuttle()

	var/datum/bank_account/prison_account = SSeconomy.get_dep_account(ACCOUNT_PRISON)
	if(!prison_account)
		CRASH("Subsystem [src] tried to add [loaded_shuttle.objective_price] to a non existant prison account!")
	COOLDOWN_START(src, shuttle_cooldown, SHUTTLE_DELAY_TIME)

	var/message
	var/sound
	//Did we complete the objective?
	switch(loaded_shuttle.objective_status)
		if(PERMABRIG_SHUTTLE_OBJECTIVE_SUCCESS)
			prison_account.adjust_money(loaded_shuttle.objective_price)
			message = "Shuttle successfully left with the objective! [loaded_shuttle.objective_price] has been deposited into the Prison budget."
			sound = 'sound/machines/synth_yes.ogg'
		if(PERMABRIG_SHUTTLE_OBJECTIVE_FAILURE)
			prison_account.adjust_money(-(loaded_shuttle.objective_price * 2))
			message = "Shuttle failed to leave with the objective. [loaded_shuttle.objective_price] has been deducted from the Prison budget."
			sound = 'sound/machines/synth_no.ogg'

	for(var/obj/item/radio/intercom/prison/broadcasters as anything in GLOB.prison_broadcasters)
		broadcasters.say("[message]")
		playsound(broadcasters, sound, 20, TRUE)

	SSshuttle.prison_shuttle.jumpToNullSpace()
	QDEL_NULL(loaded_shuttle)

#undef SHUTTLE_MIN_TIME
#undef SHUTTLE_MAX_TIME
#undef SHUTTLE_DELAY_TIME

#undef SHUTTLE_XENOBIOLOGY
#undef SHUTTLE_CLEANUP
#undef SHUTTLE_PLATE_PRESS
#undef SHUTTLE_BOTANY
#undef SHUTTLE_KITCHEN
#undef SHUTTLE_BAR
#undef SHUTTLE_MAIL
#undef SHUTTLE_DISPOSALS
