/datum/infil_corpmarket
	var/name = "Infiltrator Market"
	///all the categories within the market
	var/list/datum/infil_corpmarket/category = list()


/datum/infil_corpmarket/New()
	for(var/categories in subtypesof(/datum/corp_category))
		category += new categories


/datum/corp_category
	///name of the category
	var/name
	///items contained in the category
	var/list/datum/infil_corpitem/item = list()



/datum/corp_category/assault
	name = "ASSAULT"

/datum/corp_category/assault/New()
	for(var/items in subtypesof(/datum/infil_corpitem/assault))
		item += new items

/datum/corp_category/support
	name = "SUPPORT"

/datum/corp_category/support/New()
	for(var/items in subtypesof(/datum/infil_corpitem/support))
		item += new items

/datum/corp_category/ammo
	name = "AMMUNITION"

/datum/corp_category/ammo/New()
	for(var/items in subtypesof(/datum/infil_corpitem/ammo))
		item += new items

/datum/infil_corpitem
	///name of the item
	var/name
	///cost of the item
	var/cost
	///path of the item
	var/item
	///description of the item
	var/desc


///////////////////Uplink items

//////assault

/datum/infil_corpitem/assault/sniper
	name = "Sniper"
	cost = 30
	item = /obj/item/gun/ballistic/rifle/sniper_rifle
	desc = "Smoke some fools from a distance!"

/datum/infil_corpitem/assault/surplus_smg
	name = "Smart-SMG"
	cost = 30
	item = /obj/item/gun/ballistic/automatic/smartgun
	desc = "An outdated model of Smart-SMG. Its rounds will track and follow their targets."

/datum/infil_corpitem/assault/wt550
	name = "Security Auto Rifle"
	cost = 30
	item = /obj/item/gun/ballistic/automatic/wt550
	desc = "A model discontinued by Nanotrasen, we managed to find a whole crate of it just floating in space!"

/datum/infil_corpitem/ammo/sniper_ammo
	name = "Sniper Rounds"
	cost = 10
	item = /obj/item/ammo_box/magazine/sniper_rounds
	desc = "An extra magazine for the Sniper rifle."

////////ammunition

/datum/infil_corpitem/ammo/surplus_smg
	name = "Smart-SMG Magazine"
	cost = 10
	item = /obj/item/ammo_box/magazine/smartgun
	desc = "A large box magazine for the smart-SMG."

/datum/infil_corpitem/ammo/wt550
	name = "WT550 Magazine"
	cost = 10
	item = /obj/item/ammo_box/magazine/wt550m9
	desc = "An extra magazine for the Security Rifle."

////////support

/datum/infil_corpitem/support/backup
	name = "Request Backup"
	cost = 30
	item = /obj/item/antag_spawner/nuke_ops/infiltrator_backup
	desc = "Contact corporate for reinforcements."

/datum/infil_corpitem/support/shield
	name = "Energy Shield"
	item = /obj/item/shield/energy
	cost = 20
	desc = "Shield capable of reflecting energy projectiles!"


/////////////////////uplink object and UI


/obj/item/infil_uplink
	name = "\improper Corporate Uplink"
	desc = "What a beautiful looking radio"
	icon = 'fulp_modules/icons/antagonists/infiltrators/infils.dmi'
	icon_state = "infiltrator_uplink"
	w_class = WEIGHT_CLASS_SMALL
	///current category we viewing on the ui
	var/datum/corp_category/viewing_category
	/// What item is the current uplink attempting to buy?
	var/datum/infil_corpitem/selected_item
	///are we currently buying somth
	var/buying
	///the market we's connected to
	var/datum/infil_corpmarket/market
	///how many points are left
	var/currency = 50
	///is the uplink connected to HQ
	var/connected = FALSE
	///the area we need to be in to connect to HQ
	var/area/connecting_zone

/obj/item/infil_uplink/proc/set_connecting_zone()
	for(var/sanity in 1 to 100)
		var/area/selected_area = pick(get_sorted_areas())
		if(!is_station_level(selected_area.z) || !(selected_area.area_flags & VALID_TERRITORY))
			continue
		connecting_zone = selected_area
		break

/obj/item/infil_uplink/Initialize(mapload)
	. = ..()
	set_connecting_zone()
	add_overlay("uplink_seeking")
	market = new /datum/infil_corpmarket
	viewing_category = market.category[1]

/obj/item/infil_uplink/ui_interact(mob/living/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		add_overlay("uplink_on")
		ui = new(user, src, "InfilMarketUplink", name)
		ui.open()

/obj/item/infil_uplink/ui_close(mob/living/user)
	. = ..()
	cut_overlay("uplink_on")

/obj/item/infil_uplink/proc/check_area()
	return (get_area(src) == connecting_zone)

/obj/item/infil_uplink/ui_data(mob/user)
	var/list/data = list()
	data["categories"] = market.category
	data["currency"] = currency
	data["buying"] = buying
	data["items"] = list()
	data["viewing_category"] = viewing_category
	data["connected"] = connected
	data["area"] = check_area()
	data["connecting_zone"] = connecting_zone.name
	if(viewing_category)
		for(var/datum/infil_corpitem/contraband in viewing_category.item)
			data["items"] += list(list(
				"id" = contraband.type,
				"name" = contraband.name,
				"desc" = contraband.desc,
				"cost" = contraband.cost,
			))
	return data

/obj/item/infil_uplink/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("set_category")
			if(isnull(params["category"]))
				return
			if(params["category"] == "ASSAULT") //idfk how else to do this shit
				viewing_category = market.category[1]
			if(params["category"] == "SUPPORT")
				viewing_category = market.category[2]
			if(params["category"] == "AMMUNITION")
				viewing_category = market.category[3]

			. = TRUE
		if("select")
			if(isnull(params["item"]))
				return
			var/datum/infil_corpitem/item = text2path(params["item"])
			if(!ispath(item))
				return
			selected_item = item
			buying = TRUE
			. = TRUE
			purchase(selected_item, viewing_category, usr)

			buying = FALSE
			selected_item = null
		if("connect")
			if((get_area(usr) != connecting_zone))
				to_chat(usr, span_notice("The signal isn't strong enough here to contact HQ!"))
				return
			var/datum/antagonist/traitor/fulp_infiltrator/terrorist = usr.mind.has_antag_datum(/datum/antagonist/traitor/fulp_infiltrator)
			if(!terrorist)
				return
			var/datum/objective/connect_uplink/terrorism = locate() in terrorist.objectives
			if(!terrorism)
				return
			terrorism.completed = TRUE
			cut_overlay("uplink_seeking")
			add_overlay("uplink_found")
			playsound(src, 'sound/machines/beep/beep.ogg', 50, FALSE)

			connected = TRUE

/obj/item/infil_uplink/proc/purchase(item, category, user)
	var/purchased
	for(var/datum/infil_corpitem/contraband in viewing_category.item)
		if(contraband.type != item)
			continue
		currency -= contraband.cost
		purchased = contraband.item

	podspawn(list(
		"target" = get_turf(user),
		"style" = /datum/pod_style/syndicate,
		"spawn" = purchased,
		))


