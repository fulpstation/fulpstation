//--- Event controler code
/datum/round_event_control/halloween_costumes_2020
	name = "2020 Halloween Costume Drop"
	holidayID = HALLOWEEN
	typepath = /datum/round_event/halloween_costumes_2020
	weight = 80 //super likely to happen
	min_players = 1
	max_occurrences = 1

/datum/round_event/halloween_costumes_2020
	fakeable = FALSE

/datum/round_event/halloween_costumes_2020/start()
	..()
	for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
		H.put_in_hands(new /obj/item/halloween_gift)
		playsound(get_turf(H),'sound/magic/summon_magic.ogg', 50, TRUE)

/datum/round_event/halloween_costumes/announce()
	priority_announce("To improve morale, we've utilized our Bluespace Wardrobe technology to send bulk halloween costumes over. Enjoy.", "Its Spooky Time")


//--- Gift and box with costumes
/obj/item/halloween_gift
	name = "halloween package"
	desc = "It looks like a box wrapped in some spooky paper"
	icon = 'fulp_modules/features/halloween_event/costumes_2020/box.dmi'
	icon_state = "halloween_gift"
	inhand_icon_state = "gift"
	resistance_flags = FLAMMABLE

	var/obj/item/contains_type

/obj/item/halloween_gift/Initialize()
	. = ..()
	pixel_x = rand(-10,10)
	pixel_y = rand(-10,10)

	contains_type = get_gift_type()

/obj/item/halloween_gift/attack_self(mob/M)
	qdel(src)

	var/obj/item/I = new contains_type(get_turf(M))
	M.visible_message("<span class='notice'>[M] unwraps \the [src], finding \a [I] inside!</span>")
	M.put_in_hands(I)
	I.add_fingerprint(M)

/obj/item/halloween_gift/proc/get_gift_type()
	if(!GLOB.possible_gifts.len)
		var/list/gift_types_list = subtypesof(/obj/item/storage/box/halloween)
		for(var/V in gift_types_list)
			var/obj/item/I = V
			if((!initial(I.icon_state)) || (!initial(I.inhand_icon_state)) || (initial(I.item_flags) & ABSTRACT))
				gift_types_list -= V
		GLOB.possible_gifts = gift_types_list

	var/gift_type = pick(GLOB.possible_gifts)

	return gift_type

//--Beacon
/obj/item/choice_beacon/halloween
	name = "halloween delivery beacon"
	desc = "Summon a box of halloween costumes to help you get spooky."
	icon_state = "gangtool-white"
	var/target = /obj/item/storage/box/halloween
	var/year

/obj/item/choice_beacon/halloween/generate_display_names()
	var/list/halloween = list()
	for(var/V in subtypesof(target))
		var/obj/item/storage/box/halloween/A = V
		halloween[initial(A.theme_name)] = A
	return halloween

/obj/item/choice_beacon/halloween/spawn_option(obj/choice,mob/living/M)
	new choice(get_turf(M))
	to_chat(M, "<span class='hear'>You hear something crackle from the beacon for a moment before a voice speaks. \"Please stand by for a message from Fulptailoring Broadcasting. Message as follows: <b>Please enjoy your Fulptailoring Broadcasting's Halloween Box!</b> Message ends.\"</span>")

/obj/item/choice_beacon/halloween/Initialize()
	. = ..()
	if(year)
		name = "[year]'s [name]"
		desc = "Summon a box of [year]'s costumes to help you get spooky."


/obj/item/choice_beacon/halloween/debug
	name = "debug halloween delivery beacon"
	desc = "Summon up to 100 boxes of halloween costumes to help you get spooky."
	uses = 100

/obj/item/choice_beacon/halloween/edition_19
	year = 2019
	target = /obj/item/storage/box/halloween/edition_19

/obj/item/choice_beacon/halloween/edition_20
	year = 2020
	target = /obj/item/storage/box/halloween/edition_20

//--Box
/obj/item/storage/box/halloween
	name = "halloween box"
	desc = "Costumes in a box."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/box.dmi'
	icon_state = "halloween_box"
	illustration = "pumpkin"
	var/theme_name
	var/year

/obj/item/storage/box/halloween/Initialize()
	. = ..()
	if(theme_name)
		name = "[name] ([theme_name])"
		desc = "Costumes in a box. The box's theme is '[theme_name]'."
		inhand_icon_state = "syringe_kit"

/obj/item/storage/box/halloween/PopulateContents()
	new	/obj/item/choice_beacon/halloween(src)

/obj/item/storage/box/halloween/edition_19
	year = 2019

/obj/item/storage/box/halloween/edition_19/PopulateContents()
	new	/obj/item/choice_beacon/halloween/edition_19(src)

/obj/item/storage/box/halloween/edition_20
	year = 2020

/obj/item/storage/box/halloween/edition_20/PopulateContents()
	new	/obj/item/choice_beacon/halloween/edition_20(src)

/obj/item/storage/box/halloween/special

/obj/item/storage/box/halloween/special/PopulateContents()
	new	/obj/item/choice_beacon/halloween(src)

