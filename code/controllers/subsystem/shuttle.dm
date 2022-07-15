#define MAX_TRANSIT_REQUEST_RETRIES 10

SUBSYSTEM_DEF(shuttle)
	name = "Shuttle"
	wait = 1 SECONDS
	init_order = INIT_ORDER_SHUTTLE
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_GAME

	/// A list of all the mobile docking ports.
	var/list/mobile_docking_ports = list()
	/// A list of all the stationary docking ports.
	var/list/stationary_docking_ports = list()
	/// A list of all the beacons that can be docked to.
	var/list/beacon_list = list()
	/// A list of all the transit docking ports.
	var/list/transit_docking_ports = list()

	/// Now it's only for ID generation in /obj/docking_port/mobile/register()
	var/list/assoc_mobile = list()
	/// Now it's only for ID generation in /obj/docking_port/stationary/register()
	var/list/assoc_stationary = list()

	/// A list of all the mobile docking ports currently requesting a spot in hyperspace.
	var/list/transit_requesters = list()
	/// An associative list of the mobile docking ports that have failed a transit request, with the amount of times they've actually failed that transit request, up to MAX_TRANSIT_REQUEST_RETRIES
	var/list/transit_request_failures = list()

	/**
	 * Emergency shuttle stuff
	 */

	/// The mobile docking port of the emergency shuttle.
	var/obj/docking_port/mobile/emergency/emergency
	/// The mobile docking port of the arrivals shuttle.
	var/obj/docking_port/mobile/arrivals/arrivals
	/// The mobile docking port of the backup emergency shuttle.
	var/obj/docking_port/mobile/emergency/backup/backup_shuttle
	/// Time taken for emergency shuttle to reach the station when called (in deciseconds).
	var/emergency_call_time = 10 MINUTES
	/// Time taken for emergency shuttle to leave again once it has docked (in deciseconds).
	var/emergency_dock_time = 3 MINUTES
	/// Time taken for emergency shuttle to reach a safe distance after leaving station (in deciseconds).
	var/emergency_escape_time = 2 MINUTES
	/// Where was the emergency shuttle last called from?
	var/area/emergency_last_call_loc
	/// How many times was the escape shuttle called?
	var/emergencyCallAmount = 0
	/// Is the departure of the shuttle currently prevented? FALSE for no, any other number for yes (thanks shuttle code).
	var/emergency_no_escape = FALSE
	/// Do we prevent the recall of the shuttle?
	var/emergency_no_recall = FALSE
	/// Did admins force-prevent the recall of the shuttle?
	var/admin_emergency_no_recall = FALSE
	/// Previous mode of the shuttle before it was forcefully disabled by admins.
	var/last_mode = SHUTTLE_IDLE
	/// Previous time left to the call, only useful for disabling and re-enabling the shuttle for admins so it doesn't have to start the whole timer again.
	var/last_call_time = 10 MINUTES

	/// Things blocking escape shuttle from leaving.
	var/list/hostile_environments = list()

	/**
	 * Supply shuttle stuff
	 */

	/// The current cargo shuttle's mobile docking port.
	var/obj/docking_port/mobile/supply/supply
	/// Order number given to next order.
	var/order_number = 1
	/// Number of trade-points we have (basically money).
	var/points = 5000
	/// Remarks from CentCom on how well you checked the last order.
	var/centcom_message = ""
	/// Typepaths for unusual plants we've already sent CentCom, associated with their potencies.
	var/list/discovered_plants = list()

	/// Things blocking the cargo shuttle from leaving.
	var/list/trade_blockade = list()
	/// Is the cargo shuttle currently blocked from leaving?
	var/supply_blocked = FALSE

	/// All of the possible supply packs that can be purchased by cargo.
	var/list/supply_packs = list()

	/// Queued supplies to be purchased for the chef.
	var/list/chef_groceries = list()

	/// Queued supply packs to be purchased.
	var/list/shopping_list = list()

	/// Wishlist items made by crew for cargo to purchase at their leisure.
	var/list/request_list = list()

	/// A listing of previously delivered supply packs.
	var/list/order_history = list()

	/// A list of job accesses that are able to purchase any shuttles.
	var/list/has_purchase_shuttle_access

	/// All turfs hidden from navigation computers associated with a list containing the image hiding them and the type of the turf they are pretending to be
	var/list/hidden_shuttle_turfs = list()
	/// Only the images from the [/datum/controller/subsystem/shuttle/hidden_shuttle_turfs] list.
	var/list/hidden_shuttle_turf_images = list()

	/// The current shuttle loan event, if any.
	var/datum/round_event/shuttle_loan/shuttle_loan

	/// If the event happens where the crew can purchase shuttle insurance, catastrophe can't run.
	var/shuttle_insurance = FALSE
	// If the station has purchased a replacement escape shuttle this round.
	var/shuttle_purchased = SHUTTLEPURCHASE_PURCHASABLE
	/// For keeping track of ingame events that would unlock new shuttles, such as defeating a boss or discovering a secret item.
	var/list/shuttle_purchase_requirements_met = list()

	/// Disallow transit after nuke goes off
	var/lockdown = FALSE

	/// The currently selected shuttle map_template in the shuttle manipulator's template viewer.
	var/datum/map_template/shuttle/selected

	/// The existing shuttle associated with the selected shuttle map_template.
	var/obj/docking_port/mobile/existing_shuttle

	/// The shuttle map_template of the shuttle we want to preview.
	var/datum/map_template/shuttle/preview_template
	/// The docking port associated to the preview_template that's currently being previewed.
	var/obj/docking_port/mobile/preview_shuttle

	/// The turf reservation for the current previewed shuttle.
	var/datum/turf_reservation/preview_reservation

	/// Are we currently in the process of loading a shuttle? Useful to ensure we don't load more than one at once, to avoid weird inconsistencies and possible runtimes.
	var/shuttle_loading
	/// Did the supermatter start a cascade event?
	var/supermatter_cascade = FALSE

