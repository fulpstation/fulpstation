/obj/item/hunting_contract
	name = "\improper Hunter's Contract"
	desc = "Should I have my lawyer read this?"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll2"
	w_class = WEIGHT_CLASS_SMALL
	///have we claimed our weapon?
	var/bought = FALSE
	///the datum containing all weapons
	var/datum/hunter_market/shop
	///the weapon that we have purchased
	var/selected_item
	///the owner of this contract
	var/datum/antagonist/monsterhunter/owner

/obj/item/hunting_contract/Initialize(mapload, datum/antagonist/monsterhunter/hunter)
	. = ..()
	shop = new /datum/hunter_market
	if(hunter)
		owner = hunter

/obj/item/hunting_contract/ui_interact(mob/living/user, datum/tgui/ui)
	if(!IS_MONSTERHUNTER(user))
		to_chat(usr, span_notice("What the hell do these symbols mean?"))
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
	if(shop)
		for(var/datum/hunter_weapons/contraband in shop.weapons)
			data["items"] += list(list(
			"id" = contraband.type,
			"name" = contraband.name,
			"desc" = contraband.desc,
				))
	if(owner)
		for(var/datum/objective/obj in owner.objectives)
			data["objectives"] += list(list(
			"explanation" = obj.explanation_text,
			"completed" = (obj.check_completion()),
			))
		data["rabbits_found"] = !(owner.sickness.white_rabbits.len)
	return data

/obj/item/hunting_contract/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("select")
			if(isnull(params["item"]))
				return
			var/item = text2path(params["item"])
			selected_item = item
			. = TRUE
			purchase(selected_item, usr)
		if("claim_reward")
			var/mob/living/simple_animal/hostile/megafauna/red_rabbit/evil_rabbit
			evil_rabbit = new /mob/living/simple_animal/hostile/megafauna/red_rabbit(get_turf(usr))
			usr.mind.transfer_to(evil_rabbit)
			var/mob/living/carbon/human/man = usr
			man.gib()
			var/datum/objective/survive/destruction = new
			destruction.name = "Wreak Havoc"
			destruction.explanation_text = "Wreak havoc upon the station"
			destruction.owner = owner.owner
			owner.objectives += destruction


/obj/item/hunting_contract/proc/purchase(item, user)
	var/purchased
	for(var/datum/hunter_weapons/contraband in shop.weapons)
		if(contraband.type != item)
			continue
		bought = TRUE
		purchased = contraband.item

	podspawn(list(
		"target" = get_turf(user),
		"style" = STYLE_SYNDICATE,
		"spawn" = purchased,
		))


/datum/hunter_market
	var/name = "Hunter's market"
	var/list/datum/hunter_weapons/weapons = list()

/datum/hunter_market/New()
	for(var/items in subtypesof(/datum/hunter_weapons))
		weapons += new items


/datum/hunter_weapons
	///name of the weapon
	var/name
	///description of the weapon that will appear on the UI
	var/desc
	///path of the weapon
	var/item

/datum/hunter_weapons/threaded_cane
	name = "threaded cane"
	desc = "cane made out of heavy metal, can transform into a whip to strike foes from afar."
	item = /obj/item/melee/trick_weapon/threaded_cane


/datum/hunter_weapons/hunter_axe
	name = "hunter's axe"
	desc = "simple axe for hunters that lean towards barbarian tactics, can transform into a double bladed axe."
	item = /obj/item/melee/trick_weapon/hunter_axe

/datum/hunter_weapons/darkmoon_greatsword
	name = "Darkmoon greatsword"
	desc = "a heavy sword hilt that would knock anyone out cold, can transform into the darkmoonlight greatsword. "
	item = /obj/item/melee/trick_weapon/darkmoon


/obj/item/hunting_contract/Destroy()
	owner = null
	shop = null
	return ..()
