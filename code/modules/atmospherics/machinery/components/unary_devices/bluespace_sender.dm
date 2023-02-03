/obj/machinery/atmospherics/components/unary/bluespace_sender
	icon = 'icons/obj/atmospherics/components/bluespace_gas_selling.dmi'
	icon_state = "bluespace_sender_off"
	base_icon_state = "bluespace_sender"
	name = "Bluespace Gas Sender"
	desc = "Sends gases to the bluespace network to be shared with the connected vendors, who knows what's beyond!"

	density = TRUE
	max_integrity = 300
	armor_type = /datum/armor/unary_bluespace_sender
	layer = OBJ_LAYER
	circuit = /obj/item/circuitboard/machine/bluespace_sender
	move_resist = MOVE_RESIST_DEFAULT
	set_dir_on_move = FALSE
	pipe_flags = PIPING_ONE_PER_TURF | PIPING_DEFAULT_LAYER_ONLY

	///Gas mixture containing the inserted gases and that is connected to the vendors
	var/datum/gas_mixture/bluespace_network
	///Rate of gas transfer inside the network (from 0 to 1)
	var/gas_transfer_rate = 0.5
	///A base price for each and every gases, in case you don't want to change them
	var/list/base_prices = list()
	///List storing all the vendors connected to the machine
	var/list/vendors
	///Amount of credits gained from each vendor
	var/credits_gained = 0

/// All bluespace gas senders
GLOBAL_LIST_EMPTY_TYPED(bluespace_senders, /obj/machinery/atmospherics/components/unary/bluespace_sender)

/datum/armor/unary_bluespace_sender
	energy = 100
	fire = 80
	acid = 30

/obj/machinery/atmospherics/components/unary/bluespace_sender/Initialize(mapload)
	. = ..()
	initialize_directions = dir
	bluespace_network = new
	for(var/gas_id in GLOB.meta_gas_info)
		bluespace_network.assert_gas(gas_id)
	for(var/gas_id in GLOB.meta_gas_info)
		var/datum/gas/gas = gas_id
		base_prices[gas_id] = initial(gas.base_value)

	GLOB.bluespace_senders += src

	update_appearance()

/obj/machinery/atmospherics/components/unary/bluespace_sender/Destroy()
	if(bluespace_network.total_moles())
		var/turf/local_turf = get_turf(src)
		local_turf.assume_air(bluespace_network)

	GLOB.bluespace_senders -= src

	return ..()

/obj/machinery/atmospherics/components/unary/bluespace_sender/update_icon_state()
	if(panel_open)
		icon_state = "[base_icon_state]_open"
		return ..()
	if(on && is_operational)
		icon_state = "[base_icon_state]_on"
		return ..()
	icon_state = "[base_icon_state]_off"
	return ..()

/obj/machinery/atmospherics/components/unary/bluespace_sender/update_overlays()
	. = ..()
	. += get_pipe_image(icon, "pipe", dir, , piping_layer)
	if(showpipe)
		. += get_pipe_image(icon, "pipe", initialize_directions)

/obj/machinery/atmospherics/components/unary/bluespace_sender/process_atmos()
	if(!is_operational || !on || !nodes[1])  //if it has no power or its switched off, dont process atmos
		return

	var/datum/gas_mixture/content = airs[1]
	var/datum/gas_mixture/remove = content.remove_ratio(gas_transfer_rate)
	bluespace_network.merge(remove)
	bluespace_network.temperature = T20C
	update_parents()

/obj/machinery/atmospherics/components/unary/bluespace_sender/screwdriver_act(mob/living/user, obj/item/tool)
	if(on)
		to_chat(user, span_notice("You can't open [src] while it's on!"))
		return TOOL_ACT_TOOLTYPE_SUCCESS
	if(!anchored)
		to_chat(user, span_notice("Anchor [src] first!"))
		return TOOL_ACT_TOOLTYPE_SUCCESS
	if(default_deconstruction_screwdriver(user, "[base_icon_state]_open", "[base_icon_state]", tool))
		change_pipe_connection(panel_open)
		return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/machinery/atmospherics/components/unary/bluespace_sender/crowbar_act(mob/living/user, obj/item/tool)
	default_deconstruction_crowbar(tool, custom_deconstruct = bluespace_network.total_moles() > 0 ? TRUE : FALSE)
	say("WARNING - Bluespace network can contain hazardous gases, deconstruct with caution!")
	if(!do_after(user, 3 SECONDS, src))
		return
	tool.play_tool_sound(src, 50)
	deconstruct(TRUE)

