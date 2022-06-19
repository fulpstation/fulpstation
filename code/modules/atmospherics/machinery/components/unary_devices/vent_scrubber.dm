#define SIPHONING 0
#define SCRUBBING 1

/obj/machinery/atmospherics/components/unary/vent_scrubber
	icon_state = "scrub_map-3"

	name = "air scrubber"
	desc = "Has a valve and pump attached to it."
	use_power = IDLE_POWER_USE
	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 0.1
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.15
	can_unwrench = TRUE
	welded = FALSE
	layer = GAS_SCRUBBER_LAYER
	hide = TRUE
	shift_underlay_only = FALSE
	pipe_state = "scrubber"
	vent_movement = VENTCRAWL_ALLOWED | VENTCRAWL_CAN_SEE | VENTCRAWL_ENTRANCE_ALLOWED
	processing_flags = NONE

	///The mode of the scrubber (SCRUBBING or SIPHONING)
	var/scrubbing = SCRUBBING //0 = siphoning, 1 = scrubbing
	///The list of gases we are filtering
	var/list/filter_types = list(/datum/gas/carbon_dioxide)
	///Rate of the scrubber to remove gases from the air
	var/volume_rate = 200
	///is this scrubber acting on the 3x3 area around it.
	var/widenet = FALSE
	///List of the turfs near the scrubber, used for widenet
	var/list/turf/adjacent_turfs = list()

	///Frequency id for connecting to the NTNet
	var/frequency = FREQ_ATMOS_CONTROL
	///Reference to the radio datum
	var/datum/radio_frequency/radio_connection
	///Radio connection to the air alarm
	var/radio_filter_out
	///Radio connection from the air alarm
	var/radio_filter_in

	//Enables the use of plunger_act for ending the vent clog random event
	var/clogged = FALSE

	COOLDOWN_DECLARE(check_turfs_cooldown)

/obj/machinery/atmospherics/components/unary/vent_scrubber/New()
	if(!id_tag)
		id_tag = SSnetworks.assign_random_name()
	. = ..()
	for(var/to_filter in filter_types)
		if(istext(to_filter))
			filter_types -= to_filter
			filter_types += gas_id2path(to_filter)

/obj/machinery/atmospherics/components/unary/vent_scrubber/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/atmos_sensitive, mapload)

/obj/machinery/atmospherics/components/unary/vent_scrubber/Destroy()
	var/area/scrub_area = get_area(src)
	if(scrub_area)
		scrub_area.air_scrub_info -= id_tag
		GLOB.air_scrub_names -= id_tag

	SSradio.remove_object(src,frequency)
	radio_connection = null
	adjacent_turfs.Cut()
	return ..()

///adds a gas or list of gases to our filter_types. used so that the scrubber can check if its supposed to be processing after each change
/obj/machinery/atmospherics/components/unary/vent_scrubber/proc/add_filters(filter_or_filters)
	if(!islist(filter_or_filters))
		filter_or_filters = list(filter_or_filters)

	for(var/gas_to_filter in filter_or_filters)
		var/translated_gas = istext(gas_to_filter) ? gas_id2path(gas_to_filter) : gas_to_filter

		if(ispath(translated_gas, /datum/gas))
			filter_types |= translated_gas
			continue

	var/turf/open/our_turf = get_turf(src)

	if(!isopenturf(our_turf))
		return FALSE

	var/datum/gas_mixture/turf_gas = our_turf.air
	if(!turf_gas)
		return FALSE

	check_atmos_process(our_turf, turf_gas, turf_gas.temperature)
	return TRUE

