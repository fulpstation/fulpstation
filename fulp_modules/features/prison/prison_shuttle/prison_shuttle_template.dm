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
	///Explanation text on how this shuttle and its objective operates.
	var/explanation_text

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
	explanation_text = "Central Command has accidentally lost important documents within their junkmail, \
		please sort through them and store away the important documents within the on-board smartfridge. \
		Recycle any junkmail you may find, if there is any mail leftover on the shuttle, it will fail regardless."

/datum/map_template/shuttle/prison/disposals/check_end_shuttle()
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

	return ..()

/datum/map_template/shuttle/prison/cleaning
	suffix = "cleaning"
	name = "Cleaning Shuttle (Prison)"
	objective_price = 150
	explanation_text = "We noticed that one of our ships were getting a little... dirty. Please clean up in there. \
		Leave absolutely NOTHING in the shuttle. AT ALL. We want it completely clean and empty."

/datum/map_template/shuttle/prison/cleaning/check_end_shuttle()
	var/list/area/shuttle/shuttle_areas = SSshuttle.prison_shuttle.shuttle_areas
	for(var/area/shuttle/shuttle_area in shuttle_areas)
		for(var/turf/shuttle_turf in shuttle_area)
			for(var/obj/item/item in shuttle_turf.get_all_contents())
				if(istype(item, /obj/item/radio/intercom))
					continue
				//Literally NOTHING
				INVOKE_ASYNC(src, .proc/fail_objective)
				break

	return ..()

/datum/map_template/shuttle/prison/bar
	suffix = "bar"
	name = "Bar Shuttle (Prison)"
	objective_price = 300
	explanation_text = "The last Bartender we've hired had drank themselves to death after their shotgun was stolen. \
		We are in desperate need for some drinks, please mix up a few glasses and store them in the fridge."

/datum/map_template/shuttle/prison/kitchen
	suffix = "kitchen"
	name = "Kitchen Shuttle (Prison)"
	objective_price = 600
	explanation_text = "We hope you are aware of the recent changes made to your station's Kitchen reworks. \
		Please make something good for as a delivery to prove this effort was worthwhile. \
		You may see your smart fridge for more information."

/datum/map_template/shuttle/prison/platepress
	suffix = "platepress"
	name = "Plate Pressing Shuttle (Prison)"
	objective_price = 200
	explanation_text = "We are in dire need of pressed plates to make new prisoner jumpsuits, please send us any you have. One stack should be enough. \
		There's some things leftover that the previous person left. Leave them or throw them out, doesn't bother us."

/datum/map_template/shuttle/prison/xenobiology
	suffix = "xenobio"
	name = "Xenobiology Shuttle (Prison)"
	explanation_text = "Our Xenobiology has had a very large accident and is non functional, as are our Scientists. \
		We are sending our shuttle to make a short stop at your station, please start on some Xenobiology work to get us a head start. \
		A single extract should do, please see your smart fridge for more information."
