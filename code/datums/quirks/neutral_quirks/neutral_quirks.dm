//traits with no real impact that can be taken freely
//MAKE SURE THESE DO NOT MAJORLY IMPACT GAMEPLAY. those should be positive or negative traits.

/datum/quirk/extrovert
	name = "Extrovert"
	desc = "You are energized by talking to others, and enjoy spending your free time in the bar."
	icon = FA_ICON_USERS
	value = 0
	mob_trait = TRAIT_EXTROVERT
	gain_text = span_notice("You feel like hanging out with other people.")
	lose_text = span_danger("You feel like you're over the bar scene.")
	medical_record_text = "Patient will not shut the hell up."
	mail_goodies = list(/obj/item/reagent_containers/cup/glass/flask)

/datum/quirk/introvert
	name = "Introvert"
	desc = "You are energized by having time to yourself, and enjoy spending your free time in the library."
	icon = FA_ICON_BOOK_READER
	value = 0
	mob_trait = TRAIT_INTROVERT
	gain_text = span_notice("You feel like reading a good book quietly.")
	lose_text = span_danger("You feel like libraries are boring.")
	medical_record_text = "Patient doesn't seem to say much."
	mail_goodies = list(/obj/item/book/random)

/datum/quirk/no_taste
	name = "Ageusia"
	desc = "You can't taste anything! Toxic food will still poison you."
	icon = FA_ICON_MEH_BLANK
	value = 0
	mob_trait = TRAIT_AGEUSIA
	gain_text = span_notice("You can't taste anything!")
	lose_text = span_notice("You can taste again!")
	medical_record_text = "Patient suffers from ageusia and is incapable of tasting food or reagents."
	mail_goodies = list(/obj/effect/spawner/random/food_or_drink/condiment) // but can you taste the salt? CAN YOU?!

/datum/quirk/foreigner
	name = "Foreigner"
	desc = "You're not from around here. You don't know Galactic Common!"
	icon = FA_ICON_LANGUAGE
	value = 0
	gain_text = span_notice("The words being spoken around you don't make any sense.")
	lose_text = span_notice("You've developed fluency in Galactic Common.")
	medical_record_text = "Patient does not speak Galactic Common and may require an interpreter."
	mail_goodies = list(/obj/item/taperecorder) // for translation

/datum/quirk/foreigner/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.add_blocked_language(/datum/language/common)
	if(ishumanbasic(human_holder))
		human_holder.grant_language(/datum/language/uncommon, source = LANGUAGE_QUIRK)

/datum/quirk/foreigner/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.remove_blocked_language(/datum/language/common)
	if(ishumanbasic(human_holder))
		human_holder.remove_language(/datum/language/uncommon)

/datum/quirk/vegetarian
	name = "Vegetarian"
	desc = "You find the idea of eating meat morally and physically repulsive."
	icon = FA_ICON_CARROT
	value = 0
	gain_text = span_notice("You feel repulsion at the idea of eating meat.")
	lose_text = span_notice("You feel like eating meat isn't that bad.")
	medical_record_text = "Patient reports a vegetarian diet."
	mail_goodies = list(/obj/effect/spawner/random/food_or_drink/salad)

/datum/quirk/vegetarian/add(client/client_source)
	var/obj/item/organ/internal/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.liked_foodtypes &= ~MEAT
	tongue.disliked_foodtypes |= MEAT

/datum/quirk/vegetarian/remove()
	var/obj/item/organ/internal/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.liked_foodtypes = initial(tongue.liked_foodtypes)
	tongue.disliked_foodtypes = initial(tongue.disliked_foodtypes)

/datum/quirk/snob
	name = "Snob"
	desc = "You care about the finer things, if a room doesn't look nice its just not really worth it, is it?"
	icon = FA_ICON_USER_TIE
	value = 0
	gain_text = span_notice("You feel like you understand what things should look like.")
	lose_text = span_notice("Well who cares about deco anyways?")
	medical_record_text = "Patient seems to be rather stuck up."
	mob_trait = TRAIT_SNOB
	mail_goodies = list(/obj/item/chisel, /obj/item/paint_palette)

/datum/quirk/pineapple_liker
	name = "Ananas Affinity"
	desc = "You find yourself greatly enjoying fruits of the ananas genus. You can't seem to ever get enough of their sweet goodness!"
	icon = FA_ICON_THUMBS_UP
	value = 0
	gain_text = span_notice("You feel an intense craving for pineapple.")
	lose_text = span_notice("Your feelings towards pineapples seem to return to a lukewarm state.")
	medical_record_text = "Patient demonstrates a pathological love of pineapple."
	mail_goodies = list(/obj/item/food/pizzaslice/pineapple)