///remove a gas or list of gases from our filter_types.used so that the scrubber can check if its supposed to be processing after each change
/obj/machinery/atmospherics/components/unary/vent_scrubber/proc/remove_filters(filter_or_filters)
	if(!islist(filter_or_filters))
		filter_or_filters = list(filter_or_filters)

	for(var/gas_to_filter in filter_or_filters)
		var/translated_gas = istext(gas_to_filter) ? gas_id2path(gas_to_filter) : gas_to_filter

		if(ispath(translated_gas, /datum/gas))
			filter_types -= translated_gas
			continue

	var/turf/open/our_turf = get_turf(src)
	var/datum/gas_mixture/turf_gas

	if(isopenturf(our_turf))
		turf_gas = our_turf.air

	if(!turf_gas)
		return FALSE

	check_atmos_process(our_turf, turf_gas, turf_gas.temperature)
	return TRUE

/obj/machinery/atmospherics/components/unary/vent_scrubber/proc/toggle_filters(filter_or_filters)
	if(!islist(filter_or_filters))
		filter_or_filters = list(filter_or_filters)

	for(var/gas_to_filter in filter_or_filters)
		var/translated_gas = istext(gas_to_filter) ? gas_id2path(gas_to_filter) : gas_to_filter

		if(ispath(translated_gas, /datum/gas))
			if(translated_gas in filter_types)
				filter_types -= translated_gas
			else
				filter_types |= translated_gas

	var/turf/open/our_turf = get_turf(src)

	if(!isopenturf(our_turf))
		return FALSE

	var/datum/gas_mixture/turf_gas = our_turf.air

	if(!turf_gas)
		return FALSE

	check_atmos_process(our_turf, turf_gas, turf_gas.temperature)
	return TRUE

/obj/machinery/atmospherics/components/unary/vent_scrubber/update_icon_nopipes()
	cut_overlays()
	if(showpipe)
		var/image/cap = get_pipe_image(icon, "scrub_cap", initialize_directions)
		add_overlay(cap)
	else
		PIPING_LAYER_SHIFT(src, PIPING_LAYER_DEFAULT)

	if(welded)
		icon_state = "scrub_welded"
		return

	if(!nodes[1] || !on || !is_operational)
		icon_state = "scrub_off"
		return

	if(scrubbing & SCRUBBING)
		if(widenet)
			icon_state = "scrub_wide"
		else
			icon_state = "scrub_on"
	else //scrubbing == SIPHONING
		icon_state = "scrub_purge"

/obj/machinery/atmospherics/components/unary/vent_scrubber/proc/set_frequency(new_frequency)
	SSradio.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = SSradio.add_object(src, frequency, radio_filter_in)

/obj/machinery/atmospherics/components/unary/vent_scrubber/proc/broadcast_status()
	if(!radio_connection)
		return FALSE

	var/list/f_types = list()
	for(var/path in GLOB.meta_gas_info)
		var/list/gas = GLOB.meta_gas_info[path]
		f_types += list(list("gas_id" = gas[META_GAS_ID], "gas_name" = gas[META_GAS_NAME], "enabled" = (path in filter_types)))

	var/datum/signal/signal = new(list(
		"tag" = id_tag,
		"frequency" = frequency,
		"device" = "VS",
		"timestamp" = world.time,
		"power" = on,
		"scrubbing" = scrubbing,
		"widenet" = widenet,
		"filter_types" = f_types,
		"sigtype" = "status"
	))

	var/area/scrub_area = get_area(src)
	if(!GLOB.air_scrub_names[id_tag])
		// If we do not have a name, assign one
		update_name()
		GLOB.air_scrub_names[id_tag] = name

	scrub_area.air_scrub_info[id_tag] = signal.data

	radio_connection.post_signal(src, signal, radio_filter_out)

	return TRUE

/obj/machinery/atmospherics/components/unary/vent_scrubber/update_name()
	. = ..()
	if(override_naming)
		return
	var/area/scrub_area = get_area(src)
	name = "\proper [scrub_area.name] [name] [id_tag]"

/obj/machinery/atmospherics/components/unary/vent_scrubber/atmos_init()
	radio_filter_in = frequency == initial(frequency) ? RADIO_FROM_AIRALARM : null
	radio_filter_out = frequency == initial(frequency) ? RADIO_TO_AIRALARM : null
	if(frequency)
		set_frequency(frequency)
	broadcast_status()
	check_turfs()
	. = ..()

