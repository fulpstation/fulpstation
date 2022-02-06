/datum/map_template/shuttle/prison
	prefix = "fulp_modules/mapping/prison_shuttles/"
	port_id = "prison"
	suffix = "default"
	name = "Base Shuttle Template (Prison)"
	who_can_purchase = null
	///Where players get dropped off if found on the shuttle after it departs.
	var/dropoff_area = /area/security/prison
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

/datum/map_template/shuttle/prison/proc/check_end_shuttle()
	var/list/area/shuttle/shuttle_areas = SSshuttle.prison_shuttle.shuttle_areas
	//Kick everyone off
	for(var/area/shuttle/shuttle_area in shuttle_areas)
		for(var/turf/shuttle_turf in shuttle_area)
			for(var/mob/living/passenger in shuttle_turf.get_all_contents())
				if(!passenger.mind)
					continue
				to_chat(passenger, span_boldwarning("You fell off the shuttle!"))
				passenger.forceMove(pick(GLOB.areas_by_type[dropoff_area]))
				passenger.adjustBruteLoss(20)
				passenger.Paralyze(10 SECONDS)

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

/datum/map_template/shuttle/prison/disposals
	suffix = "disposals"
	name = "Disposals Shuttle (Prison)"
	objective_price = 600

/datum/map_template/shuttle/prison/disposals/check_end_shuttle()
	. = ..()
	var/list/all_documents = list()

	var/list/area/shuttle/shuttle_areas = SSshuttle.prison_shuttle.shuttle_areas
	for(var/area/shuttle/shuttle_area in shuttle_areas)
		for(var/turf/shuttle_turf in shuttle_area)
			for(var/obj/item/item in shuttle_turf.get_all_contents())
				if(!istype(item, /obj/item/paper) && !istype(item, /obj/item/mail))
					continue
				all_documents += item

	//Check if 3 or more documents were left unrecycled on the shuttle
	if(all_documents.len >= 3)
		INVOKE_ASYNC(src, .proc/fail_objective)


/datum/map_template/shuttle/prison/bar
	suffix = "bar"
	name = "Bar Shuttle (Prison)"
	objective_price = 300

/datum/map_template/shuttle/prison/kitchen
	suffix = "kitchen"
	name = "Kitchen Shuttle (Prison)"
	objective_price = 600

/datum/map_template/shuttle/prison/kitchen
	suffix = "platepress"
	name = "Plate Pressing Shuttle (Prison)"
	objective_price = 200

/datum/map_template/shuttle/prison/xenobiology
	suffix = "xenobio"
	name = "Xenobiology Shuttle (Prison)"
