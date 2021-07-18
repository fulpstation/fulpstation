#define MECH_FIGHTERS "Fighter Kit"
#define MECH_SUPPORT "Support Kit"
#define MECH_DESTROY "Destroyer Kit"
#define MECH_LAUGH "Silly Kit"
#define MECH_NUKE "Nuclear Kit"
#define MECH_DECOMMISSIONED "Decommissioned Kit"
#define MECH_LEFTOVER "Leftovers Kit"

/*
 *	# List of all mechs
 *
	/obj/item/toy/mecha/ripley
	/obj/item/toy/mecha/ripleymkii
	/obj/item/toy/mecha/hauler
	/obj/item/toy/mecha/clarke
	/obj/item/toy/mecha/odysseus
	/obj/item/toy/mecha/gygax
	/obj/item/toy/mecha/durand
	/obj/item/toy/mecha/savannahivanov
	/obj/item/toy/mecha/phazon
	/obj/item/toy/mecha/honk
	/obj/item/toy/mecha/darkgygax
	/obj/item/toy/mecha/mauler
	/obj/item/toy/mecha/darkhonk
	/obj/item/toy/mecha/deathripley
	/obj/item/toy/mecha/reticence
	/obj/item/toy/mecha/marauder
	/obj/item/toy/mecha/seraph
	/obj/item/toy/mecha/firefighter
 */

/// Mailbag.
/obj/item/storage/bag/mechs
	name = "mech bag"
	desc = "A bag for holding your little mech fighters."
	icon = 'icons/obj/library.dmi'
	icon_state = "bookbag"
	worn_icon_state = "bookbag"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/mech_type = MECH_FIGHTERS

/// Subtypes
/obj/item/storage/bag/mechs/fighters
	mech_type = MECH_FIGHTERS
/obj/item/storage/bag/mechs/support
	mech_type = MECH_SUPPORT
/obj/item/storage/bag/mechs/destroy
	mech_type = MECH_DESTROY
/obj/item/storage/bag/mechs/laugh
	mech_type = MECH_LAUGH
/obj/item/storage/bag/mechs/nuke
	mech_type = MECH_NUKE
/obj/item/storage/bag/mechs/decommissioned
	mech_type = MECH_DECOMMISSIONED
/obj/item/storage/bag/mechs/leftover
	mech_type = MECH_LEFTOVER

/obj/item/storage/bag/mechs/ComponentInitialize()
	. = ..()
	var/datum/component/storage/storage = GetComponent(/datum/component/storage)
	storage.max_w_class = WEIGHT_CLASS_NORMAL
	storage.max_combined_w_class = 80
	storage.max_items = 40
	storage.display_numerical_stacking = FALSE
	storage.set_holdable(list(
		/obj/item/toy/mecha,
	))

/obj/item/storage/bag/mechs/PopulateContents()
	switch(mech_type)
		if(MECH_FIGHTERS)
			new /obj/item/toy/mecha/gygax(src)
			new /obj/item/toy/mecha/durand(src)
			new /obj/item/toy/mecha/ripleymkii(src)
		if(MECH_SUPPORT)
			new /obj/item/toy/mecha/odysseus(src)
			new /obj/item/toy/mecha/phazon(src)
			new /obj/item/toy/mecha/seraph(src)
		if(MECH_DESTROY)
			new /obj/item/toy/mecha/savannahivanov(src)
			new /obj/item/toy/mecha/clarke(src)
			new /obj/item/toy/mecha/marauder(src)
		if(MECH_LAUGH)
			new /obj/item/toy/mecha/honk(src)
			new /obj/item/toy/mecha/darkhonk(src)
			new /obj/item/toy/mecha/reticence(src)
		if(MECH_NUKE)
			new /obj/item/toy/mecha/deathripley(src)
			new /obj/item/toy/mecha/darkhonk(src)
			new /obj/item/toy/mecha/darkgygax(src)
		if(MECH_DECOMMISSIONED)
			new /obj/item/toy/mecha/reticence(src)
			new /obj/item/toy/mecha/firefighter(src)
			new /obj/item/toy/mecha/ripley(src)
		if(MECH_LEFTOVER)
			new /obj/item/toy/mecha/hauler(src)
			new /obj/item/toy/mecha/marauder(src)
			new /obj/item/toy/mecha/mauler(src)

/*
 *	# HOW TO DEAL WITH GIVING THE MECHS OVER
 *
 *	Check out at:
 *	/obj/item/toy/mecha/proc/mecha_brawl(obj/item/toy/mecha/attacker, mob/living/carbon/attacker_controller, mob/living/carbon/opponent)
 *	Make sure the winner gets the other person's mech.
 *	Use this to check if the event has been triggered to do the handover:
 *	var/datum/round_event_control/mech_dropoff/mechdropoff = locate(/datum/round_event_control/mech_dropoff) in SSevents.control
 *	if(istype(mechdropoff) && mechdropoff.occurrences >= mechdropoff.max_occurrences)
 */