/datum/controller/subsystem/shuttle/Initialize(timeofday)
	order_number = rand(1, 9000)

	var/list/pack_processing = subtypesof(/datum/supply_pack)
	while(length(pack_processing))
		var/datum/supply_pack/pack = pack_processing[length(pack_processing)]
		pack_processing.len--
		if(ispath(pack, /datum/supply_pack))
			pack = new pack

		var/list/generated_packs = pack.generate_supply_packs()
		if(generated_packs)
			pack_processing += generated_packs
			continue

		if(!pack.contains)
			continue

		supply_packs[pack.id] = pack

	setup_shuttles(stationary_docking_ports)
	has_purchase_shuttle_access = init_has_purchase_shuttle_access()

	if(!arrivals)
		log_mapping("No /obj/docking_port/mobile/arrivals placed on the map!")
	if(!emergency)
		log_mapping("No /obj/docking_port/mobile/emergency placed on the map!")
	if(!backup_shuttle)
		log_mapping("No /obj/docking_port/mobile/emergency/backup placed on the map!")
	if(!supply)
		log_mapping("No /obj/docking_port/mobile/supply placed on the map!")
	return ..()

/datum/controller/subsystem/shuttle/proc/setup_shuttles(list/stationary)
	for(var/obj/docking_port/stationary/port as anything in stationary)
		port.load_roundstart()
		CHECK_TICK

/datum/controller/subsystem/shuttle/fire()
	for(var/thing in mobile_docking_ports)
		if(!thing)
			mobile_docking_ports.Remove(thing)
			continue
		var/obj/docking_port/mobile/P = thing
		P.check()
	for(var/thing in transit_docking_ports)
		var/obj/docking_port/stationary/transit/T = thing
		if(!T.owner)
			qdel(T, force=TRUE)
		// This next one removes transit docks/zones that aren't
		// immediately being used. This will mean that the zone creation
		// code will be running a lot.
		var/obj/docking_port/mobile/owner = T.owner
		if(owner)
			var/idle = owner.mode == SHUTTLE_IDLE
			var/not_centcom_evac = owner.launch_status == NOLAUNCH
			var/not_in_use = (!T.get_docked())
			if(idle && not_centcom_evac && not_in_use)
				qdel(T, force=TRUE)
	CheckAutoEvac()

	if(!SSmapping.clearing_reserved_turfs)
		while(transit_requesters.len)
			var/requester = popleft(transit_requesters)
			var/success = generate_transit_dock(requester)
			if(!success) // BACK OF THE QUEUE
				transit_request_failures[requester]++
				if(transit_request_failures[requester] < MAX_TRANSIT_REQUEST_RETRIES)
					transit_requesters += requester
				else
					var/obj/docking_port/mobile/M = requester
					M.transit_failure()
			if(MC_TICK_CHECK)
				break

/datum/controller/subsystem/shuttle/proc/CheckAutoEvac()
	if(emergency_no_escape || admin_emergency_no_recall || emergency_no_recall || !emergency || !SSticker.HasRoundStarted())
		return

	var/threshold = CONFIG_GET(number/emergency_shuttle_autocall_threshold)
	if(!threshold)
		return

	var/alive = 0
	for(var/I in GLOB.player_list)
		var/mob/M = I
		if(M.stat != DEAD)
			++alive

	var/total = GLOB.joined_player_list.len
	if(total <= 0)
		return //no players no autoevac

	if(alive / total <= threshold)
		var/msg = "Automatically dispatching emergency shuttle due to crew death."
		message_admins(msg)
		log_shuttle("[msg] Alive: [alive], Roundstart: [total], Threshold: [threshold]")
		emergency_no_recall = TRUE
		priority_announce("Catastrophic casualties detected: crisis shuttle protocols activated - jamming recall signals across all frequencies.")
		if(emergency.timeLeft(1) > emergency_call_time * 0.4)
			emergency.request(null, set_coefficient = 0.4)

/datum/controller/subsystem/shuttle/proc/block_recall(lockout_timer)
	if(admin_emergency_no_recall)
		priority_announce("Error!", "Emergency Shuttle Uplink Alert", 'sound/misc/announce_dig.ogg')
		addtimer(CALLBACK(src, .proc/unblock_recall), lockout_timer)
		return
	emergency_no_recall = TRUE
	addtimer(CALLBACK(src, .proc/unblock_recall), lockout_timer)

/datum/controller/subsystem/shuttle/proc/unblock_recall()
	if(admin_emergency_no_recall)
		priority_announce("Error!", "Emergency Shuttle Uplink Alert", 'sound/misc/announce_dig.ogg')
		return
	emergency_no_recall = FALSE

