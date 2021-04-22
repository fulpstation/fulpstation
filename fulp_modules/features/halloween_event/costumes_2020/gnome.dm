//Papaporo just gnome'd you
/obj/item/clothing/under/gnome
	name = "Gnome's jumpsuit"
	desc = "A gnome suit for gnoming."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/gnome_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/gnome_worn.dmi'
	icon_state = "gnome_jumpsuit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	fitted = FEMALE_UNIFORM_FULL
	has_sensor = HAS_SENSORS
	random_sensor = TRUE
	can_adjust = FALSE

/obj/item/clothing/head/gnome
	name = "Gnome's hat"
	desc = "This is gnot a gnelf hat."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/gnome_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/gnome_worn.dmi'
	icon_state = "gnome_hat"
	var/armed = FALSE

/obj/item/clothing/head/gnome/proc/triggered(mob/target)
	if(!armed)
		return
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.Knockdown(30)
		SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "gnomed", /datum/mood_event/gnomed)
	playsound(src, 'fulp_modules/features/halloween_event/gnomed.ogg', 50, TRUE)
	armed = FALSE
	update_icon()

/obj/item/clothing/head/gnome/on_found(mob/finder)
	if(armed)
		if(finder)
			finder.visible_message("<span class='warning'>[finder] gets gnomed by the [src].</span>", \
							   "<span class='big hypnophrase'>You got gnomed by the [src]!</span>")
			triggered(finder, (finder.active_hand_index % 2 == 0) ? BODY_ZONE_PRECISE_R_HAND : BODY_ZONE_PRECISE_L_HAND)
			return TRUE	//end the search!
		else
			visible_message("<span class='warning'>[src] snaps shut!</span>")
			triggered(loc)
			return FALSE
	return FALSE

/obj/item/clothing/head/gnome/gnomed
	armed = TRUE

//--Fun gnomed stuff here
/datum/mood_event/gnomed
	description = "<span class='warning'>I can't believe I got gnomed!...</span>\n"
	mood_change = -1
	timeout = 5 MINUTES

/obj/item/clothing/suit/gnome
	name = "Gnome's suit"
	desc = "I'm a gnome, and you will be gnomed."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/gnome_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/gnome_worn.dmi'
	icon_state = "gnome_suit"
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)

/obj/item/clothing/shoes/gnome
	name = "Gnome's shoes"
	desc = "These are gnot gnoblin boots."
	icon = 'fulp_modules/features/halloween_event/costumes_2020/gnome_item.dmi'
	worn_icon = 'fulp_modules/features/halloween_event/costumes_2020/gnome_worn.dmi'
	icon_state = "gnome_shoes"

//--Box that contains the costumes
/obj/item/storage/box/halloween/edition_20/gnome
	theme_name = "2020's Gnome"
	illustration = "moth"

/obj/item/storage/box/halloween/edition_20/gnome/PopulateContents()
	new /obj/item/clothing/under/gnome(src)
	new /obj/item/clothing/head/gnome(src)
	new /obj/item/clothing/suit/gnome(src)
	new /obj/item/clothing/shoes/gnome(src)

/obj/item/storage/box/halloween/special/gnomed
	illustration = "pumpkin"

/obj/item/storage/box/halloween/special/gnomed/Initialize()
	. = ..()
	year = pick("2019", "2020")
	switch(year)
		if("2019")
			theme_name = pick("2019's Centaur", "2019's Hotdog", "2019's Ketchup", "2019's Mustard",
			"2019's Angel", "2019's Devil", "2019's Cat", "2019's Pumpkin", "2019's Skeleton",
			"2019's Spider", "2019's Witch", "2019's Sailor Moon", "2019's Tuxedo Mask",
			"2019's Tricksters", "2019's Next Adventure", "2019's Phantom maid", "2019's Sans",
			"2019's Solid Snake", "2019's Starship Trooper", "2019's Bounty Hunter", "2019's Zombie")
		if("2020")
			theme_name = pick("2020's Frog", "2020's Skull mask", "2020's Heisters")

	if(theme_name)
		name = "[name] ([theme_name])"
		desc = "Costumes in a box. The box's theme is '[theme_name]'."
		inhand_icon_state = "syringe_kit"

/obj/item/storage/box/halloween/special/gnomed/PopulateContents()
	new /obj/item/clothing/under/gnome(src)
	new /obj/item/clothing/head/gnome/gnomed(src)
	new /obj/item/clothing/suit/gnome(src)
	new /obj/item/clothing/shoes/gnome(src)