/obj/machinery/atmospherics/components/unary/vent_scrubber/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	if(welded || !is_operational)
		return FALSE
	if(!nodes[1] || !on || (!filter_types && scrubbing != SIPHONING))
		on = FALSE
		return FALSE

	var/list/changed_gas = air.gases

	if(!changed_gas)
		return FALSE

	if(scrubbing == SIPHONING || length(filter_types & changed_gas))
		return TRUE

	return FALSE

/obj/machinery/atmospherics/components/unary/vent_scrubber/atmos_expose(datum/gas_mixture/air, exposed_temperature)
	if(welded || !is_operational)
		return FALSE
	if(!nodes[1] || !on)
		on = FALSE
		return FALSE
	var/turf/open/us = loc
	if(!istype(us))
		return
	scrub(us)
	if(widenet)
		if(COOLDOWN_FINISHED(src, check_turfs_cooldown))
			check_turfs()
			COOLDOWN_START(src, check_turfs_cooldown, 2 SECONDS)

		for(var/turf/tile in adjacent_turfs)
			scrub(tile)
	return TRUE

///filtered gases at or below this amount automatically get removed from the mix
#define MINIMUM_MOLES_TO_SCRUB MOLAR_ACCURACY*100

/obj/machinery/atmospherics/components/unary/vent_scrubber/proc/scrub(turf/tile)
	if(!istype(tile))
		return FALSE
	var/datum/gas_mixture/environment = tile.return_air()
	var/datum/gas_mixture/air_contents = airs[1]
	var/list/env_gases = environment.gases

	if(air_contents.return_pressure() >= 50 * ONE_ATMOSPHERE)
		return FALSE

	if(scrubbing == SCRUBBING)
		if(length(env_gases & filter_types))
			///contains all of the gas we're sucking out of the tile, gets put into our parent pipenet
			var/datum/gas_mixture/filtered_out = new
			var/list/filtered_gases = filtered_out.gases
			filtered_out.temperature = environment.temperature

			///maximum percentage of the turfs gas we can filter
			var/removal_ratio =  min(1, volume_rate / environment.volume)

			var/total_moles_to_remove = 0
			for(var/gas in filter_types & env_gases)
				total_moles_to_remove += env_gases[gas][MOLES]

			if(total_moles_to_remove == 0)//sometimes this gets non gc'd values
				environment.garbage_collect()
				return FALSE

			for(var/gas in filter_types & env_gases)
				filtered_out.add_gas(gas)
				//take this gases portion of removal_ratio of the turfs air, or all of that gas if less than or equal to MINIMUM_MOLES_TO_SCRUB
				var/transfered_moles = max(QUANTIZE(env_gases[gas][MOLES] * removal_ratio * (env_gases[gas][MOLES] / total_moles_to_remove)), min(MINIMUM_MOLES_TO_SCRUB, env_gases[gas][MOLES]))

				filtered_gases[gas][MOLES] = transfered_moles
				env_gases[gas][MOLES] -= transfered_moles

			environment.garbage_collect()

			//Remix the resulting gases
			air_contents.merge(filtered_out)
			update_parents()

	else //Just siphoning all air

		var/transfer_moles = environment.total_moles() * (volume_rate / environment.volume)

		var/datum/gas_mixture/removed = tile.remove_air(transfer_moles)

		air_contents.merge(removed)
		update_parents()

	return TRUE

#undef MINIMUM_MOLES_TO_SCRUB

///we populate a list of turfs with nonatmos-blocked cardinal turfs AND
/// diagonal turfs that can share atmos with *both* of the cardinal turfs
/obj/machinery/atmospherics/components/unary/vent_scrubber/proc/check_turfs()
	adjacent_turfs.Cut()
	var/turf/local_turf = get_turf(src)
	adjacent_turfs = local_turf.get_atmos_adjacent_turfs(alldir = TRUE)

