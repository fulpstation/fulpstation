///Max temperature allowed inside the cryotube, should break before reaching this heat
#define MAX_TEMPERATURE 4000
// Multiply factor is used with efficiency to multiply Tx quantity
// Tx quantity is how much volume should be removed from the cell's beaker - multiplied by delta_time
// Throttle Counter Max is how many calls of process() between ones that inject reagents.
// These three defines control how fast and efficient cryo is
#define CRYO_MULTIPLY_FACTOR 25
#define CRYO_TX_QTY 0.5
// The minimum O2 moles in the cryotube before it switches off.
#define CRYO_MIN_GAS_MOLES 5
#define CRYO_BREAKOUT_TIME 30 SECONDS

/// This is a visual helper that shows the occupant inside the cryo cell.
/atom/movable/visual/cryo_occupant
	icon = 'icons/obj/cryogenics.dmi'
	// Must be tall, otherwise the filter will consider this as a 32x32 tile
	// and will crop the head off.
	icon_state = "mask_bg"
	layer = MOB_LAYER + 0.01
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	pixel_y = 22
	appearance_flags = KEEP_TOGETHER
	/// The current occupant being presented
	var/mob/living/occupant

/atom/movable/visual/cryo_occupant/Initialize(mapload, obj/machinery/atmospherics/components/unary/cryo_cell/parent)
	. = ..()
	// Alpha masking
	// It will follow this as the animation goes, but that's no problem as the "mask" icon state
	// already accounts for this.
	add_filter("alpha_mask", 1, list("type" = "alpha", "icon" = icon('icons/obj/cryogenics.dmi', "mask"), "y" = -22))
	RegisterSignal(parent, COMSIG_MACHINERY_SET_OCCUPANT, .proc/on_set_occupant)
	RegisterSignal(parent, COMSIG_CRYO_SET_ON, .proc/on_set_on)

/// COMSIG_MACHINERY_SET_OCCUPANT callback
/atom/movable/visual/cryo_occupant/proc/on_set_occupant(datum/source, mob/living/new_occupant)
	SIGNAL_HANDLER

	if(occupant)
		vis_contents -= occupant
		REMOVE_TRAIT(occupant, TRAIT_IMMOBILIZED, CRYO_TRAIT)
		REMOVE_TRAIT(occupant, TRAIT_FORCED_STANDING, CRYO_TRAIT)

	occupant = new_occupant
	if(!occupant)
		return

	occupant.setDir(SOUTH)
	vis_contents += occupant
	pixel_y = 22
	ADD_TRAIT(occupant, TRAIT_IMMOBILIZED, CRYO_TRAIT)
	// Keep them standing! They'll go sideways in the tube when they fall asleep otherwise.
	ADD_TRAIT(occupant, TRAIT_FORCED_STANDING, CRYO_TRAIT)

/// COMSIG_CRYO_SET_ON callback
/atom/movable/visual/cryo_occupant/proc/on_set_on(datum/source, on)
	SIGNAL_HANDLER

	if(on)
		animate(src, pixel_y = 24, time = 20, loop = -1)
		animate(pixel_y = 22, time = 20)
	else
		animate(src)

/// Cryo cell
/obj/machinery/atmospherics/components/unary/cryo_cell
	name = "cryo cell"
	icon = 'icons/obj/cryogenics.dmi'
	icon_state = "pod-off"
	density = TRUE
	max_integrity = 350
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 100, BOMB = 0, BIO = 100, FIRE = 30, ACID = 30)
	layer = MOB_LAYER
	state_open = FALSE
	circuit = /obj/item/circuitboard/machine/cryo_tube
	pipe_flags = PIPING_ONE_PER_TURF | PIPING_DEFAULT_LAYER_ONLY
	occupant_typecache = list(/mob/living/carbon, /mob/living/simple_animal)
	processing_flags = NONE

	showpipe = FALSE

	var/autoeject = TRUE
	var/volume = 100

	var/efficiency = 1
	var/sleep_factor = 0.00125
	var/unconscious_factor = 0.001
	var/heat_capacity = 20000
	var/conduction_coefficient = 0.3

	var/obj/item/reagent_containers/glass/beaker = null
	var/consume_gas = FALSE

	var/obj/item/radio/radio
	var/radio_key = /obj/item/encryptionkey/headset_med
	var/radio_channel = RADIO_CHANNEL_MEDICAL
	vent_movement = NONE

	/// Visual content - Occupant
	var/atom/movable/visual/cryo_occupant/occupant_vis

	var/message_cooldown
	///Cryo will continue to treat people with 0 damage but existing wounds, but will sound off when damage healing is done in case doctors want to directly treat the wounds instead
	var/treating_wounds = FALSE
	fair_market_price = 10
	payment_department = ACCOUNT_MED


