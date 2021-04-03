/obj/item/transfer_valve
	icon = 'icons/obj/assemblies.dmi'
	name = "tank transfer valve"
	icon_state = "valve_1"
	base_icon_state = "valve"
	inhand_icon_state = "ttv"
	lefthand_file = 'icons/mob/inhands/weapons/bombs_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/bombs_righthand.dmi'
	desc = "Regulates the transfer of air between two tanks."
	w_class = WEIGHT_CLASS_BULKY

	var/obj/item/tank/tank_one
	var/obj/item/tank/tank_two
	var/obj/item/assembly/attached_device
	var/mob/attacher = null
	var/valve_open = FALSE
	var/toggle = TRUE

/obj/item/transfer_valve/IsAssemblyHolder()
	return TRUE

/obj/item/transfer_valve/attackby(obj/item/item, mob/user, params)
	if(istype(item, /obj/item/tank))
		if(tank_one && tank_two)
			to_chat(user, "<span class='warning'>There are already two tanks attached, remove one first!</span>")
			return

		if(!tank_one)
			if(!user.transferItemToLoc(item, src))
				return
			tank_one = item
			to_chat(user, "<span class='notice'>You attach the tank to the transfer valve.</span>")
		else if(!tank_two)
			if(!user.transferItemToLoc(item, src))
				return
			tank_two = item
			to_chat(user, "<span class='notice'>You attach the tank to the transfer valve.</span>")

		update_appearance()
//TODO: Have this take an assemblyholder
	else if(isassembly(item))
		var/obj/item/assembly/A = item
		if(A.secured)
			to_chat(user, "<span class='notice'>The device is secured.</span>")
			return
		if(attached_device)
			to_chat(user, "<span class='warning'>There is already a device attached to the valve, remove it first!</span>")
			return
		if(!user.transferItemToLoc(item, src))
			return
		attached_device = A
		to_chat(user, "<span class='notice'>You attach the [item] to the valve controls and secure it.</span>")
		A.holder = src
		A.toggle_secure() //this calls update_icon(), which calls update_icon() on the holder (i.e. the bomb).
		log_bomber(user, "attached a [item.name] to a ttv -", src, null, FALSE)
		attacher = user
	return

//These keep attached devices synced up, for example a TTV with a mouse trap being found in a bag so it's triggered, or moving the TTV with an infrared beam sensor to update the beam's direction.
/obj/item/transfer_valve/Move()
	. = ..()
	if(attached_device)
		attached_device.holder_movement()

/obj/item/transfer_valve/dropped()
	. = ..()
	if(attached_device)
		attached_device.dropped()

/obj/item/transfer_valve/on_found(mob/finder)
	if(attached_device)
		attached_device.on_found(finder)

/obj/item/transfer_valve/Crossed(atom/movable/AM as mob|obj)
	. = ..()
	if(attached_device)
		attached_device.Crossed(AM)

//Triggers mousetraps
/obj/item/transfer_valve/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(attached_device)
		attached_device.attack_hand()

/obj/item/transfer_valve/proc/process_activation(obj/item/D)
	if(toggle)
		toggle = FALSE
		toggle_valve()
		addtimer(CALLBACK(src, .proc/toggle_off), 5) //To stop a signal being spammed from a proxy sensor constantly going off or whatever

/obj/item/transfer_valve/proc/toggle_off()
	toggle = TRUE

/obj/item/transfer_valve/update_icon_state()
	icon_state = "[base_icon_state][(!tank_one && !tank_two && !attached_device) ? "_1" : null]"
	return ..()

/obj/item/transfer_valve/update_overlays()
	. = ..()
	if(tank_one)
		. += "[tank_one.icon_state]"

	if(!tank_two)
		underlays = null
	else
		var/mutable_appearance/J = mutable_appearance(icon, icon_state = "[tank_two.icon_state]")
		var/matrix/T = matrix()
		T.Translate(-13, 0)
		J.transform = T
		underlays = list(J)

	if(!attached_device)
		return

	. += "device"
	if(!istype(attached_device, /obj/item/assembly/infra))
		return
	var/obj/item/assembly/infra/sensor = attached_device
	if(sensor.on && sensor.visible)
		. += "proxy_beam"


/obj/item/transfer_valve/proc/merge_gases(datum/gas_mixture/target, change_volume = TRUE)
	var/target_self = FALSE
	if(!target || (target == tank_one.air_contents))
		target = tank_two.air_contents
	if(target == tank_two.air_contents)
		target_self = TRUE
	if(change_volume)
		if(!target_self)
			target.volume += tank_two.volume
		target.volume += tank_one.air_contents.volume
	var/datum/gas_mixture/temp
	temp = tank_one.air_contents.remove_ratio(1)
	target.merge(temp)
	if(!target_self)
		temp = tank_two.air_contents.remove_ratio(1)
		target.merge(temp)