/obj/machinery/atmospherics/components/unary/vent_scrubber/receive_signal(datum/signal/signal)
	if(!is_operational || !signal.data["tag"] || (signal.data["tag"] != id_tag) || (signal.data["sigtype"]!="command"))
		return

	var/old_widenet = widenet
	var/old_scrubbing = scrubbing
	var/old_filter_length = length(filter_types)

	///whether we should attempt to start processing due to settings allowing us to take gas out of our environment
	var/try_start_processing = FALSE

	var/turf/open/our_turf = get_turf(src)
	var/datum/gas_mixture/turf_gas = our_turf?.air

	var/atom/signal_sender = signal.data["user"]

	if("power" in signal.data)
		on = text2num(signal.data["power"])
		try_start_processing = TRUE
	if("power_toggle" in signal.data)
		on = !on
		try_start_processing = TRUE

	if("widenet" in signal.data)
		widenet = text2num(signal.data["widenet"])
	if("toggle_widenet" in signal.data)
		widenet = !widenet

	if("scrubbing" in signal.data)
		scrubbing = text2num(signal.data["scrubbing"])
		try_start_processing = TRUE
	if("toggle_scrubbing" in signal.data)
		scrubbing = !scrubbing
		try_start_processing = TRUE

	if(scrubbing != old_scrubbing)
		investigate_log(" was toggled to [scrubbing ? "scrubbing" : "siphon"] mode by [key_name(signal_sender)]",INVESTIGATE_ATMOS)

	if("toggle_filter" in signal.data)
		toggle_filters(signal.data["toggle_filter"])

	if("set_filters" in signal.data)
		filter_types = list()
		add_filters(signal.data["set_filters"])

	if("init" in signal.data)
		name = signal.data["init"]
		return

	if("status" in signal.data)
		broadcast_status()
		return //do not update_appearance

	broadcast_status()
	update_appearance()

	if(!our_turf || !turf_gas)
		try_start_processing = FALSE

	if(try_start_processing)//check if our changes should make us start processing
		check_atmos_process(our_turf, turf_gas, turf_gas.temperature)

	if(length(filter_types) == old_filter_length && old_scrubbing == scrubbing && old_widenet == widenet)
		return

	idle_power_usage = initial(idle_power_usage)
	active_power_usage = initial(idle_power_usage)

	var/new_power_usage = 0
	if(scrubbing == SCRUBBING)
		new_power_usage = idle_power_usage + idle_power_usage * length(filter_types)
		update_use_power(IDLE_POWER_USE)
	else
		new_power_usage = active_power_usage
		update_use_power(ACTIVE_POWER_USE)

	if(widenet)
		new_power_usage += new_power_usage * (length(adjacent_turfs) * (length(adjacent_turfs) / 2))

	update_mode_power_usage(scrubbing == SCRUBBING ? IDLE_POWER_USE : ACTIVE_POWER_USE, new_power_usage)

/obj/machinery/atmospherics/components/unary/vent_scrubber/power_change()
	. = ..()
	update_icon_nopipes()

/obj/machinery/atmospherics/components/unary/vent_scrubber/welder_act(mob/living/user, obj/item/welder)
	..()
	if(!welder.tool_start_check(user, amount=0))
		return TRUE
	to_chat(user, span_notice("Now welding the scrubber."))
	if(welder.use_tool(src, user, 20, volume=50))
		if(!welded)
			user.visible_message(span_notice("[user] welds the scrubber shut."),span_notice("You weld the scrubber shut."), span_hear("You hear welding."))
			welded = TRUE
		else
			user.visible_message(span_notice("[user] unwelds the scrubber."), span_notice("You unweld the scrubber."), span_hear("You hear welding."))
			welded = FALSE
		update_appearance()
		pipe_vision_img = image(src, loc, dir = dir)
		pipe_vision_img.plane = ABOVE_HUD_PLANE
		investigate_log("was [welded ? "welded shut" : "unwelded"] by [key_name(user)]", INVESTIGATE_ATMOS)
		add_fingerprint(user)
	return TRUE

