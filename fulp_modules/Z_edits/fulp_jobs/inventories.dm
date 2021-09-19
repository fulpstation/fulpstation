/*
 *	# Security Crowbars
 *
 * 	Gives Security the improved box in their roundstart bag, one that includes a Crowbar.
 *	Originally created by Surrealistik
 */

/// The box we give
/obj/item/storage/box/survival/security/improved/PopulateContents()
	. = ..() // we want the regular stuff too; crowbar for latejoins into depowered situations
	new /obj/item/crowbar/red(src)

///Their inventories should stay the same, save for the added crowbar
/datum/outfit/job/security
	box = /obj/item/storage/box/survival/security/improved

/datum/outfit/job/warden
	box = /obj/item/storage/box/survival/security/improved

/datum/outfit/job/hos
	box = /obj/item/storage/box/survival/security/improved
