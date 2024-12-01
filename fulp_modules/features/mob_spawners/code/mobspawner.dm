/obj/effect/spawner/random_mob
	icon = 'fulp_modules/icons/mob_spawners/landmark_static.dmi'
	icon_state = "exclamation"
	name = "custom mob spawner"
	//valid_mobs is a list of paths with lists
	//each path's list MUST have 3 numbers
	//pick_weight, min spawn, max spawn
	var/list/valid_mobs

/obj/effect/spawner/random_mob/Initialize(mapload)
	..()
	if(valid_mobs?.len)
		var/mobspawndata = pick_random_item_and_count(valid_mobs)
		if(mobspawndata)
			var/mobX = mobspawndata[1]
			for(var/i = 0, i < mobspawndata[2], i++)
				new mobX(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/random_mob/maintenance
	name = "maintenance mob spawner"
	valid_mobs = list(
			/mob/living/basic/viscerator = list(1,2,4),
			/mob/living/basic/cow = list(1,1,2),
			/mob/living/basic/hivebot = list(1,1,3),
			/mob/living/basic/skeleton = list(1,1,2),
			/mob/living/basic/bot/medbot = list(1,1,1),
			/mob/living/basic/crab = list(1,1,3),
			/mob/living/basic/mouse/rat = list(1,1,2),
		)

/obj/effect/spawner/random_mob/maintenance/hostile
	name = "hostile maintenance mob spawner"
	icon_state = "black_exclamation"
	valid_mobs = list(
			/mob/living/basic/viscerator = list(1,2,4),
			/mob/living/basic/hivebot = list(1,1,3),
			/mob/living/basic/skeleton = list(1,1,2),
			/mob/living/basic/spider/giant/hunter/scrawny = list(1,2,2),
			/mob/living/basic/spider/giant/tarantula/scrawny = list(1,1,1),
			/mob/living/basic/bear = list(1,1,1),
		)

///  code/__HELPERS/_lists.dm ///
///This version only works with associated lists where the value is a list containing 3 ints - pick_weight, min, and max. Returns list (array) where 1 is path and 2 is num
/proc/pick_random_item_and_count(list/random_stuff)
	var/total = 0
	var/item
	for(item in random_stuff)
		world << random_stuff[item]
		world << random_stuff[item][1]
		if(!random_stuff[item][1])
			random_stuff[item][1] = 1
		total += random_stuff[item][1]
	total = rand(1, total)
	for(item in random_stuff)
		total -= random_stuff[item][1]
		if(total <= 0)
			var/randx = rand(random_stuff[item][2], random_stuff[item][3])
			return list(item,randx)
	return null
