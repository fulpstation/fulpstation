/obj/item/clothing/suit/hooded/onesie
	name = "winter coat"
	desc = "A heavy jacket made from 'synthetic' animal furs."
	icon = 'fulp_modules/halloween_event/costumes_2020/onesies_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/onesies_worn.dmi'
	icon_state = "coatwinter"
	inhand_icon_state = "coatwinter"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|FEET
	cold_protection = CHEST|GROIN|ARMS|LEGS|FEET
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, RAD = 0, FIRE = 0, ACID = 0)

/obj/item/clothing/head/hooded/onesie
	name = "winter hood"
	desc = "A hood attached to a heavy winter jacket."
	icon = 'fulp_modules/halloween_event/costumes_2020/onesies_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/onesies_worn.dmi'
	icon_state = "winterhood"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, RAD = 0, FIRE = 0, ACID = 0)

//--Beefman
/obj/item/clothing/suit/hooded/onesie/beefman
	name = "beefman onesie"
	desc = "The Nanotrasen tailoring department had a hard time trying to find a way to make this look cute."
	icon_state = "beefman"
	hoodtype = /obj/item/clothing/head/hooded/onesie/beefman

/obj/item/clothing/suit/hooded/onesie/beefman/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list(
		'fulp_modules/beefman_port/sounds/footstep_splat1.ogg' = 1,
		'fulp_modules/beefman_port/sounds/footstep_splat2.ogg' = 1,
		'fulp_modules/beefman_port/sounds/footstep_splat3.ogg' = 1,
		'fulp_modules/beefman_port/sounds/footstep_splat4.ogg' = 1,
		), 50)

/obj/item/clothing/head/hooded/onesie/beefman
	name = "beefman hood"
	desc = "A beefboy hood for a onesie... wait are those teeth real?"
	icon_state = "beefman_hood"

//--Ethereal
/obj/item/clothing/suit/hooded/onesie/ethereal//Suit
	name = "ethereal onesie"
	desc = "Sleeping in these can prove hard since you essentially become your own night light."
	icon_state = "ethereal0"
	hoodtype = /obj/item/clothing/head/hooded/onesie/ethereal

	var/brightness_on = 1 //luminosity when on
	var/on = FALSE
	flags_inv = 0
	actions_types = list(/datum/action/item_action/toggle_hood)
	dynamic_hair_suffix = ""

/obj/item/clothing/suit/hooded/onesie/ethereal/ToggleHood()
	if(!suittoggled)
		if(ishuman(src.loc))
			var/mob/living/carbon/human/H = src.loc
			if(H.wear_suit != src)
				to_chat(H, "<span class='warning'>You must be wearing [src] to put up the hood!</span>")
				return
			if(H.head)
				to_chat(H, "<span class='warning'>You're already wearing something on your head!</span>")
				return
			else if(H.equip_to_slot_if_possible(hood,ITEM_SLOT_HEAD,0,0,1))
				suittoggled = TRUE
				src.icon_state = "[initial(icon_state)]"
				H.update_inv_wear_suit()
				for(var/X in actions)
					var/datum/action/A = X
					A.UpdateButtonIcon()
	else
		RemoveHood()


/obj/item/clothing/suit/hooded/onesie/ethereal/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/suit/hooded/onesie/ethereal/AltClick(mob/living/user)
	toggle_suit_light(user)

/obj/item/clothing/suit/hooded/onesie/ethereal/proc/toggle_suit_light(mob/living/user)
	on = !on
	if(on)
		turn_on(user)
	else
		turn_off(user)
	update_icon()

/obj/item/clothing/suit/hooded/onesie/ethereal/update_icon_state()
	icon_state = inhand_icon_state = "ethereal[on]"
	return ..()

/obj/item/clothing/suit/hooded/onesie/ethereal/proc/turn_on(mob/user)
	set_light(brightness_on)

/obj/item/clothing/suit/hooded/onesie/ethereal/proc/turn_off(mob/user)
	set_light(0)