/datum/controller/subsystem/shuttle/proc/getShuttle(id)
	for(var/obj/docking_port/mobile/M in mobile_docking_ports)
		if(M.id == id)
			return M
	WARNING("couldn't find shuttle with id: [id]")

/datum/controller/subsystem/shuttle/proc/getDock(id)
	for(var/obj/docking_port/stationary/S in stationary_docking_ports)
		if(S.id == id)
			return S
	WARNING("couldn't find dock with id: [id]")

/// Check if we can call the evac shuttle.
/// Returns TRUE if we can. Otherwise, returns a string detailing the problem.
/datum/controller/subsystem/shuttle/proc/canEvac(mob/user)
	var/srd = CONFIG_GET(number/shuttle_refuel_delay)
	if(world.time - SSticker.round_start_time < srd)
		return "The emergency shuttle is refueling. Please wait [DisplayTimeText(srd - (world.time - SSticker.round_start_time))] before attempting to call."

	switch(emergency.mode)
		if(SHUTTLE_RECALL)
			return "The emergency shuttle may not be called while returning to CentCom."
		if(SHUTTLE_CALL)
			return "The emergency shuttle is already on its way."
		if(SHUTTLE_DOCKED)
			return "The emergency shuttle is already here."
		if(SHUTTLE_IGNITING)
			return "The emergency shuttle is firing its engines to leave."
		if(SHUTTLE_ESCAPE)
			return "The emergency shuttle is moving away to a safe distance."
		if(SHUTTLE_STRANDED)
			return "The emergency shuttle has been disabled by CentCom."

	return TRUE

/datum/controller/subsystem/shuttle/proc/requestEvac(mob/user, call_reason)
	if(!emergency)
		WARNING("requestEvac(): There is no emergency shuttle, but the \
			shuttle was called. Using the backup shuttle instead.")
		if(!backup_shuttle)
			CRASH("requestEvac(): There is no emergency shuttle, \
			or backup shuttle! The game will be unresolvable. This is \
			possibly a mapping error, more likely a bug with the shuttle \
			manipulation system, or badminry. It is possible to manually \
			resolve this problem by loading an emergency shuttle template \
			manually, and then calling register() on the mobile docking port. \
			Good luck.")
		emergency = backup_shuttle

	var/can_evac_or_fail_reason = SSshuttle.canEvac(user)
	if(can_evac_or_fail_reason != TRUE)
		to_chat(user, span_alert("[can_evac_or_fail_reason]"))
		return

	call_reason = trim(html_encode(call_reason))

	if(length(call_reason) < CALL_SHUTTLE_REASON_LENGTH && SSsecurity_level.get_current_level_as_number() > SEC_LEVEL_GREEN)
		to_chat(user, span_alert("You must provide a reason."))
		return

	var/area/signal_origin = get_area(user)
	var/emergency_reason = "\nNature of emergency:\n\n[call_reason]"
	var/security_num = SSsecurity_level.get_current_level_as_number()
	switch(security_num)
		if(SEC_LEVEL_RED,SEC_LEVEL_DELTA)
			emergency.request(null, signal_origin, html_decode(emergency_reason), 1) //There is a serious threat we gotta move no time to give them five minutes.
		else
			emergency.request(null, signal_origin, html_decode(emergency_reason), 0)

	var/datum/radio_frequency/frequency = SSradio.return_frequency(FREQ_STATUS_DISPLAYS)

	if(!frequency)
		return

	var/datum/signal/status_signal = new(list("command" = "update")) // Start processing shuttle-mode displays to display the timer
	frequency.post_signal(src, status_signal)

	var/area/A = get_area(user)

	log_shuttle("[key_name(user)] has called the emergency shuttle.")
	deadchat_broadcast(" has called the shuttle at [span_name("[A.name]")].", span_name("[user.real_name]"), user, message_type=DEADCHAT_ANNOUNCEMENT)
	if(call_reason)
		SSblackbox.record_feedback("text", "shuttle_reason", 1, "[call_reason]")
		log_shuttle("Shuttle call reason: [call_reason]")
		SSticker.emergency_reason = call_reason
	message_admins("[ADMIN_LOOKUPFLW(user)] has called the shuttle. (<A HREF='?_src_=holder;[HrefToken()];trigger_centcom_recall=1'>TRIGGER CENTCOM RECALL</A>)")

/datum/controller/subsystem/shuttle/proc/centcom_recall(old_timer, admiral_message)
	if(emergency.mode != SHUTTLE_CALL || emergency.timer != old_timer)
		return
	emergency.cancel()

	if(!admiral_message)
		admiral_message = pick(GLOB.admiral_messages)
	var/intercepttext = "<font size = 3><b>Nanotrasen Update</b>: Request For Shuttle.</font><hr>\
						To whom it may concern:<br><br>\
						We have taken note of the situation upon [station_name()] and have come to the \
						conclusion that it does not warrant the abandonment of the station.<br>\
						If you do not agree with our opinion we suggest that you open a direct \
						line with us and explain the nature of your crisis.<br><br>\
						<i>This message has been automatically generated based upon readings from long \
						range diagnostic tools. To assure the quality of your request every finalized report \
						is reviewed by an on-call rear admiral.<br>\
						<b>Rear Admiral's Notes:</b> \
						[admiral_message]"
	print_command_report(intercepttext, announce = TRUE)

