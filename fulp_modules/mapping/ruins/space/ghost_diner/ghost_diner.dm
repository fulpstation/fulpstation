/datum/map_template/ruin/space/fulp/ghost_diner
	name = "Space-Ruin Staffed All-American Diner"
	id = "ghost diner"
	description = "A fully staffed american diner, floating in the void of space."
	suffix = "allamericandiner_openforbusiness.dmm"

/datum/job/fulp_ghostchef
	title = ROLE_GHOST_CHEF

/datum/job/fulp_ghostcook
	title = ROLE_GHOST_COOK

/datum/job/fulp_ghostregular
	title = ROLE_GHOST_REGULAR

/datum/component/stationstuck/diner
	punishment = PIZZAFICATION

// Copied over from "/datum/smite/objectify/effect()"
// in 'code\modules\admin\smites\become_object.dm'
/datum/component/stationstuck/diner/punish()
	if(punishment != PIZZAFICATION)
		return ..()

	// We're turning them into a Hawaiian pizza for extra shock value.
	var/atom/transform_path = /obj/item/food/pizza/pineapple
	var/mutable_appearance/pizzafied_player = mutable_appearance(initial(transform_path.icon), initial(transform_path.icon_state))
	pizzafied_player.pixel_x = initial(transform_path.pixel_x)
	pizzafied_player.pixel_y = initial(transform_path.pixel_y)
	var/mutable_appearance/transform_scanline = mutable_appearance('icons/effects/effects.dmi', "transform_effect")
	var/mob/living/future_pizza = parent
	future_pizza.transformation_animation(pizzafied_player, 5 SECONDS, transform_scanline.appearance)
	future_pizza.Immobilize(5 SECONDS, ignore_canstun = TRUE)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(objectify), future_pizza, transform_path), 5 SECONDS)

/obj/effect/mob_spawn/ghost_role/human/allamerican
	prompt_name = "A real american"
	you_are_text = "A real american, fight for the rights of every man!"
	flavour_text = "Fight what's right, fight for your life!"

// (Implementation of the stationstuck component has been copied over from
// 'fulp_modules\mapping\ruins\space\syndicate_engineer\syndicate_engineer.dm')
/obj/effect/mob_spawn/ghost_role/human/all_american/special(mob/living/new_spawn)
	. = ..()
	to_chat(new_spawn, "<b>You have been implanted with a pizzafication implant that will activate if you stray too far from the diner. Glory to Nanotrasen.</b>")
	new_spawn.AddComponent(/datum/component/stationstuck/diner, PIZZAFICATION, "You have left the vicinity of the diner. Your pizzafication implant has been triggered.")

/obj/effect/mob_spawn/ghost_role/human/allamerican/chef
	name = "All-American Chef"
	desc = "A cryogenics pod, storing a trained chef to prepare meals when activity is detected in this sector."
	prompt_name = "an all american chef"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "You are a head chef employed by the All American foods company."
	flavour_text = "After a recent accquistion by Nanotrasen, you've been reassigned. \
	Lead the kitchen and ensure your cook has direction. Create culinary masterpieces."
	important_text = "Do not abandon the kitchen! Lead with grace."
	spawner_job_path = /datum/job/fulp_ghostchef
	outfit = /datum/outfit/fulp_ghostchef

/obj/effect/mob_spawn/ghost_role/human/allamerican/cook
	name = "All-American Cook"
	desc = "A cryogenics pod, storing a trained(?) cook to assist when activity is detected in this sector."
	prompt_name = "an all american cook"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "You are a line cook employed by the All American foods company."
	flavour_text = "After a recent accquistion by Nanotrasen, you've been reassigned. \
	Follow the chef's direction. Do menial tasks. Clean up after the recent Flyperson birthday bash."
	important_text = "Yes chef! You answer directly to the chef."
	spawner_job_path = /datum/job/fulp_ghostcook
	outfit = /datum/outfit/fulp_ghostcook

/obj/effect/mob_spawn/ghost_role/human/allamerican/regular
	name = "All-American Regular"
	desc = "A cryogenics pod, storing a regular customer of the diner. They seem to be sleeping off a serious food coma."
	prompt_name = "an all american customer"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "You are a lover of fine dining."
	flavour_text = "After realizing you could claim to be a health inspector (and recieve free meals) \
	you began a journey across the Spinward sector (on a quest for free meals). As an ironic punishment \
	for impersonating a food safety official, you are now unwillingly imprisoned on a space diner."
	important_text = "Don't get yourself kicked out: you'll turn into a pizza!"
	spawner_job_path = /datum/job/fulp_ghostregular
	outfit = /datum/outfit/fulp_ghostregular

/datum/outfit/fulp_ghostchef
	name = "All-American Chef"
	uniform = /obj/item/clothing/under/misc/patriotsuit
	suit = /obj/item/clothing/suit/toggle/chef
	head = /obj/item/clothing/head/utility/chefhat
	shoes = /obj/item/clothing/shoes/sneakers/black
	id = /obj/item/card/id
	id_trim = /datum/id_trim/job/cook/chef

/datum/outfit/fulp_ghostcook
	name = "All-American Cook"
	uniform = /obj/item/clothing/under/misc/patriotsuit
	suit = /obj/item/clothing/suit/apron/chef
	head = /obj/item/clothing/head/soft/mime
	shoes = /obj/item/clothing/shoes/sneakers/black
	id = /obj/item/card/id
	id_trim = /datum/id_trim/job/cook

/datum/outfit/fulp_ghostregular
	name = "Diner Regular"
	uniform = /obj/item/clothing/under/suit/black
	shoes = /obj/item/clothing/shoes/laceup
	r_hand = /obj/item/storage/briefcase