/datum/quirk/pineapple_liker/add(client/client_source)
	var/obj/item/organ/internal/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.liked_foodtypes |= PINEAPPLE

/datum/quirk/pineapple_liker/remove()
	var/obj/item/organ/internal/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.liked_foodtypes = initial(tongue.liked_foodtypes)

/datum/quirk/pineapple_hater
	name = "Ananas Aversion"
	desc = "You find yourself greatly detesting fruits of the ananas genus. Serious, how the hell can anyone say these things are good? And what kind of madman would even dare putting it on a pizza!?"
	icon = FA_ICON_THUMBS_DOWN
	value = 0
	gain_text = span_notice("You find yourself pondering what kind of idiot actually enjoys pineapples...")
	lose_text = span_notice("Your feelings towards pineapples seem to return to a lukewarm state.")
	medical_record_text = "Patient is correct to think that pineapple is disgusting."
	mail_goodies = list( // basic pizza slices
		/obj/item/food/pizzaslice/margherita,
		/obj/item/food/pizzaslice/meat,
		/obj/item/food/pizzaslice/mushroom,
		/obj/item/food/pizzaslice/vegetable,
		/obj/item/food/pizzaslice/sassysage,
	)

/datum/quirk/pineapple_hater/add(client/client_source)
	var/obj/item/organ/internal/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.disliked_foodtypes |= PINEAPPLE

/datum/quirk/pineapple_hater/remove()
	var/obj/item/organ/internal/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.disliked_foodtypes = initial(tongue.disliked_foodtypes)

/datum/quirk/deviant_tastes
	name = "Deviant Tastes"
	desc = "You dislike food that most people enjoy, and find delicious what they don't."
	icon = FA_ICON_GRIN_TONGUE_SQUINT
	value = 0
	gain_text = span_notice("You start craving something that tastes strange.")
	lose_text = span_notice("You feel like eating normal food again.")
	medical_record_text = "Patient demonstrates irregular nutrition preferences."
	mail_goodies = list(/obj/item/food/urinalcake, /obj/item/food/badrecipe) // Mhhhmmm yummy

/datum/quirk/deviant_tastes/add(client/client_source)
	var/obj/item/organ/internal/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	var/liked_foodtypes = tongue.liked_foodtypes
	tongue.liked_foodtypes = tongue.disliked_foodtypes
	tongue.disliked_foodtypes = liked_foodtypes

/datum/quirk/deviant_tastes/remove()
	var/obj/item/organ/internal/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.liked_foodtypes = initial(tongue.liked_foodtypes)
	tongue.disliked_foodtypes = initial(tongue.disliked_foodtypes)

/datum/quirk/heterochromatic
	name = "Heterochromatic"
	desc = "One of your eyes is a different color than the other!"
	icon = FA_ICON_EYE_LOW_VISION // Ignore the icon name, its actually a fairly good representation of different color eyes
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	value = 0
	mail_goodies = list(/obj/item/clothing/glasses/eyepatch)

// Only your first eyes are heterochromatic
// If someone comes and says "well mr coder you can have DNA bound heterochromia so it's not unrealistic
// to allow all inserted replacement eyes to become heterochromatic or for it to transfer between mobs"
// Then just change this to [proc/add] I really don't care
/datum/quirk/heterochromatic/add_unique(client/client_source)
	var/color = client_source?.prefs.read_preference(/datum/preference/color/heterochromatic)
	if(!color)
		return

	apply_heterochromatic_eyes(color)

/// Applies the passed color to this mob's eyes
/datum/quirk/heterochromatic/proc/apply_heterochromatic_eyes(color)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/was_not_hetero = !human_holder.eye_color_heterochromatic
	human_holder.eye_color_heterochromatic = TRUE
	human_holder.eye_color_right = color

	var/obj/item/organ/internal/eyes/eyes_of_the_holder = quirk_holder.get_organ_by_type(/obj/item/organ/internal/eyes)
	if(!eyes_of_the_holder)
		return

	eyes_of_the_holder.eye_color_right = color
	eyes_of_the_holder.old_eye_color_right = color
	eyes_of_the_holder.refresh()

	if(was_not_hetero)
		RegisterSignal(human_holder, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(check_eye_removal))

