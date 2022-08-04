// HoS bot
/datum/customer_data/head_of_sec
	prefix_file = "fulp_modules/features/prison/prison_kitchen/prefixes/hos_prefix.txt"
	base_icon_state = "british"
	clothing_sets = list("iamnotreal")
	is_unique = TRUE

	friendly_pull_line = "Step away from me before I bagcheck you."
	first_warning_line = "Don't touch me man, I have half the armory in my bag!"
	second_warning_line = "Last chance! I will declare you Hostile!"
	self_defense_line = "Alright, your time's up."
	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/obj/item/food/donut/plain = 6,
			/obj/item/food/burger/superbite = 6,
			/obj/item/food/pizza/vegetable = 5,
			/obj/item/food/grilled_cheese_sandwich = 5,
			/obj/item/food/pancakes = 5,
			/obj/item/food/spaghetti/butternoodles = 4,
			/obj/item/food/meatbun = 4,
			/obj/item/food/taco/plain = 4,
			/obj/item/food/burrito = 4,
			/obj/item/food/pie/meatpie = 4,
		),
	)
	found_seat_lines = list(
		"What's going on here? I just came to search some bags.",
		"Oh wow, the Warden's been actually working for once?",
		"The Warden really got you guys in shape, huh.",
		"What's been going on over here now?",
		"Please make sure to empty your bags on the floor to save us both some time.",
	)
	cant_find_seat_lines = list(
		"Hmpf, out of everyone here, you'd think they'd leave ME a seat.",
		"How can there not have any seats, just make one out of yourself!",
		"Maybe I let my expectations get too high.",
		"Where's the damn seats?",
	)
	leave_mad_lines = list(
		"I have bags to check.",
		"I have officers to order.",
		"I have prisoners to beat.",
		"I have clowns to slip.",
		"I have assistants to beat.",
		"I have wardens to yell at.",
		"I have gods to have a nice chat with",
		"I have brig physicians to abuse",
		"I hate deputies to arrest",
		"I have a cargonian problem to death with.",
		"I have a future career to think about.",
		"I have a couch to move",
		"I have a Captain to overthrow",
		"I have insulated gloves to bagcheck",
	)
	leave_happy_lines = list(
		"Food was great, maybe I should let you guys out. Just kidding! Hahaha!",
		"That was terrible food. I'll never be returning here again",
		"I guess I got what I expected when I decided to not just head over to the Kitchen.",
		"Hopefully this will keep me awake through the greenshift",
		"As mediocre as your food tastes, I have security business to attend to.",
		"I should hurry along now, the Captain won't micromanage every department themselves!",
	)
	wait_for_food_lines = list(
		"What's taking so long?",
		"Is something going on over there that I should investigate?",
		"...",
		"Sorry, I'm just speaking over my headset",
		"I keep getting reports of crimes, we should really hurry this up",
		"I wonder if the Library's running DnD",
		"...So I had to gib them before I could get authorization",
	)

/datum/customer_data/head_of_sec/get_overlays(mob/living/simple_animal/robot_customer/customer)
	var/list/underlays = list()
	var/mutable_appearance/hos_clothes = mutable_appearance(icon = 'fulp_modules/features/prison/icons/bots.dmi', icon_state = "hos_british")
	hos_clothes.appearance_flags = RESET_COLOR
	underlays += hos_clothes
	return underlays