/obj/machinery/atmospherics/components/unary/bluespace_sender/multitool_act(mob/living/user, obj/item/item)
	var/obj/item/multitool/multitool = item
	multitool.buffer = src
	to_chat(user, span_notice("You store linkage information in [item]'s buffer."))
	return TRUE

/obj/machinery/atmospherics/components/unary/bluespace_sender/wrench_act(mob/living/user, obj/item/tool)
	return default_change_direction_wrench(user, tool)

/obj/machinery/atmospherics/components/unary/bluespace_sender/wrench_act_secondary(mob/living/user, obj/item/tool)
	if(!panel_open)
		return
	if(default_unfasten_wrench(user, tool))
		return TOOL_ACT_TOOLTYPE_SUCCESS
	return

/obj/machinery/atmospherics/components/unary/bluespace_sender/default_change_direction_wrench(mob/user, obj/item/item)
	if(!..())
		return FALSE
	set_init_directions()
	update_appearance()
	return TRUE

/obj/machinery/atmospherics/components/unary/bluespace_sender/CtrlClick(mob/living/user)
	if(!panel_open)
		if(!can_interact(user))
			return
		on = !on
		investigate_log("was turned [on ? "on" : "off"] by [key_name(user)]", INVESTIGATE_ATMOS)
		update_appearance()
		return
	. = ..()

/obj/machinery/atmospherics/components/unary/bluespace_sender/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BluespaceSender", name)
		ui.open()

/obj/machinery/atmospherics/components/unary/bluespace_sender/ui_data(mob/user)
	var/list/data = list()
	data["on"] = on
	data["gas_transfer_rate"] = gas_transfer_rate
	var/list/bluespace_gasdata = list()
	if(bluespace_network.total_moles())
		for(var/gas_id in bluespace_network.gases)
			bluespace_gasdata.Add(list(list(
			"name" = bluespace_network.gases[gas_id][GAS_META][META_GAS_NAME],
			"id" = bluespace_network.gases[gas_id][GAS_META][META_GAS_ID],
			"amount" = round(bluespace_network.gases[gas_id][MOLES], 0.01),
			"price" = base_prices[gas_id],
			)))
	else
		for(var/gas_id in bluespace_network.gases)
			bluespace_gasdata.Add(list(list(
				"name" = bluespace_network.gases[gas_id][GAS_META][META_GAS_NAME],
				"id" = "",
				"amount" = 0,
				"price" = 0,
				)))
	data["bluespace_network_gases"] = bluespace_gasdata
	var/list/vendors_list = list()
	if(vendors)
		for(var/obj/machinery/bluespace_vendor/vendor in vendors)
			vendors_list.Add(list(list(
				"name" = vendor.name,
				"area" = get_area(vendor),
			)))
	data["vendors_list"] = vendors_list
	data["credits"] = credits_gained
	return data

/obj/machinery/atmospherics/components/unary/bluespace_sender/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("power")
			on = !on
			investigate_log("was turned [on ? "on" : "off"] by [key_name(usr)]", INVESTIGATE_ATMOS)
			update_appearance()
			. = TRUE

		if("rate")
			gas_transfer_rate = clamp(params["rate"], 0, 1)
			. = TRUE

		if("price")
			var/gas_type = gas_id2path(params["gas_type"])
			base_prices[gas_type] = clamp(params["gas_price"], 0, 100)
			. = TRUE

		if("retrieve")
			if(bluespace_network.total_moles() > 0)
				var/datum/gas_mixture/remove = bluespace_network.remove(bluespace_network.total_moles())
				airs[1].merge(remove)
				update_parents()
				bluespace_network.garbage_collect()
			. = TRUE

/obj/machinery/atmospherics/components/unary/bluespace_sender/update_layer()
	return
