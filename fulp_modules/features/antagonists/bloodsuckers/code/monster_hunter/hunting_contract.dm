/obj/item/hunting_contract
	name = "\improper Hunter's Contract"
	desc = "Should I have my lawyer read this?"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll2"
	w_class = WEIGHT_CLASS_SMALL
	var/bought = FALSE
	var/datum/hunter_market/shop
	var/selected_item
	var/datum/antagonist/monsterhunter/owner

/obj/item/hunting_contract/Initialize(mapload)
	. = ..()
	shop = new /datum/hunter_market
	for(var/datum/antagonist/monsterhunter/moh in GLOB.antagonists)
		if(!moh)
			continue
		owner = moh

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

/obj/item/hunting_contract/proc/purchase(item, user)
	var/purchased
	for(var/datum/hunter_weapons/contraband in shop.weapons)
		if(contraband.type != item)
			continue
		var/shit = contraband.item
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
	var/name
	var/desc
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
