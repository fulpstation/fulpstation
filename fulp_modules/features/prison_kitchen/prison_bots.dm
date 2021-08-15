// In case you're confused - A lot of these lines came from Sec offiers/Prisoners from The Escapists.

/// Warden bot
/datum/customer_data/warden
	prefix_file = "fulp_modules/features/prison_kitchen/warden_prefix.txt"
	base_icon = "italian"
	clothing_sets = list("italian_pison", "italian_godfather")

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
			/obj/item/food/eggssausage = 3,
			/obj/item/food/hotdog = 3,
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
	var/mutable_appearance/warden_clothes = mutable_appearance(icon = 'fulp_modules/features/prison_kitchen/icons/bots.dmi', icon_state = "warden_italian")
	warden_clothes.appearance_flags = RESET_COLOR
	underlays += warden_clothes
	return underlays


/// Prisoner bot
/datum/customer_data/prisoner
	prefix_file = "fulp_modules/features/prison_kitchen/prisoner_prefix.txt"
	base_icon = "japanese"
	clothing_sets = list("japanese_salary")

	friendly_pull_line = "I'm starving, I don't want to go with you."
	first_warning_line = "Stop touching me, you'll regret it."
	second_warning_line = "Last chance dude, I'm a glass cannon!"
	self_defense_line = "Alright, you've asked for it! Violent Psychosis, headbutt!"
	orderable_objects = list(
		VENUE_RESTAURANT = list(
			/obj/item/food/friedegg = 6,
			/obj/item/food/bread/tofu = 5,
			/obj/item/food/soup/hotchili = 3,
			/obj/item/food/nugget = 4,
			/obj/item/food/soup/miso = 4,
			/obj/item/food/eggssausage = 3,
			/obj/item/food/grilled_cheese_sandwich = 3,
			/obj/item/food/spaghetti = 3,
			/obj/item/food/eggssausage = 3,
			/obj/item/food/burger/plain = 1,
		),
	)
	found_seat_lines = list(
		"Wow, this place looks way better than where I have to stay.",
		"This place looks amazing compared to the shithole I was stuck in.",
		"How on earth is this place so clean?",
		"This place looks fantastic, I wish I got put in here instead.",
		"You really have it lucky in here, don't you.",
		"Got enough respect for you.",
		"Wanna know how I got these scars?",
	)
	cant_find_seat_lines = list(
		"And... there's no seats available. Great.",
		"Wow, what a surprise, there's no place to sit.",
		"You know, you might think it's funny to not let us sit down, and actually yeah that's fair.",
		"Can I please just sit down already, I was forced to walk on the way here.",
	)
	leave_mad_lines = list(
		"And my time's up, without service. Fantastic...",
		"Yeah, screw this. I'd rather go back to eating rats.",
		"Wow, and I thought I was the worst criminal.",
		"Aint got time to chat.",
	)
	leave_happy_lines = list(
		"This food really makes me want to re-evaluate my life choices. Thank you for everything.",
		"Just like the outside world...",
		"This is great, I wish I could come here more often.",
		"I never knew how positive a prison can be, I wish to know more about this place when I get back to my cell.",
		"Just pretend it's good.",
		"Yo I'm still hungry, but whatever.",
		"You the man.",
		"We'll catch up later.",
	)
	wait_for_food_lines = list(
		"Last I ate was a dead rat... 3 days ago.",
		"You think food would be coming anytime soon? Not that I'm picky",
		"Hey asshole, if food doesn't come soon, I might have to start getting rowdy",
		"I hope the warden here isn't as tough as mine.",
		"I used to be a cab driver you know.",
		"There were only eight of them so I had to take them out.",
		"So my wife stopped ringing after she heard that.",
		"Ever thought about escaping?",
		"Turns out my bro was my sis.",
	)

/datum/customer_data/prisoner/get_overlays(mob/living/simple_animal/robot_customer/customer)
	var/list/underlays = list()
	var/mutable_appearance/prisoner_clothes = mutable_appearance(icon = 'fulp_modules/features/prison_kitchen/icons/bots.dmi', icon_state = "prisoner_japanese")
	prisoner_clothes.appearance_flags = RESET_COLOR
	underlays += prisoner_clothes
	return underlays


/// HoS bot
/datum/customer_data/head_of_sec
	prefix_file = "fulp_modules/features/prison_kitchen/hos_prefix.txt"
	base_icon = "british"
	clothing_sets = list("british_gentleman")
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
	var/mutable_appearance/warden_clothes = mutable_appearance(icon = 'fulp_modules/features/prison_kitchen/icons/bots.dmi', icon_state = "hos_british")
	warden_clothes.appearance_flags = RESET_COLOR
	underlays += warden_clothes
	return underlays
