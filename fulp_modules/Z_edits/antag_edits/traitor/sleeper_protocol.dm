// THIS CONTENT IS NOT ORIGINAL. SEE '_attribution.md' FOR MORE INFORMATION //
// Comments surrounded with brackets were made during porting.              //

/datum/traitor_objective_category/sleeper_protocol
	name = "Sleeper Protocol"
	objectives = list(
		/datum/traitor_objective/sleeper_protocol = 1,
		/datum/traitor_objective/sleeper_protocol/everybody = 1,
	)

/datum/traitor_objective/sleeper_protocol
	name = "Perform the sleeper protocol on a crewmember"
	description = "Use the button below to materialize a surgery disk in your hand, where you'll then be able to perform the sleeper protocol on a crewmember. If the disk gets destroyed, the objective will fail. This will only work on living and sentient crewmembers."

	progression_minimum = 0 MINUTES

	progression_reward = list(8 MINUTES, 15 MINUTES)
	telecrystal_reward = 1

	var/list/limited_to = list(
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_MEDICAL_DOCTOR,
		JOB_PARAMEDIC,
		JOB_ROBOTICIST,
	)

	var/obj/item/disk/surgery/sleeper_protocol/disk

	var/mob/living/current_registered_mob

	var/inverted_limitation = FALSE

/datum/traitor_objective/sleeper_protocol/generate_ui_buttons(mob/user)
	var/list/buttons = list()
	if(!disk)
		buttons += add_ui_button("", "Clicking this will materialize the sleeper protocol surgery in your hand", "save", "summon_disk")
	return buttons

/datum/traitor_objective/sleeper_protocol/ui_perform_action(mob/living/user, action)
	switch(action)
		if("summon_disk")
			if(disk)
				return
			disk = new(user.drop_location())
			user.put_in_hands(disk)
			AddComponent(/datum/component/traitor_objective_register, disk, \
				fail_signals = list(COMSIG_QDELETING))

/datum/traitor_objective/sleeper_protocol/proc/on_surgery_success(datum/source, datum/surgery_step/step, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	SIGNAL_HANDLER
	if(istype(step, /datum/surgery_step/brainwash/sleeper_agent))
		succeed_objective()

/datum/traitor_objective/sleeper_protocol/can_generate_objective(datum/mind/generating_for, list/possible_duplicates)
	var/datum/job/job = generating_for.assigned_role
	if(!(job.title in limited_to) && !inverted_limitation)
		return FALSE
	if((job.title in limited_to) && inverted_limitation)
		return FALSE
	if(length(possible_duplicates) > 0)
		return FALSE
	return TRUE

/datum/traitor_objective/sleeper_protocol/generate_objective(datum/mind/generating_for, list/possible_duplicates)
	AddComponent(/datum/component/traitor_objective_mind_tracker, generating_for, \
		signals = list(COMSIG_MOB_SURGERY_STEP_SUCCESS = PROC_REF(on_surgery_success)))
	return TRUE

/datum/traitor_objective/sleeper_protocol/ungenerate_objective()
	disk = null

/datum/traitor_objective/sleeper_protocol/everybody //Much harder for non-med and non-robo
	progression_minimum = 30 MINUTES
	progression_reward = list(8 MINUTES, 15 MINUTES)
	telecrystal_reward = 1

	inverted_limitation = TRUE
