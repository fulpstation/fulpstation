// Valentine's Day events //
// why are you playing spessmens on valentine's day you wizard //

#define VALENTINE_FILE "valentines.json"

// valentine / candy heart distribution //

/datum/round_event_control/valentines
	name = "Valentines!"
	holidayID = VALENTINES
	typepath = /datum/round_event/valentines
	weight = -1 //forces it to be called, regardless of weight
	max_occurrences = 1
	earliest_start = 0 MINUTES
	category = EVENT_CATEGORY_HOLIDAY
	description = "Puts people on dates! They must protect each other. Sometimes a vengeful third wheel spawns."

/datum/round_event/valentines/start()
	..()
	for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
		H.put_in_hands(new /obj/item/valentine)
		var/obj/item/storage/backpack/b = locate() in H.contents
		new /obj/item/food/candyheart(b)
		new /obj/item/storage/fancy/heart_box(b)

	var/list/valentines = list()
	for(var/mob/living/M in GLOB.player_list)
		var/turf/current_turf = get_turf(M.mind.current)
		if(!M.stat && M.mind && !current_turf.onCentCom())
			valentines |= M


	while(valentines.len)
		var/mob/living/L = pick_n_take(valentines)
		if(valentines.len)
			var/mob/living/date = pick_n_take(valentines)


			forge_valentines_objective(L, date)
			forge_valentines_objective(date, L)

			if(valentines.len && prob(4))
				var/mob/living/notgoodenough = pick_n_take(valentines)
				forge_valentines_objective(notgoodenough, date)
		else
			L.mind.add_antag_datum(/datum/antagonist/heartbreaker)

/proc/forge_valentines_objective(mob/living/lover,mob/living/date)
	lover.mind.special_role = "valentine"
	var/datum/antagonist/valentine/V = new
	V.date = date.mind
	lover.mind.add_antag_datum(V) //These really should be teams but i can't be assed to incorporate third wheels right now

/datum/round_event/valentines/announce(fake)
	priority_announce("It's Valentine's Day! Give a valentine to that special someone!")

/obj/item/valentine
	name = "valentine"
	desc = "A Valentine's card! Wonder what it says..."
	icon = 'icons/obj/toys/playing_cards.dmi'
	icon_state = "sc_Ace of Hearts_syndicate" // shut up // bye felicia
	var/message = "A generic message of love or whatever."
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY

/obj/item/valentine/Initialize(mapload)
	. = ..()
	message = pick(strings(VALENTINE_FILE, "valentines"))

/obj/item/valentine/attackby(obj/item/W, mob/user, params)
	..()
	if(istype(W, /obj/item/pen) || istype(W, /obj/item/toy/crayon))
		if(!user.can_write(W))
			return
		var/recipient = tgui_input_text(user, "Who is receiving this valentine?", "To:", max_length = MAX_NAME_LEN)
		var/sender = tgui_input_text(user, "Who is sending this valentine?", "From:", max_length = MAX_NAME_LEN)
		if(!user.can_perform_action(src))
			return
		if(recipient && sender)
			name = "valentine - To: [recipient] From: [sender]"

/obj/item/valentine/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		if( !(ishuman(user) || isobserver(user) || issilicon(user)) )
			user << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[stars(message)]</BODY></HTML>", "window=[name]")
			onclose(user, "[name]")
		else
			user << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY>[message]</BODY></HTML>", "window=[name]")
			onclose(user, "[name]")
	else
		. += span_notice("It is too far away.")

/obj/item/valentine/attack_self(mob/user)
	user.examinate(src)

/obj/item/food/candyheart
	name = "candy heart"
	icon = 'icons/obj/holiday/holiday_misc.dmi'
	icon_state = "candyheart"
	desc = "A heart-shaped candy that reads: "
	food_reagents = list(/datum/reagent/consumable/sugar = 2)
	junkiness = 5

/obj/item/food/candyheart/Initialize(mapload)
	. = ..()
	desc = pick(strings(VALENTINE_FILE, "candyhearts"))
	icon_state = pick("candyheart", "candyheart2", "candyheart3", "candyheart4")