/obj/machinery/atmospherics/components/unary/vent_scrubber/can_unwrench(mob/user)
	. = ..()
	if(. && on && is_operational)
		to_chat(user, span_warning("You cannot unwrench [src], turn it off first!"))
		return FALSE

/obj/machinery/atmospherics/components/unary/vent_scrubber/examine(mob/user)
	. = ..()
	if(welded)
		. += "It seems welded shut."

/obj/machinery/atmospherics/components/unary/vent_scrubber/attack_alien(mob/user, list/modifiers)
	if(!welded || !(do_after(user, 20, target = src)))
		return
	user.visible_message(span_warning("[user] furiously claws at [src]!"), span_notice("You manage to clear away the stuff blocking the scrubber."), span_hear("You hear loud scraping noises."))
	welded = FALSE
	update_appearance()
	pipe_vision_img = image(src, loc, dir = dir)
	pipe_vision_img.plane = ABOVE_HUD_PLANE
	playsound(loc, 'sound/weapons/bladeslice.ogg', 100, TRUE)


/obj/machinery/atmospherics/components/unary/vent_scrubber/layer2
	piping_layer = 2
	icon_state = "scrub_map-2"

/obj/machinery/atmospherics/components/unary/vent_scrubber/layer4
	piping_layer = 4
	icon_state = "scrub_map-4"

/obj/machinery/atmospherics/components/unary/vent_scrubber/on
	on = TRUE
	icon_state = "scrub_map_on-3"

/obj/machinery/atmospherics/components/unary/vent_scrubber/on/layer2
	piping_layer = 2
	icon_state = "scrub_map_on-2"

/obj/machinery/atmospherics/components/unary/vent_scrubber/on/layer4
	piping_layer = 4
	icon_state = "scrub_map_on-4"

/obj/machinery/atmospherics/components/unary/vent_scrubber/plunger_act(obj/item/plunger/plunger, mob/living/user, reinforced)
	if(!clogged)
		return

	if(welded)
		to_chat(user, span_notice("You cannot pump [src] if it's welded shut!"))
		return

	to_chat(user, span_notice("You begin pumping [src] with your plunger."))
	if(do_after(user, 6 SECONDS, target = src))
		to_chat(user, span_notice("You finish pumping [src]."))
		clogged = FALSE

/**
 * Sets "clogged" to TRUE.
 *
 * Sets the clogged value to be true. Called during the scrubber clog event to begin the production of mobs, and allows for the plunger_act to run.
 */

/obj/machinery/atmospherics/components/unary/vent_scrubber/proc/clog()
	clogged = TRUE

/**
 * Sets "clogged" to FALSE.
 *
 * Changes the clogged value to be false. Called during the scrubber clog event to stop the production of mobs and prevent further plunger use.
 */

/obj/machinery/atmospherics/components/unary/vent_scrubber/proc/unclog()
	clogged = FALSE

/**
 * Produces a mob based on the input given by scrubber clog event.
 *
 * Used by the scrubber clog random event to handle the spawning of mobs. The proc recieves the mob that will be spawned,
 * and the event's current list of living mobs produced by the event so far. After checking if the vent is welded, the
 * new mob is created on the scrubber's turf, then added to the living_mobs list.
 *
 * Arguments:
 * * spawned_mob - Stores which mob will be spawned and added to the living_mobs list.
 * * living_mobs - Used to add the spawned mob to the list of currently living mobs produced by this vent.
 * Relevant code for how the list is handled is in the scrubber_clog.dm file.
 */

/obj/machinery/atmospherics/components/unary/vent_scrubber/proc/produce_mob(spawned_mob, list/living_mobs)
	if(welded)
		return

	var/mob/new_mob = new spawned_mob(get_turf(src))
	living_mobs += WEAKREF(new_mob)
	visible_message(span_warning("[new_mob] crawls out of [src]!"))

#undef SIPHONING
#undef SCRUBBING
