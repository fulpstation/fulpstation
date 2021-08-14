/obj/effect/spawner/statue
	name = "random statue spawner"
	loot = list(
		/obj/structure/statue/gold/hop = 2,
		/obj/structure/statue/gold/rd = 2,
		/obj/structure/statue/diamond/captain = 1,
		/obj/structure/statue/diamond/ai1 = 2,
		/obj/structure/statue/elder_atmosian  = 1,,
		/obj/structure/statue/uranium/eng = 2,
		/obj/structure/statue/silver/janitor = 2,
		/obj/structure/statue/silver/sec = 2,
		/obj/structure/statue/silver/md = 2,
		/obj/structure/statue/sandstone/assistant = 2,
		/obj/structure/statue/petrified = 4,
		/mob/living/simple_animal/hostile/statue = 2
	)

/obj/effect/spawner/wall
	name = "secret passage spawner"
	loot = list(
		/turf/closed/wall = 99,
		/obj/structure/falsewall = 1,
	)

/mob/living/simple_animal/hostile/statue/weak
	maxHealth = 500
	health = 500
	healable = 0
	harm_intent_damage = 10
	obj_damage = 15
	melee_damage_lower = 68
	melee_damage_upper = 83
	search_objects = 0