/obj/machinery/atmospherics/components/unary/cryo_cell/Initialize(mapload)
	. = ..()
	initialize_directions = dir
	if(is_operational)
		begin_processing()

	radio = new(src)
	radio.keyslot = new radio_key
	radio.subspace_transmission = TRUE
	radio.canhear_range = 0
	radio.recalculateChannels()

	occupant_vis = new(null, src)
	vis_contents += occupant_vis

/obj/machinery/atmospherics/components/unary/cryo_cell/set_occupant(atom/movable/new_occupant)
	. = ..()
	update_appearance()

/obj/machinery/atmospherics/components/unary/cryo_cell/on_construction()
	..(dir, dir)

/obj/machinery/atmospherics/components/unary/cryo_cell/RefreshParts()
	var/C
	for(var/obj/item/stock_parts/matter_bin/M in component_parts)
		C += M.rating

	efficiency = initial(efficiency) * C
	sleep_factor = initial(sleep_factor) * C
	unconscious_factor = initial(unconscious_factor) * C
	heat_capacity = initial(heat_capacity) / C
	conduction_coefficient = initial(conduction_coefficient) * C

/obj/machinery/atmospherics/components/unary/cryo_cell/examine(mob/user) //this is leaving out everything but efficiency since they follow the same idea of "better beaker, better results"
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("The status display reads: Efficiency at <b>[efficiency*100]%</b>.")

/obj/machinery/atmospherics/components/unary/cryo_cell/Destroy()
	vis_contents.Cut()

	QDEL_NULL(occupant_vis)
	QDEL_NULL(radio)
	QDEL_NULL(beaker)
	///Take the turf the cryotube is on
	var/turf/T = get_turf(src)
	if(T)
		///Take the air composition inside the cryotube
		var/datum/gas_mixture/air1 = airs[1]
		T.assume_air(air1)

	return ..()

/obj/machinery/atmospherics/components/unary/cryo_cell/contents_explosion(severity, target)
	. = ..()
	if(!beaker)
		return

	switch(severity)
		if(EXPLODE_DEVASTATE)
			SSexplosions.high_mov_atom += beaker
		if(EXPLODE_HEAVY)
			SSexplosions.med_mov_atom += beaker
		if(EXPLODE_LIGHT)
			SSexplosions.low_mov_atom += beaker

/obj/machinery/atmospherics/components/unary/cryo_cell/handle_atom_del(atom/A)
	..()
	if(A == beaker)
		beaker = null
		updateUsrDialog()

/obj/machinery/atmospherics/components/unary/cryo_cell/on_deconstruction()
	if(beaker)
		beaker.forceMove(drop_location())
		beaker = null

/obj/machinery/atmospherics/components/unary/cryo_cell/update_icon_state()
	icon_state = (state_open) ? "pod-open" : ((on && is_operational) ? "pod-on" : "pod-off")
	return ..()

/obj/machinery/atmospherics/components/unary/cryo_cell/update_icon()
	. = ..()
	plane = initial(plane)

GLOBAL_VAR_INIT(cryo_overlay_cover_on, mutable_appearance('icons/obj/cryogenics.dmi', "cover-on", layer = MOB_LAYER + 0.02))
GLOBAL_VAR_INIT(cryo_overlay_cover_off, mutable_appearance('icons/obj/cryogenics.dmi', "cover-off", layer = MOB_LAYER + 0.02))

/obj/machinery/atmospherics/components/unary/cryo_cell/update_overlays()
	. = ..()
	if(panel_open)
		. += "pod-panel"
	if(state_open)
		return
	. += (on && is_operational) ? GLOB.cryo_overlay_cover_on : GLOB.cryo_overlay_cover_off

/obj/machinery/atmospherics/components/unary/cryo_cell/nap_violation(mob/violator)
	open_machine()


/obj/machinery/atmospherics/components/unary/cryo_cell/proc/set_on(new_value)
	if(on == new_value)
		return
	SEND_SIGNAL(src, COMSIG_CRYO_SET_ON, new_value)
	. = on
	on = new_value
	update_appearance()

/obj/machinery/atmospherics/components/unary/cryo_cell/on_set_is_operational(old_value)
	if(old_value) //Turned off
		set_on(FALSE)
		end_processing()
	else //Turned on
		begin_processing()


