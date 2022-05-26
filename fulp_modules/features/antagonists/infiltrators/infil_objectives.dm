/datum/antagonist/traitor/infiltrator/forge_traitor_objectives()
	if(!employer)
		return
	switch(employer)
		if(INFILTRATOR_FACTION_CORPORATE_CLIMBER)
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

			var/datum/objective/steal/steal_obj = new
			steal_obj.owner = owner
			steal_obj.find_target()
			objectives += steal_obj

		if(INFILTRATOR_FACTION_ANIMAL_RIGHTS_CONSORTIUM)
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

			var/datum/objective/assassinate/kill_head = new
			kill_head.owner = owner
			kill_head.find_head_target()
			objectives += kill_head

		if(INFILTRATOR_FACTION_GORLEX_MARAUDERS)
			for(var/i = 0, i < rand(4,6) , i++)
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
		explanation_text = "Special intel has identified [target.name] the [!target_role_type ? target.assigned_role.title : target.special_role]. as a threat to Nanotrasen, ensure they are eliminated."


//advanced mulligan objective

/datum/objective/escape/escape_with_identity/infiltrator
	name = "escape with identity (as infiltrator)"

/datum/objective/escape/escape_with_identity/infiltrator/proc/find_sec_target()
	var/list/sec = SSjob.get_all_sec()
	if(!sec.len)
		find_target()
	else
		target = pick(sec)

	if(target?.current)
		explanation_text = "Using Advanced Mulligan, escape with the identity of [target.name] the [target.assigned_role.title] while wearing their ID card!"

//Animal Rights Consortium Objectives

//pet killing

/datum/objective/kill_pet
	name = "Kill a command pet"
	martyr_compatible = TRUE
	var/mob/living/target_pet ///The assigned target pet for the objective

/datum/objective/kill_pet/proc/find_pet_target()
	var/list/possible_target_pets = list(
		/mob/living/simple_animal/pet/dog/corgi/ian,
		/mob/living/simple_animal/pet/dog/corgi/puppy/ian,
		/mob/living/simple_animal/hostile/carp/lia,
		/mob/living/simple_animal/hostile/retaliate/bat/sgt_araneus,
		/mob/living/simple_animal/pet/fox/renault,
 		/mob/living/simple_animal/pet/cat/runtime,
 		/mob/living/simple_animal/parrot/poly,
 	)

	remove_duplicate(possible_target_pets) //removes pets from the list that are already in the owner's objective
	var/chosen_pet
	while(!target_pet)
		chosen_pet = pick(possible_target_pets)
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
	return completed || (target_pet?.stat == DEAD)

//scientist killing

/datum/objective/assassinate/proc/find_sci_target()
	var/list/sci_targets = list()
	for(var/mob/living/carbon/human/player as anything in GLOB.human_list)
		if(player.stat == DEAD)
			continue
		if((player.mind?.assigned_role.departments_bitflags & DEPARTMENT_BITFLAG_SCIENCE))
			sci_targets += player.mind

	for(var/datum/objective/assassinate/kill in owner.get_all_objectives())
		if(kill.target in sci_targets)
			sci_targets -= kill.target

	if(!sci_targets.len)
		find_target()
		return
	else
		target = pick(sci_targets)

	if(target?.current)
		explanation_text = "Make a stance against science's animal experimentation by assassinating [target.name] the [!target_role_type ? target.assigned_role.title : target.special_role]!"




/datum/objective/assassinate/proc/find_head_target()
	var/list/com_targets = SSjob.get_all_heads()
	if(!com_targets.len)
		find_target()
		return
	else
		target = pick(com_targets)
	update_explanation_text()


//Mauradars Objectives

//emagging emergency shuttle console

/datum/objective/emag_console
	name = "Emag the emergency shuttle console"
	explanation_text = "Give the crew a bumpy ride back home by emagging the emergency shuttle console!"

/datum/objective/emag_console/check_completion()
	var/check_emag = FALSE
	for(var/obj/machinery/computer/emergency_shuttle/console in GLOB.machines)
		if(console.obj_flags & EMAGGED)
			check_emag = TRUE
			break

	return completed || check_emag