// Called when an emergency shuttle mobile docking port is
// destroyed, which will only happen with admin intervention
/datum/controller/subsystem/shuttle/proc/emergencyDeregister()
	// When a new emergency shuttle is created, it will override the
	// backup shuttle.
	src.emergency = src.backup_shuttle

/datum/controller/subsystem/shuttle/proc/cancelEvac(mob/user)
	if(canRecall())
		emergency.cancel(get_area(user))
		log_shuttle("[key_name(user)] has recalled the shuttle.")
		message_admins("[ADMIN_LOOKUPFLW(user)] has recalled the shuttle.")
		deadchat_broadcast(" has recalled the shuttle from [span_name("[get_area_name(user, TRUE)]")].", span_name("[user.real_name]"), user, message_type=DEADCHAT_ANNOUNCEMENT)
		return 1

/datum/controller/subsystem/shuttle/proc/canRecall()
	if(!emergency || emergency.mode != SHUTTLE_CALL || admin_emergency_no_recall || emergency_no_recall)
		return
	var/security_num = SSsecurity_level.get_current_level_as_number()
	switch(security_num)
		if(SEC_LEVEL_GREEN)
			if(emergency.timeLeft(1) < emergency_call_time)
				return
		if(SEC_LEVEL_BLUE)
			if(emergency.timeLeft(1) < emergency_call_time * 0.5)
				return
		else
			if(emergency.timeLeft(1) < emergency_call_time * 0.25)
				return
	return 1

/datum/controller/subsystem/shuttle/proc/autoEvac()
	if (!SSticker.IsRoundInProgress() || supermatter_cascade)
		return

	var/callShuttle = TRUE

	for(var/thing in GLOB.shuttle_caller_list)
		if(isAI(thing))
			var/mob/living/silicon/ai/AI = thing
			if(AI.deployed_shell && !AI.deployed_shell.client)
				continue
			if(AI.stat || !AI.client)
				continue
		else if(istype(thing, /obj/machinery/computer/communications))
			var/obj/machinery/computer/communications/C = thing
			if(C.machine_stat & BROKEN)
				continue

		var/turf/T = get_turf(thing)
		if(T && is_station_level(T.z))
			callShuttle = FALSE
			break

	if(callShuttle)
		if(EMERGENCY_IDLE_OR_RECALLED)
			emergency.request(null, set_coefficient = 2.5)
			log_shuttle("There is no means of calling the emergency shuttle anymore. Shuttle automatically called.")
			message_admins("All the communications consoles were destroyed and all AIs are inactive. Shuttle called.")

/datum/controller/subsystem/shuttle/proc/registerHostileEnvironment(datum/bad)
	hostile_environments[bad] = TRUE
	checkHostileEnvironment()

/datum/controller/subsystem/shuttle/proc/clearHostileEnvironment(datum/bad)
	hostile_environments -= bad
	checkHostileEnvironment()


/datum/controller/subsystem/shuttle/proc/registerTradeBlockade(datum/bad)
	trade_blockade[bad] = TRUE
	checkTradeBlockade()

/datum/controller/subsystem/shuttle/proc/clearTradeBlockade(datum/bad)
	trade_blockade -= bad
	checkTradeBlockade()


/datum/controller/subsystem/shuttle/proc/checkTradeBlockade()
	for(var/datum/d in trade_blockade)
		if(!istype(d) || QDELETED(d))
			trade_blockade -= d
	supply_blocked = trade_blockade.len

	if(supply_blocked && (supply.mode == SHUTTLE_IGNITING))
		supply.mode = SHUTTLE_STRANDED
		supply.timer = null
		//Make all cargo consoles speak up
	if(!supply_blocked && (supply.mode == SHUTTLE_STRANDED))
		supply.mode = SHUTTLE_DOCKED
		//Make all cargo consoles speak up

/datum/controller/subsystem/shuttle/proc/checkHostileEnvironment()
	for(var/datum/d in hostile_environments)
		if(!istype(d) || QDELETED(d))
			hostile_environments -= d
	emergency_no_escape = hostile_environments.len

	if(emergency_no_escape && (emergency.mode == SHUTTLE_IGNITING))
		emergency.mode = SHUTTLE_STRANDED
		emergency.timer = null
		emergency.sound_played = FALSE
		priority_announce("Hostile environment detected. \
			Departure has been postponed indefinitely pending \
			conflict resolution.", null, 'sound/misc/notice1.ogg', "Priority")
	if(!emergency_no_escape && (emergency.mode == SHUTTLE_STRANDED))
		emergency.mode = SHUTTLE_DOCKED
		emergency.setTimer(emergency_dock_time)
		priority_announce("Hostile environment resolved. \
			You have 3 minutes to board the Emergency Shuttle.",
			null, ANNOUNCER_SHUTTLEDOCK, "Priority")