/obj/machinery/atmospherics/components/unary/cryo_cell/process(delta_time)
	..()

	if(!on)
		return
	if(!occupant)
		return

	var/mob/living/mob_occupant = occupant
	if(mob_occupant.on_fire)
		mob_occupant.extinguish_mob()
	if(!check_nap_violations())
		return
	if(mob_occupant.stat == DEAD) // We don't bother with dead people.
		return
	if(mob_occupant.get_organic_health() >= mob_occupant.getMaxHealth()) // Don't bother with fully healed people.
		if(iscarbon(mob_occupant))
			var/mob/living/carbon/C = mob_occupant
			if(C.all_wounds)
				if(!treating_wounds) // if we have wounds and haven't already alerted the doctors we're only dealing with the wounds, let them know
					treating_wounds = TRUE
					playsound(src, 'sound/machines/cryo_warning.ogg', volume) // Bug the doctors.
					var/msg = "Patient vitals fully recovered, continuing automated wound treatment."
					radio.talk_into(src, msg, radio_channel)
			else // otherwise if we were only treating wounds and now we don't have any, turn off treating_wounds so we can boot 'em out
				treating_wounds = FALSE

		if(!treating_wounds)
			set_on(FALSE)
			playsound(src, 'sound/machines/cryo_warning.ogg', volume) // Bug the doctors.
			var/msg = "Patient fully restored."
			if(autoeject) // Eject if configured.
				msg += " Auto ejecting patient now."
				open_machine()
			radio.talk_into(src, msg, radio_channel)
			return

	var/datum/gas_mixture/air1 = airs[1]

	if(air1.gases[/datum/gas/oxygen][MOLES] > CRYO_MIN_GAS_MOLES)
		if(mob_occupant.bodytemperature < T0C) // Sleepytime. Why? More cryo magic.
			mob_occupant.Sleeping((mob_occupant.bodytemperature * sleep_factor) * 1000 * delta_time)
			mob_occupant.Unconscious((mob_occupant.bodytemperature * unconscious_factor) * 1000 * delta_time)
		if(beaker)
			beaker.reagents.trans_to(occupant, (CRYO_TX_QTY / (efficiency * CRYO_MULTIPLY_FACTOR)) * delta_time, efficiency * CRYO_MULTIPLY_FACTOR, methods = VAPOR) // Transfer reagents.
			consume_gas = TRUE
	return TRUE

/obj/machinery/atmospherics/components/unary/cryo_cell/process_atmos()
	..()

	if(!on)
		return

	var/datum/gas_mixture/air1 = airs[1]

	if(!nodes[1] || !airs[1] || !air1.gases.len || air1.gases[/datum/gas/oxygen][MOLES] < CRYO_MIN_GAS_MOLES) // Turn off if the machine won't work.
		var/msg = "Insufficient cryogenic gas, shutting down."
		radio.talk_into(src, msg, radio_channel)
		set_on(FALSE)
		return

	if(occupant)
		var/mob/living/mob_occupant = occupant
		var/cold_protection = 0
		var/temperature_delta = air1.temperature - mob_occupant.bodytemperature // The only semi-realistic thing here: share temperature between the cell and the occupant.

		if(ishuman(mob_occupant))
			var/mob/living/carbon/human/H = mob_occupant
			cold_protection = H.get_cold_protection(air1.temperature)

		if(abs(temperature_delta) > 1)
			var/air_heat_capacity = air1.heat_capacity()

			var/heat = ((1 - cold_protection) * 0.1 + conduction_coefficient) * temperature_delta * (air_heat_capacity * heat_capacity / (air_heat_capacity + heat_capacity))

			air1.temperature = clamp(air1.temperature - heat / air_heat_capacity, TCMB, MAX_TEMPERATURE)
			mob_occupant.adjust_bodytemperature(heat / heat_capacity, TCMB)

			//lets have the core temp match the body temp in humans
			if(ishuman(mob_occupant))
				var/mob/living/carbon/human/humi = mob_occupant
				humi.adjust_coretemperature(humi.bodytemperature - humi.coretemperature)

		if(consume_gas) // Transferring reagent costs us extra gas
			air1.gases[/datum/gas/oxygen][MOLES] -= max(0, 2 / efficiency + 1 / efficiency) // Magically consume gas? Why not, we run on cryo magic.
			consume_gas = FALSE
		if(!consume_gas)
			air1.gases[/datum/gas/oxygen][MOLES] -= max(0, 2 / efficiency)
		air1.garbage_collect()

		if(air1.temperature > 2000)
			take_damage(clamp((air1.temperature)/200, 10, 20), BURN)

		update_parents()

