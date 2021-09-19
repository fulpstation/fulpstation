//every quirk in this folder should be coded around being applied on spawn
//these are NOT "mob quirks" like GOTTAGOFAST, but exist as a medium to apply them and other different effects
/datum/quirk
	var/name = "Test Quirk"
	var/desc = "This is a test quirk."
	var/value = 0
	var/human_only = TRUE
	var/gain_text
	var/lose_text
	var/medical_record_text //This text will appear on medical records for the trait. Not yet implemented
	var/mood_quirk = FALSE //if true, this quirk affects mood and is unavailable if moodlets are disabled
	var/mob_trait //if applicable, apply and remove this mob trait
	/// Amount of points this trait is worth towards the hardcore character mode; minus points implies a positive quirk, positive means its hard. This is used to pick the quirks assigned to a hardcore character. 0 means its not available to hardcore draws.
	var/hardcore_value = 0
	var/mob/living/quirk_holder
	/// This quirk should START_PROCESSING when added and STOP_PROCESSING when removed.
	var/processing_quirk = FALSE
	/// When making an abstract quirk (in OOP terms), don't forget to set this var to the type path for that abstract quirk.
	var/abstract_parent_type = /datum/quirk

/datum/quirk/Destroy()
	if(quirk_holder)
		remove_from_current_holder()

	return ..()

/// Called when quirk_holder is qdeleting. Simply qdels this datum and lets Destroy() handle the rest.
/datum/quirk/proc/on_holder_qdeleting(mob/living/source, force)
	SIGNAL_HANDLER
	qdel(src)

/**
 * Adds the quirk to a new quirk_holder.
 *
 * Performs logic to make sure new_holder is a valid holder of this quirk.
 * Returns FALSEy if there was some kind of error. Returns TRUE otherwise.
 * Arguments:
 * * new_holder - The mob to add this quirk to.
 * * quirk_transfer - If this is being added to the holder as part of a quirk transfer. Quirks can use this to decide not to spawn new items or apply any other one-time effects.
 */
/datum/quirk/proc/add_to_holder(mob/living/new_holder, quirk_transfer = FALSE)
	if(!new_holder)
		CRASH("Quirk attempted to be added to null mob.")

	if(human_only && !ishuman(new_holder))
		CRASH("Human only quirk attempted to be added to non-human mob.")

	if(new_holder.has_quirk(type))
		CRASH("Quirk attempted to be added to mob which already had this quirk.")

	if(quirk_holder)
		CRASH("Attempted to add quirk to a holder when it already has a holder.")

	quirk_holder = new_holder
	quirk_holder.quirks += src

	if(mob_trait)
		ADD_TRAIT(quirk_holder, mob_trait, QUIRK_TRAIT)

	add()

	if(processing_quirk)
		START_PROCESSING(SSquirks, src)

	if(!quirk_transfer)
		if(gain_text)
			to_chat(quirk_holder, gain_text)
		add_unique()

		if(quirk_holder.client)
			post_add()
		else
			RegisterSignal(quirk_holder, COMSIG_MOB_LOGIN, .proc/on_quirk_holder_first_login)

	RegisterSignal(quirk_holder, COMSIG_PARENT_QDELETING, .proc/on_holder_qdeleting)

	return TRUE

/// Removes the quirk from the current quirk_holder.
/datum/quirk/proc/remove_from_current_holder(quirk_transfer = FALSE)
	if(!quirk_holder)
		CRASH("Attempted to remove quirk from the current holder when it has no current holder.")

	UnregisterSignal(quirk_holder, list(COMSIG_MOB_LOGIN, COMSIG_PARENT_QDELETING))

	quirk_holder.quirks -= src

	if(!quirk_transfer && lose_text)
		to_chat(quirk_holder, lose_text)

	if(mob_trait)
		REMOVE_TRAIT(quirk_holder, mob_trait, QUIRK_TRAIT)

	if(processing_quirk)
		STOP_PROCESSING(SSquirks, src)

	remove()

	quirk_holder = null

/**
 * On client connection set quirk preferences.
 *
 * Run post_add to set the client preferences for the quirk.
 * Clear the attached signal for login.
 * Used when the quirk has been gained and no client is attached to the mob.
 */
/datum/quirk/proc/on_quirk_holder_first_login(mob/living/source)
		SIGNAL_HANDLER

		UnregisterSignal(source, COMSIG_MOB_LOGIN)
		post_add()

/// Any effect that should be applied every single time the quirk is added to any mob, even when transferred.
/datum/quirk/proc/add()
/// Any effects from the proc that should not be done multiple times if the quirk is transferred between mobs. Put stuff like spawning items in here.
/datum/quirk/proc/add_unique()
/// Removal of any reversible effects added by the quirk.
/datum/quirk/proc/remove()
/// Any special effects or chat messages which should be applied. This proc is guaranteed to run if the mob has a client when the quirk is added. Otherwise, it runs once on the next COMSIG_MOB_LOGIN.
/datum/quirk/proc/post_add()