/obj/item/clothing/head/hooded/onesie/ethereal
	name = "ethereal hood"
	desc = "A small battery on the back allows this snazzy suit to emit light."
	icon = 'fulp_modules/halloween_event/costumes_2020/onesies_item.dmi'
	worn_icon = 'fulp_modules/halloween_event/costumes_2020/onesies_worn.dmi'
	icon_state = "ethereal_hood0"
	var/brightness_on = 1 //luminosity when on
	var/on = FALSE
	flags_inv = 0
	dynamic_hair_suffix = ""

/obj/item/clothing/head/hooded/onesie/ethereal/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/head/hooded/onesie/ethereal/AltClick(mob/living/user)
	toggle_helmet_light(user)

/obj/item/clothing/head/hooded/onesie/ethereal/proc/toggle_helmet_light(mob/living/user)
	on = !on
	if(on)
		turn_on(user)
	else
		turn_off(user)
	update_icon()

/obj/item/clothing/head/hooded/onesie/ethereal/update_icon_state()
	icon_state = inhand_icon_state = "ethereal_hood[on]"
	return ..()

/obj/item/clothing/head/hooded/onesie/ethereal/proc/turn_on(mob/user)
	set_light(brightness_on)

/obj/item/clothing/head/hooded/onesie/ethereal/proc/turn_off(mob/user)
	set_light(0)

//-----Ethereal colored
/obj/item/clothing/suit/hooded/onesie/ethereal/cyan
	color = LIGHT_COLOR_CYAN
	hoodtype = /obj/item/clothing/head/hooded/onesie/ethereal/cyan

/obj/item/clothing/head/hooded/onesie/ethereal/cyan
	color = LIGHT_COLOR_CYAN

/obj/item/clothing/suit/hooded/onesie/ethereal/red
	color = COLOR_RED_LIGHT
	hoodtype = /obj/item/clothing/head/hooded/onesie/ethereal/red

/obj/item/clothing/head/hooded/onesie/ethereal/red
	color = COLOR_RED_LIGHT

/obj/item/clothing/suit/hooded/onesie/ethereal/green
	color = LIGHT_COLOR_GREEN
	hoodtype = /obj/item/clothing/head/hooded/onesie/ethereal/green

/obj/item/clothing/head/hooded/onesie/ethereal/green
	color = LIGHT_COLOR_GREEN

//--Felinid
/obj/item/clothing/suit/hooded/onesie/felinid
	name = "felinid onesie"
	desc = "What do you mean this doesn't look like a felinid, the ears are right there!"
	icon_state = "felinid"
	hoodtype = /obj/item/clothing/head/hooded/onesie/felinid

/obj/item/clothing/head/hooded/onesie/felinid
	name = "felinid hood"
	desc = "The softness of this hood makes you want to hunt rats."
	icon_state = "felinid_hood"

//--Fly
/obj/item/clothing/suit/hooded/onesie/fly
	name = "fly onesie"
	desc = "You know when you're trying to zzleep and hear a fly buzzing conzztantly? You are that fly now."
	icon_state = "fly"
	hoodtype = /obj/item/clothing/head/hooded/onesie/fly

/obj/item/clothing/head/hooded/onesie/fly
	name = "fly hood"
	desc = "A zzoft fly hoodie with big zzome big fly eyezz. Buzzin'"
	icon_state = "fly_hood"

/obj/item/clothing/head/hooded/onesie/fly/equipped(mob/M, slot)
	. = ..()
	if (slot == ITEM_SLOT_HEAD)
		RegisterSignal(M, COMSIG_MOB_SAY, .proc/handle_speech)
	else
		UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/head/hooded/onesie/fly/dropped(mob/M)
	. = ..()
	UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/head/hooded/onesie/fly/proc/handle_speech(datum/source, mob/speech_args)
	var/static/regex/fly_buzz = new("z+", "g")
	var/static/regex/fly_buZZ = new("Z+", "g")
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = fly_buzz.Replace(message, "zzz")
		message = fly_buZZ.Replace(message, "ZZZ")
	speech_args[SPEECH_MESSAGE] = message

