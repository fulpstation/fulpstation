/datum/antagonist/traitor/fulp_infiltrator
	name = "Infiltrator"
	antagpanel_category = "Infiltrator"
	job_rank = ROLE_INFILTRATOR
	hijack_speed = 1
	hud_icon = 'fulp_modules/icons/antagonists/infiltrators/infils.dmi'
	antag_hud_name = "infil_hud"
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	preview_outfit = /datum/outfit/infiltrator

	///If set, this is the employer that Admins have set.
	var/admin_selected
	///List of all possible Employers that can be assigned.
	var/static/list/possible_employers = list(
		INFILTRATOR_FACTION_CORPORATE_CLIMBER,
		INFILTRATOR_FACTION_ANIMAL_RIGHTS_CONSORTIUM,
		INFILTRATOR_FACTION_GORLEX_MARAUDERS,
		INFILTRATOR_FACTION_SELF
	)

/datum/antagonist/traitor/fulp_infiltrator/proc/equip_infiltrator(mob/living/carbon/human/infiltrator = owner.current)
	switch(employer)
		if(INFILTRATOR_FACTION_CORPORATE_CLIMBER)
			return infiltrator.equipOutfit(/datum/outfit/infiltrator/cc)
		if(INFILTRATOR_FACTION_ANIMAL_RIGHTS_CONSORTIUM)
			return infiltrator.equipOutfit(/datum/outfit/infiltrator/arc)
		if(INFILTRATOR_FACTION_GORLEX_MARAUDERS)
			return infiltrator.equipOutfit(/datum/outfit/infiltrator/gm)
		if(INFILTRATOR_FACTION_SELF)
			return infiltrator.equipOutfit(/datum/outfit/infiltrator/self)

/datum/antagonist/traitor/fulp_infiltrator/on_gain()
	. = ..()
	owner.current.mind.set_assigned_role(SSjob.get_job_type(/datum/job/infiltrator))
	owner.current.mind.special_role = ROLE_INFILTRATOR
	uplink_handler.has_progression = FALSE
	uplink_handler.has_objectives = FALSE
	uplink_handler.maximum_potential_objectives = 0

/datum/antagonist/traitor/fulp_infiltrator/admin_add(datum/mind/new_owner, mob/admin)
	var/choice = tgui_input_list(admin, "What affiliation would you like [new_owner] to have?", "Affiliation", possible_employers)
	if(!choice)
		return
	admin_selected = choice
	return ..()

/datum/antagonist/traitor/fulp_infiltrator/pick_employer()
	if(admin_selected)
		employer = admin_selected
	else
		employer = pick(possible_employers)

	equip_infiltrator(owner.current)
	forge_traitor_objectives()
	if(employer == INFILTRATOR_FACTION_SELF)
		traitor_flavor = strings("infiltrator_self.json", "S.E.L.F", "fulp_modules/strings/infiltrator")
	else
		traitor_flavor = strings(TRAITOR_FLAVOR_FILE, employer)

/datum/job/infiltrator
	title = ROLE_INFILTRATOR

/datum/outfit/infiltrator
	name = "Infiltrator"
	uniform = /obj/item/clothing/under/chameleon
	suit = /obj/item/clothing/suit/space/syndicate
	glasses = /obj/item/clothing/glasses/night
	mask = /obj/item/clothing/mask/gas/syndicate
	head = /obj/item/clothing/head/helmet/space/syndicate
	ears = /obj/item/radio/headset
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival/infil = 1,
		/obj/item/knife/combat/survival = 1,
		/obj/item/infiltrator_radio = 1,
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
	l_pocket = /obj/item/infil_uplink

/datum/outfit/infiltrator/arc
	name = "Animal Rights Consortium Infiltrator"
	suit = /obj/item/clothing/suit/space/syndicate/green
	head = /obj/item/clothing/head/helmet/space/syndicate/green
	l_pocket = /obj/item/gorilla_serum

/datum/outfit/infiltrator/gm
	name = "Gorlex Marauders Infiltrator"
	suit = /obj/item/clothing/suit/space/syndicate/black/red
	head = /obj/item/clothing/head/helmet/space/syndicate/black/red
	r_hand = /obj/item/missile_disk
	l_pocket = /obj/item/missilephone


/datum/outfit/infiltrator/self
	name = "S.E.L.F Infiltrator"
	suit = /obj/item/clothing/suit/space/syndicate/black/orange
	head = /obj/item/clothing/head/helmet/space/syndicate/black/orange
	r_hand = /obj/item/aicard
	l_pocket = /obj/item/grenade/c4/wormhole

/datum/antagonist/infiltrator_backup
	name = "Infiltrator Reinforcement"
	antagpanel_category = "Infiltrator"
	job_rank = ROLE_INFILTRATOR
	hijack_speed = 1
	hud_icon = 'fulp_modules/icons/antagonists/infiltrators/infils.dmi'
	antag_hud_name = "infil_hud"
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	///the owner of this kid
	var/datum/antagonist/traitor/fulp_infiltrator/purchaser

/datum/antagonist/infiltrator_backup/on_gain()
	if(!purchaser)
		return
	owner.enslave_mind_to_creator(purchaser.owner.current)
	var/datum/objective/custom/custom = new
	custom.owner = owner
	custom.name = "Aid [purchaser.owner.name]"
	custom.explanation_text = "Aid [purchaser.owner.name] with their goals!"
	objectives += custom
	var/mob/living/carbon/human/infiltrator = owner.current
	infiltrator.equipOutfit(/datum/outfit/infiltrator_reinforcement)
	return ..()

/datum/outfit/infiltrator_reinforcement
	name = "Infiltrator Reinforcement"
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/jacket/oversized
	gloves = /obj/item/clothing/gloves/fingerless
	glasses = /obj/item/clothing/glasses/sunglasses
	mask = /obj/item/cigarette/cigar
	ears = /obj/item/radio/headset
	back = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/storage/box/survival/infil = 1,
		/obj/item/knife/combat/survival = 1,
	)
/obj/item/storage/box/survival/infil
	// This is just like /box/survival/syndie, but without the misleading paper about explosive implants.
	name = "infiltration-ready survival box"
	desc = "A box with the essentials for your infiltration. This one is labelled to contain an extended-capacity tank."
	icon_state = "syndiebox"
	illustration = "extendedtank"
	mask_type = /obj/item/clothing/mask/gas/syndicate
	internal_type = /obj/item/tank/internals/emergency_oxygen/engi
	medipen_type = /obj/item/reagent_containers/hypospray/medipen/atropine

/obj/item/storage/box/survival/infil/PopulateContents()
	..()
	new /obj/item/crowbar/red(src)
	new /obj/item/screwdriver/red(src)
	new /obj/item/weldingtool/mini(src)
