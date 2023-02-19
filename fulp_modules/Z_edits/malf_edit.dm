/**
 * Prevents the AI from purchasing the nuclear device ability if they
 * don't have a valid objective to do so.
 */
/datum/module_picker/purchase_module(mob/living/silicon/ai/AI, datum/ai_module/purchasing_module)
	if(!istype(purchasing_module, /datum/ai_module/destructive/nuke_station))
		return ..()
	var/datum/antagonist/malf_ai/malf_datum = AI.mind.has_antag_datum(/datum/antagonist/malf_ai)
	if(!(locate(/datum/objective/purge) in malf_datum.objectives) && !(locate(/datum/objective/block) in malf_datum.objectives))
		to_chat(AI, span_warning("Unable to purchase, user lacks reasoning (No hijack or nuclear objective)."))
		return FALSE
	return ..()
