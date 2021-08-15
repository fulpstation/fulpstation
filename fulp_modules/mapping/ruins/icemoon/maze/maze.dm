/obj/effect/spawner/lootdrop/statue
	name = "random statue spawner"
	loot = list(
		/obj/structure/statue/gold/hop = 2,
		/obj/structure/statue/gold/rd = 2,
		/obj/structure/statue/diamond/captain = 1,
		/obj/structure/statue/diamond/ai1 = 2,
		/obj/structure/statue/elder_atmosian  = 1,,
		/obj/structure/statue/uranium/eng = 1,
		/obj/structure/statue/silver/janitor = 2,
		/obj/structure/statue/silver/sec = 2,
		/obj/structure/statue/silver/md = 2,
		/obj/structure/statue/sandstone/assistant = 2,
		/obj/structure/statue/petrified = 5,
		/mob/living/simple_animal/hostile/statue/weak = 2
	)

/obj/effect/spawner/lootdrop/wall
	name = "secret passage spawner"
	loot = list(
		/turf/closed/wall = 24,
		/obj/structure/falsewall = 1,
	)

/mob/living/simple_animal/hostile/statue/weak
	maxHealth = 1000
	health = 1000
	healable = 0
	harm_intent_damage = 10
	obj_damage = 15
	melee_damage_lower = 68
	melee_damage_upper = 83
	search_objects = 0
	faction = list("statue", "spiders")

/obj/effect/mob_spawn/human/ethereal/museum_refugee
	death = FALSE
	roundstart = FALSE
	random = TRUE
	mob_name = "Museum refugee"
	mob_species = /datum/species/ethereal
	mob_type = /mob/living/carbon/human/species/ethereal
	name = "Whatever the etheral planet is refugee"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	short_desc = "You are a refugee from Sprout, the home planet of ethereals."
	flavour_text = "After years of civil war, you and your fellow musician-caste ethereal decided to flee your home planet. Your cryo pods have landed in a long-abandoned museum on ice moon. While your new home has everything you need, the creaks and thuds in the halls make you wonder how abandoned it truly is."

/datum/map_template/ruin/space/beef_station
	name = "Maze Museum"
	id = "Maze Museum"
	description = "I'll do this part later"
	suffix = "maze_museum.dmm"

/datum/map_template/ruin/icemoon/maze_museum
	name = "Maze Museum"
	id = "Maze Museum"
	description = "An art spawner for etherals"
	suffix = "icemoon_underground_maze_museum.dmm"

/area/ruin/powered/ethereal_maze
	name = "Museum"
	icon_state = "dk_yellow"


