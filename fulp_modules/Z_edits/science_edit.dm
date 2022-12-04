/obj/machinery/computer/rdconsole
	//sets lock access to command
	req_access = list(ACCESS_COMMAND)
	//starts it off locked
	locked = TRUE

/datum/computer_file/program/science
	//starts it off locked
	locked = TRUE
	//sets lock/download access to command
	lock_access = ACCESS_COMMAND
	required_access = list(ACCESS_COMMAND)
	transfer_access = list(ACCESS_COMMAND)
