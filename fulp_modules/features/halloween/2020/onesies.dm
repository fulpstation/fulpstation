/**
 * Onesie costumes
 * Made by: Papaporo
 * Too many items to be worth moving into the main file.
 */

/obj/item/clothing/suit/hooded/onesie
	name = "winter coat"
	desc = "A heavy jacket made from 'synthetic' animal furs."
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'
	icon_state = "coatwinter"
	inhand_icon_state = "coatwinter"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|FEET
	cold_protection = CHEST|GROIN|ARMS|LEGS|FEET
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, FIRE = 0, ACID = 0)

/obj/item/clothing/head/hooded/onesie
	name = "winter hood"
	desc = "A hood attached to a heavy winter jacket."
	icon = 'fulp_modules/features/halloween/2020/2020_icons.dmi'
	worn_icon = 'fulp_modules/features/halloween/2020/2020_icons_worn.dmi'
	icon_state = "winterhood"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, FIRE = 0, ACID = 0)

///Beefman onesie
/obj/item/clothing/suit/hooded/onesie/beefman
	name = "beefman onesie"
	desc = "The Nanotrasen tailoring department had a hard time trying to find a way to make this look cute."
	icon_state = "onesie_beefman"
	hoodtype = /obj/item/clothing/head/hooded/onesie/beefman

/obj/item/clothing/suit/hooded/onesie/beefman/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list(
		'fulp_modules/features/species/sounds/footstep_splat1.ogg' = 1,
		'fulp_modules/features/species/sounds/footstep_splat2.ogg' = 1,
		'fulp_modules/features/species/sounds/footstep_splat3.ogg' = 1,
		'fulp_modules/features/species/sounds/footstep_splat4.ogg' = 1,
		), 50)

/obj/item/clothing/head/hooded/onesie/beefman
	name = "beefman hood"
	desc = "A beefboy hood for a onesie... wait are those teeth real?"
	icon_state = "onesie_beefman_hood"

///Ethereal Onesie
/obj/item/clothing/suit/hooded/onesie/ethereal
	name = "ethereal onesie"
	desc = "Sleeping in these can prove hard since you essentially become your own night light."
	icon_state = "onesie_ethereal0"
	hoodtype = /obj/item/clothing/head/hooded/onesie/ethereal

	///Luminosity when the suit is on
	var/brightness_on = 1
	var/on = FALSE
	flags_inv = 0
	actions_types = list(/datum/action/item_action/toggle_hood)
	dynamic_hair_suffix = ""

/obj/item/clothing/suit/hooded/onesie/ethereal/ToggleHood()
	if(hood_up)
		RemoveHood()
		return
	if(ishuman(src.loc))
		var/mob/living/carbon/human/user = src.loc
		if(user.wear_suit != src)
			to_chat(user, span_warning("You must be wearing [src] to put up the hood!"))
			return
		if(user.head)
			to_chat(user, span_warning("You're already wearing something on your head!"))
			return
		else if(user.equip_to_slot_if_possible(hood, ITEM_SLOT_HEAD,0,0,1))
			hood_up = TRUE
			src.icon_state = "[initial(icon_state)]"
			user.update_inv_wear_suit()
			for(var/all_selections in actions)
				var/datum/action/onesie_options = all_selections
				onesie_options.UpdateButtonIcon()

/obj/item/clothing/suit/hooded/onesie/ethereal/proc/toggle_suit_light(mob/living/user)
	on = !on
	if(on)
		turn_on(user)
	else
		turn_off(user)
	update_icon()

/obj/item/clothing/suit/hooded/onesie/ethereal/Initialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/suit/hooded/onesie/ethereal/Destroy()
	RemoveElement(/datum/element/update_icon_updates_onmob)
	return ..()

/obj/item/clothing/suit/hooded/onesie/ethereal/AltClick(mob/living/user)
	toggle_suit_light(user)

/obj/item/clothing/suit/hooded/onesie/ethereal/update_icon_state()
	icon_state = inhand_icon_state = "onesie_ethereal[on]"
	return ..()

/obj/item/clothing/suit/hooded/onesie/ethereal/proc/turn_on(mob/user)
	set_light(brightness_on)

/obj/item/clothing/suit/hooded/onesie/ethereal/proc/turn_off(mob/user)
	set_light(0)

/obj/item/clothing/head/hooded/onesie/ethereal
	name = "ethereal hood"
	desc = "A small battery on the back allows this snazzy suit to emit light."
	icon_state = "onesie_ethereal_hood0"

	///Luminosity when the suit is on
	var/brightness_on = 1
	var/on = FALSE
	flags_inv = 0
	dynamic_hair_suffix = ""

