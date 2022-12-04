/**
 * Sets all places where techwebs can be purchased to start off locked
 * and behind Command access, giving Command better control over
 * research throughout a round.
 */

//RD console
/obj/machinery/computer/rdconsole
	//sets lock access to command
	req_access = list(ACCESS_COMMAND)
	//starts it off locked
	locked = TRUE

//Techweb app
/datum/computer_file/program/science
	//sets lock/download access to command
	lock_access = ACCESS_COMMAND
	required_access = list(ACCESS_COMMAND)
	transfer_access = list(ACCESS_COMMAND)
	//starts it off locked
	locked = TRUE