//try to move/request to dock_home if possible, otherwise dock_away. Mainly used for admin buttons
/datum/controller/subsystem/shuttle/proc/toggleShuttle(shuttle_id, dock_home, dock_away, timed)
	var/obj/docking_port/mobile/shuttle_port = getShuttle(shuttle_id)
	if(!shuttle_port)
		return DOCKING_BLOCKED
	var/obj/docking_port/stationary/docked_at = shuttle_port.get_docked()
	var/destination = dock_home
	if(docked_at && docked_at.id == dock_home)
		destination = dock_away
	if(timed)
		if(shuttle_port.request(getDock(destination)))
			return DOCKING_IMMOBILIZED
	else
		if(shuttle_port.initiate_docking(getDock(destination)) != DOCKING_SUCCESS)
			return DOCKING_IMMOBILIZED
	return DOCKING_SUCCESS //dock successful


/datum/controller/subsystem/shuttle/proc/moveShuttle(shuttle_id, dock_id, timed)
	var/obj/docking_port/mobile/shuttle_port = getShuttle(shuttle_id)
	var/obj/docking_port/stationary/docking_target = getDock(dock_id)

	if(!shuttle_port)
		return DOCKING_BLOCKED
	if(timed)
		if(shuttle_port.request(docking_target))
			return DOCKING_IMMOBILIZED
	else
		if(shuttle_port.initiate_docking(docking_target) != DOCKING_SUCCESS)
			return DOCKING_IMMOBILIZED
	return DOCKING_SUCCESS //dock successful

/datum/controller/subsystem/shuttle/proc/request_transit_dock(obj/docking_port/mobile/M)
	if(!istype(M))
		CRASH("[M] is not a mobile docking port")

	if(M.assigned_transit)
		return
	else
		if(!(M in transit_requesters))
			transit_requesters += M

/datum/controller/subsystem/shuttle/proc/generate_transit_dock(obj/docking_port/mobile/M)
	// First, determine the size of the needed zone
	// Because of shuttle rotation, the "width" of the shuttle is not
	// always x.
	var/travel_dir = M.preferred_direction
	// Remember, the direction is the direction we appear to be
	// coming from
	var/dock_angle = dir2angle(M.preferred_direction) + dir2angle(M.port_direction) + 180
	var/dock_dir = angle2dir(dock_angle)

	var/transit_width = SHUTTLE_TRANSIT_BORDER * 2
	var/transit_height = SHUTTLE_TRANSIT_BORDER * 2

	// Shuttles travelling on their side have their dimensions swapped
	// from our perspective
	switch(dock_dir)
		if(NORTH, SOUTH)
			transit_width += M.width
			transit_height += M.height
		if(EAST, WEST)
			transit_width += M.height
			transit_height += M.width

/*
	to_chat(world, "The attempted transit dock will be [transit_width] width, and \)
		[transit_height] in height. The travel dir is [travel_dir]."
*/

	var/transit_path = /turf/open/space/transit
	switch(travel_dir)
		if(NORTH)
			transit_path = /turf/open/space/transit/north
		if(SOUTH)
			transit_path = /turf/open/space/transit/south
		if(EAST)
			transit_path = /turf/open/space/transit/east
		if(WEST)
			transit_path = /turf/open/space/transit/west

	var/datum/turf_reservation/proposal = SSmapping.RequestBlockReservation(transit_width, transit_height, null, /datum/turf_reservation/transit, transit_path)

	if(!istype(proposal))
		return FALSE

	var/turf/bottomleft = locate(proposal.bottom_left_coords[1], proposal.bottom_left_coords[2], proposal.bottom_left_coords[3])
	// Then create a transit docking port in the middle
	var/coords = M.return_coords(0, 0, dock_dir)
	/*  0------2
	*   |      |
	*   |      |
	*   |  x   |
	*   3------1
	*/

	var/x0 = coords[1]
	var/y0 = coords[2]
	var/x1 = coords[3]
	var/y1 = coords[4]
	// Then we want the point closest to -infinity,-infinity
	var/x2 = min(x0, x1)
	var/y2 = min(y0, y1)

	// Then invert the numbers
	var/transit_x = bottomleft.x + SHUTTLE_TRANSIT_BORDER + abs(x2)
	var/transit_y = bottomleft.y + SHUTTLE_TRANSIT_BORDER + abs(y2)

	var/turf/midpoint = locate(transit_x, transit_y, bottomleft.z)
	if(!midpoint)
		return FALSE
	var/area/shuttle/transit/A = new()
	A.parallax_movedir = travel_dir
	A.contents = proposal.reserved_turfs
	var/obj/docking_port/stationary/transit/new_transit_dock = new(midpoint)
	new_transit_dock.reserved_area = proposal
	new_transit_dock.name = "Transit for [M.id]/[M.name]"
	new_transit_dock.owner = M
	new_transit_dock.assigned_area = A

	// Add 180, because ports point inwards, rather than outwards
	new_transit_dock.setDir(angle2dir(dock_angle))

	M.assigned_transit = new_transit_dock
	return new_transit_dock

