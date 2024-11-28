/mob/living/basic/parrot/headsetted/turkey
	name = "\improper turkey"
	desc = "it's that time again."
	icon = 'fulp_modules/features/events/icons/event_icons.dmi'
	icon_state = "turkey_plain"
	icon_living = "turkey_plain"
	icon_dead = "turkey_plain_dead"
	speak = list("Gobble!","GOBBLE GOBBLE GOBBLE!","Cluck.")
	speak_emote = list("clucks","gobbles")
	emote_hear = list("gobbles.")
	emote_see = list("pecks at the ground.","flaps its wings viciously.")
	density = FALSE
	health = 50
	maxHealth = 50
	melee_damage_lower = 13
	melee_damage_upper = 15
	attack_verb_continuous = "pecks"
	attack_verb_simple = "peck"
	attack_sound = 'fulp_modules/sounds/misc/turkey.ogg'
	ventcrawler = VENTCRAWLER_ALWAYS
	icon_prefix = "turkey"
	feedMessages = list("It gobbles up the food voraciously.","It clucks happily.")
	validColors = list("plain")
	gold_core_spawnable = FRIENDLY_SPAWN
	chat_color = "#FFDC9B"

/obj/item/food/meat/slab/chicken/turkey
	name = "turkey meat"
	icon_state = "birdmeat"
	desc = "A slab of raw turkey. Remember to wash your hands!"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/inverse/healing/tirimol = 5)
	tastes = list("turkey" = 1)
	starting_reagent_purity = 1
