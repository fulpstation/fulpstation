/obj/item/clothing/suit/armor
	var/upgraded = FALSE
	var/obj/machinery/camera/builtInCamera = null
	var/registrant

/obj/item/clothing/suit/armor/examine(mob/user)
	. = ..()
	if(builtInCamera)
		. += "It appears to have an <b>active</b> body camera attached."

/// Modifying the Jumpsuit
/obj/item/clothing/suit/armor/attackby(obj/item/item, mob/user, params)
	. = ..()

	// Using a bodycam on the jumpsuit, upgrading it
	if(istype(item, /obj/item/bodycam_upgrade))
		// Check if its already upgraded
		if(upgraded)
			to_chat(user, span_warning("We have already installed [item] into [src]!"))
			playsound(loc, 'sound/machines/buzz-two.ogg', get_clamped_volume(), TRUE, -1)
			return
		upgraded = TRUE
		to_chat(user, span_warning("You install [item] into [src]."))
		playsound(loc, 'sound/items/drill_use.ogg', get_clamped_volume(), TRUE, -1)
		qdel(item)
		return

	// Check: Is the Jumpsuit upgraded?
	if(!upgraded)
		return
	// Upgraded, but removing it.
	if(item.tool_behaviour == TOOL_SCREWDRIVER)
		// If it isnt upgraded, it will go onto the next check, and just return.
		if(upgraded)
			to_chat(user, span_warning("You remove the upgrade from [src]."))
			playsound(loc, 'sound/items/drill_use.ogg', get_clamped_volume(), TRUE, -1)
			upgraded = FALSE
			unregister_body_camera()
			var/obj/item/bodycam_upgrade/bodycam = new /obj/item/bodycam_upgrade
			user.put_in_hands(bodycam)
			return

	// Registering our ID
	var/obj/item/card/id/id_card
	if(isidcard(item))
		id_card = item
	else if(istype(item, /obj/item/pda))
		var/obj/item/pda/worn_pda = item
		id_card = worn_pda.id
	if(!id_card)
		to_chat(user, span_warning("No ID detected for body camera registration."))
		return

	register_body_camera(id_card, user)

/// Manual Register via ID
/obj/item/clothing/suit/armor/proc/register_body_camera(obj/item/card/id/id_card, mob/living/carbon/human/user)
	if(!id_card)
		return
	var/obj/item/clothing/suit/armor/worn_suit = user.get_item_by_slot(ITEM_SLOT_OCLOTHING)
	if(!istype(worn_suit))
		to_chat(user, span_warning("You have to be wearing [src] to turn the body camera on!"))
		return
	var/id_name = id_card.registered_name
	if(id_name == registrant) //If already registered to the same person swiping the ID, we will 'toggle off' registration and unregister the body camera.
		unregister_body_camera(user)
		return

	registrant = id_name

	/**
	 *	# Body Camera
	 *
	 *	Due to how TG deals with moving cameras, they have to be set to a PERSON, rather than an ITEM, otherwise its a black screen.
	 *	We're tying the body camera to the body via the Jumpsuit, unregistering the Body camera if unequipped,
	 *	Otherwise we'll have jumpsuit-less officers running about with body cameras permanently on them.
	 */
	/// Signal to remove the camera when the jumpsuit is removed
	RegisterSignal(src, COMSIG_ITEM_POST_UNEQUIP, .proc/unregister_body_camera)
	builtInCamera = new(usr)
	builtInCamera.internal_light = FALSE
	builtInCamera.network = list("ss13")

	var/cam_name = "-Body Camera: [id_name] ([id_card.assignment])"
	for(var/obj/machinery/camera/matching_camera in GLOB.cameranet.cameras)
		if(cam_name == matching_camera.c_tag)
			to_chat(user, span_notice("Matching registration found. Unregistering previously registered body camera."))
			if(worn_suit)
				worn_suit.unregister_body_camera(user)
			break

	builtInCamera.c_tag = "[cam_name]"

	playsound(loc, 'sound/machines/beep.ogg', get_clamped_volume(), TRUE, -1)
	if(user)
		user.balloon_alert(user, "bodycamera activated")
		to_chat(user, span_notice("[src] body camera successfully registered to [id_name]."))

/// Unregistering the ID - Called when using your ID on an already claimed jumpsuit, or removing it.
/obj/item/clothing/suit/armor/proc/unregister_body_camera(mob/user)
	if(!builtInCamera)
		return
	QDEL_NULL(builtInCamera)
	UnregisterSignal(src, COMSIG_ITEM_POST_UNEQUIP)
	registrant = null
	if(user)
		playsound(loc, 'sound/machines/beep.ogg', get_clamped_volume(), TRUE, -1)
		user.balloon_alert(user, "bodycamera deactivated")

/// Bodycamera upgrade
/obj/item/bodycam_upgrade
	name = "body camera upgrade"
	icon = 'fulp_modules/features/clothing/body_cameras/bodycamera.dmi'
	icon_state = "bodycamera"
	desc = "An armor vest upgrade, it says to examine closer to understand how it works."

/obj/item/bodycam_upgrade/examine_more(mob/user)
	. = list(span_notice("<i>You examine [src]'s instruction tag...</i>"))
	. += list(span_warning("How to use Body Cameras v3.5: EMP-proof Edition!"))
	. += list(span_notice("Use [src] on an armor vest to install it."))
	. += list(span_notice("Use a Screwdriver to remove it when needed."))
	. += list(span_notice("While equipped, use your ID card on the vest to activate the camera."))
	. += list(span_notice("Unequipping the vest or using your ID again will deactivate the camera."))
	. += list(span_notice("While the camera is active, the wearer will be visible to camera consoles."))