/datum/controller/subsystem/shuttle/Recover()
	initialized = SSshuttle.initialized
	if (istype(SSshuttle.mobile_docking_ports))
		mobile_docking_ports = SSshuttle.mobile_docking_ports
	if (istype(SSshuttle.stationary_docking_ports))
		stationary_docking_ports = SSshuttle.stationary_docking_ports
	if (istype(SSshuttle.transit_docking_ports))
		transit_docking_ports = SSshuttle.transit_docking_ports
	if (istype(SSshuttle.transit_requesters))
		transit_requesters = SSshuttle.transit_requesters
	if (istype(SSshuttle.transit_request_failures))
		transit_request_failures = SSshuttle.transit_request_failures

	if (istype(SSshuttle.emergency))
		emergency = SSshuttle.emergency
	if (istype(SSshuttle.arrivals))
		arrivals = SSshuttle.arrivals
	if (istype(SSshuttle.backup_shuttle))
		backup_shuttle = SSshuttle.backup_shuttle

	if (istype(SSshuttle.emergency_last_call_loc))
		emergency_last_call_loc = SSshuttle.emergency_last_call_loc

	if (istype(SSshuttle.hostile_environments))
		hostile_environments = SSshuttle.hostile_environments

	if (istype(SSshuttle.supply))
		supply = SSshuttle.supply

	if (istype(SSshuttle.discovered_plants))
		discovered_plants = SSshuttle.discovered_plants

	if (istype(SSshuttle.shopping_list))
		shopping_list = SSshuttle.shopping_list
	if (istype(SSshuttle.request_list))
		request_list = SSshuttle.request_list
	if (istype(SSshuttle.order_history))
		order_history = SSshuttle.order_history

	if (istype(SSshuttle.shuttle_loan))
		shuttle_loan = SSshuttle.shuttle_loan

	if (istype(SSshuttle.shuttle_purchase_requirements_met))
		shuttle_purchase_requirements_met = SSshuttle.shuttle_purchase_requirements_met

	var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_CAR)
	centcom_message = SSshuttle.centcom_message
	order_number = SSshuttle.order_number
	points = D.account_balance
	emergency_no_escape = SSshuttle.emergency_no_escape
	emergencyCallAmount = SSshuttle.emergencyCallAmount
	shuttle_purchased = SSshuttle.shuttle_purchased
	lockdown = SSshuttle.lockdown

	selected = SSshuttle.selected

	existing_shuttle = SSshuttle.existing_shuttle

	preview_shuttle = SSshuttle.preview_shuttle
	preview_template = SSshuttle.preview_template

	preview_reservation = SSshuttle.preview_reservation

/datum/controller/subsystem/shuttle/proc/is_in_shuttle_bounds(atom/A)
	var/area/current = get_area(A)
	if(istype(current, /area/shuttle) && !istype(current, /area/shuttle/transit))
		return TRUE
	for(var/obj/docking_port/mobile/M in mobile_docking_ports)
		if(M.is_in_shuttle_bounds(A))
			return TRUE

/datum/controller/subsystem/shuttle/proc/get_containing_shuttle(atom/A)
	var/list/mobile_docking_ports_cache = mobile_docking_ports
	for(var/i in 1 to mobile_docking_ports_cache.len)
		var/obj/docking_port/port = mobile_docking_ports_cache[i]
		if(port.is_in_shuttle_bounds(A))
			return port

/datum/controller/subsystem/shuttle/proc/get_containing_dock(atom/A)
	. = list()
	var/list/stationary_docking_ports_cache = stationary_docking_ports
	for(var/i in 1 to stationary_docking_ports_cache.len)
		var/obj/docking_port/port = stationary_docking_ports_cache[i]
		if(port.is_in_shuttle_bounds(A))
			. += port

/datum/controller/subsystem/shuttle/proc/get_dock_overlap(x0, y0, x1, y1, z)
	. = list()
	var/list/stationary_docking_ports_cache = stationary_docking_ports
	for(var/i in 1 to stationary_docking_ports_cache.len)
		var/obj/docking_port/port = stationary_docking_ports_cache[i]
		if(!port || port.z != z)
			continue
		var/list/bounds = port.return_coords()
		var/list/overlap = get_overlap(x0, y0, x1, y1, bounds[1], bounds[2], bounds[3], bounds[4])
		var/list/xs = overlap[1]
		var/list/ys = overlap[2]
		if(xs.len && ys.len)
			.[port] = overlap

/datum/controller/subsystem/shuttle/proc/update_hidden_docking_ports(list/remove_turfs, list/add_turfs)
	var/list/remove_images = list()
	var/list/add_images = list()

	if(remove_turfs)
		for(var/T in remove_turfs)
			var/list/L = hidden_shuttle_turfs[T]
			if(L)
				remove_images += L[1]
		hidden_shuttle_turfs -= remove_turfs

	if(add_turfs)
		for(var/V in add_turfs)
			var/turf/T = V
			var/image/I
			if(remove_images.len)
				//we can just reuse any images we are about to delete instead of making new ones
				I = remove_images[1]
				remove_images.Cut(1, 2)
				I.loc = T
			else
				I = image(loc = T)
				add_images += I
			I.appearance = T.appearance
			I.override = TRUE
			hidden_shuttle_turfs[T] = list(I, T.type)

	hidden_shuttle_turf_images -= remove_images
	hidden_shuttle_turf_images += add_images

	for(var/V in GLOB.navigation_computers)
		var/obj/machinery/computer/camera_advanced/shuttle_docker/C = V
		C.update_hidden_docking_ports(remove_images, add_images)

	QDEL_LIST(remove_images)


