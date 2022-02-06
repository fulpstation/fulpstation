/// Prisoner bot
/datum/customer_data/prisoner
	prefix_file = "fulp_modules/features/prison/prison_kitchen/prefixes/prisoner_prefix.txt"
	base_icon = "japanese"
	clothing_sets = list("iamnotreal")

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
			/obj/item/food/grilled_cheese_sandwich = 3,
			/obj/item/food/spaghetti/boiledspaghetti = 3,
			/obj/item/food/eggsausage = 3,
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
	var/mutable_appearance/prisoner_clothes = mutable_appearance(icon = 'fulp_modules/features/prison/icons/bots.dmi', icon_state = "prisoner_japanese")
	prisoner_clothes.appearance_flags = RESET_COLOR
	underlays += prisoner_clothes
	return underlays
