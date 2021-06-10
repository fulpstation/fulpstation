/// Jumpsuit datum
/obj/item/clothing/under/rank/security
	var/upgraded = FALSE
	var/obj/machinery/camera/builtInCamera = null
	var/registrant

/// Bodycamera upgrade
/obj/item/bodycam_upgrade
	name = "body camera upgrade"
	icon = 'icons/obj/clothing/accessories.dmi'
	icon_state = "pocketprotector"
	desc = "An upgrade able to be applied to any Security jumpsuit, allowing you to use your ID on it to allow any Security camera console to view you through it."

/obj/item/clothing/under/rank/security/attackby(obj/item/W, mob/user, params)
	. = ..()
	/// Are we upgrading it?
	if(istype(W, /obj/item/bodycam_upgrade))
		if(upgraded)
			to_chat(user, "<span class='warning'>We have already installed [W] into [src]!</span>")
			return
		upgraded = TRUE
		to_chat(user, "<span class='warning'>You install [W] into [src].</span>")
		qdel(W)
		return
	/// Is the Jumpsuit upgraded to have Security cameras? No? Too bad!
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

/// Register the ID
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

	camera_sound()
	if(user)
		to_chat(user, "<span class='notice'>Security uniform body camera successfully registered to [id_name]</span>")

/// Unregister
/obj/item/clothing/under/rank/security/proc/unregister_body_camera(obj/item/card/id/I, mob/user, message=TRUE)
	if(builtInCamera)
		QDEL_NULL(builtInCamera)
		UnregisterSignal(src, COMSIG_ITEM_POST_UNEQUIP)
	registrant = null
	if(user && message)
		camera_sound()
		to_chat(user, "<span class='notice'>Security uniform body camera successfully unregistered from [I.registered_name]</span>")

/// Dealing with the cameras being visible
/obj/item/clothing/under/rank/security/proc/camera_toggle()
	var/message = "<span class='notice'>There's no camera!</span>"

	if(builtInCamera)
		if(builtInCamera.status)
			builtInCamera.status = FALSE
			message = "<span class='notice'>You toggle the body camera off.</span>"
		else
			builtInCamera.status = TRUE
			message = "<span class='notice'>You toggle the body camera on.</span>"
		camera_sound()

	if(ismob(loc))
		var/mob/user = loc
		if(user)
			to_chat(user, "[message]")

/// Sound the camera makes, changes depending on if accepted.
/obj/item/clothing/under/rank/security/proc/camera_sound(accepted = TRUE)
	if(accepted)
		playsound(loc, 'sound/machines/beep.ogg', get_clamped_volume(), TRUE, -1)
	else
		playsound(loc, 'sound/machines/buzz-two.ogg', get_clamped_volume(), TRUE, -1)

/obj/item/clothing/under/rank/security/emp_act()
	. = ..()
	camera_toggle()

/obj/item/clothing/under/rank/security/examine(mob/user)
	. = ..()
	if(!upgraded)
		return
	if(registrant)
		. += "The body camera is registered to <b>[registrant]</b>."
		return
	if(builtInCamera?.status)
		. += "Its body camera appears to be <b>active</b>."
	else
		. += "Its body camera appears to be <b>inactive</b>."
