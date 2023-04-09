/datum/map_generator/cave_generator/icemoon
	weighted_open_turf_types = list(/turf/open/misc/asteroid/snow/icemoon = 19, /turf/open/misc/ice/icemoon = 1)
	weighted_closed_turf_types = list(/turf/closed/mineral/random/snow = 1)


	weighted_mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/wolf = 50, /obj/structure/spawner/ice_moon = 3, \
						  /mob/living/simple_animal/hostile/asteroid/polarbear = 30, /obj/structure/spawner/ice_moon/polarbear = 3, \
						  /mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow = 50, /mob/living/simple_animal/hostile/asteroid/goldgrub = 10, \
						  /mob/living/simple_animal/hostile/asteroid/lobstrosity = 15)
	weighted_flora_spawn_list = list(/obj/structure/flora/tree/pine/style_random = 2, /obj/structure/flora/rock/icy/style_random = 2, /obj/structure/flora/rock/pile/icy/style_random = 2, /obj/structure/flora/grass/both/style_random = 6, /obj/structure/flora/ash/chilly = 2)
	///Note that this spawn list is also in the lavaland generator
	weighted_feature_spawn_list = list(/obj/structure/geyser/wittel = 10, /obj/structure/geyser/random = 2, /obj/structure/geyser/plasma_oxide = 10, /obj/structure/geyser/protozine = 10, /obj/structure/geyser/hollowwater = 10)

/datum/map_generator/cave_generator/icemoon/surface
	flora_spawn_chance = 4
	weighted_mob_spawn_list = null
	initial_closed_chance = 53
	birth_limit = 5
	death_limit = 4
	smoothing_iterations = 10

/datum/map_generator/cave_generator/icemoon/surface/noruins //use this for when you don't want ruins to spawn in a certain area

/datum/map_generator/cave_generator/icemoon/deep
	weighted_closed_turf_types = list(/turf/closed/mineral/random/snow/underground = 1)
	weighted_mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/ice_demon = 100, /obj/structure/spawner/ice_moon/demonic_portal = 6, \
						  /mob/living/simple_animal/hostile/asteroid/ice_whelp = 60, /obj/structure/spawner/ice_moon/demonic_portal/ice_whelp = 6, \
						  /mob/living/simple_animal/hostile/asteroid/hivelord/legion/snow = 100, /obj/structure/spawner/ice_moon/demonic_portal/snowlegion = 6, \
						  SPAWN_MEGAFAUNA = 1)
	weighted_megafauna_spawn_list = list(/mob/living/simple_animal/hostile/megafauna/colossus = 1)
	weighted_flora_spawn_list = list(/obj/structure/flora/rock/icy/style_random = 6, /obj/structure/flora/rock/pile/icy/style_random = 6, /obj/structure/flora/ash/chilly = 1)