/// Subtype quirk that has some bonus logic to spawn items for the player.
/datum/quirk/item_quirk
	/// Lazylist of strings describing where all the quirk items have been spawned.
	var/list/where_items_spawned
	/// If true, the backpack automatically opens on post_add(). Usually set to TRUE when an item is equipped inside the player's backpack.
	var/open_backpack = FALSE
	abstract_parent_type = /datum/quirk/item_quirk

/**
 * Handles inserting an item in any of the valid slots provided, then allows for post_add notification.
 *
 * If no valid slot is available for an item, the item is left at the mob's feet.
 * Arguments:
 * * quirk_item - The item to give to the quirk holder. If the item is a path, the item will be spawned in first on the player's turf.
 * * valid_slots - Assoc list of descriptive location strings to item slots that is fed into [/mob/living/carbon/proc/equip_in_one_of_slots]. list(LOCATION_BACKPACK = ITEM_SLOT_BACKPACK)
 * * flavour_text - Optional flavour text to append to the where_items_spawned string after the item's location.
 * * default_location - If the item isn't possible to equip in a valid slot, this is a description of where the item was spawned.
 * * notify_player - If TRUE, adds strings to where_items_spawned list to be output to the player in [/datum/quirk/item_quirk/post_add()]
 */
/datum/quirk/item_quirk/proc/give_item_to_holder(quirk_item, list/valid_slots, flavour_text = null, default_location = "at your feet", notify_player = TRUE)
	if(ispath(quirk_item))
		quirk_item = new quirk_item(get_turf(quirk_holder))

	var/mob/living/carbon/human/human_holder = quirk_holder

	var/where = human_holder.equip_in_one_of_slots(quirk_item, valid_slots, qdel_on_fail = FALSE) || default_location

	if(where == LOCATION_BACKPACK)
		open_backpack = TRUE

	if(notify_player)
		LAZYADD(where_items_spawned, span_boldnotice("You have \a [quirk_item] [where]. [flavour_text]"))

/datum/quirk/item_quirk/post_add()
	if(open_backpack)
		var/mob/living/carbon/human/human_holder = quirk_holder
		// post_add() can be called via delayed callback. Check they still have a backpack equipped before trying to open it.
		if(human_holder.back)
			SEND_SIGNAL(human_holder.back, COMSIG_TRY_STORAGE_SHOW, human_holder)

	for(var/chat_string in where_items_spawned)
		to_chat(quirk_holder, chat_string)

	where_items_spawned = null

/**
 * get_quirk_string() is used to get a printable string of all the quirk traits someone has for certain criteria
 *
 * Arguments:
 * * Medical- If we want the long, fancy descriptions that show up in medical records, or if not, just the name
 * * Category- Which types of quirks we want to print out. Defaults to everything
 */
/mob/living/proc/get_quirk_string(medical, category = CAT_QUIRK_ALL) //helper string. gets a string of all the quirks the mob has
	var/list/dat = list()
	switch(category)
		if(CAT_QUIRK_ALL)
			for(var/V in quirks)
				var/datum/quirk/T = V
				dat += medical ? T.medical_record_text : T.name
		//Major Disabilities
		if(CAT_QUIRK_MAJOR_DISABILITY)
			for(var/V in quirks)
				var/datum/quirk/T = V
				if(T.value < -4)
					dat += medical ? T.medical_record_text : T.name
		//Minor Disabilities
		if(CAT_QUIRK_MINOR_DISABILITY)
			for(var/V in quirks)
				var/datum/quirk/T = V
				if(T.value >= -4 && T.value < 0)
					dat += medical ? T.medical_record_text : T.name
		//Neutral and Positive quirks
		if(CAT_QUIRK_NOTES)
			for(var/V in quirks)
				var/datum/quirk/T = V
				if(T.value > -1)
					dat += medical ? T.medical_record_text : T.name
	if(!dat.len)
		return medical ? "No issues have been declared." : "None"
	return medical ?  dat.Join("<br>") : dat.Join(", ")

/mob/living/proc/cleanse_trait_datums() //removes all trait datums
	for(var/V in quirks)
		var/datum/quirk/T = V
		qdel(T)

/mob/living/proc/transfer_trait_datums(mob/living/to_mob)
	for(var/datum/quirk/quirk as anything in quirks)
		quirk.remove_from_current_holder(quirk_transfer = TRUE)
		quirk.add_to_holder(to_mob, quirk_transfer = TRUE)
