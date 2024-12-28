GLOBAL_LIST_EMPTY_TYPED(halloween_gifts, /obj/item/storage/box/halloween)

/proc/populate_halloween_gifts()
	var/list/valid_gifts = subtypesof(/obj/item/storage/box/halloween)
	for(var/obj/item/storage/box/halloween/halloween_box as anything in valid_gifts)
		if(!initial(halloween_box.theme_name))
			valid_gifts -= halloween_box

	GLOB.halloween_gifts = valid_gifts

/**
 * Choice beacon
 * Purchased at Cargo, allows you to order any Costume you want
 * Copied from Cook's ingedient beacon
 */
/obj/item/choice_beacon/halloween
	name = "halloween delivery beacon"
	desc = "Summon a box of halloween costumes to help you get spooky."
	icon_state = "generic_delivery"

/obj/item/choice_beacon/halloween/generate_display_names()
	var/static/list/halloween_costumes
	if(!halloween_costumes)
		if(!GLOB.halloween_gifts.len)
			populate_halloween_gifts()

		halloween_costumes = list()
		for(var/obj/item/storage/box/halloween/halloween_boxes as anything in GLOB.halloween_gifts)
			halloween_costumes[initial(halloween_boxes.theme_name)] = halloween_boxes

	return halloween_costumes

/obj/item/choice_beacon/halloween/spawn_option(obj/choice, mob/living/gifted_person)
	new choice(get_turf(gifted_person))
	to_chat(gifted_person, span_hear("You hear something crackle from the beacon for a moment before a voice speaks. \"Please stand by for a message from Fulptailoring Broadcasting. Message as follows: <b>Please enjoy your Fulptailoring Broadcasting's Halloween Box!</b> Message ends.\""))

/// Debug delivery beacon with unlimited uses
/obj/item/choice_beacon/halloween/debug
	name = "debug halloween delivery beacon"
	desc = "A wonder of bluespace technology, capable of warping in an unlimited amount halloween costumes to help you get spooky."
	uses = 100

/obj/item/choice_beacon/halloween/debug/consume_use(obj/choice_path, mob/living/user)
	uses++
	return ..()

/**
 * Storage box code
 */
/obj/item/storage/box/halloween
	name = "halloween box"
	desc = "Costumes in a box."
	icon = 'fulp_modules/icons/halloween/box.dmi'
	icon_state = "halloween_box"
	illustration = "pumpkin"
	///The costumes that comes with the box
	var/list/costume_contents = list()
	///The Theme's name, used for the halloween beacon
	var/theme_name
	///The Year this costume was made in
	var/year

/obj/item/storage/box/halloween/Initialize(mapload)
	. = ..()
	if(theme_name)
		name = "[name] ([theme_name])"
		desc = "Costumes in a box. The box's theme is '[theme_name]'."
		inhand_icon_state = "syringe_kit"

/obj/item/storage/box/halloween/PopulateContents()
	for(var/each_item in costume_contents)
		new each_item(src)

/obj/item/storage/box/halloween/edition_19
	year = 2019

/obj/item/storage/box/halloween/edition_20
	year = 2020

/obj/item/storage/box/halloween/edition_21
	year = 2021

/obj/item/storage/box/halloween/edition_22
	year = 2022

/obj/item/storage/box/halloween/edition_23
	year = 2023

/obj/item/storage/box/halloween/edition_24
	year = 2024

/**
 * Gift code
 */
/obj/item/halloween_gift
	name = "halloween package"
	desc = "It looks like a box wrapped in some spooky paper"
	icon = 'fulp_modules/icons/halloween/box.dmi'
	icon_state = "halloween_gift"
	inhand_icon_state = "gift"
	resistance_flags = FLAMMABLE

	var/obj/item/contains_type

/obj/item/halloween_gift/Initialize()
	. = ..()
	pixel_x = rand(-10,10)
	pixel_y = rand(-10,10)

	contains_type = get_gift_type()

/obj/item/halloween_gift/attack_self(mob/user)
	qdel(src)

	var/obj/item/item = new contains_type(get_turf(user))
	user.visible_message(span_notice("[user] unwraps \the [src], finding \a [item] inside!"))
	user.put_in_hands(item)
	item.add_fingerprint(user)

/obj/item/halloween_gift/proc/get_gift_type()
	if(!GLOB.halloween_gifts.len)
		populate_halloween_gifts()

	return pick(GLOB.halloween_gifts)
