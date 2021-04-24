/// Security (Original by Surrealistik) ///

/datum/outfit/job/security
	backpack_contents = list(/obj/item/melee/baton/loaded=1) //we want to keep the stuff they had before
	box = /obj/item/storage/box/survival/security/improved //then put the crowbar into their survival box

/datum/outfit/job/warden
	backpack_contents = list(/obj/item/melee/baton/loaded=1)
	box = /obj/item/storage/box/survival/security/improved

/datum/outfit/job/hos
	backpack_contents = list(/obj/item/melee/baton/loaded=1, /obj/item/modular_computer/tablet/preset/advanced/command=1)
	box = /obj/item/storage/box/survival/security/improved
