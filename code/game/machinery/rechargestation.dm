/obj/machinery/recharge_station
	name = "recharging station"
	desc = "This device recharges energy dependent lifeforms, like cyborgs, ethereals and MODsuit users."
	icon = 'icons/obj/objects.dmi'
	icon_state = "borgcharger0"
	density = FALSE
	req_access = list(ACCESS_ROBOTICS)
	state_open = TRUE
	circuit = /obj/item/circuitboard/machine/cyborgrecharger
	occupant_typecache = list(/mob/living/silicon/robot, /mob/living/carbon/human)
	processing_flags = NONE
	var/recharge_speed
	var/repairs
	///Whether we're sending iron and glass to a cyborg. Requires Silo connection.
	var/sendmats = FALSE
	var/datum/component/remote_materials/materials


/obj/machinery/recharge_station/Initialize(mapload)
	. = ..()

	materials = AddComponent(
		/datum/component/remote_materials, \
		"charger", \
		mapload, \
		mat_container_flags = MATCONTAINER_NO_INSERT, \
	)

	update_appearance()
	if(is_operational)
		begin_processing()

	if(!mapload)
		return

	var/area/my_area = get_area(src)
	if(!(my_area.type in GLOB.the_station_areas))
		return

	var/area_name = get_area_name(src, format_text = TRUE)
	if(area_name in GLOB.roundstart_station_borgcharger_areas)
		return
	GLOB.roundstart_station_borgcharger_areas += area_name

/obj/machinery/recharge_station/RefreshParts()
	. = ..()
	recharge_speed = 0
	repairs = 0
	for(var/datum/stock_part/capacitor/capacitor in component_parts)
		recharge_speed += capacitor.tier * 100
	for(var/datum/stock_part/manipulator/manipulator in component_parts)
		repairs += manipulator.tier - 1
	for(var/obj/item/stock_parts/cell/cell in component_parts)
		recharge_speed *= cell.maxcharge / 10000

/obj/machinery/recharge_station/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: Recharging <b>[recharge_speed]J</b> per cycle.")
		if(materials.silo)
			. += span_notice("The ore silo link indicator is lit, and cyborg restocking can be activated by <b>Right-Clicking</b> [src].")
		if(repairs)
			. += span_notice("[src] has been upgraded to support automatic repairs.")


/obj/machinery/recharge_station/on_set_is_operational(old_value)
	if(old_value) //Turned off
		end_processing()
	else //Turned on
		begin_processing()


/obj/machinery/recharge_station/process(seconds_per_tick)
	if(occupant)
		process_occupant(seconds_per_tick)
	return 1

/obj/machinery/recharge_station/relaymove(mob/living/user, direction)
	if(user.stat)
		return
	open_machine()

/obj/machinery/recharge_station/emp_act(severity)
	. = ..()
	if(!(machine_stat & (BROKEN|NOPOWER)))
		if(occupant && !(. & EMP_PROTECT_CONTENTS))
			occupant.emp_act(severity)
		if (!(. & EMP_PROTECT_SELF))
			open_machine()

/obj/machinery/recharge_station/attackby(obj/item/P, mob/user, params)
	if(state_open)
		if(default_deconstruction_screwdriver(user, "borgdecon2", "borgcharger0", P))
			return

	if(default_pry_open(P, close_after_pry = FALSE, open_density = FALSE, closed_density = TRUE))
		return

	if(default_deconstruction_crowbar(P))
		return
	return ..()

/obj/machinery/recharge_station/attack_ai_secondary(mob/user, list/modifiers)
	toggle_restock(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/recharge_station/attack_hand_secondary(mob/user, list/modifiers)
	toggle_restock(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/recharge_station/proc/toggle_restock(mob/user)
	if(sendmats)
		sendmats = FALSE
		balloon_alert(user, "restocking from ore silo: disabled")
		return
	if(state_open || !occupant)
		return
	if(!iscyborg(occupant))
		return
	if(!materials.silo)
		balloon_alert(user, "error: ore silo connection offline")
		return
	if(materials.on_hold())
		balloon_alert(user, "error: access denied")
		return FALSE
	sendmats = TRUE
	balloon_alert(user, "restocking from ore silo: enabled")

/obj/machinery/recharge_station/interact(mob/user)
	toggle_open()
	return TRUE

/obj/machinery/recharge_station/proc/toggle_open()
	if(state_open)
		close_machine(density_to_set = TRUE)
	else
		open_machine()

/obj/machinery/recharge_station/open_machine(drop = TRUE, density_to_set = FALSE)
	. = ..()
	sendmats = FALSE //Leaving off for the next user
	update_use_power(IDLE_POWER_USE)

/obj/machinery/recharge_station/close_machine(atom/movable/target, density_to_set = TRUE)
	. = ..()
	if(occupant)
		update_use_power(ACTIVE_POWER_USE) //It always tries to charge, even if it can't.
		add_fingerprint(occupant)

/obj/machinery/recharge_station/update_icon_state()
	if(!is_operational)
		icon_state = "borgcharger-u[state_open ? 0 : 1]"
		return ..()
	icon_state = "borgcharger[state_open ? 0 : (occupant ? 1 : 2)]"
	return ..()

/obj/machinery/recharge_station/proc/process_occupant(seconds_per_tick)
	if(!occupant)
		return
	SEND_SIGNAL(occupant, COMSIG_PROCESS_BORGCHARGER_OCCUPANT, recharge_speed * seconds_per_tick / 2, repairs, sendmats)