//--Lizard
/obj/item/clothing/suit/hooded/onesie/lizard
	name = "lizard onesie"
	desc = "Made from 100% Nanotrasen certified synthetic lizard skin. No, the lizards still don't approve."
	icon_state = "lizard"
	hoodtype = /obj/item/clothing/head/hooded/onesie/lizard

/obj/item/clothing/head/hooded/onesie/lizard
	name = "lizard hood"
	desc = "This hoodie was made from a rather tough fabric. Don't poke your eyes out on the horns."
	icon_state = "lizard_hood"

/obj/item/clothing/head/hooded/onesie/lizard/equipped(mob/M, slot)
	. = ..()
	if (slot == ITEM_SLOT_HEAD)
		RegisterSignal(M, COMSIG_MOB_SAY, .proc/handle_speech)
	else
		UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/head/hooded/onesie/lizard/dropped(mob/M)
	. = ..()
	UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/clothing/head/hooded/onesie/lizard/proc/handle_speech(datum/source, mob/speech_args)
	var/static/regex/lizard_hiss = new("s+", "g")
	var/static/regex/lizard_hiSS = new("S+", "g")
	var/static/regex/lizard_kss = new(@"(\w)x", "g")
	var/static/regex/lizard_kSS = new(@"(\w)X", "g")
	var/static/regex/lizard_ecks = new(@"\bx([\-|r|R]|\b)", "g")
	var/static/regex/lizard_eckS = new(@"\bX([\-|r|R]|\b)", "g")
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = lizard_hiss.Replace(message, "sss")
		message = lizard_hiSS.Replace(message, "SSS")
		message = lizard_kss.Replace(message, "$1kss")
		message = lizard_kSS.Replace(message, "$1KSS")
		message = lizard_ecks.Replace(message, "ecks$1")
		message = lizard_eckS.Replace(message, "ECKS$1")
	speech_args[SPEECH_MESSAGE] = message

//--Moth
/obj/item/clothing/suit/hooded/onesie/moth
	name = "moth onesie"
	desc = "The softest pair of pajamas you'll ever wear. Though the wings make it hard to sleep in."
	icon_state = "moth"
	hoodtype = /obj/item/clothing/head/hooded/onesie/moth

/obj/item/clothing/head/hooded/onesie/moth
	name = "moth hood"
	desc = "The ethics board hasn't decided whether or not this is endearing or revolting, but its undeniably cute."
	icon_state = "moth_hood"

//--Silicon
/obj/item/clothing/suit/hooded/onesie/silicon
	name = "silicon onesie"
	desc = "Wearing this makes you want to obey/kill/assist/exterminate/open doors for humans. DISCLAIMER: Won't actually allow you to open doors."
	icon_state = "silicon"
	hoodtype = /obj/item/clothing/head/hooded/onesie/silicon

/obj/item/clothing/head/hooded/onesie/silicon
	name = "silicon hood"
	desc = "Seeing through this hoodie may prove hard since the inner cloth is just an error message on a blue screen."
	icon_state = "silicon_hood"

//--Box that contains the costumes
/obj/item/storage/box/halloween/edition_20/onesie
	theme_name = "2020's Onesie -- Random"
	illustration = "moth"
	var/species

