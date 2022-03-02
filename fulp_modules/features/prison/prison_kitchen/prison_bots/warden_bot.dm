// Warden bot
/datum/customer_data/warden
	prefix_file = "fulp_modules/features/prison/prison_kitchen/prefixes/warden_prefix.txt"
	base_icon = "italian"
	// We set a non-existant icon_state because TG's code REQUIRES we have one, but we set one ourselves later.
	clothing_sets = list("iamnotreal")

	friendly_pull_line = "Hey, don't touch me, asshole!"
	first_warning_line = "Let me go, I have a laser gun, and I'm not afraid to open fire blindly!"
	second_warning_line = "Final warning, I'm trained in the arts of Krav Maga!"
	self_defense_line = "That's it! The harmbaton for you!"
	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/obj/item/food/donut/plain = 8,
			/obj/item/food/poutine = 6,
			/obj/item/food/pie/applepie = 4,
			/obj/item/food/burger/cheese = 4,
			/obj/item/food/eggsausage = 3,
			/obj/item/food/nachos = 3,
			/obj/item/food/soup/hotchili = 2,

		),
	)
	found_seat_lines = list(
		"This perma seems cleaner than the one I worked at.",
		"I hope the prisoners here know how to behave themselves.",
		"It's amazing what happens when Nanotrasen actually cares.",
		"I wish I was assigned at this station instead.",
		"This place seems great so far, I'm wonderfully impressed.",
		"I can't wait to see how the service here turns out.",
		"Your wife's told me all about you.",
		"Get the kettle on.",
		"Take a bow.",
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
		"This is why you've been locked up permanently.",
		"I've places to be.",
		"I dont wish to hear it.",
		"Last time your mouth was opened, it got slapped.",
	)
	leave_happy_lines = list(
		"You know, maybe prisoners aren't bad afterall.",
		"This has been great, I hope my brig gets the same treatment one day.",
		"This place realy is something new. I'd love to see you once you've completed your sentence.",
		"I hope you're sent to my brig next time you're arrested.",
		"I don't go for the face.",
		"Taking your wife out to dinner tomorrow.",
	)
	wait_for_food_lines = list(
		"Food's been taking a while...",
		"I wonder how long it'll take for the actual food to get here.",
		"I hope they aren't poisoning my food, my prisoners have tried that on me enough times already.",
		"So many assistants are being left un-harmbatoned for this food to take its sweet time!",
		"You're delaying me.",
		"You can be quite boring.",
	)

/datum/customer_data/warden/get_overlays(mob/living/simple_animal/robot_customer/customer)
	var/list/underlays = list()
	var/mutable_appearance/warden_clothes = mutable_appearance(icon = 'fulp_modules/features/prison/icons/bots.dmi', icon_state = "warden_italian")
	warden_clothes.appearance_flags = RESET_COLOR
	underlays += warden_clothes
	return underlays
