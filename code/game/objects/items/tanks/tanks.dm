/// How much time (in seconds) is assumed to pass while assuming air. Used to scale overpressure/overtemp damage when assuming air.
#define ASSUME_AIR_DT_FACTOR 1

/**
 * # Gas Tank
 *
 * Handheld gas canisters
 * Can rupture explosively if overpressurized
 */
/obj/item/tank
	name = "tank"
	icon = 'icons/obj/tank.dmi'
	icon_state = "generic"
	lefthand_file = 'icons/mob/inhands/equipment/tanks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tanks_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	worn_icon = 'icons/mob/clothing/back.dmi' //since these can also get thrown into suit storage slots. if something goes on the belt, set this to null.
	hitsound = 'sound/weapons/smash.ogg'
	pressure_resistance = ONE_ATMOSPHERE * 5
	force = 5
	throwforce = 10
	throw_speed = 1
	throw_range = 4
	custom_materials = list(/datum/material/iron = 500)
	actions_types = list(/datum/action/item_action/set_internals)
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 10, BIO = 0, RAD = 0, FIRE = 80, ACID = 30)
	integrity_failure = 0.5
	/// The gases this tank contains.
	var/datum/gas_mixture/air_contents = null
	/// The volume of this tank.
	var/volume = 70
	/// Whether the tank is currently leaking.
	var/leaking = FALSE
	/// The pressure of the gases this tank supplies to internals.
	var/distribute_pressure = ONE_ATMOSPHERE
	/// Icon state when in a tank holder. Null makes it incompatible with tank holder.
	var/tank_holder_icon_state = "holder_generic"

/obj/item/tank/ui_action_click(mob/user)
	toggle_internals(user)

/obj/item/tank/proc/toggle_internals(mob/user)
	var/mob/living/carbon/human/H = user
	if(!istype(H))
		return

	if(H.internal == src)
		to_chat(H, "<span class='notice'>You close [src] valve.</span>")
		H.internal = null
		H.update_internals_hud_icon(0)
	else
		if(!H.getorganslot(ORGAN_SLOT_BREATHING_TUBE))
			if(!H.wear_mask)
				to_chat(H, "<span class='warning'>You need a mask!</span>")
				return
			var/is_clothing = isclothing(H.wear_mask)
			if(is_clothing && H.wear_mask.mask_adjusted)
				H.wear_mask.adjustmask(H)
			if(!is_clothing || !(H.wear_mask.clothing_flags & MASKINTERNALS))
				to_chat(H, "<span class='warning'>[H.wear_mask] can't use [src]!</span>")
				return

		if(H.internal)
			to_chat(H, "<span class='notice'>You switch your internals to [src].</span>")
		else
			to_chat(H, "<span class='notice'>You open [src] valve.</span>")
		H.internal = src
		H.update_internals_hud_icon(1)
	H.update_action_buttons_icon()


/obj/item/tank/Initialize()
	. = ..()

	air_contents = new(volume) //liters
	air_contents.temperature = T20C

	populate_gas()

	START_PROCESSING(SSobj, src)

/obj/item/tank/proc/populate_gas()
	return

/obj/item/tank/Destroy()
	if(air_contents)
		QDEL_NULL(air_contents)

	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/tank/ComponentInitialize()
	. = ..()
	if(tank_holder_icon_state)
		AddComponent(/datum/component/container_item/tank_holder, tank_holder_icon_state)

/obj/item/tank/examine(mob/user)
	var/obj/icon = src
	. = ..()
	if(istype(src.loc, /obj/item/assembly))
		icon = src.loc
	if(!in_range(src, user) && !isobserver(user))
		if(icon == src)
			. += "<span class='notice'>If you want any more information you'll need to get closer.</span>"
		return

	. += "<span class='notice'>The pressure gauge reads [round(src.air_contents.return_pressure(),0.01)] kPa.</span>"

	var/celsius_temperature = src.air_contents.temperature-T0C
	var/descriptive

	if (celsius_temperature < 20)
		descriptive = "cold"
	else if (celsius_temperature < 40)
		descriptive = "room temperature"
	else if (celsius_temperature < 80)
		descriptive = "lukewarm"
	else if (celsius_temperature < 100)
		descriptive = "warm"
	else if (celsius_temperature < 300)
		descriptive = "hot"
	else
		descriptive = "furiously hot"

	. += "<span class='notice'>It feels [descriptive].</span>"

