/datum/antagonist/traitor/fulp_infiltrator/forge_traitor_objectives()
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

			var/datum/objective/connect_uplink/uplink = new
			uplink.owner = owner
			var/mob/living/carbon/human/infil = owner.current
			var/obj/item/infil_uplink/radio = infil.l_store
			uplink.explanation_text = "Connect the Uplink Radio to HQ in [radio.connecting_zone]"
			objectives += uplink

		if(INFILTRATOR_FACTION_ANIMAL_RIGHTS_CONSORTIUM)
			for(var/i = 0, i < 2, i++)
				var/datum/objective/kill_pet/pet = new
				pet.owner = owner
				pet.find_pet_target()
				objectives += pet

			var/datum/objective/assassinate/kill = new
			kill.owner = owner
			kill.find_sci_target()
			objectives += kill

			var/datum/objective/gorillize/gorilla = new
			gorilla.owner = owner
			gorilla.find_target()
			objectives += gorilla

			var/mob/living/carbon/human/infil = owner.current
			var/obj/item/gorilla_serum/serum = infil.l_store
			serum.set_objective(owner.has_antag_datum(/datum/antagonist/traitor/fulp_infiltrator))

		if(INFILTRATOR_FACTION_GORLEX_MARAUDERS)
			for(var/i = 0, i < rand(3,5) , i++)
				var/datum/objective/assassinate/assassinate = new
				assassinate.owner = owner
				assassinate.find_target()
				objectives += assassinate

			var/datum/objective/missiles/rocket = new
			rocket.owner = owner
			rocket.update_explanation_text()
			objectives += rocket

		if(INFILTRATOR_FACTION_SELF)
			for(var/i = 0, i < 2 , i++)
				var/datum/objective/assassinate/assassinate = new
				assassinate.owner = owner
				assassinate.find_target()
				objectives += assassinate

			var/datum/objective/cyborg_hack/hacking = new
			hacking.owner = owner
			hacking.update_explanation_text()
			hacking.give_card()
			objectives += hacking

			var/datum/objective/summon_wormhole/wormhole = new
			wormhole.owner = owner
			var/mob/living/carbon/human/infil = owner.current
			var/obj/item/grenade/c4/wormhole/bomb = infil.l_store
			bomb.set_bombing_zone()
			wormhole.explanation_text = "Summon a cyborg rift in [bomb.bombing_zone]!"
			objectives += wormhole


/datum/antagonist/traitor/fulp_infiltrator/forge_ending_objective()
	return


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
		explanation_text = "Special intel has identified [target.name] the [!target_role_type ? target.assigned_role.title : target.special_role] as a Syndicate Agent, ensure they are eliminated."


//advanced mulligan objective

/datum/objective/escape/escape_with_identity/infiltrator
	name = "escape with identity (as infiltrator)"
	admin_grantable = TRUE

/datum/objective/escape/escape_with_identity/infiltrator/proc/find_sec_target()
	var/list/sec = SSjob.get_all_sec()
	if(!sec.len)
		find_target()
	else
		target = pick(sec)

	if(target?.current)
		target_real_name = target.current.real_name
		var/mob/living/carbon/human/target_body = target.current
		if(target_body && target_body.get_id_name() != target_real_name)
			target_missing_id = 1
		explanation_text = "Using Advanced Mulligan, steal the identity of [target.name] the [target.assigned_role.title] while wearing their ID card!"

/datum/objective/escape/escape_with_identity/infiltrator/check_completion()
	if(!target || !target_real_name)
		return TRUE
	var/mob/living/carbon/human/human = owner.current
	if(human.dna.real_name == target_real_name && (human.get_id_name() == target_real_name || target_missing_id))
		return TRUE

//Animal Rights Consortium Objectives

//pet killing

/datum/objective/kill_pet
	name = "Kill a command pet"
	martyr_compatible = TRUE
	admin_grantable = TRUE
	var/mob/living/target_pet ///The assigned target pet for the objective

/datum/objective/kill_pet/proc/find_pet_target()
	var/list/possible_target_pets = list(
		/mob/living/basic/pet/dog/corgi/ian,
		/mob/living/basic/pet/dog/corgi/puppy/ian,
		/mob/living/basic/pet/dog/pug/mcgriff,
		/mob/living/basic/carp/pet/lia,
		/mob/living/basic/spider/giant/sgt_araneus,
		/mob/living/basic/pet/fox/renault,
		/mob/living/basic/sloth/paperwork,
		/mob/living/basic/sloth/citrus,

		// le sad simple animals (let's kill them)
		/mob/living/basic/pet/cat/runtime,
		/mob/living/basic/parrot/poly,
 	)

	remove_duplicate(possible_target_pets) //removes pets from the list that are already in the owner's objective
	var/chosen_pet
	while(!target_pet && possible_target_pets.len)
		chosen_pet = pick(possible_target_pets)
		target_pet = locate(chosen_pet) in GLOB.mob_living_list
		if(!target_pet)
			possible_target_pets -= chosen_pet
			continue
		if(target_pet.stat == DEAD || istype(target_pet, /mob/living/basic/parrot/poly/ghost))
			target_pet = null
		possible_target_pets -= chosen_pet

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
	if(target_pet)
		return completed || (target_pet.stat == DEAD) || !locate(target_pet.type) in GLOB.mob_living_list
	return TRUE

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

/datum/objective/gorillize
	name = "Summon endangered gorilla"
	admin_grantable = TRUE
	var/target_role_type = FALSE

/datum/objective/gorillize/update_explanation_text()
	if(target?.current)
		explanation_text = "Inject [target.name] the [!target_role_type ? target.assigned_role.title : target.special_role] with the gorilla serum!"

// SELF objectives
/datum/objective/cyborg_hack
    name = "Emag Robot"

/datum/objective/cyborg_hack/update_explanation_text()
	explanation_text = "Steal a cyborg's data and subvert them by using your single-use silicon cryptographic sequencer on them!"

/datum/objective/cyborg_hack/proc/give_card()
	if(!owner)
		return
	var/mob/living/carbon/criminal = owner.current
	var/obj/item/card/emag/silicon_hack/card = new(criminal)
	var/list/slots = list ("backpack" = ITEM_SLOT_BACKPACK)
	criminal.equip_in_one_of_slots(card, slots)

/datum/objective/missiles
	name = "Missile Barrage"

/datum/objective/missiles/update_explanation_text()
		explanation_text = "Launch missiles towards the station by using the Missile Disk on a communications console and inserting it into the Large Handphone. "

/datum/objective/summon_wormhole
	name = "Summon a cyborg wormhole"


/datum/objective/connect_uplink
	name = "Connect uplink"
