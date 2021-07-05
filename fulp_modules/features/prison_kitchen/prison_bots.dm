/datum/customer_data/warden
	prefix_file = "fulp_modules/features/prison_kitchen/warden_prefix.txt"
	base_icon = "italian"
	clothing_sets = list("italian_pison", "italian_godfather")

	found_seat_lines = list(
		"This perma seems cleaner than the one I worked at.",
		"I hope the prisoners here know how to behave themselves.",
		"It's amazing what happens when Nanotrasen actually cares.",
		"I wish I was assigned at this station instead.",
		"This place seems great so far, I'm wonderfully impressed.",
	)
	cant_find_seat_lines = list(
		"Seriously? There's no available seats?",
		"I guess I shouldn't have been too surprised.",
		"Expecting good service out of prisoners was stupid on my part.",
		"Are seats really that hard to get in prisons? I wouldn't know.",
		"How crowded is this place to not have any seats available?",
	)
	leave_mad_lines = list(
		"I am over my break limit, I should be heading off now!",
		"Actually, it's been years since I last checked in on MY prisoners, I should go check in on them.",
		"This prison is too horrifying for me to stay in any longer, I stay in prisons long enough anyways.",
		"I'll be heading out before someone recognizes me here.",
		"The warden here should be ashamed of what's been happening back there!",
	)
	leave_happy_lines = list(
		"You know, maybe prisoners aren't bad afterall.",
		"This has been great, I hope my brig gets the same treatment one day.",
		"This place realy is something new. I'd love to see you once you've completed your sentence.",
	)
	wait_for_food_lines = list(
		"Food's been taking a while...",
		"I wonder how long it'll take for the actual food to get here.",
		"I hope they aren't poisoning my food, my prisoners have tried that on me enough times already.",
	)
	friendly_pull_line = "Hey, don't touch me!"
	first_warning_line = "Let me go, asshole!"
	second_warning_line = "Final warning, I'm trained in the arts of Krav Maga!"
	self_defense_line = "That's it! The harmbaton for you!"
	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/obj/item/food/donut = 5,
/*
			/obj/item/food/spaghetti/pastatomato = 20,
			/obj/item/food/spaghetti/copypasta = 6,
			/obj/item/food/spaghetti/meatballspaghetti = 4,
			/obj/item/food/spaghetti/butternoodles = 4,
			/obj/item/food/pizza/vegetable = 2,
			/obj/item/food/pizza/mushroom = 2,
			/obj/item/food/pizza/meat = 2,
			/obj/item/food/pizza/margherita = 2,
			/obj/item/food/lasagna = 4,
			/obj/item/food/cannoli = 3,
			/obj/item/food/salad/risotto =5,
			/obj/item/food/eggplantparm = 3,
			/obj/item/food/cornuto = 2,
*/
		),
	)

/datum/customer_data/proc/get_overlays(mob/living/simple_animal/robot_customer/customer)
	var/list/underlays = list()
	var/mutable_appearance/warden_clothes = mutable_appearance(icon = 'fulp_modules/features/prison_kitchen/icons/warden_bot.dmi', icon_state = "italian_warden")
	warden_clothes.appearance_flags = RESET_COLOR
	underlays += warden_clothes
	return underlays


/datum/customer_data/prisoner
	prefix_file = "fulp_modules/features/prison_kitchen/prisoner_prefix.txt"
	base_icon = "japanese"
	clothing_sets = list("japanese_animes")

	found_seat_lines = list("What a wonderful place to sit.", "I hope they serve it like-a my momma used to make it.")
	cant_find_seat_lines = list("Mamma mia! I just want a seat!", "Why-a you making me stand here?")
	leave_mad_lines = list("I have-a not seen-a this much disrespect in years!", "What-a horrendous establishment!")
	leave_happy_lines = list("That's amoreee!", "Just like momma used to make it!")
	wait_for_food_lines = list("I'ma so hungry...")
	friendly_pull_line = "No-a I'm a hungry! I don't want to go anywhere."
	first_warning_line = "Do not-a touch me!"
	second_warning_line = "Last warning! Do not touch my spaghet."
	self_defense_line = "I'm going to knead you like mama kneaded her delicious meatballs!"
	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/obj/item/food/spaghetti/pastatomato = 20,
			/obj/item/food/spaghetti/copypasta = 6,
			/obj/item/food/spaghetti/meatballspaghetti = 4,
			/obj/item/food/spaghetti/butternoodles = 4,
			/obj/item/food/pizza/vegetable = 2,
			/obj/item/food/pizza/mushroom = 2,
			/obj/item/food/pizza/meat = 2,
			/obj/item/food/pizza/margherita = 2,
			/obj/item/food/lasagna = 4,
			/obj/item/food/cannoli = 3,
			/obj/item/food/salad/risotto =5,
			/obj/item/food/eggplantparm = 3,
			/obj/item/food/cornuto = 2,
		),
	)

/datum/customer_data/prisoner/get_overlays(mob/living/simple_animal/robot_customer/customer)
	var/list/underlays = list()

	var/mutable_appearance/prisoner_clothes = mutable_appearance(icon = 'fulp_modules/features/prison_kitchen/icons/prisoner_bot.dmi', icon_state = "japanese_perma")
	prisoner_clothes.appearance_flags = RESET_COLOR
	underlays += prisoner_clothes
	return underlays
