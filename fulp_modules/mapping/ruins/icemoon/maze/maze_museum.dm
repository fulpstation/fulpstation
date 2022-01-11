/datum/map_template/ruin/icemoon/underground/fulp/maze_museum
	name = "Ethereal Maze Museum"
	id = "maze museum"
	description = "An 'abandoned' museum."
	suffix = "maze_museum.dmm"

/obj/effect/mob_spawn/ghost_role/human/ethereal
	name = "Sprout Planet Refugee"
	desc = "A cryogenics pod, storing meat for future consumption."
	prompt_name = "a Sproutian artist"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/ethereal
	you_are_text = "You are an artist-caste refugee from the planet Sprout."
	flavour_text = "Due to the ongoing civil war on your home planet, Sprout, you and your fellow refugee have fled your home. \
	Luckily, you were able to find safety in an abandoned museum. Create art and try to build your new home, but be warned, sometimes it feels like the statues in the back are watching you."
	important_text = "Make art and upload it to the database in peace!"
	outfit = /datum/outfit/ethereal_maze
	spawner_job_path = /datum/job/fulp_museum

/datum/outfit/ethereal_maze
	name = "Ethereal Museum Curator"
	uniform = /obj/item/clothing/under/misc/durathread/ethereal
	suit =  /obj/item/clothing/suit/changshan_blue/ethereal
	shoes = /obj/item/clothing/shoes/sandal
	back = /obj/item/storage/backpack
	box = /obj/item/storage/box/survival

/obj/item/clothing/under/misc/durathread/ethereal
	alpha = 50

/obj/item/clothing/suit/changshan_blue/ethereal
	alpha = 150

/obj/effect/spawner/random/wall
	name = "False Wall Spawner"
	loot = list(
		/obj/structure/falsewall = 1,
		/turf/closed/wall = 5,
	)

/obj/effect/spawner/random/decoration/statue/museum
	name = "statue spawner"
	icon_state = "statue"
	loot = list(

		/mob/living/simple_animal/hostile/statue/maze_museum = 2,
		/obj/structure/statue/sandstone/assistant = 1,
		/obj/structure/statue/silver/md = 1,
		/obj/structure/statue/silver/janitor = 1,
		/obj/structure/statue/silver/sec = 1,
		/obj/structure/statue/silver/secborg = 1,
		/obj/structure/statue/gold/hos = 1,
		/obj/structure/statue/gold/hop = 1,
		/obj/structure/statue/gold/cmo = 1,
		/obj/structure/statue/gold/ce = 1,
		/obj/structure/statue/gold/rd = 1,
		/obj/structure/statue/bronze/marx = 1,
		/obj/structure/statue/bananium/clown = 1,
		/obj/structure/statue/diamond/captain = 1,
	)

/mob/living/simple_animal/hostile/statue/maze_museum
	obj_damage = 0
	maxHealth = 500
	health = 500