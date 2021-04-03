/obj/machinery/accounting
	name = "account registration device"
	desc = "A machine that allows heads of staff to create a new bank account after inserting an ID."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "recharger"
	circuit = /obj/item/circuitboard/machine/accounting
	pass_flags = PASSTABLE
	req_one_access = list(ACCESS_HEADS, ACCESS_CHANGE_IDS)
	var/obj/item/card/id/inserted_id

/obj/machinery/accounting/Destroy()
	if(inserted_id)
		remove_card()
	return ..()

/obj/machinery/accounting/attackby(obj/item/I, mob/living/user, params)
	if(isidcard(I))
		var/obj/item/card/id/new_id = I
		if(inserted_id)
			to_chat(user, "<span class='warning'>[src] already has a card inserted!</span>")
			return
		if(new_id.registered_account)
			to_chat(user, "<span class='warning'>[src] already has a bank account!</span>")
			return
		if(!anchored || !user.transferItemToLoc(I,src))
			to_chat(user, "<span class='warning'>\the [src] blinks red as you try to insert the ID Card!</span>")
			return
		inserted_id = new_id
		RegisterSignal(inserted_id, COMSIG_PARENT_QDELETING, .proc/remove_card)
		var/datum/bank_account/bank_account = new /datum/bank_account(inserted_id.registered_name)
		inserted_id.registered_account = bank_account
		playsound(loc, 'sound/machines/synth_yes.ogg', 30 , TRUE)
		update_appearance()
		return
	return ..()


/obj/machinery/accounting/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!inserted_id)
		return

	user.put_in_hands(inserted_id)
	inserted_id.add_fingerprint(user)
	user.visible_message("<span class='notice'>[user] removes [inserted_id] from \the [src].</span>", "<span class='notice'>You remove [inserted_id] from \the [src].</span>")
	remove_card()

///Used to clean up variables after the card has been removed, unregisters the removal signal, sets inserted ID to null, and updates the icon.
/obj/machinery/accounting/proc/remove_card()
	UnregisterSignal(inserted_id, COMSIG_PARENT_QDELETING)
	inserted_id = null
	update_appearance()

/obj/machinery/accounting/update_overlays()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN) || !anchored)
		return
	if(panel_open)
		. += mutable_appearance(icon, "recharger-open", layer, plane, alpha)
		return
	if(inserted_id)
		. += mutable_appearance(icon, "recharger-full", layer, plane, alpha)
		. += mutable_appearance(icon, "recharger-full", 0, EMISSIVE_PLANE, alpha)
		return

	. += mutable_appearance(icon, "recharger-empty", layer, plane, alpha)
	. += mutable_appearance(icon, "recharger-empty", 0, EMISSIVE_PLANE, alpha)

/obj/machinery/accounting/update_appearance(updates)
	. = ..()
	if((machine_stat & (NOPOWER|BROKEN)) || panel_open || !anchored)
		luminosity = 0
		return
	luminosity = 1
