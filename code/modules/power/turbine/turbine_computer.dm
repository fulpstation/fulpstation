/obj/machinery/computer/turbine_computer
	name = "gas turbine control computer"
	desc = "A computer to remotely control a gas turbine."
	icon_screen = "turbinecomp"
	icon_keyboard = "tech_key"
	circuit = /obj/item/circuitboard/computer/turbine_computer
	///Weakref of the connected machine to this computer
	var/datum/weakref/turbine_core
	///Easy way to connect a computer and a turbine roundstart by setting an id on both this and the core_rotor
	var/mapping_id

/obj/machinery/computer/turbine_computer/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/computer/turbine_computer/LateInitialize()
	. = ..()
	locate_machinery()

/obj/machinery/computer/turbine_computer/locate_machinery(multitool_connection)
	if(!mapping_id)
		return
	for(var/obj/machinery/power/turbine/core_rotor/main in GLOB.machines)
		if(main.mapping_id != mapping_id)
			continue
		register_machine(main)
		return

/obj/machinery/computer/turbine_computer/multitool_act(mob/living/user, obj/item/tool)
	var/obj/item/multitool/multitool = tool
	if(!istype(multitool.buffer, /obj/machinery/power/turbine/core_rotor))
		to_chat(user, span_notice("Wrong machine type in [multitool] buffer..."))
		return
	if(turbine_core)
		to_chat(user, span_notice("Changing [src] bluespace network..."))
	if(!do_after(user, 0.2 SECONDS, src))
		return
	playsound(get_turf(user), 'sound/machines/click.ogg', 10, TRUE)
	register_machine(multitool.buffer)
	to_chat(user, span_notice("You link [src] to the console in [multitool]'s buffer."))
	return TRUE

/obj/machinery/computer/turbine_computer/proc/register_machine(machine)
	turbine_core = WEAKREF(machine)

/obj/machinery/computer/turbine_computer/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TurbineComputer", name)
		ui.open()

/obj/machinery/computer/turbine_computer/ui_data(mob/user)
	var/list/data = list()

	var/obj/machinery/power/turbine/core_rotor/main_control = turbine_core?.resolve()

	data["connected"] = main_control ? TRUE : FALSE
	if(!main_control)
		return
	data["active"] = main_control.active
	data["rpm"] = main_control.rpm ? main_control.rpm : 0
	data["power"] = main_control.produced_energy ? main_control.produced_energy : 0
	data["temp"] = main_control.input_turf?.air.temperature
	data["integrity"] = main_control.get_turbine_integrity()
	data["parts_linked"] = main_control.all_parts_connected
	data["parts_ready"] = main_control.all_parts_ready()

	data["max_rpm"] = main_control.max_allowed_rpm
	data["max_temperature"] = main_control.max_allowed_temperature

	data["can_turn_off"] = main_control.rpm < 1000

	data["regulator"] = main_control.intake_regulator

	return data

/obj/machinery/computer/turbine_computer/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("toggle_power")
			var/obj/machinery/power/turbine/core_rotor/main_control = turbine_core?.resolve()
			if(!main_control || !main_control.all_parts_connected || main_control.rpm > 1000)
				return TRUE
			if(!main_control.activate_parts(usr, check_only = TRUE))
				return TRUE
			main_control.toggle_power()
			main_control.rpm = 0
			main_control.produced_energy = 0
			. = TRUE
		if("regulate")
			var/intake_size = text2num(params["regulate"])
			var/obj/machinery/power/turbine/core_rotor/main_control = turbine_core?.resolve()
			if(intake_size == null || !main_control)
				return
			main_control.intake_regulator = clamp(intake_size, 0.01, 1)
			. = TRUE