/datum/controller/subsystem/shuttle/proc/action_load(datum/map_template/shuttle/loading_template, obj/docking_port/stationary/destination_port, replace = FALSE)
	// Check for an existing preview
	if(preview_shuttle && (loading_template != preview_template))
		preview_shuttle.jumpToNullSpace()
		preview_shuttle = null
		preview_template = null
		QDEL_NULL(preview_reservation)

	if(!preview_shuttle)
		load_template(loading_template)
		preview_template = loading_template

	// get the existing shuttle information, if any
	var/timer = 0
	var/mode = SHUTTLE_IDLE
	var/obj/docking_port/stationary/D

	if(istype(destination_port))
		D = destination_port
	else if(existing_shuttle && replace)
		timer = existing_shuttle.timer
		mode = existing_shuttle.mode
		D = existing_shuttle.get_docked()

	if(!D)
		D = generate_transit_dock(preview_shuttle)

	if(!D)
		CRASH("No dock found for preview shuttle ([preview_template.name]), aborting.")

	var/result = preview_shuttle.canDock(D)
	// truthy value means that it cannot dock for some reason
	// but we can ignore the someone else docked error because we'll
	// be moving into their place shortly
	if((result != SHUTTLE_CAN_DOCK) && (result != SHUTTLE_SOMEONE_ELSE_DOCKED))
		CRASH("Template shuttle [preview_shuttle] cannot dock at [D] ([result]).")

	if(existing_shuttle && replace)
		existing_shuttle.jumpToNullSpace()

	var/list/force_memory = preview_shuttle.movement_force
	preview_shuttle.movement_force = list("KNOCKDOWN" = 0, "THROW" = 0)
	preview_shuttle.mode = SHUTTLE_PREARRIVAL//No idle shuttle moving. Transit dock get removed if shuttle moves too long.
	preview_shuttle.initiate_docking(D)
	preview_shuttle.movement_force = force_memory

	. = preview_shuttle

	// Shuttle state involves a mode and a timer based on world.time, so
	// plugging the existing shuttles old values in works fine.
	preview_shuttle.timer = timer
	preview_shuttle.mode = mode

	preview_shuttle.register(replace)

	// TODO indicate to the user that success happened, rather than just
	// blanking the modification tab
	preview_shuttle = null
	preview_template = null
	existing_shuttle = null
	selected = null
	QDEL_NULL(preview_reservation)

/datum/controller/subsystem/shuttle/proc/load_template(datum/map_template/shuttle/S)
	. = FALSE
	// Load shuttle template to a fresh block reservation.
	preview_reservation = SSmapping.RequestBlockReservation(S.width, S.height, SSmapping.transit.z_value, /datum/turf_reservation/transit)
	if(!preview_reservation)
		CRASH("failed to reserve an area for shuttle template loading")
	var/turf/BL = TURF_FROM_COORDS_LIST(preview_reservation.bottom_left_coords)
	S.load(BL, centered = FALSE, register = FALSE)

	var/affected = S.get_affected_turfs(BL, centered=FALSE)

	var/found = 0
	// Search the turfs for docking ports
	// - We need to find the mobile docking port because that is the heart of
	//   the shuttle.
	// - We need to check that no additional ports have slipped in from the
	//   template, because that causes unintended behaviour.
	for(var/T in affected)
		for(var/obj/docking_port/P in T)
			if(istype(P, /obj/docking_port/mobile))
				found++
				if(found > 1)
					qdel(P, force=TRUE)
					log_mapping("Shuttle Template [S.mappath] has multiple mobile docking ports.")
				else
					preview_shuttle = P
			if(istype(P, /obj/docking_port/stationary))
				log_mapping("Shuttle Template [S.mappath] has a stationary docking port.")
	if(!found)
		var/msg = "load_template(): Shuttle Template [S.mappath] has no mobile docking port. Aborting import."
		for(var/T in affected)
			var/turf/T0 = T
			T0.empty()

		message_admins(msg)
		WARNING(msg)
		return
	//Everything fine
	S.post_load(preview_shuttle)
	return TRUE

/datum/controller/subsystem/shuttle/proc/unload_preview()
	if(preview_shuttle)
		preview_shuttle.jumpToNullSpace()
	preview_shuttle = null

/datum/controller/subsystem/shuttle/ui_state(mob/user)
	return GLOB.admin_state

/datum/controller/subsystem/shuttle/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ShuttleManipulator")
		ui.open()

