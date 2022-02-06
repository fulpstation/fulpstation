/datum/map_template/shuttle/prison
	prefix = "fulp_modules/mapping/prison_shuttles/"
	port_id = "prison"
	suffix = "default"
	name = "Base Shuttle Template (Prison)"
	who_can_purchase = null
	///What stage do we start this ship off at? Some will auto-start completed, and fail by screwing up.
	var/objective_status = PERMABRIG_SHUTTLE_OBJECTIVE_FAILURE
	///How much money is this objective worth? Given/taken from the Budget when completed/failed.
	var/objective_price = 500

/datum/map_template/shuttle/prison/New()
	. = ..()
	RegisterSignal(src, COMSIG_PRISON_OBJECTIVE_COMPLETED, .proc/complete_objective)
	RegisterSignal(src, COMSIG_PRISON_OBJECTIVE_FAILED, .proc/fail_objective)

/datum/map_template/shuttle/prison/Destroy(force, ...)
	UnregisterSignal(src, COMSIG_PRISON_OBJECTIVE_FAILED)
	UnregisterSignal(src, COMSIG_PRISON_OBJECTIVE_COMPLETED)
	return ..()

/**
 * complete_objective/fail_objective
 *
 * Sets the objective as completed/failed.
 */
/datum/map_template/shuttle/prison/proc/complete_objective()
	SIGNAL_HANDLER
	objective_status = PERMABRIG_SHUTTLE_OBJECTIVE_SUCCESS
/datum/map_template/shuttle/prison/proc/fail_objective()
	SIGNAL_HANDLER
	objective_status = PERMABRIG_SHUTTLE_OBJECTIVE_FAILURE

/**
 * SHUTTLE TEMPLATES
 */

/datum/map_template/shuttle/prison/bar
	suffix = "bar"
	name = "Bar Shuttle (Prison)"
	objective_price = 300

/datum/map_template/shuttle/prison/xenobiology
	suffix = "xenobio"
	name = "Xenobiology Shuttle (Prison)"
