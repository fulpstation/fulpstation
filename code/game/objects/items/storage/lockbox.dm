/obj/item/storage/lockbox
	name = "lockbox"
	desc = "A locked box."
	icon = 'icons/obj/storage/case.dmi'
	icon_state = "lockbox+l"
	inhand_icon_state = "lockbox"
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	req_access = list(ACCESS_ARMORY)
	var/broken = FALSE
	var/open = FALSE
	var/icon_locked = "lockbox+l"
	var/icon_closed = "lockbox"
	var/icon_broken = "lockbox+b"

/obj/item/storage/lockbox/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 14
	atom_storage.max_slots = 4
	atom_storage.locked = TRUE

	register_context()

/obj/item/storage/lockbox/attackby(obj/item/W, mob/user, params)
	var/locked = atom_storage.locked
	if(W.GetID())
		if(broken)
			balloon_alert(user, "broken!")
			return
		if(allowed(user))
			if(atom_storage.locked)
				atom_storage.locked = STORAGE_NOT_LOCKED
			else
				atom_storage.locked = STORAGE_FULLY_LOCKED
			locked = atom_storage.locked
			if(locked)
				icon_state = icon_locked
				atom_storage.close_all()
			else
				icon_state = icon_closed

			balloon_alert(user, locked ? "locked" : "unlocked")
			return

		else
			balloon_alert(user, "access denied!")
			return
	if(!locked)
		return ..()
	else
		balloon_alert(user, "locked!")

/obj/item/storage/lockbox/emag_act(mob/user)
	if(!broken)
		broken = TRUE
		atom_storage.locked = STORAGE_NOT_LOCKED
		icon_state = src.icon_broken
		if(user)
			visible_message(span_warning("\The [src] is broken by [user] with an electromagnetic card!"))
			return

/obj/item/storage/lockbox/examine(mob/user)
	. = ..()
	if(broken)
		. += span_notice("It appears to be broken.")

/obj/item/storage/lockbox/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	open = TRUE
	update_appearance()

/obj/item/storage/lockbox/Exited(atom/movable/gone, direction)
	. = ..()
	open = TRUE
	update_appearance()

/obj/item/storage/lockbox/loyalty
	name = "lockbox of mindshield implants"
	req_access = list(ACCESS_SECURITY)

/obj/item/storage/lockbox/loyalty/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/implantcase/mindshield(src)
	new /obj/item/implanter/mindshield(src)

/obj/item/storage/lockbox/clusterbang
	name = "lockbox of clusterbangs"
	desc = "You have a bad feeling about opening this."
	req_access = list(ACCESS_SECURITY)

/obj/item/storage/lockbox/clusterbang/PopulateContents()
	new /obj/item/grenade/clusterbuster(src)

/obj/item/storage/lockbox/medal
	name = "medal box"
	desc = "A locked box used to store medals of honor."
	icon_state = "medalbox+l"
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	req_access = list(ACCESS_CAPTAIN)
	icon_locked = "medalbox+l"
	icon_closed = "medalbox"
	icon_broken = "medalbox+b"

/obj/item/storage/lockbox/medal/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL
	atom_storage.max_slots = 10
	atom_storage.max_total_storage = 20
	atom_storage.set_holdable(list(/obj/item/clothing/accessory/medal))

/obj/item/storage/lockbox/medal/examine(mob/user)
	. = ..()
	if(!atom_storage.locked)
		. += span_notice("Alt-click to [open ? "close":"open"] it.")

/obj/item/storage/lockbox/medal/AltClick(mob/user)
	if(!user.can_perform_action(src))
		return
	if(!atom_storage.locked)
		open = (open ? FALSE : TRUE)
		update_appearance()
	..()