/datum/controller/subsystem/shuttle/ui_data(mob/user)
	var/list/data = list()
	data["tabs"] = list("Status", "Templates", "Modification")

	// Templates panel
	data["templates"] = list()
	var/list/templates = data["templates"]
	data["templates_tabs"] = list()
	data["selected"] = list()

	for(var/shuttle_id in SSmapping.shuttle_templates)
		var/datum/map_template/shuttle/S = SSmapping.shuttle_templates[shuttle_id]

		if(!templates[S.port_id])
			data["templates_tabs"] += S.port_id
			templates[S.port_id] = list(
				"port_id" = S.port_id,
				"templates" = list())

		var/list/L = list()
		L["name"] = S.name
		L["shuttle_id"] = S.shuttle_id
		L["port_id"] = S.port_id
		L["description"] = S.description
		L["admin_notes"] = S.admin_notes

		if(selected == S)
			data["selected"] = L

		templates[S.port_id]["templates"] += list(L)

	data["templates_tabs"] = sort_list(data["templates_tabs"])

	data["existing_shuttle"] = null

	// Status panel
	data["shuttles"] = list()
	for(var/i in mobile_docking_ports)
		var/obj/docking_port/mobile/M = i
		var/timeleft = M.timeLeft(1)
		var/list/L = list()
		L["name"] = M.name
		L["id"] = M.id
		L["timer"] = M.timer
		L["timeleft"] = M.getTimerStr()
		if (timeleft > 1 HOURS)
			L["timeleft"] = "Infinity"
		L["can_fast_travel"] = M.timer && timeleft >= 50
		L["can_fly"] = TRUE
		if(istype(M, /obj/docking_port/mobile/emergency))
			L["can_fly"] = FALSE
		else if(!M.destination)
			L["can_fast_travel"] = FALSE
		if (M.mode != SHUTTLE_IDLE)
			L["mode"] = capitalize(M.mode)
		L["status"] = M.getDbgStatusText()
		if(M == existing_shuttle)
			data["existing_shuttle"] = L

		data["shuttles"] += list(L)

	return data

/datum/controller/subsystem/shuttle/ui_act(action, params)
	. = ..()
	if(.)
		return

	var/mob/user = usr

	// Preload some common parameters
	var/shuttle_id = params["shuttle_id"]
	var/datum/map_template/shuttle/S = SSmapping.shuttle_templates[shuttle_id]

	switch(action)
		if("select_template")
			if(S)
				existing_shuttle = getShuttle(S.port_id)
				selected = S
				. = TRUE
		if("jump_to")
			if(params["type"] == "mobile")
				for(var/i in mobile_docking_ports)
					var/obj/docking_port/mobile/M = i
					if(M.id == params["id"])
						user.forceMove(get_turf(M))
						. = TRUE
						break

		if("fly")
			for(var/i in mobile_docking_ports)
				var/obj/docking_port/mobile/M = i
				if(M.id == params["id"])
					. = TRUE
					M.admin_fly_shuttle(user)
					break

		if("fast_travel")
			for(var/i in mobile_docking_ports)
				var/obj/docking_port/mobile/M = i
				if(M.id == params["id"] && M.timer && M.timeLeft(1) >= 50)
					M.setTimer(50)
					. = TRUE
					message_admins("[key_name_admin(usr)] fast travelled [M]")
					log_admin("[key_name(usr)] fast travelled [M]")
					SSblackbox.record_feedback("text", "shuttle_manipulator", 1, "[M.name]")
					break

		if("load")
			if(S && !shuttle_loading)
				. = TRUE
				shuttle_loading = TRUE
				// If successful, returns the mobile docking port
				var/obj/docking_port/mobile/mdp = action_load(S)
				if(mdp)
					user.forceMove(get_turf(mdp))
					message_admins("[key_name_admin(usr)] loaded [mdp] with the shuttle manipulator.")
					log_admin("[key_name(usr)] loaded [mdp] with the shuttle manipulator.</span>")
					SSblackbox.record_feedback("text", "shuttle_manipulator", 1, "[mdp.name]")
				shuttle_loading = FALSE

		if("preview")
			//if(preview_shuttle && (loading_template != preview_template))
			if(S && !shuttle_loading)
				. = TRUE
				shuttle_loading = TRUE
				unload_preview()
				load_template(S)
				if(preview_shuttle)
					preview_template = S
					user.forceMove(get_turf(preview_shuttle))
				shuttle_loading = FALSE

		if("replace")
			if(existing_shuttle == backup_shuttle)
				// TODO make the load button disabled
				WARNING("The shuttle that the selected shuttle will replace \
					is the backup shuttle. Backup shuttle is required to be \
					intact for round sanity.")
			else if(S && !shuttle_loading)
				. = TRUE
				shuttle_loading = TRUE
				// If successful, returns the mobile docking port
				var/obj/docking_port/mobile/mdp = action_load(S, replace = TRUE)
				if(mdp)
					user.forceMove(get_turf(mdp))
					message_admins("[key_name_admin(usr)] load/replaced [mdp] with the shuttle manipulator.")
					log_admin("[key_name(usr)] load/replaced [mdp] with the shuttle manipulator.</span>")
					SSblackbox.record_feedback("text", "shuttle_manipulator", 1, "[mdp.name]")
				shuttle_loading = FALSE
				if(emergency == mdp) //you just changed the emergency shuttle, there are events in game + captains that can change your snowflake choice.
					var/set_purchase = tgui_alert(usr, "Do you want to also disable shuttle purchases/random events that would change the shuttle?", "Butthurt Admin Prevention", list("Yes, disable purchases/events", "No, I want to possibly get owned"))
					if(set_purchase == "Yes, disable purchases/events")
						SSshuttle.shuttle_purchased = SHUTTLEPURCHASE_FORCED

/datum/controller/subsystem/shuttle/proc/init_has_purchase_shuttle_access()
	var/list/has_purchase_shuttle_access = list()

	for (var/shuttle_id in SSmapping.shuttle_templates)
		var/datum/map_template/shuttle/shuttle_template = SSmapping.shuttle_templates[shuttle_id]
		if (!isnull(shuttle_template.who_can_purchase))
			has_purchase_shuttle_access |= shuttle_template.who_can_purchase

	return has_purchase_shuttle_access