/obj/machinery/atmospherics/components/unary/cryo_cell/relaymove(mob/living/user, direction)
	if(message_cooldown <= world.time)
		message_cooldown = world.time + 50
		to_chat(user, span_warning("[src]'s door won't budge!"))

/obj/machinery/atmospherics/components/unary/cryo_cell/open_machine(drop = FALSE)
	if(!state_open && !panel_open)
		set_on(FALSE)
	for(var/mob/M in contents) //only drop mobs
		M.forceMove(get_turf(src))
	set_occupant(null)
	flick("pod-open-anim", src)
	..()

/obj/machinery/atmospherics/components/unary/cryo_cell/close_machine(mob/living/carbon/user)
	treating_wounds = FALSE
	if((isnull(user) || istype(user)) && state_open && !panel_open)
		flick("pod-close-anim", src)
		..(user)
		return occupant

/obj/machinery/atmospherics/components/unary/cryo_cell/container_resist_act(mob/living/user)
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(span_notice("You see [user] kicking against the glass of [src]!"), \
		span_notice("You struggle inside [src], kicking the release with your foot... (this will take about [DisplayTimeText(CRYO_BREAKOUT_TIME)].)"), \
		span_hear("You hear a thump from [src]."))
	if(do_after(user, CRYO_BREAKOUT_TIME, target = src))
		if(!user || user.stat != CONSCIOUS || user.loc != src )
			return
		user.visible_message(span_warning("[user] successfully broke out of [src]!"), \
			span_notice("You successfully break out of [src]!"))
		open_machine()

/obj/machinery/atmospherics/components/unary/cryo_cell/examine(mob/user)
	. = ..()
	if(occupant)
		if(on)
			. += "Someone's inside [src]!"
		else
			. += "You can barely make out a form floating in [src]."
	else
		. += "[src] seems empty."

/obj/machinery/atmospherics/components/unary/cryo_cell/MouseDrop_T(mob/target, mob/user)
	if(user.incapacitated() || !Adjacent(user) || !user.Adjacent(target) || !iscarbon(target) || !ISADVANCEDTOOLUSER(user))
		return
	if(isliving(target))
		var/mob/living/L = target
		if(L.incapacitated())
			close_machine(target)
	else
		user.visible_message(span_notice("[user] starts shoving [target] inside [src]."), span_notice("You start shoving [target] inside [src]."))
		if (do_after(user, 2.5 SECONDS, target=target))
			close_machine(target)

/obj/machinery/atmospherics/components/unary/cryo_cell/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/glass))
		. = 1 //no afterattack
		if(beaker)
			to_chat(user, span_warning("A beaker is already loaded into [src]!"))
			return
		if(!user.transferItemToLoc(I, src))
			return
		beaker = I
		user.visible_message(span_notice("[user] places [I] in [src]."), \
							span_notice("You place [I] in [src]."))
		var/reagentlist = pretty_string_from_reagent_list(I.reagents.reagent_list)
		log_game("[key_name(user)] added an [I] to cryo containing [reagentlist]")
		return
	if(!on && !occupant && !state_open && (default_deconstruction_screwdriver(user, "pod-off", "pod-off", I)) \
		|| default_change_direction_wrench(user, I) \
		|| default_pry_open(I) \
		|| default_deconstruction_crowbar(I))
		update_appearance()
		return
	else if(I.tool_behaviour == TOOL_SCREWDRIVER)
		to_chat(user, "<span class='warning'>You can't access the maintenance panel while the pod is " \
		+ (on ? "active" : (occupant ? "full" : "open")) + "!</span>")
		return
	return ..()

/obj/machinery/atmospherics/components/unary/cryo_cell/ui_state(mob/user)
	return GLOB.notcontained_state


/obj/machinery/atmospherics/components/unary/cryo_cell/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Cryo", name)
		ui.open()