/obj/item/clothing/head/hooded/onesie/ethereal/Initialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/head/hooded/onesie/ethereal/Destroy()
	RemoveElement(/datum/element/update_icon_updates_onmob)
	return ..()

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
	icon_state = inhand_icon_state = "onesie_ethereal_hood[on]"
	return ..()

/obj/item/clothing/head/hooded/onesie/ethereal/proc/turn_on(mob/user)
	set_light(brightness_on)

/obj/item/clothing/head/hooded/onesie/ethereal/proc/turn_off(mob/user)
	set_light(0)

///Ethereal colors
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

///Felinid Onesie
/obj/item/clothing/suit/hooded/onesie/felinid
	name = "felinid onesie"
	desc = "What do you mean this doesn't look like a felinid, the ears are right there!"
	icon_state = "onesie_felinid"
	hoodtype = /obj/item/clothing/head/hooded/onesie/felinid

/obj/item/clothing/head/hooded/onesie/felinid
	name = "felinid hood"
	desc = "The softness of this hood makes you want to hunt rats."
	icon_state = "onesie_felinid_hood"

///Flyperson onesie
/obj/item/clothing/suit/hooded/onesie/fly
	name = "fly onesie"
	desc = "You know when you're trying to zzleep and hear a fly buzzing conzztantly? You are that fly now."
	icon_state = "onesie_fly"
	hoodtype = /obj/item/clothing/head/hooded/onesie/fly

/obj/item/clothing/head/hooded/onesie/fly
	name = "fly hood"
	desc = "A zzoft fly hoodie with big zzome big fly eyezz. Buzzin'"
	icon_state = "onesie_fly_hood"

/obj/item/clothing/head/hooded/onesie/fly/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HEAD)
		RegisterSignal(user, COMSIG_MOB_SAY, .proc/handle_speech)
	else
		UnregisterSignal(user, COMSIG_MOB_SAY)

/obj/item/clothing/head/hooded/onesie/fly/dropped(mob/user)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_SAY)

/obj/item/clothing/head/hooded/onesie/fly/proc/handle_speech(datum/source, mob/speech_args)
	SIGNAL_HANDLER

	var/static/regex/fly_buzz = new("z+", "g")
	var/static/regex/fly_buZZ = new("Z+", "g")
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = fly_buzz.Replace(message, "zzz")
		message = fly_buZZ.Replace(message, "ZZZ")
	speech_args[SPEECH_MESSAGE] = message

///Lizardperson Onesie
/obj/item/clothing/suit/hooded/onesie/lizard
	name = "lizard onesie"
	desc = "Made from 100% Nanotrasen certified synthetic lizard skin. No, the lizards still don't approve."
	icon_state = "onesie_lizard"
	hoodtype = /obj/item/clothing/head/hooded/onesie/lizard

/obj/item/clothing/head/hooded/onesie/lizard
	name = "lizard hood"
	desc = "This hoodie was made from a rather tough fabric. Don't poke your eyes out on the horns."
	icon_state = "onesie_lizard_hood"

/obj/item/clothing/head/hooded/onesie/lizard/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_HEAD)
		RegisterSignal(user, COMSIG_MOB_SAY, .proc/handle_speech)
	else
		UnregisterSignal(user, COMSIG_MOB_SAY)

/obj/item/clothing/head/hooded/onesie/lizard/dropped(mob/user)
	UnregisterSignal(user, COMSIG_MOB_SAY)
	return ..()

/obj/item/clothing/head/hooded/onesie/lizard/proc/handle_speech(datum/source, mob/speech_args)
	SIGNAL_HANDLER

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

///Mothperson Onesie
/obj/item/clothing/suit/hooded/onesie/moth
	name = "moth onesie"
	desc = "The softest pair of pajamas you'll ever wear. Though the wings make it hard to sleep in."
	icon_state = "onesie_moth"
	hoodtype = /obj/item/clothing/head/hooded/onesie/moth

/obj/item/clothing/head/hooded/onesie/moth
	name = "moth hood"
	desc = "The ethics board hasn't decided whether or not this is endearing or revolting, but its undeniably cute."
	icon_state = "onesie_moth_hood"

///Silicon Onesie
/obj/item/clothing/suit/hooded/onesie/silicon
	name = "silicon onesie"
	desc = "Wearing this makes you want to obey/kill/assist/exterminate/open doors for humans. DISCLAIMER: Won't actually allow you to open doors."
	icon_state = "onesie_silicon"
	hoodtype = /obj/item/clothing/head/hooded/onesie/silicon

