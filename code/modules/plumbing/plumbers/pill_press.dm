///We take a constant input of reagents, and produce a pill once a set volume is reached
/obj/machinery/plumbing/pill_press
	name = "chemical press"
	desc = "A press that makes pills, patches and bottles."
	icon_state = "pill_press"
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 2
	///category for plumbing RCD
	category="Storage"

	///maximum size of a pill
	var/max_pill_volume = 50
	///maximum size of a patch
	var/max_patch_volume = 40
	///maximum size of a bottle
	var/max_bottle_volume = 30
	///current operating product (pills or patches)
	var/product = "pill"
	///the minimum size a pill or patch can be
	var/min_volume = 5
	///the maximum size a pill or patch can be
	var/max_volume = 50
	///selected size of the product
	var/current_volume = 10
	///prefix for the product name
	var/product_name = "factory"
	///the icon_state number for the pill.
	var/pill_number = RANDOM_PILL_STYLE
	///list of id's and icons for the pill selection of the ui
	var/list/pill_styles
	/// Currently selected patch style
	var/patch_style = DEFAULT_PATCH_STYLE
	/// List of available patch styles for UI
	var/list/patch_styles
	///list of products stored in the machine, so we dont have 610 pills on one tile
	var/list/stored_products = list()
	///max amount of pills allowed on our tile before we start storing them instead
	var/max_floor_products = 10

/obj/machinery/plumbing/pill_press/examine(mob/user)
	. = ..()
	. += span_notice("The [name] currently has [stored_products.len] stored. There needs to be less than [max_floor_products] on the floor to continue dispensing.")

/obj/machinery/plumbing/pill_press/Initialize(mapload, bolt, layer)
	. = ..()

	AddComponent(/datum/component/plumbing/simple_demand, bolt, layer)

/obj/machinery/plumbing/pill_press/process(delta_time)
	if(machine_stat & NOPOWER)
		return
	if(reagents.total_volume >= current_volume)
		if (product == "pill")
			var/obj/item/reagent_containers/pill/P = new(src)
			reagents.trans_to(P, current_volume)
			P.name = trim("[product_name] pill")
			stored_products += P
			if(pill_number == RANDOM_PILL_STYLE)
				P.icon_state = "pill[rand(1,21)]"
			else
				P.icon_state = "pill[pill_number]"
			if(P.icon_state == "pill4") //mirrored from chem masters
				P.desc = "A tablet or capsule, but not just any, a red one, one taken by the ones not scared of knowledge, freedom, uncertainty and the brutal truths of reality."
		else if (product == "patch")
			var/obj/item/reagent_containers/pill/patch/P = new(src)
			reagents.trans_to(P, current_volume)
			P.name = trim("[product_name] patch")
			P.icon_state = patch_style
			stored_products += P
		else if (product == "bottle")
			var/obj/item/reagent_containers/cup/bottle/P = new(src)
			reagents.trans_to(P, current_volume)
			P.name = trim("[product_name] bottle")
			stored_products += P
	if(stored_products.len)
		var/pill_amount = 0
		for(var/thing in loc)
			if(!istype(thing, /obj/item/reagent_containers/cup/bottle) && !istype(thing, /obj/item/reagent_containers/pill))
				continue
			pill_amount++
			if(pill_amount >= max_floor_products) //too much so just stop
				break
		if(pill_amount < max_floor_products && anchored)
			var/atom/movable/AM = stored_products[1] //AM because forceMove is all we need
			stored_products -= AM
			AM.forceMove(drop_location())

	use_power(active_power_usage * delta_time)

/obj/machinery/plumbing/pill_press/proc/load_styles()
	//expertly copypasted from chemmasters
	var/datum/asset/spritesheet/simple/assets = get_asset_datum(/datum/asset/spritesheet/simple/pills)
	pill_styles = list()
	for (var/x in 1 to PILL_STYLE_COUNT)
		var/list/SL = list()
		SL["id"] = x
		SL["class_name"] = assets.icon_class_name("pill[x]")
		pill_styles += list(SL)
	var/datum/asset/spritesheet/simple/patches_assets = get_asset_datum(/datum/asset/spritesheet/simple/patches)
	patch_styles = list()
	for (var/raw_patch_style in PATCH_STYLE_LIST)
		//adding class_name for use in UI
		var/list/patch_style = list()
		patch_style["style"] = raw_patch_style
		patch_style["class_name"] = patches_assets.icon_class_name(raw_patch_style)
		patch_styles += list(patch_style)

/obj/machinery/plumbing/pill_press/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/simple/pills),
		get_asset_datum(/datum/asset/spritesheet/simple/patches),
	)

/obj/machinery/plumbing/pill_press/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ChemPress", name)
		ui.open()

/obj/machinery/plumbing/pill_press/ui_data(mob/user)
	if(!pill_styles || !patch_styles)
		load_styles()
	var/list/data = list()
	data["pill_style"] = pill_number
	data["current_volume"] = current_volume
	data["product_name"] = product_name
	data["pill_styles"] = pill_styles
	data["product"] = product
	data["min_volume"] = min_volume
	data["max_volume"] = max_volume
	data["patch_style"] = patch_style
	data["patch_styles"] = patch_styles
	return data

/obj/machinery/plumbing/pill_press/ui_act(action, params)
	. = ..()
	if(.)
		return
	. = TRUE
	switch(action)
		if("change_pill_style")
			pill_number = clamp(text2num(params["id"]), 1 , PILL_STYLE_COUNT)
		if("change_current_volume")
			current_volume = clamp(text2num(params["volume"]), min_volume, max_volume)
		if("change_product_name")
			var/formatted_name = html_encode(params["name"])
			if (length(formatted_name) > MAX_NAME_LEN)
				product_name = copytext(formatted_name, 1, MAX_NAME_LEN+1)
			else
				product_name = formatted_name
		if("change_product")
			product = params["product"]
			if (product == "pill")
				max_volume = max_pill_volume
			else if (product == "patch")
				max_volume = max_patch_volume
			else if (product == "bottle")
				max_volume = max_bottle_volume
			current_volume = clamp(current_volume, min_volume, max_volume)
		if("change_patch_style")
			patch_style = params["patch_style"]