/obj/item/transfer_valve/proc/split_gases()
	if (!valve_open || !tank_one || !tank_two)
		return
	var/ratio1 = tank_one.air_contents.volume/tank_two.air_contents.volume
	var/datum/gas_mixture/temp
	temp = tank_two.air_contents.remove_ratio(ratio1)
	tank_one.air_contents.merge(temp)
	tank_two.air_contents.volume -=  tank_one.air_contents.volume

/*
	Exadv1: I know this isn't how it's going to work, but this was just to check
	it explodes properly when it gets a signal (and it does).
*/
/obj/item/transfer_valve/proc/toggle_valve()
	if(!valve_open && tank_one && tank_two)
		valve_open = TRUE
		var/turf/bombturf = get_turf(src)

		var/attachment
		var/attachment_signal_log
		if(attached_device)
			if(istype(attached_device, /obj/item/assembly/signaler))
				var/obj/item/assembly/signaler/attached_signaller = attached_device
				attachment = "<A HREF='?_src_=holder;[HrefToken()];secrets=list_signalers'>[attached_signaller]</A>"
				attachment_signal_log = attached_signaller.last_receive_signal_log ? "The following log entry is the last one associated with the attached signaller<br>[attached_signaller.last_receive_signal_log]" : "There is no signal log entry."
			else
				attachment = attached_device

		var/admin_attachment_message
		var/attachment_message
		if(attachment)
			admin_attachment_message = "The bomb had [attachment], which was attached by [attacher ? ADMIN_LOOKUPFLW(attacher) : "Unknown"]"
			attachment_message = " with [attachment] attached by [attacher ? key_name_admin(attacher) : "Unknown"]"

		var/mob/bomber = get_mob_by_key(fingerprintslast)
		var/admin_bomber_message
		var/bomber_message
		if(bomber)
			admin_bomber_message = "The bomb's most recent set of fingerprints indicate it was last touched by [ADMIN_LOOKUPFLW(bomber)]"
			bomber_message = " - Last touched by: [key_name_admin(bomber)]"

		var/admin_bomb_message = "Bomb valve opened in [ADMIN_VERBOSEJMP(bombturf)]<br>[admin_attachment_message]<br>[admin_bomber_message]<br>[attachment_signal_log]"
		GLOB.bombers += admin_bomb_message
		message_admins(admin_bomb_message)
		log_game("Bomb valve opened in [AREACOORD(bombturf)][attachment_message][bomber_message]")

		merge_gases()
		for(var/i in 1 to 6)
			addtimer(CALLBACK(src, /atom/.proc/update_appearance), 20 + (i - 1) * 10)

	else if(valve_open && tank_one && tank_two)
		split_gases()
		valve_open = FALSE
		update_appearance()
/*
	This doesn't do anything but the timer etc. expects it to be here
	eventually maybe have it update icon to show state (timer, prox etc.) like old bombs
*/
/obj/item/transfer_valve/proc/c_state()
	return

/obj/item/transfer_valve/ui_state(mob/user)
	return GLOB.hands_state

/obj/item/transfer_valve/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TransferValve", name)
		ui.open()

/obj/item/transfer_valve/ui_data(mob/user)
	var/list/data = list()
	data["tank_one"] = tank_one ? tank_one.name : null
	data["tank_two"] = tank_two ? tank_two.name : null
	data["attached_device"] = attached_device ? attached_device.name : null
	data["valve"] = valve_open
	return data

/obj/item/transfer_valve/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("tankone")
			if(tank_one)
				split_gases()
				valve_open = FALSE
				tank_one.forceMove(drop_location())
				tank_one = null
				. = TRUE
		if("tanktwo")
			if(tank_two)
				split_gases()
				valve_open = FALSE
				tank_two.forceMove(drop_location())
				tank_two = null
				. = TRUE
		if("toggle")
			toggle_valve()
			. = TRUE
		if("device")
			if(attached_device)
				attached_device.attack_self(usr)
				. = TRUE
		if("remove_device")
			if(attached_device)
				attached_device.on_detach()
				attached_device = null
				. = TRUE

	update_appearance()

/**
 * Returns if this is ready to be detonated. Checks if both tanks are in place.
 */
/obj/item/transfer_valve/proc/ready()
	return tank_one && tank_two
