/*
	The relay idles until it receives information. It then passes on that information
	depending on where it came from.

	The relay is needed in order to send information pass Z levels. It must be linked
	with a HUB, the only other machine that can send/receive pass Z levels.
*/

/obj/machinery/telecomms/relay
	name = "telecommunication relay"
	icon_state = "relay"
	desc = "A mighty piece of hardware used to send massive amounts of data far away."
	telecomms_type = /obj/machinery/telecomms/relay
	density = TRUE
	idle_power_usage = BASE_MACHINE_IDLE_CONSUMPTION * 0.01
	netspeed = 5
	long_range_link = 1
	circuit = /obj/item/circuitboard/machine/telecomms/relay
	var/broadcasting = 1
	var/receiving = 1

/obj/machinery/telecomms/relay/receive_information(datum/signal/subspace/signal, obj/machinery/telecomms/machine_from)
	// Add our level and send it back
	var/turf/relay_turf = get_turf(src)
	if(can_send(signal) && relay_turf)
		// Relays send signals to all ZTRAIT_STATION z-levels
		if(SSmapping.level_trait(relay_turf.z, ZTRAIT_STATION))
			for(var/z in SSmapping.levels_by_trait(ZTRAIT_STATION))
				signal.levels |= z
		else
			signal.levels |= relay_turf.z

	use_power(idle_power_usage)

/// Checks to see if it can send/receive.
/obj/machinery/telecomms/relay/proc/can(datum/signal/signal)
	if(!on)
		return FALSE
	if(!is_freq_listening(signal))
		return FALSE
	return TRUE

/obj/machinery/telecomms/relay/proc/can_send(datum/signal/signal)
	if(!can(signal))
		return FALSE
	return broadcasting

/obj/machinery/telecomms/relay/proc/can_receive(datum/signal/signal)
	if(!can(signal))
		return FALSE
	return receiving

//Preset Relay

/obj/machinery/telecomms/relay/preset
	network = "tcommsat"

/obj/machinery/telecomms/relay/Initialize(mapload)
	. = ..()
	if(autolinkers.len) //We want lateloaded presets to autolink (lateloaded aways/ruins/shuttles)
		return INITIALIZE_HINT_LATELOAD

/obj/machinery/telecomms/relay/preset/station
	id = "Station Relay"
	autolinkers = list("s_relay")

/obj/machinery/telecomms/relay/preset/telecomms
	id = "Telecomms Relay"
	autolinkers = list("relay")

/obj/machinery/telecomms/relay/preset/mining
	id = "Mining Relay"
	autolinkers = list("m_relay")

/obj/machinery/telecomms/relay/preset/ruskie
	id = "Ruskie Relay"
	hide = 1
	toggled = FALSE
	autolinkers = list("r_relay")

//Generic preset relay
/obj/machinery/telecomms/relay/preset/auto
	hide = TRUE
	autolinkers = list("autorelay")