/obj/item/storage/lockbox/medal/PopulateContents()
	new /obj/item/clothing/accessory/medal/gold/captain(src)
	new /obj/item/clothing/accessory/medal/silver/valor(src)
	new /obj/item/clothing/accessory/medal/silver/valor(src)
	new /obj/item/clothing/accessory/medal/silver/security(src)
	new /obj/item/clothing/accessory/medal/bronze_heart(src)
	new /obj/item/clothing/accessory/medal/plasma/nobel_science(src)
	new /obj/item/clothing/accessory/medal/plasma/nobel_science(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/accessory/medal/conduct(src)

/obj/item/storage/lockbox/medal/update_icon_state()
	if(atom_storage?.locked)
		icon_state = "medalbox+l"
		return ..()

	icon_state = "medalbox"
	if(open)
		icon_state += "open"
	if(broken)
		icon_state += "+b"
	return ..()

/obj/item/storage/lockbox/medal/update_overlays()
	. = ..()
	if(!contents || !open)
		return
	if(atom_storage?.locked)
		return
	for(var/i in 1 to contents.len)
		var/obj/item/clothing/accessory/medal/M = contents[i]
		var/mutable_appearance/medalicon = mutable_appearance(initial(icon), M.medaltype)
		if(i > 1 && i <= 5)
			medalicon.pixel_x += ((i-1)*3)
		else if(i > 5)
			medalicon.pixel_y -= 7
			medalicon.pixel_x -= 2
			medalicon.pixel_x += ((i-6)*3)
		. += medalicon

/obj/item/storage/lockbox/medal/hop
	name = "Head of Personnel medal box"
	desc = "A locked box used to store medals to be given to those exhibiting excellence in management."
	req_access = list(ACCESS_HOP)

/obj/item/storage/lockbox/medal/hop/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/clothing/accessory/medal/silver/bureaucracy(src)
	new /obj/item/clothing/accessory/medal/gold/ordom(src)

/obj/item/storage/lockbox/medal/sec
	name = "security medal box"
	desc = "A locked box used to store medals to be given to members of the security department."
	req_access = list(ACCESS_HOS)

/obj/item/storage/lockbox/medal/med
	name = "medical medal box"
	desc = "A locked box used to store medals to be given to members of the medical department."
	req_access = list(ACCESS_CMO)

/obj/item/storage/lockbox/medal/med/PopulateContents()
	new /obj/item/clothing/accessory/medal/med_medal(src)
	new /obj/item/clothing/accessory/medal/med_medal2(src)

/obj/item/storage/lockbox/medal/sec/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/clothing/accessory/medal/silver/security(src)

/obj/item/storage/lockbox/medal/cargo
	name = "cargo award box"
	desc = "A locked box used to store awards to be given to members of the cargo department."
	req_access = list(ACCESS_QM)

/obj/item/storage/lockbox/medal/cargo/PopulateContents()
		new /obj/item/clothing/accessory/medal/ribbon/cargo(src)

/obj/item/storage/lockbox/medal/service
	name = "service award box"
	desc = "A locked box used to store awards to be given to members of the service department."
	req_access = list(ACCESS_HOP)

/obj/item/storage/lockbox/medal/service/PopulateContents()
		new /obj/item/clothing/accessory/medal/silver/excellence(src)

/obj/item/storage/lockbox/medal/sci
	name = "science medal box"
	desc = "A locked box used to store medals to be given to members of the science department."
	req_access = list(ACCESS_RD)

/obj/item/storage/lockbox/medal/sci/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/clothing/accessory/medal/plasma/nobel_science(src)

/obj/item/storage/lockbox/order
	name = "order lockbox"
	desc = "A box used to secure small cargo orders from being looted by those who didn't order it. Yeah, cargo tech, that means you."
	icon_state = "secure"
	icon_broken = "secure+b"
	inhand_icon_state = "sec-case"
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	var/datum/bank_account/buyer_account
	var/privacy_lock = TRUE

/obj/item/storage/lockbox/order/Initialize(mapload, datum/bank_account/_buyer_account)
	. = ..()
	buyer_account = _buyer_account
	ADD_TRAIT(src, TRAIT_NO_MISSING_ITEM_ERROR, TRAIT_GENERIC)

/obj/item/storage/lockbox/order/attackby(obj/item/W, mob/user, params)
	var/obj/item/card/id/id_card = W.GetID()
	if(!id_card)
		return ..()

	if(iscarbon(user))
		add_fingerprint(user)

	if(id_card.registered_account != buyer_account)
		balloon_alert(user, "incorrect bank account!")
		return

	if(privacy_lock)
		atom_storage.locked = STORAGE_NOT_LOCKED
	else
		atom_storage.locked = STORAGE_FULLY_LOCKED
	privacy_lock = atom_storage.locked
	user.visible_message(span_notice("[user] [privacy_lock ? "" : "un"]locks [src]'s privacy lock."),
					span_notice("You [privacy_lock ? "" : "un"]lock [src]'s privacy lock."))

///screentips for lockboxes
/obj/item/storage/lockbox/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(!held_item)
		return NONE
	if(src.broken)
		return NONE
	if(!held_item.GetID())
		return NONE
	context[SCREENTIP_CONTEXT_LMB] = atom_storage.locked ? "Unlock with ID" : "Lock with ID"
	return CONTEXTUAL_SCREENTIP_SET
