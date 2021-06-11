/// Security Jumpsuit
/obj/item/clothing/under/rank/security
	var/upgraded = FALSE
	var/obj/machinery/camera/builtInCamera = null
	var/registrant

/obj/item/clothing/under/rank/security/examine(mob/user)
	. = ..()
	if(!upgraded)
		. += "It appears to have an empty slot for a <b>body camera upgrade</b>."
		return
	if(builtInCamera)
		. += "Its body camera appears to be <b>active</b>."
	else
		. += "Its body camera appears to be <b>inactive</b>."

/// Modifying the Jumpsuit
/obj/item/clothing/under/rank/security/attackby(obj/item/W, mob/user, params)
	. = ..()
	/// Using a bodycam on the jumpsuit, upgrading it
	if(istype(W, /obj/item/bodycam_upgrade))
		// Check if its already upgraded
		if(upgraded)
			to_chat(user, "<span class='warning'>We have already installed [W] into [src]!</span>")
			playsound(loc, 'sound/machines/buzz-two.ogg', get_clamped_volume(), TRUE, -1)
			return
		upgraded = TRUE
		to_chat(user, "<span class='warning'>You install [W] into [src].</span>")
		playsound(loc, 'sound/items/drill_use.ogg', get_clamped_volume(), TRUE, -1)
		qdel(W)
		return
	/// Upgraded, but removing it
	if(W.tool_behaviour == TOOL_SCREWDRIVER)
		// If it isnt upgraded, it will go onto the next check, and just return.
		if(upgraded)
			to_chat(user, "<span class='warning'>You remove the upgrade from [src].</span>")
			playsound(loc, 'sound/items/drill_use.ogg', get_clamped_volume(), TRUE, -1)
			upgraded = FALSE
			unregister_body_camera()
			var/obj/item/bodycam_upgrade/bodycam = new /obj/item/bodycam_upgrade
			user.put_in_hands(bodycam)
			return
	/// Check: Is the Jumpsuit upgraded? Otherwise, we can't register body cameras!
	if(!upgraded)
		return

	var/obj/item/card/id/I
	if(isidcard(W))
		I = W
	else if(istype(W, /obj/item/pda))
		var/obj/item/pda/P = W
		I = P.id
	if(!I)
		to_chat(user, "<span class='warning'>No ID detected for body camera registration.</span>")
		return

	register_body_camera(I, user)

/// Manual Register via ID
/obj/item/clothing/under/rank/security/proc/register_body_camera(obj/item/card/id/I, mob/user)
	if(!I)
		return
	var/mob/living/carbon/human/H = user
	var/obj/item/clothing/under/rank/security/S = H.get_item_by_slot(ITEM_SLOT_ICLOTHING)
	if(!istype(S))
		to_chat(user, "<span class='warning'>you have to be wearing [src] to turn the body camera on!</span>")
		return
	var/id_name = I.registered_name
	if(id_name == registrant) //If already registered to the same person swiping the ID, we will 'toggle off' registration and unregister the body camera.
		unregister_body_camera(I, user)
		return

	registrant = id_name

	/*
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

	var/cam_name = "-Body Camera: [id_name] ([I.assignment])"
	for(var/obj/machinery/camera/matching_camera in GLOB.cameranet.cameras)
		if(cam_name == matching_camera.c_tag)
			to_chat(user, "<span class='notice'>Matching registration found. Unregistering previously registered body camera.</span>")
			if(S)
				S.unregister_body_camera(I, user, FALSE)
			break

	builtInCamera.c_tag = "[cam_name]"

	playsound(loc, 'sound/machines/beep.ogg', get_clamped_volume(), TRUE, -1)
	if(user)
		to_chat(user, "<span class='notice'>Security uniform body camera successfully registered to [id_name]</span>")

/// Unregistering the ID - Called when using your ID on an already claimed jumpsuit, or removing it.
/obj/item/clothing/under/rank/security/proc/unregister_body_camera(obj/item/card/id/I, mob/user)
	if(!builtInCamera)
		return
	QDEL_NULL(builtInCamera)
	UnregisterSignal(src, COMSIG_ITEM_POST_UNEQUIP)
	registrant = null
	if(user)
		playsound(loc, 'sound/machines/beep.ogg', get_clamped_volume(), TRUE, -1)
		to_chat(user, "<span class='notice'>Security uniform body camera successfully unregistered from [I.registered_name]</span>")

/// Bodycamera upgrade
/obj/item/bodycam_upgrade
	name = "body camera upgrade"
	icon = 'icons/obj/clothing/accessories.dmi'
	icon_state = "pocketprotector"
	desc = "A Security Jumpsuit upgrade, it says to examine closer to understand how it works."

/obj/item/bodycam_upgrade/examine_more(mob/user)
	. = list("<span class='notice'><i>You examine [src]'s instruction tag...</i></span>")
	. += list("<span class='warning'>How to use Body Cameras v3.5: EMP-proof Edition!</span>")
	. += list("<span class='notice'>Use the Body camera Upgrade on any SECURITY jumpsuit to upgrade it.</span>")
	. += list("<span class='notice'>Use a Screwdriver to remove the upgrade once you're done with it.</span>")
	. += list("<span class='notice'>While upgraded & equipped, use your ID card on the jumpsuit to turn the camera on.</span>")
	. += list("<span class='notice'>Unequipping or using your ID on the Jumpsuit will disable its camera.</span>")
	. += list("<span class='notice'>While active, the wearer will be visible to Security camera consoles.</span>")
