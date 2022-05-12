/datum/antagonist/traitor/infiltrator
	name = "Infiltrator"
	antagpanel_category = "Infiltrator"
	job_rank = ROLE_INFILTRATOR
	hijack_speed = 1
	antag_hud_name = "traitor"
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	preview_outfit = /datum/outfit/infiltrator
	var/give_equipment = TRUE ///gives infiltrators equipment

/datum/job/infiltrator
	title = ROLE_INFILTRATOR


/datum/antagonist/traitor/infiltrator/proc/equip_infiltrator(mob/living/carbon/human/infiltrator = owner.current)
	switch(employer)
		if(INFILTRATOR_FACTION_CORPORATE_CLIMBER)
			return infiltrator.equipOutfit(/datum/outfit/infiltrator/cc)
		if(INFILTRATOR_FACTION_ANIMAL_RIGHTS_CONSORTIUM)
			return infiltrator.equipOutfit(/datum/outfit/infiltrator/arc)
		if(INFILTRATOR_FACTION_GORLEX_MARAUDERS)
			return infiltrator.equipOutfit(/datum/outfit/infiltrator/gm)


/datum/antagonist/traitor/infiltrator/on_gain()
	..()
	owner.current.mind.set_assigned_role(SSjob.GetJobType(/datum/job/infiltrator))
	owner.current.mind.special_role = ROLE_INFILTRATOR
	uplink_handler.has_progression = FALSE
	uplink_handler.has_objectives = FALSE

/datum/antagonist/traitor/infiltrator/pick_employer(faction)
	faction = prob(70) ? FACTION_SYNDICATE : FACTION_NANOTRASEN
	if(faction == FACTION_NANOTRASEN)
		employer = INFILTRATOR_FACTION_CORPORATE_CLIMBER
	else
		employer = pick(INFILTRATOR_FACTION_ANIMAL_RIGHTS_CONSORTIUM , INFILTRATOR_FACTION_GORLEX_MARAUDERS)
	if(give_equipment)
		equip_infiltrator(owner.current)
	forge_traitor_objectives()
	traitor_flavor = strings(TRAITOR_FLAVOR_FILE, employer)

/datum/outfit/infiltrator
	name = "Infiltrator"
	uniform = /obj/item/clothing/under/chameleon
	suit = /obj/item/clothing/suit/space/syndicate
	glasses = /obj/item/clothing/glasses/night
	mask = /obj/item/clothing/mask/gas/syndicate
	head = /obj/item/clothing/head/helmet/space/syndicate
	ears = /obj/item/radio/headset
	back = /obj/item/storage/backpack/old
	backpack_contents = list(
		/obj/item/storage/box/survival/syndie = 1,
		/obj/item/knife/combat/survival = 1,
	)
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/chameleon/operative
	l_hand = /obj/item/tank/jetpack/oxygen
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/combat
	r_pocket = /obj/item/tank/internals/emergency_oxygen
	internals_slot = ITEM_SLOT_RPOCKET

/datum/outfit/infiltrator/cc
	name = "Corporate Climber Infiltrator"
	suit = /obj/item/clothing/suit/space/syndicate/blue
	head = /obj/item/clothing/head/helmet/space/syndicate/blue
	r_hand = /obj/item/adv_mulligan

/datum/outfit/infiltrator/arc
	name = "Animal Rights Consortium Infiltrator"
	suit = /obj/item/clothing/suit/space/syndicate/green
	head = /obj/item/clothing/head/helmet/space/syndicate/green

/datum/outfit/infiltrator/gm
	name = "Gorlex Marauders Infiltrator"
	suit = /obj/item/clothing/suit/space/syndicate/orange
	head = /obj/item/clothing/head/helmet/space/syndicate/orange
	r_hand = /obj/item/card/emag



