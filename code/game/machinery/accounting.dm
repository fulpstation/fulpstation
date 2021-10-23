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
			to_chat(user, span_warning("[src] already has a card inserted!"))
			return
		if(new_id.registered_account)
			to_chat(user, span_warning("[src] already has a bank account!"))
			return
		if(!anchored || !user.transferItemToLoc(I,src))
			to_chat(user, span_warning("\the [src] blinks red as you try to insert the ID Card!"))
			return
		inserted_id = new_id
		RegisterSignal(inserted_id, COMSIG_PARENT_QDELETING, .proc/remove_card)
		var/datum/bank_account/bank_account = new /datum/bank_account(inserted_id.registered_name)
		inserted_id.registered_account = bank_account
		if(istype(new_id.trim, /datum/id_trim/job))
			var/datum/id_trim/job/job_trim = new_id.trim
			bank_account.account_job = job_trim.job
		else
			bank_account.account_job = /datum/job/unassigned
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
	user.visible_message(span_notice("[user] removes [inserted_id] from \the [src]."), span_notice("You remove [inserted_id] from \the [src]."))
	remove_card()

///Used to clean up variables after the card has been removed, unregisters the removal signal, sets inserted ID to null, and updates the icon.
/obj/machinery/accounting/proc/remove_card()
	SIGNAL_HANDLER
	UnregisterSignal(inserted_id, COMSIG_PARENT_QDELETING)
	inserted_id = null
	update_appearance()

/obj/machinery/accounting/update_overlays()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN) || !anchored)
		return
	if(panel_open)
		. += mutable_appearance(icon, "recharger-open", alpha = src.alpha)
		return
	if(inserted_id)
		. += mutable_appearance(icon, "recharger-full", alpha = src.alpha)
		. += emissive_appearance(icon, "recharger-full", alpha = src.alpha)
		return

	. += mutable_appearance(icon, "recharger-empty", alpha = src.alpha)
	. += emissive_appearance(icon, "recharger-empty", alpha = src.alpha)

/obj/machinery/accounting/update_appearance(updates)
	. = ..()
	if((machine_stat & (NOPOWER|BROKEN)) || panel_open || !anchored)
		luminosity = 0
		return
	luminosity = 1
