/obj/item/clothing/under/gothlita_purple
	name = "purple Gothlita dress"
	desc = "A fashioned, delicate and fragile dress made of silk."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/gothlita_purple_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/gothlita_purple_worn.dmi'
	icon_state = "dress"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	fitted = NO_FEMALE_UNIFORM
	has_sensor = HAS_SENSORS
	random_sensor = TRUE
	can_adjust = FALSE

/obj/item/clothing/head/gothlita_purple
	name = "purple Gothlita side-hat."
	desc = "It's a delicate top-hat, but worn sideway."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/gothlita_purple_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/gothlita_purple_worn.dmi'
	icon_state = "sidehat_left"
	dynamic_hair_suffix = ""
	var/flipped = FALSE

/obj/item/clothing/head/gothlita_purple/dropped()
	icon_state = "sidehat_left"
	flipped = FALSE
	..()

/obj/item/clothing/head/gothlita_purple/verb/flipcap()
	set category = "Object"
	set name = "Flip cap"

	flip(usr)

/obj/item/clothing/head/gothlita_purple/AltClick(mob/user)
	..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	else
		flip(user)

/obj/item/clothing/head/gothlita_purple/proc/flip(mob/user)
	if(!user.incapacitated())
		flipped = !flipped
		if(flipped)
			icon_state = "sidehat_right"
			to_chat(user, "<span class='notice'>You flip the hat to the right.</span>")
		else
			icon_state = "sidehat_left"
			to_chat(user, "<span class='notice'>You flip the hat back to the left.</span>")
		usr.update_inv_head()	//so our mob-overlays update

/obj/item/clothing/head/gothlita_purple/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click the hat to flip it [flipped ? "left" : "right"].</span>"

/obj/item/clothing/gloves/gothlita_purple
	name = "purple Gothlita gloves"
	desc = "A pair of delicate silken gloves, orned with a dried rose."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/gothlita_purple_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/gothlita_purple_worn.dmi'
	icon_state = "gloves"

/obj/item/clothing/mask/gothlita_purple
	name = "purple Gothlita mask"
	desc = "Is it a mask? It looks morelike a pale makeup."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/gothlita_purple_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/gothlita_purple_worn.dmi'
	icon_state = "mask"

/obj/item/clothing/shoes/gothlita_purple
	name = "purple Gothlita heels"
	desc = "A pair of fashioned heels orned with a dried rose."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/gothlita_purple_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/gothlita_purple_worn.dmi'
	icon_state = "shoes"

/obj/item/storage/box/halloween/edition_20/gothlita_purple
	theme_name = "2020's Gothlita - Purple"
	illustration = "mask"

/obj/item/storage/box/halloween/edition_20/gothlita_purple/PopulateContents()
	new /obj/item/clothing/under/gothlita_purple(src)
	new /obj/item/clothing/head/gothlita_purple(src)
	new /obj/item/clothing/gloves/gothlita_purple(src)
	new /obj/item/clothing/mask/gothlita_purple(src)
	new /obj/item/clothing/shoes/gothlita_purple(src)
	new /obj/item/lipstick/purple(src)
