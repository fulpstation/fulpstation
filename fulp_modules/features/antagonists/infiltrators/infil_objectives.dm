/datum/antagonist/traitor/infiltrator/forge_traitor_objectives()
	if(!employer)
		return
	switch(employer)
		if("Corporate Climber")
			var/datum/objective/assassinate/killtraitor = new
			killtraitor.owner = owner
			killtraitor.find_traitor_target()
			objectives += killtraitor

			var/datum/objective/escape/escape_with_identity/infiltrator/escape = new
			escape.owner = owner
			escape.find_sec_target()
			objectives += escape

			var/datum/objective/assassinate/killsec = new
			killsec.owner = owner
			killsec.target = escape.target   //assassinate the officer you're supposed to impersonate
			killsec.update_explanation_text()
			objectives += killsec

			for(var/i = 0, i < 2, i++)
				var/datum/objective/steal/steal_objective = new
				steal_objective.owner = owner
				steal_objective.find_target()
				objectives += steal_objective

		if("Animal Rights Consortium")
			for(var/i = 0, i < 2, i++)
				var/datum/objective/kill_pet/pet = new
				pet.owner = owner
				pet.find_pet_target()
				objectives += pet

			for(var/i = 0, i < 2, i++)
				var/datum/objective/assassinate/kill = new
				kill.owner = owner
				kill.find_sci_target()
				objectives += kill

			var/datum/objective/assassinate/monkify/monk = new
			monk.owner = owner
			monk.find_head_target()
			objectives += monk

		if("Gorlex Marauders")
			for(var/i = 0, i < rand(3,5) , i++)
				var/datum/objective/assassinate/assassinate = new
				assassinate.owner = owner
				assassinate.find_target()
				objectives += assassinate

			var/datum/objective/emag_console/emag = new
			emag.owner = owner
			emag.update_explanation_text()
			objectives += emag


//Corporate Climber objectives

//Find Traitor target
/datum/objective/assassinate/proc/find_traitor_target()
	var/list/possible_targets = list()
	for(var/mob/living/carbon/human/player in GLOB.player_list)
		if(player.stat == DEAD || player.mind == owner)
			continue
		if(player.mind?.has_antag_datum(/datum/antagonist/traitor))
			possible_targets += player.mind

	if(!possible_targets.len)
		find_target() //if no traitors on station, this becomes a normal assassination obj
		return
	else
		target = pick(possible_targets)

	if(target?.current)
		explanation_text = "Special intel has identified [target.name] the [!target_role_type ? target.assigned_role.title : target.special_role]. as a threat to Nanotrasen. Eliminate them at all costs."


//advanced mulligan objective

/datum/objective/escape/escape_with_identity/infiltrator
	name = "escape with identity (as infiltrator)"

/datum/objective/escape/escape_with_identity/infiltrator/proc/find_sec_target()
	var/list/sec = SSjob.get_all_sec()
	target = (sec.len) ? pick(sec) : find_target()
	update_explanation_text()

//Animal Rights Consortium Objectives

//pet killing

/datum/objective/kill_pet
	var/mob/living/target_pet
	martyr_compatible = TRUE

/datum/objective/kill_pet/proc/find_pet_target()
	var/list/possible_target_pets = list (/mob/living/simple_animal/pet/dog/corgi/ian,
	/mob/living/simple_animal/pet/fox/renault, /mob/living/simple_animal/pet/cat/runtime,
	/mob/living/simple_animal/parrot/poly)

	remove_duplicate(possible_target_pets) //removes pets from the list that are already in the owner's objective

	var/chosen_pet = pick(possible_target_pets)
	target_pet = locate(chosen_pet) in GLOB.mob_living_list

	update_explanation_text()



/datum/objective/kill_pet/proc/remove_duplicate(possible_target_pets)
	for(var/datum/objective/kill_pet/objective in owner.get_all_objectives())
		if(objective.target_pet.type in possible_target_pets)
			possible_target_pets -= objective.target_pet.type


/datum/objective/kill_pet/update_explanation_text()
	..()
	if(target_pet)
		explanation_text = "[target_pet] has been tainted by Nanotrasen agenda, give them a mercy killing."


/datum/objective/kill_pet/check_completion()
	return completed || (target_pet.stat == DEAD)

//scientist killing

/datum/objective/assassinate/proc/find_sci_target()
	var/list/sci_targets = list()
	for(var/mob/living/carbon/human/player as anything in GLOB.human_list)
		if(player.stat == DEAD)
			continue
		if((player.mind?.assigned_role.departments_bitflags & DEPARTMENT_BITFLAG_SCIENCE))
			sci_targets += player.mind

	if(!sci_targets.len)
		find_target()
		return
	else
		target = pick(sci_targets)

	if(target?.current)
		explanation_text = "Make a stance against science's animal experimentation by assassinating [target.name] the [!target_role_type ? target.assigned_role.title : target.special_role]!"

//monkifying head of staff

/datum/objective/assassinate/monkify

/datum/objective/assassinate/monkify/proc/find_head_target()
	var/list/com_targets = SSjob.get_all_heads()
	target = (com_targets.len) ? pick(com_targets) : find_target()
	update_explanation_text()

/datum/objective/assassinate/monkify/check_completion()
	. = ..()

	if(!.)
		return FALSE

	return completed || ismonkey(target.current)

/datum/objective/assassinate/monkify/update_explanation_text()
	..()
	if(target?.current)
		explanation_text = "Monkify [target.name] the [!target_role_type ? target.assigned_role.title : target.special_role] and euthanize him."


//Mauradars Objectives

//emagging communication console

/datum/objective/emag_console
	explanation_text = "Secure communication lines between Space Station 13 and the Syndicate by emagging the communications console!"

/datum/objective/emag_console/check_completion()
	var/check_emag = FALSE
	for(var/obj/machinery/computer/communications/console in GLOB.machines)
		if(!is_station_level(console.z))
			continue
		if(console.obj_flags & EMAGGED)
			check_emag = TRUE
			break

	return completed || check_emag

