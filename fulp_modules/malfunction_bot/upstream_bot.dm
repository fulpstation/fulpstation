/*
 *	This file is overwriting /datum/customer_data/malfunction from 'code\modules\food_and_drinks\restaurant\customers\_customer.dm'
 *
 */

///MALFUNCTIONING - only shows up once per venue, very rare
/datum/customer_data/malfunction
	base_icon = "defect"
	prefix_file = "fulp_modules/malfunction_bot/upstream_prefix.txt"
	speech_sound = 'sound/effects/clang.ogg'
	clothing_sets = list("defect_wires", "defect_bad_takes")
	is_unique = TRUE
	orderable_objects = list(
		/datum/venue/restaurant = list(
			/obj/item/toy/crayon/red = 1,
			/obj/item/toy/crayon/orange = 1,
			/obj/item/toy/crayon/yellow = 1,
			/obj/item/toy/crayon/green = 1,
			/obj/item/toy/crayon/blue = 1,
			/obj/item/toy/crayon/purple = 1,
			/obj/item/food/canned/peaches/maint = 6,
			/obj/item/food/tofu = 1,
		),
		/datum/venue/bar = list(
			/datum/reagent/consumable/ethanol/beer = 1,
			/datum/reagent/consumable/failed_reaction = 1,
			/datum/reagent/spraytan = 1,
			/datum/reagent/reaction_agent/basic_buffer = 1,
			/datum/reagent/reaction_agent/acidic_buffer = 1,
		),
	)

	found_seat_lines = list("customer_pawn.say(pick(customer_data.found_seat_lines))", "I knew I shouldn't have used the hub.", "So this is the place with Beefmen they were talking about?", "So, you guys finally updated?")
	cant_find_seat_lines = list("Is the dilation too high for me to get a seat around here?", "Maybe I should've went to Bee, at least they still have intents.")
	leave_mad_lines = list("IF WE HADN'T REMOVED HARM INTENT I WOULD'VE HIT YOU!", "I'm grudgecoding a CQC buff over of this.", "No wonder they call this place beginner-friendly.")
	leave_happy_lines = list("No! I don't wanna go upstream! Please, I don't want to be murderboned again! HELP!!")
	wait_for_food_lines = list("TODO: fix the code I broke a month ago", "Where's the wiki for this area?", "Mentors how do I eat food?", "How do I become a Bloodsucker?")
	friendly_pull_line = "Chelp."
	first_warning_line = "You'd fit in well where I'm from. But you better stop."
	second_warning_line = "Listen buster, where I'm from, we don't have laws preventing murderbone."
	self_defense_line = "I have been designed to do two things: Order food, and complain online over getting banned for murdering you."
