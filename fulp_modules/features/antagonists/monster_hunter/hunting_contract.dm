/obj/item/hunting_contract
	name = "\improper Hunter's Contract"
	desc = "A contract detailing all the guidelines a good hunter needs."
	icon = 'icons/obj/scrolls.dmi'
	icon_state = "scroll2"
	w_class = WEIGHT_CLASS_SMALL
	///have we claimed our weapon?
	var/bought = FALSE
	///the datum containing all weapons
	var/list/datum/hunter_weapons/weapons = list()
	///the weapon that we have purchased
	var/datum/hunter_weapons/selected_item
	///the owner of this contract
	var/datum/antagonist/monsterhunter/owner

	///Boolean on whether all objectives have been completed.
	var/objectives_completed = FALSE
	///Boolean on whether the contract has given it's final objective.
	var/used_up = FALSE

/obj/item/hunting_contract/Initialize(mapload, datum/antagonist/monsterhunter/hunter)
	. = ..()
	for(var/items in subtypesof(/datum/hunter_weapons))
		weapons += new items
	if(hunter)
		owner = hunter

/obj/item/hunting_contract/ui_interact(mob/living/user, datum/tgui/ui)
	if(!IS_MONSTERHUNTER(user))
		to_chat(usr, span_notice("You are unable to decipher the symbols."))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HunterContract", name)
		ui.open()

/obj/item/hunting_contract/ui_data(mob/user)
	var/list/data = list()
	data["bought"] = bought
	data["items"] = list()
	data["objectives"] = list()
	if(weapons.len)
		for(var/datum/hunter_weapons/contraband as anything in weapons)
			data["items"] += list(list(
				"id" = contraband.type,
				"name" = contraband.name,
				"desc" = contraband.desc,
			))
	if(owner)
		data["rabbits_found"] = !(owner.rabbits.len)
		data["used_up"] = used_up
		var/objective_unfinished = FALSE
		for(var/datum/objective/existing_objective as anything in owner.objectives)
			var/completed = existing_objective.check_completion()
			if(completed)
				continue
			data["objectives"] += list(list("explanation" = existing_objective.explanation_text))
			objective_unfinished = TRUE
		objectives_completed = !objective_unfinished
		data["all_completed"] = objectives_completed
	return data

/obj/item/hunting_contract/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("select")
			if(isnull(params["item"]))
				return
			var/datum/hunter_weapons/item = text2path(params["item"])
			if(!ispath(item))
				return
			selected_item = item
			. = TRUE
			purchase(selected_item, usr)
		if("claim_reward")
			if(!objectives_completed || length(owner.rabbits) || used_up)
				return
			if(!is_station_level(loc.z))
				to_chat(usr, span_warning("The pull of the ice moon isn't strong enough here...."))
				return
			SEND_SIGNAL(owner, COMSIG_BEASTIFY)
			used_up = TRUE


/obj/item/hunting_contract/proc/purchase(item, user)
	var/obj/item/purchased
	for(var/datum/hunter_weapons/contraband as anything in weapons)
		if(contraband.type != item)
			continue
		bought = TRUE
		purchased = new contraband.item

	var/datum/action/cooldown/spell/summonitem/recall = new()
	recall.mark_item(purchased)
	recall.Grant(user)

	podspawn(list(
		"target" = get_turf(user),
		"style" = STYLE_SYNDICATE,
		"spawn" = purchased,
		))

/obj/item/hunting_contract/Destroy()
	owner = null
	weapons = null
	return ..()

/datum/hunter_weapons
	///name of the weapon
	var/name
	///description of the weapon that will appear on the UI
	var/desc
	///path of the weapon
	var/item

/datum/hunter_weapons/threaded_cane
	name = "Threaded cane"
	desc = "cane made out of heavy metal, can transform into a whip to strike foes from afar."
	item = /obj/item/melee/trick_weapon/threaded_cane


/datum/hunter_weapons/hunter_axe
	name = "Hunter's axe"
	desc = "simple axe for hunters that lean towards barbarian tactics, can transform into a double bladed axe."
	item = /obj/item/melee/trick_weapon/hunter_axe

/datum/hunter_weapons/darkmoon_greatsword
	name = "Darkmoon greatsword"
	desc = "a heavy sword hilt that would knock anyone out cold, can transform into the darkmoonlight greatsword. "
	item = /obj/item/melee/trick_weapon/darkmoon


