/obj/item/prison_mail //copy paste from '/obj/item/mail'
	name = "mail"
	desc = "An officially postmarked, tamper-evident parcel regulated by CentCom and made of high-quality materials."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "mail_small"
	inhand_icon_state = "paper"
	worn_icon_state = "paper"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	drop_sound = 'sound/items/handling/paper_drop.ogg'
	pickup_sound = 'sound/items/handling/paper_pickup.ogg'
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	/// List of all stamp overlays on the letter.
	var/list/stamps = list()
	/// Physical offset of stamps on the object. X direction.
	var/stamp_offset_x = 0
	/// Physical offset of stamps on the object. Y direction.
	var/stamp_offset_y = 2

	///This mail's assigned department
	var/mail_department = NONE

/obj/item/prison_mail/Initialize(mapload)
	. = ..()
	name = "[mail_department] mail"
	AddElement(/datum/element/item_scaling, 0.75, 1)
	var/stamp_count = rand(1, 3)
	for(var/i in 1 to stamp_count)
		stamps += list("stamp_[rand(2, 6)]")
	update_icon()

/obj/item/prison_mail/update_overlays()
	. = ..()
	var/bonus_stamp_offset = 0
	for(var/stamp in stamps)
		var/image/stamp_image = image(
			icon = icon,
			icon_state = stamp,
			pixel_x = stamp_offset_x,
			pixel_y = stamp_offset_y + bonus_stamp_offset)
		stamp_image.appearance_flags |= RESET_COLOR
		add_overlay(stamp_image)
		bonus_stamp_offset -= 5

	var/image/postmark_image = image(
		icon = icon,
		icon_state = "postmark",
		pixel_x = stamp_offset_x + rand(-3, 1),
		pixel_y = stamp_offset_y + rand(bonus_stamp_offset + 3, 1))
	postmark_image.appearance_flags |= RESET_COLOR
	add_overlay(postmark_image)

/obj/item/prison_mail/security/Initialize(mapload)
	color = COLOR_PALE_RED_GRAY
	mail_department = DEPARTMENT_SECURITY
	. = ..()
/obj/item/prison_mail/engineering/Initialize(mapload)
	color = COLOR_PALE_ORANGE
	mail_department = DEPARTMENT_ENGINEERING
	. = ..()
/obj/item/prison_mail/science/Initialize(mapload)
	color = COLOR_PALE_PURPLE_GRAY
	mail_department = DEPARTMENT_SCIENCE
	. = ..()
/obj/item/prison_mail/medical/Initialize(mapload)
	color = COLOR_PALE_BLUE_GRAY
	mail_department = DEPARTMENT_MEDICAL
	. = ..()
/obj/item/prison_mail/service/Initialize(mapload)
	color = COLOR_PALE_GREEN_GRAY
	mail_department = DEPARTMENT_SERVICE
	. = ..()
/obj/item/prison_mail/supply/Initialize(mapload)
	color = COLOR_BEIGE
	mail_department = DEPARTMENT_CARGO
	. = ..()

/**
 * # BINS
 */
/obj/machinery/disposal/bin/prison
	desc = "A unit that stores and sends mail to their assigned department."
	///Disposal unit's department
	var/unit_department = NONE

/obj/machinery/disposal/bin/prison/Initialize(mapload, obj/structure/disposalconstruct/make_from)
	. = ..()
	name = "[unit_department] mailing unit"

/obj/machinery/disposal/bin/prison/attackby(obj/item/weapon, mob/user, params)
	if(!istype(weapon, /obj/item/prison_mail))
		say("Only mail can be inserted!")
		return
	var/obj/item/prison_mail/inserted_mail = weapon
	if(inserted_mail.mail_department != unit_department)
		say("MAIL SENT TO THE WRONG DEPARTMENT!")
		playsound(src, 'sound/machines/warning-buzzer.ogg', 40, TRUE)
		qdel(inserted_mail)
		SEND_SIGNAL(SSpermabrig.loaded_shuttle, COMSIG_PRISON_OBJECTIVE_FAILED)
		return
	say("Mail delivered to [unit_department].")
	playsound(src, 'sound/machines/ping.ogg', 20, TRUE)
	qdel(inserted_mail)

/obj/machinery/disposal/bin/prison/security/Initialize(mapload, obj/structure/disposalconstruct/make_from)
	color = COLOR_PALE_RED_GRAY
	unit_department = DEPARTMENT_SECURITY
	. = ..()
/obj/machinery/disposal/bin/prison/engineering/Initialize(mapload, obj/structure/disposalconstruct/make_from)
	color = COLOR_PALE_ORANGE
	unit_department = DEPARTMENT_ENGINEERING
	. = ..()
/obj/machinery/disposal/bin/prison/science/Initialize(mapload, obj/structure/disposalconstruct/make_from)
	color = COLOR_PALE_PURPLE_GRAY
	unit_department = DEPARTMENT_SCIENCE
	. = ..()
/obj/machinery/disposal/bin/prison/medical/Initialize(mapload, obj/structure/disposalconstruct/make_from)
	color = COLOR_PALE_BLUE_GRAY
	unit_department = DEPARTMENT_MEDICAL
	. = ..()
/obj/machinery/disposal/bin/prison/service/Initialize(mapload, obj/structure/disposalconstruct/make_from)
	color = COLOR_PALE_GREEN_GRAY
	unit_department = DEPARTMENT_SERVICE
	. = ..()
/obj/machinery/disposal/bin/prison/supply/Initialize(mapload, obj/structure/disposalconstruct/make_from)
	color = COLOR_BEIGE
	unit_department = DEPARTMENT_CARGO
	. = ..()

/**
 * MAIL CRATE
 */
/obj/structure/closet/crate/mail/prison/prison_mail/populate()
	return
/obj/structure/closet/crate/mail/prison/prison_mail/PopulateContents()
	var/list/mail_type = list(
		/obj/item/prison_mail/security,
		/obj/item/prison_mail/engineering,
		/obj/item/prison_mail/science,
		/obj/item/prison_mail/medical,
		/obj/item/prison_mail/service,
		/obj/item/prison_mail/supply,
	)

	for(var/i in 1 to 20)
		var/spawned_mail = pick(mail_type)
		new spawned_mail(src)