/obj/item/clothing/head/hooded/onesie/silicon
	name = "silicon hood"
	desc = "Seeing through this hoodie may prove hard since the inner cloth is just an error message on a blue screen."
	icon_state = "onesie_silicon_hood"

/obj/item/storage/box/halloween/edition_20/onesie
	theme_name = "2020's Onesie -- Random"
	illustration = "moth"
	var/species

/obj/item/storage/box/halloween/edition_20/onesie/PopulateContents()
	if(costume_contents.len)
		return ..()
	species = pick("beefman", "ethereal", "felinid", "fly", "lizard", "moth", "silicon")
	switch(species)
		if("beefman")
			costume_contents = list(
				/obj/item/clothing/suit/hooded/onesie/beefman,
				/obj/item/toy/plush/beefplushie,
			)

		if("ethereal")
			costume_contents = list(/obj/item/toy/sword)
			costume_contents += pick(
				/obj/item/clothing/suit/hooded/onesie/ethereal/cyan,
				/obj/item/clothing/suit/hooded/onesie/ethereal/green,
				/obj/item/clothing/suit/hooded/onesie/ethereal/red,
			)

		if("felinid")
			costume_contents = list(
				/obj/item/clothing/suit/hooded/onesie/felinid,
				/obj/item/toy/plush/carpplushie,
				/obj/item/toy/cattoy,
			)

		if("fly")
			costume_contents = list(
				/obj/item/clothing/suit/hooded/onesie/fly,
				/obj/item/toy/plush/fly,
				/obj/item/melee/flyswatter,
			)

		if("lizard")
			costume_contents = list(
				/obj/item/clothing/suit/hooded/onesie/lizard,
				/obj/item/toy/plush/lizard_plushie,
			)

		if("moth")
			costume_contents = list(
				/obj/item/clothing/suit/hooded/onesie/moth,
				/obj/item/toy/plush/moth,
				/obj/item/flashlight/lantern/jade,
			)

		if("silicon")
			costume_contents = list(
				/obj/item/clothing/suit/hooded/onesie/silicon,
				/obj/item/toy/plush/pkplush,
				/obj/item/toy/talking/ai,
			)

	// Call parent to deal with the rest
	. = ..()

/obj/item/storage/box/halloween/edition_20/onesie/beefman
	theme_name = "2020's Onesie - Beefman"
	costume_contents = list(
		/obj/item/clothing/suit/hooded/onesie/beefman,
		/obj/item/toy/plush/beefplushie,
	)

/obj/item/storage/box/halloween/edition_20/onesie/ethereal
	theme_name = "2020's Onesie - Ethereal"
	costume_contents = list(
		/obj/item/toy/sword,
	)

/obj/item/storage/box/halloween/edition_20/onesie/ethereal/PopulateContents()
	costume_contents += pick(
		/obj/item/clothing/suit/hooded/onesie/ethereal/cyan,
		/obj/item/clothing/suit/hooded/onesie/ethereal/green,
		/obj/item/clothing/suit/hooded/onesie/ethereal/red,
	)
	// Call parent to deal with the rest
	. = ..()

/obj/item/storage/box/halloween/edition_20/onesie/felinid
	theme_name = "2020's Onesie - Felinid"
	costume_contents = list(
		/obj/item/clothing/suit/hooded/onesie/felinid,
		/obj/item/toy/plush/carpplushie,
		/obj/item/toy/cattoy,
	)

/obj/item/storage/box/halloween/edition_20/onesie/fly
	theme_name = "2020's Onesie - Fly"
	costume_contents = list(
		/obj/item/clothing/suit/hooded/onesie/fly,
		/obj/item/toy/plush/beeplushie,
		/obj/item/melee/flyswatter,
	)

/obj/item/storage/box/halloween/edition_20/onesie/lizard
	theme_name = "2020's Onesie - Lizard"
	costume_contents = list(
		/obj/item/clothing/suit/hooded/onesie/lizard,
		/obj/item/toy/plush/lizard_plushie,
	)

/obj/item/storage/box/halloween/edition_20/onesie/moth
	theme_name = "2020's Onesie - Moth"
	costume_contents = list(
		/obj/item/clothing/suit/hooded/onesie/moth,
		/obj/item/toy/plush/moth,
		/obj/item/flashlight/lantern/jade,
	)

/obj/item/storage/box/halloween/edition_20/onesie/silicon
	theme_name = "2020's Onesie - Silicon"
	costume_contents = list(
		/obj/item/clothing/suit/hooded/onesie/silicon,
		/obj/item/toy/plush/pkplush,
		/obj/item/toy/talking/ai,
	)
