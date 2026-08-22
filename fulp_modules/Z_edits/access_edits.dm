//We're overwriting accesses_by_region to add our own access flags to different regions
/datum/controller/subsystem/id_access/setup_region_lists()
	. = ..()
	accesses_by_region[REGION_ENGINEERING] = REGION_ACCESS_ENGINEERING + ACCESS_TCOMMS_ADMIN

//Editing access trims to have updated access versions
/datum/id_trim/job/chief_engineer/New()
	minimal_access += list(ACCESS_TCOMMS_ADMIN)
	return ..()
