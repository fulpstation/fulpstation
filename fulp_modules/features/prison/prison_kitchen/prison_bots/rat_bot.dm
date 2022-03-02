/datum/customer_data/rat
	prefix_file = "fulp_modules/features/prison/prison_kitchen/prefixes/rat_prefix.txt"
	base_icon_state = "british"
	clothing_sets = list("iamnotreal")

	friendly_pull_line = "Squeak?"
	first_warning_line = "Squeak."
	second_warning_line = "Squeak!"
	self_defense_line = "Squeak!!"
	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/obj/item/food/cheese = 10,
			/obj/item/food/grilled_cheese_sandwich = 8,
			/obj/item/food/burger/cheese = 5,
			/obj/item/food/cheese_sandwich = 4,
			/obj/item/food/cheesyfries = 4,
			/obj/item/food/cheese/wheel = 3,
		),
	)
	found_seat_lines = list(
		"I can't wait for some luxury cheese",
		"My wife left me",
		"How do you stay competetive with all these other cheese companies?",
		"How's the cheese going?",
		"Let's get that cheese rolling!",
	)
	cant_find_seat_lines = list(
		"Cheese?",
		"Squeak?",
		"Nowhere to go...",
		"What's taking so long?",
		"What wasted oppertunity.",
	)
	leave_mad_lines = list(
		"Where's the cheese...",
		"I hate this place!",
		"Where else is there to go...",
		"Back to the tunnels!",
		"You've just met your new worst enemy.",
	)
	leave_happy_lines = list(
		"Squeak!",
		"Finally!",
		"Back to digging tunnels!",
		"I will come back soon... real soon...",
	)
	wait_for_food_lines = list(
		"Cheese, my beloved...",
		"I hope it won't take too long.",
		"I have a ton of work ahead of me.",
		"...So that's why I'm banned from entering our mines again.",
		"Squeak..",
	)

/datum/customer_data/rat/get_overlays(mob/living/simple_animal/robot_customer/customer)
	var/list/underlays = list()
	var/mutable_appearance/lizard_clothes = mutable_appearance(icon = 'fulp_modules/features/prison/icons/bots.dmi', icon_state = "rat_british")
	lizard_clothes.appearance_flags = RESET_COLOR
	underlays += lizard_clothes
	return underlays