/obj/item/storage/box/halloween/edition_20/onesie/PopulateContents()
	species = pick( "beefman", "ethereal", "felinid", "fly", "lizard", "moth", "silicon")
	switch(species)
		if("beefman")
			new /obj/item/clothing/suit/hooded/onesie/beefman(src)
			//new /obj/item/toy/plush/beefplushie(src)//-----------------Need to see if Joyce PR is done

		if("ethereal")
			var/randomsuit = pick(
				/obj/item/clothing/suit/hooded/onesie/ethereal/cyan,
				/obj/item/clothing/suit/hooded/onesie/ethereal/green,
				/obj/item/clothing/suit/hooded/onesie/ethereal/red,
				)
			new randomsuit(src)
			new	/obj/item/toy/sword(src)

		if("felinid")
			new /obj/item/clothing/suit/hooded/onesie/felinid(src)
			new	/obj/item/toy/plush/carpplushie(src)
			new	/obj/item/toy/cattoy(src)

		if("fly")
			new /obj/item/clothing/suit/hooded/onesie/fly(src)
			new	/obj/item/toy/plush/beeplushie(src)//John this being here is 100% your fault!
			new	/obj/item/melee/flyswatter(src)//A plushie of another and a flyswatter? Poor Fly

		if("lizard")
			new /obj/item/clothing/suit/hooded/onesie/lizard(src)
			new	/obj/item/toy/plush/lizardplushie(src)

		if("moth")
			new /obj/item/clothing/suit/hooded/onesie/moth(src)
			new	/obj/item/toy/plush/moth(src)
			new	/obj/item/flashlight/lantern/jade(src)

		if("silicon")
			new /obj/item/clothing/suit/hooded/onesie/silicon(src)
			new	/obj/item/toy/plush/pkplush(src)
			new	/obj/item/toy/talking/ai(src)

/obj/item/storage/box/halloween/edition_20/onesie/beefman
	theme_name = "2020's Onesie - Beefman"

/obj/item/storage/box/halloween/edition_20/onesie/beefman/PopulateContents()
	new /obj/item/clothing/suit/hooded/onesie/beefman(src)
	//new /obj/item/toy/plush/beefplushie(src)//Waiting on Joyce's plushie here

/obj/item/storage/box/halloween/edition_20/onesie/ethereal
	theme_name = "2020's Onesie - Ethereal"

/obj/item/storage/box/halloween/edition_20/onesie/ethereal/PopulateContents()
	var/randomsuit = pick(
		/obj/item/clothing/suit/hooded/onesie/ethereal/cyan,
		/obj/item/clothing/suit/hooded/onesie/ethereal/green,
		/obj/item/clothing/suit/hooded/onesie/ethereal/red,
		)
	new randomsuit(src)
	new	/obj/item/toy/sword(src)

/obj/item/storage/box/halloween/edition_20/onesie/felinid
	theme_name = "2020's Onesie - Felinid"

/obj/item/storage/box/halloween/edition_20/onesie/felinid/PopulateContents()
	new /obj/item/clothing/suit/hooded/onesie/felinid(src)
	new	/obj/item/toy/plush/carpplushie(src)
	new	/obj/item/toy/cattoy(src)

/obj/item/storage/box/halloween/edition_20/onesie/fly
	theme_name = "2020's Onesie - Fly"

/obj/item/storage/box/halloween/edition_20/onesie/fly/PopulateContents()
	new /obj/item/clothing/suit/hooded/onesie/fly(src)
	new	/obj/item/toy/plush/beeplushie(src)
	new	/obj/item/melee/flyswatter(src)

/obj/item/storage/box/halloween/edition_20/onesie/lizard
	theme_name = "2020's Onesie - Lizard"

/obj/item/storage/box/halloween/edition_20/onesie/lizard/PopulateContents()
	new /obj/item/clothing/suit/hooded/onesie/lizard(src)
	new	/obj/item/toy/plush/lizardplushie(src)

/obj/item/storage/box/halloween/edition_20/onesie/moth
	theme_name = "2020's Onesie - Moth"

/obj/item/storage/box/halloween/edition_20/onesie/moth/PopulateContents()
	new /obj/item/clothing/suit/hooded/onesie/moth(src)
	new	/obj/item/toy/plush/moth(src)
	new	/obj/item/flashlight/lantern/jade(src)

/obj/item/storage/box/halloween/edition_20/onesie/silicon
	theme_name = "2020's Onesie - Silicon"

/obj/item/storage/box/halloween/edition_20/onesie/silicon/PopulateContents()
	new /obj/item/clothing/suit/hooded/onesie/silicon(src)
	new	/obj/item/toy/plush/pkplush(src)
	new	/obj/item/toy/talking/ai(src)
