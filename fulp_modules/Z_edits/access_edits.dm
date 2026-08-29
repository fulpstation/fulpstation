//We're overwriting accesses_by_region to add our own access flags to different regions
/datum/controller/subsystem/id_access/setup_region_lists()
	. = ..()
	accesses_by_region[REGION_ENGINEERING] |= ACCESS_TCOMMS_ADMIN

/datum/controller/subsystem/id_access/setup_access_flags()
	. = ..()
	accesses_by_flag["[ACCESS_FLAG_COMMAND]"] |= ACCESS_TCOMMS_ADMIN
	flags_by_access |= list(ACCESS_TCOMMS_ADMIN = ACCESS_FLAG_COMMAND)

/datum/controller/subsystem/id_access/setup_access_descriptions()
	. = ..()
	desc_by_access["[ACCESS_TCOMMS_ADMIN]"] = "Telecommunications Admin"

//Editing access trims to have updated access versions
/datum/id_trim/job/chief_engineer/New()
	minimal_access += list(ACCESS_TCOMMS_ADMIN)
	return ..()

/obj/effect/mapping_helpers/airlock/access/any/engineering/tcoms_admin/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_TCOMMS_ADMIN
	return access_list

/obj/effect/mapping_helpers/airlock/access/all/engineering/tcoms_admin/get_access()
	var/list/access_list = ..()
	access_list += ACCESS_TCOMMS_ADMIN
	return access_list