/datum/quirk/heterochromatic/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.eye_color_heterochromatic = FALSE
	human_holder.eye_color_right = human_holder.eye_color_left
	UnregisterSignal(human_holder, COMSIG_CARBON_LOSE_ORGAN)

/datum/quirk/heterochromatic/proc/check_eye_removal(datum/source, obj/item/organ/internal/eyes/removed)
	SIGNAL_HANDLER

	if(!istype(removed))
		return

	// Eyes were removed, remove heterochromia from the human holder and bid them adieu
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.eye_color_heterochromatic = FALSE
	human_holder.eye_color_right = human_holder.eye_color_left
	UnregisterSignal(human_holder, COMSIG_CARBON_LOSE_ORGAN)

/datum/quirk/monochromatic
	name = "Monochromacy"
	desc = "You suffer from full colorblindness, and perceive nearly the entire world in blacks and whites."
	icon = FA_ICON_ADJUST
	value = 0
	medical_record_text = "Patient is afflicted with almost complete color blindness."
	mail_goodies = list( // Noir detective wannabe
		/obj/item/clothing/suit/jacket/det_suit/noir,
		/obj/item/clothing/suit/jacket/det_suit/dark,
		/obj/item/clothing/head/fedora/beige,
		/obj/item/clothing/head/fedora/white,
	)

/datum/quirk/monochromatic/add(client/client_source)
	quirk_holder.add_client_colour(/datum/client_colour/monochrome)

/datum/quirk/monochromatic/post_add()
	if(is_detective_job(quirk_holder.mind.assigned_role))
		to_chat(quirk_holder, span_boldannounce("Mmm. Nothing's ever clear on this station. It's all shades of gray..."))
		quirk_holder.playsound_local(quirk_holder, 'sound/ambience/ambidet1.ogg', 50, FALSE)

/datum/quirk/monochromatic/remove()
	quirk_holder.remove_client_colour(/datum/client_colour/monochrome)

/datum/quirk/phobia
	name = "Phobia"
	desc = "You are irrationally afraid of something."
	icon = FA_ICON_SPIDER
	value = 0
	medical_record_text = "Patient has an irrational fear of something."
	mail_goodies = list(/obj/item/clothing/glasses/blindfold, /obj/item/storage/pill_bottle/psicodine)

