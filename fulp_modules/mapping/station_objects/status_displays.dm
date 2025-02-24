// Status display overrides (a fair bit of code has been repeated from original definitions).

/obj/machinery/status_display/display_shuttle_status(obj/docking_port/mobile/shuttle)
	if(!shuttle)
		set_messages("shutl","not in service")
		return PROCESS_KILL
	else if(shuttle.timer)
		var/line1 = shuttle.getModeStr()
		var/line2 = shuttle.getTimerStr()

		set_messages(line1, line2)
	else if(shuttle.mode == SHUTTLE_IDLE && !istype(shuttle, /obj/docking_port/mobile/emergency))
		var/line1 = "shutl"
		var/line2 = "idle"

		set_messages(line1, line2)
	else
		set_messages("", "")

// Custom status display machines.

// PLEASE NOTE:
// These may not work for all shuttles; the 'shuttle_id' var
// may need to be edited on some maps.

/obj/machinery/status_display/shuttle/arrivals
	name = "arrivals shuttle display"
	shuttle_id = "arrival"

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/status_display/shuttle/arrivals, 32)

/obj/machinery/status_display/shuttle/mining
	name = "mining shuttle display"
	shuttle_id = "mining"

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/status_display/shuttle/mining, 32)

/obj/machinery/status_display/shuttle/mining/common
	name = "public mining shuttle display"
	shuttle_id = "mining_common"

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/status_display/shuttle/mining/common, 32)