/obj/machinery/atmospherics/components/unary/cryo_cell/ui_data()
	var/list/data = list()
	data["isOperating"] = on
	data["hasOccupant"] = occupant ? TRUE : FALSE
	data["isOpen"] = state_open
	data["autoEject"] = autoeject

	data["occupant"] = list()
	if(occupant)
		var/mob/living/mob_occupant = occupant
		data["occupant"]["name"] = mob_occupant.name
		switch(mob_occupant.stat)
			if(CONSCIOUS)
				data["occupant"]["stat"] = "Conscious"
				data["occupant"]["statstate"] = "good"
			if(SOFT_CRIT)
				data["occupant"]["stat"] = "Conscious"
				data["occupant"]["statstate"] = "average"
			if(UNCONSCIOUS, HARD_CRIT)
				data["occupant"]["stat"] = "Unconscious"
				data["occupant"]["statstate"] = "average"
			if(DEAD)
				data["occupant"]["stat"] = "Dead"
				data["occupant"]["statstate"] = "bad"
		data["occupant"]["health"] = round(mob_occupant.health, 1)
		data["occupant"]["maxHealth"] = mob_occupant.maxHealth
		data["occupant"]["minHealth"] = HEALTH_THRESHOLD_DEAD
		data["occupant"]["bruteLoss"] = round(mob_occupant.getBruteLoss(), 1)
		data["occupant"]["oxyLoss"] = round(mob_occupant.getOxyLoss(), 1)
		data["occupant"]["toxLoss"] = round(mob_occupant.getToxLoss(), 1)
		data["occupant"]["fireLoss"] = round(mob_occupant.getFireLoss(), 1)
		data["occupant"]["bodyTemperature"] = round(mob_occupant.bodytemperature, 1)
		if(mob_occupant.bodytemperature < TCRYO)
			data["occupant"]["temperaturestatus"] = "good"
		else if(mob_occupant.bodytemperature < T0C)
			data["occupant"]["temperaturestatus"] = "average"
		else
			data["occupant"]["temperaturestatus"] = "bad"

	var/datum/gas_mixture/air1 = airs[1]
	data["cellTemperature"] = round(air1.temperature, 1)

	data["isBeakerLoaded"] = beaker ? TRUE : FALSE
	var/beakerContents = list()
	if(beaker && beaker.reagents && beaker.reagents.reagent_list.len)
		for(var/datum/reagent/R in beaker.reagents.reagent_list)
			beakerContents += list(list("name" = R.name, "volume" = R.volume))
	data["beakerContents"] = beakerContents
	return data

/obj/machinery/atmospherics/components/unary/cryo_cell/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("power")
			if(on)
				set_on(FALSE)
			else if(!state_open)
				set_on(TRUE)
			. = TRUE
		if("door")
			if(state_open)
				close_machine()
			else
				open_machine()
			. = TRUE
		if("autoeject")
			autoeject = !autoeject
			. = TRUE
		if("ejectbeaker")
			if(beaker)
				beaker.forceMove(drop_location())
				if(Adjacent(usr) && !issilicon(usr))
					usr.put_in_hands(beaker)
				beaker = null
				. = TRUE

/obj/machinery/atmospherics/components/unary/cryo_cell/can_interact(mob/user)
	return ..() && user.loc != src

/obj/machinery/atmospherics/components/unary/cryo_cell/CtrlClick(mob/user)
	if(can_interact(user) && !state_open)
		set_on(!on)
	return ..()

/obj/machinery/atmospherics/components/unary/cryo_cell/AltClick(mob/user)
	if(can_interact(user))
		if(state_open)
			close_machine()
		else
			open_machine()
	return ..()

/obj/machinery/atmospherics/components/unary/cryo_cell/update_remote_sight(mob/living/user)
	return // we don't see the pipe network while inside cryo.

/obj/machinery/atmospherics/components/unary/cryo_cell/get_remote_view_fullscreens(mob/user)
	user.overlay_fullscreen("remote_view", /atom/movable/screen/fullscreen/impaired, 1)

/obj/machinery/atmospherics/components/unary/cryo_cell/can_see_pipes()
	return FALSE // you can't see the pipe network when inside a cryo cell.

/obj/machinery/atmospherics/components/unary/cryo_cell/return_temperature()
	var/datum/gas_mixture/G = airs[1]

	if(G.total_moles() > 10)
		return G.temperature
	return ..()

/obj/machinery/atmospherics/components/unary/cryo_cell/default_change_direction_wrench(mob/user, obj/item/wrench/W)
	. = ..()
	if(.)
		set_init_directions()
		var/obj/machinery/atmospherics/node = nodes[1]
		if(node)
			node.disconnect(src)
			nodes[1] = null
			if(parents[1])
				nullify_pipenet(parents[1])

		atmos_init()
		node = nodes[1]
		if(node)
			node.atmos_init()
			node.add_member(src)
		SSair.add_to_rebuild_queue(src)

#undef MAX_TEMPERATURE
#undef CRYO_MULTIPLY_FACTOR
#undef CRYO_TX_QTY
#undef CRYO_MIN_GAS_MOLES
#undef CRYO_BREAKOUT_TIME