// Phobia will follow you between transfers
/datum/quirk/phobia/add(client/client_source)
	var/phobia = client_source?.prefs.read_preference(/datum/preference/choiced/phobia)
	if(!phobia)
		return

	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.gain_trauma(new /datum/brain_trauma/mild/phobia(phobia), TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/phobia/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.cure_trauma_type(/datum/brain_trauma/mild/phobia, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/shifty_eyes
	name = "Shifty Eyes"
	desc = "Your eyes tend to wander all over the place, whether you mean to or not, causing people to sometimes think you're looking directly at them when you aren't."
	icon = FA_ICON_EYE
	value = 0
	medical_record_text = "Fucking creep kept staring at me the whole damn checkup. I'm only diagnosing this because it's less awkward than thinking it was on purpose."
	mob_trait = TRAIT_SHIFTY_EYES
	mail_goodies = list(/obj/item/clothing/head/costume/papersack, /obj/item/clothing/head/costume/papersack/smiley)

/datum/quirk/item_quirk/bald
	name = "Smooth-Headed"
	desc = "You have no hair and are quite insecure about it! Keep your wig on, or at least your head covered up."
	icon = FA_ICON_EGG
	value = 0
	mob_trait = TRAIT_BALD
	gain_text = span_notice("Your head is as smooth as can be, it's terrible.")
	lose_text = span_notice("Your head itches, could it be... growing hair?!")
	medical_record_text = "Patient starkly refused to take off headwear during examination."
	mail_goodies = list(/obj/item/clothing/head/wig/random)
	/// The user's starting hairstyle
	var/old_hair

/datum/quirk/item_quirk/bald/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	old_hair = human_holder.hairstyle
	human_holder.set_hairstyle("Bald", update = TRUE)
	RegisterSignal(human_holder, COMSIG_CARBON_EQUIP_HAT, PROC_REF(equip_hat))
	RegisterSignal(human_holder, COMSIG_CARBON_UNEQUIP_HAT, PROC_REF(unequip_hat))

/datum/quirk/item_quirk/bald/add_unique(client/client_source)
	var/obj/item/clothing/head/wig/natural/baldie_wig = new(get_turf(quirk_holder))
	if(old_hair == "Bald")
		baldie_wig.hairstyle = pick(GLOB.hairstyles_list - "Bald")
	else
		baldie_wig.hairstyle = old_hair

	baldie_wig.update_appearance()

	give_item_to_holder(baldie_wig, list(LOCATION_HEAD = ITEM_SLOT_HEAD, LOCATION_BACKPACK = ITEM_SLOT_BACKPACK, LOCATION_HANDS = ITEM_SLOT_HANDS))

/datum/quirk/item_quirk/bald/remove()
	. = ..()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.hairstyle = old_hair
	human_holder.update_body_parts()
	UnregisterSignal(human_holder, list(COMSIG_CARBON_EQUIP_HAT, COMSIG_CARBON_UNEQUIP_HAT))
	human_holder.clear_mood_event("bad_hair_day")

///Checks if the headgear equipped is a wig and sets the mood event accordingly
/datum/quirk/item_quirk/bald/proc/equip_hat(mob/user, obj/item/hat)
	SIGNAL_HANDLER

	if(istype(hat, /obj/item/clothing/head/wig))
		quirk_holder.add_mood_event("bad_hair_day", /datum/mood_event/confident_mane) //Our head is covered, but also by a wig so we're happy.
	else
		quirk_holder.clear_mood_event("bad_hair_day") //Our head is covered

///Applies a bad moodlet for having an uncovered head
/datum/quirk/item_quirk/bald/proc/unequip_hat(mob/user, obj/item/clothing, force, newloc, no_move, invdrop, silent)
	SIGNAL_HANDLER

	quirk_holder.add_mood_event("bad_hair_day", /datum/mood_event/bald)

/datum/quirk/item_quirk/photographer
	name = "Photographer"
	desc = "You carry your camera and personal photo album everywhere you go, and your scrapbooks are legendary among your coworkers."
	icon = FA_ICON_CAMERA
	value = 0
	mob_trait = TRAIT_PHOTOGRAPHER
	gain_text = span_notice("You know everything about photography.")
	lose_text = span_danger("You forget how photo cameras work.")
	medical_record_text = "Patient mentions photography as a stress-relieving hobby."
	mail_goodies = list(/obj/item/camera_film)

/datum/quirk/item_quirk/photographer/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/storage/photo_album/personal/photo_album = new(get_turf(human_holder))
	photo_album.persistence_id = "personal_[human_holder.last_mind?.key]" // this is a persistent album, the ID is tied to the account's key to avoid tampering
	photo_album.persistence_load()
	photo_album.name = "[human_holder.real_name]'s photo album"

	give_item_to_holder(photo_album, list(LOCATION_BACKPACK = ITEM_SLOT_BACKPACK, LOCATION_HANDS = ITEM_SLOT_HANDS))
	give_item_to_holder(
		/obj/item/camera,
		list(
			LOCATION_NECK = ITEM_SLOT_NECK,
			LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
			LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
			LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
			LOCATION_HANDS = ITEM_SLOT_HANDS
		)
	)

/datum/quirk/item_quirk/colorist
	name = "Colorist"
	desc = "You like carrying around a hair dye spray to quickly apply color patterns to your hair."
	icon = FA_ICON_FILL_DRIP
	value = 0
	medical_record_text = "Patient enjoys dyeing their hair with pretty colors."
	mail_goodies = list(/obj/item/dyespray)

/datum/quirk/item_quirk/colorist/add_unique(client/client_source)
	give_item_to_holder(/obj/item/dyespray, list(LOCATION_BACKPACK = ITEM_SLOT_BACKPACK, LOCATION_HANDS = ITEM_SLOT_HANDS))

#define GAMING_WITHDRAWAL_TIME (15 MINUTES)
/datum/quirk/gamer
	name = "Gamer"
	desc = "You are a hardcore gamer, and you have a need to game. You love winning and hate losing. You only like gamer food."
	icon = FA_ICON_GAMEPAD
	value = 0
	gain_text = span_notice("You feel the sudden urge to game.")
	lose_text = span_notice("You've lost all interest in gaming.")
	medical_record_text = "Patient has a severe video game addiction."
	mob_trait = TRAIT_GAMER
	mail_goodies = list(/obj/item/toy/intento, /obj/item/clothing/head/fedora)
	/// Timer for gaming withdrawal to kick in
	var/gaming_withdrawal_timer = TIMER_ID_NULL

/datum/quirk/gamer/add(client/client_source)
	var/obj/item/organ/internal/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(tongue)
		// Gamer diet
		tongue.liked_foodtypes = JUNKFOOD
	RegisterSignal(quirk_holder, COMSIG_MOB_WON_VIDEOGAME, PROC_REF(won_game))
	RegisterSignal(quirk_holder, COMSIG_MOB_LOST_VIDEOGAME, PROC_REF(lost_game))
	RegisterSignal(quirk_holder, COMSIG_MOB_PLAYED_VIDEOGAME, PROC_REF(gamed))

/datum/quirk/gamer/add_unique(client/client_source)
	// The gamer starts off quelled
	gaming_withdrawal_timer = addtimer(CALLBACK(src, PROC_REF(enter_withdrawal)), GAMING_WITHDRAWAL_TIME, TIMER_STOPPABLE)

/datum/quirk/gamer/remove()
	var/obj/item/organ/internal/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(tongue)
		tongue.liked_foodtypes = initial(tongue.liked_foodtypes)
	UnregisterSignal(quirk_holder, COMSIG_MOB_WON_VIDEOGAME)
	UnregisterSignal(quirk_holder, COMSIG_MOB_LOST_VIDEOGAME)
	UnregisterSignal(quirk_holder, COMSIG_MOB_PLAYED_VIDEOGAME)

/**
 * Gamer won a game
 *
 * Executed on the COMSIG_MOB_WON_VIDEOGAME signal
 * This signal should be called whenever a player has won a video game.
 * (E.g. Orion Trail)
 */
/datum/quirk/gamer/proc/won_game()
	SIGNAL_HANDLER
	// Epic gamer victory
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.add_mood_event("gamer_won", /datum/mood_event/gamer_won)

/**
 * Gamer lost a game
 *
 * Executed on the COMSIG_MOB_LOST_VIDEOGAME signal
 * This signal should be called whenever a player has lost a video game.
 * (E.g. Orion Trail)
 */
/datum/quirk/gamer/proc/lost_game()
	SIGNAL_HANDLER
	// Executed when a gamer has lost
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.add_mood_event("gamer_lost", /datum/mood_event/gamer_lost)
	// Executed asynchronously due to say()
	INVOKE_ASYNC(src, PROC_REF(gamer_moment))
/**
 * Gamer is playing a game
 *
 * Executed on the COMSIG_MOB_PLAYED_VIDEOGAME signal
 * This signal should be called whenever a player interacts with a video game.
 */
/datum/quirk/gamer/proc/gamed()
	SIGNAL_HANDLER

	var/mob/living/carbon/human/human_holder = quirk_holder
	// Remove withdrawal malus
	human_holder.clear_mood_event("gamer_withdrawal")
	// Reset withdrawal timer
	if (gaming_withdrawal_timer)
		deltimer(gaming_withdrawal_timer)
	gaming_withdrawal_timer = addtimer(CALLBACK(src, PROC_REF(enter_withdrawal)), GAMING_WITHDRAWAL_TIME, TIMER_STOPPABLE)


/datum/quirk/gamer/proc/gamer_moment()
	// It was a heated gamer moment...
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.say(";[pick("SHIT", "PISS", "FUCK", "CUNT", "COCKSUCKER", "MOTHERFUCKER")]!!", forced = name)

/datum/quirk/gamer/proc/enter_withdrawal()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.add_mood_event("gamer_withdrawal", /datum/mood_event/gamer_withdrawal)

#undef GAMING_WITHDRAWAL_TIME


/datum/quirk/item_quirk/pride_pin
	name = "Pride Pin"
	desc = "Show off your pride with this changing pride pin!"
	icon = FA_ICON_RAINBOW
	value = 0
	gain_text = span_notice("You feel fruity.")
	lose_text = span_danger("You feel only slightly less fruity than before.")
	medical_record_text = "Patient appears to be fruity."

/datum/quirk/item_quirk/pride_pin/add_unique(client/client_source)
	var/obj/item/clothing/accessory/pride/pin = new(get_turf(quirk_holder))

	var/pride_choice = client_source?.prefs?.read_preference(/datum/preference/choiced/pride_pin) || assoc_to_keys(GLOB.pride_pin_reskins)[1]
	var/pride_reskin = GLOB.pride_pin_reskins[pride_choice]

	pin.current_skin = pride_choice
	pin.icon_state = pride_reskin

	give_item_to_holder(pin, list(LOCATION_BACKPACK = ITEM_SLOT_BACKPACK, LOCATION_HANDS = ITEM_SLOT_HANDS))
