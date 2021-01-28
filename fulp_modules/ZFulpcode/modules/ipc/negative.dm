/datum/quirk/brainproblems/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/pills = new /obj/item/storage/pill_bottle/mannitol/braintumor()
	var/synth_pills = new /obj/item/storage/pill_bottle/mannitol/synth()
	var/list/slots = list(
		LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
		LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
		LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
		LOCATION_HANDS = ITEM_SLOT_HANDS
	)
	if(isIPC(H))
		where = H.equip_in_one_of_slots(synth_pills, slots, FALSE) || "at your feet"
	else
		where = H.equip_in_one_of_slots(pills, slots, FALSE) || "at your feet"

/datum/quirk/brainproblems/post_add()
	if(where == ITEM_SLOT_BACKPACK)
		var/mob/living/carbon/human/H = quirk_holder
		SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)

	if(isIPC(quirk_holder))
		to_chat(quirk_holder, "<span class='boldnotice'>There is a bottle of liquid solder [where] to keep you alive until you can secure a supply of medication. Don't rely on it too much!</span>")
	else
		to_chat(quirk_holder, "<span class='boldnotice'>There is a bottle of mannitol pills [where] to keep you alive until you can secure a supply of medication. Don't rely on it too much!</span>")