/obj/item/tank/deconstruct(disassembled = TRUE)
	var/turf/location = get_turf(src)
	if(location)
		location.assume_air(air_contents)
		location.air_update_turf(FALSE, FALSE)
		playsound(location, 'sound/effects/spray.ogg', 10, TRUE, -3)
	return ..()

/obj/item/tank/suicide_act(mob/user)
	var/mob/living/carbon/human/H = user
	user.visible_message("<span class='suicide'>[user] is putting [src]'s valve to [user.p_their()] lips! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(loc, 'sound/effects/spray.ogg', 10, TRUE, -3)
	if(!QDELETED(H) && air_contents && air_contents.return_pressure() >= 1000)
		ADD_TRAIT(H, TRAIT_DISFIGURED, TRAIT_GENERIC)
		H.inflate_gib()
		return MANUAL_SUICIDE
	else
		to_chat(user, "<span class='warning'>There isn't enough pressure in [src] to commit suicide with...</span>")
	return SHAME

/obj/item/tank/attackby(obj/item/W, mob/user, params)
	add_fingerprint(user)
	if(istype(W, /obj/item/assembly_holder))
		bomb_assemble(W, user)
		return TRUE
	return ..()

/obj/item/tank/ui_state(mob/user)
	return GLOB.hands_state

/obj/item/tank/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Tank", name)
		ui.open()

/obj/item/tank/ui_static_data(mob/user)
	. = list (
		"defaultReleasePressure" = round(TANK_DEFAULT_RELEASE_PRESSURE),
		"minReleasePressure" = round(TANK_MIN_RELEASE_PRESSURE),
		"maxReleasePressure" = round(TANK_MAX_RELEASE_PRESSURE),
		"leakPressure" = round(TANK_LEAK_PRESSURE),
		"fragmentPressure" = round(TANK_FRAGMENT_PRESSURE)
	)

/obj/item/tank/ui_data(mob/user)
	. = list(
		"tankPressure" = round(air_contents.return_pressure()),
		"releasePressure" = round(distribute_pressure)
	)

	var/mob/living/carbon/C = user
	if(!istype(C))
		C = loc.loc
	if(istype(C) && C.internal == src)
		.["connected"] = TRUE

/obj/item/tank/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("pressure")
			var/pressure = params["pressure"]
			if(pressure == "reset")
				pressure = initial(distribute_pressure)
				. = TRUE
			else if(pressure == "min")
				pressure = TANK_MIN_RELEASE_PRESSURE
				. = TRUE
			else if(pressure == "max")
				pressure = TANK_MAX_RELEASE_PRESSURE
				. = TRUE
			else if(text2num(pressure) != null)
				pressure = text2num(pressure)
				. = TRUE
			if(.)
				distribute_pressure = clamp(round(pressure), TANK_MIN_RELEASE_PRESSURE, TANK_MAX_RELEASE_PRESSURE)

/obj/item/tank/remove_air(amount)
	return air_contents.remove(amount)

/obj/item/tank/return_air()
	return air_contents

/obj/item/tank/return_analyzable_air()
	return air_contents

/obj/item/tank/assume_air(datum/gas_mixture/giver)
	air_contents.merge(giver)
	handle_tolerances(ASSUME_AIR_DT_FACTOR)
	return TRUE

/**
 * Removes some volume of the tanks gases as the tanks distribution pressure.
 *
 * Arguments:
 * - volume_to_return: The amount of volume to remove from the tank.
 */
/obj/item/tank/proc/remove_air_volume(volume_to_return)
	if(!air_contents)
		return null

	var/tank_pressure = air_contents.return_pressure()
	var/actual_distribute_pressure = clamp(tank_pressure, 0, distribute_pressure)

	// Lets do some algebra to understand why this works, yeah?
	// R_IDEAL_GAS_EQUATION is (kPa * L) / (K * mol) by the by, so the units in this equation look something like this
	// kpa * L / (R_IDEAL_GAS_EQUATION * K)
	// Or restated (kpa * L / K) * 1/R_IDEAL_GAS_EQUATION
	// (kpa * L * K * mol) / (kpa * L * K)
	// If we cancel it all out, we get moles, which is the expected unit
	// This sort of thing comes up often in atmos, keep the tool in mind for other bits of code
	var/moles_needed = actual_distribute_pressure*volume_to_return/(R_IDEAL_GAS_EQUATION*air_contents.temperature)

	return remove_air(moles_needed)

/obj/item/tank/process(delta_time)
	if(!air_contents)
		return

	//Allow for reactions
	air_contents.react(src)
	handle_tolerances(delta_time)
	if(QDELETED(src) || !leaking || !air_contents)
		return
	var/turf/location = get_turf(src)
	if(!location)
		return
	var/datum/gas_mixture/leaked_gas = air_contents.remove_ratio(0.25)
	location.assume_air(leaked_gas)
	location.air_update_turf(FALSE, FALSE)

/**
 * Handles the minimum and maximum pressure tolerances of the tank.
 *
 * Arguments:
 * - delta_time: How long has passed between ticks.
 */
/obj/item/tank/proc/handle_tolerances(delta_time)
	if(!air_contents)
		return FALSE

	var/pressure = air_contents.return_pressure()
	var/temperature = air_contents.return_temperature()
	if(temperature >= TANK_MELT_TEMPERATURE)
		var/temperature_damage_ratio = (temperature - TANK_MELT_TEMPERATURE) / temperature
		take_damage(max_integrity * temperature_damage_ratio * delta_time, BURN, FIRE, FALSE, NONE)
		if(QDELETED(src))
			return TRUE

	if(pressure >= TANK_LEAK_PRESSURE)
		var/pressure_damage_ratio = (pressure - TANK_LEAK_PRESSURE) / (TANK_RUPTURE_PRESSURE - TANK_LEAK_PRESSURE)
		take_damage(max_integrity * pressure_damage_ratio * delta_time, BRUTE, BOMB, FALSE, NONE)
	return TRUE

/// Handles the tank springing a leak.
/obj/item/tank/obj_break(damage_flag)
	. = ..()
	if(leaking)
		return

	leaking = TRUE
	if(obj_integrity < 0) // So we don't play the alerts while we are exploding or rupturing.
		return
	visible_message("<span class='warning'>[src] springs a leak!</span>")
	playsound(src, 'sound/effects/spray.ogg', 10, TRUE, -3)

/// Handles rupturing and fragmenting
/obj/item/tank/obj_destruction(damage_flag)
	if(!air_contents)
		return ..()

	var/turf/location = get_turf(src)
	if(!location)
		return ..()

	/// Handle fragmentation
	var/pressure = air_contents.return_pressure()
	if(pressure > TANK_FRAGMENT_PRESSURE)
		if(!istype(loc, /obj/item/transfer_valve))
			log_bomber(get_mob_by_key(fingerprintslast), "was last key to touch", src, "which ruptured explosively")
		//Give the gas a chance to build up more pressure through reacting
		air_contents.react(src)
		pressure = air_contents.return_pressure()
		var/range = (pressure-TANK_FRAGMENT_PRESSURE)/TANK_FRAGMENT_SCALE

		explosion(location, round(range*0.25), round(range*0.5), round(range), round(range*1.5))
	return ..()

/obj/item/tank/rad_act(strength)
	. = ..()
	var/gas_change = FALSE
	var/list/cached_gases = air_contents.gases
	if(cached_gases[/datum/gas/oxygen] && cached_gases[/datum/gas/carbon_dioxide])
		gas_change = TRUE
		var/pulse_strength = min(strength, cached_gases[/datum/gas/oxygen][MOLES] * 1000, cached_gases[/datum/gas/carbon_dioxide][MOLES] * 2000)
		cached_gases[/datum/gas/carbon_dioxide][MOLES] -= pulse_strength / 2000
		cached_gases[/datum/gas/oxygen][MOLES] -= pulse_strength / 1000
		ASSERT_GAS(/datum/gas/pluoxium, air_contents)
		cached_gases[/datum/gas/pluoxium][MOLES] += pulse_strength / 4000
		strength -= pulse_strength

	if(cached_gases[/datum/gas/hydrogen])
		gas_change = TRUE
		var/pulse_strength = min(strength, cached_gases[/datum/gas/hydrogen][MOLES] * 1000)
		cached_gases[/datum/gas/hydrogen][MOLES] -= pulse_strength / 1000
		ASSERT_GAS(/datum/gas/tritium, air_contents)
		cached_gases[/datum/gas/tritium][MOLES] += pulse_strength / 1000
		strength -= pulse_strength

	if(gas_change)
		air_contents.garbage_collect()

#undef ASSUME_AIR_DT_FACTOR
