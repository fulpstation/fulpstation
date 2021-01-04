// Created by claiming a Coffin.



// 		THINGS TO SPAWN:
//
//	/obj/effect/decal/cleanable/cobweb && /obj/effect/decal/cleanable/cobweb/cobweb2
//	/obj/effect/decal/cleanable/generic
//	/obj/effect/decal/cleanable/dirt/dust <-- Pretty cool, just stains the tile itself.
//	/obj/effect/decal/cleanable/blood/old

/*
/area/
	// All coffins assigned to this area
	var/list/obj/structure/closet/crate/laircoffins = new list()

// Called by Coffin when an area is claimed as a vamp's lair
/area/proc/ClaimAsLair(/obj/structure/closet/crate/inClaimant)
	set waitfor = FALSE // Don't make on_gain() wait for this function to finish. This lets this code run on the side.

	laircoffins += laircoffins
	sleep()

	// Cancel!
	if (laircoffins.len == 0)
		return
		*/

/datum/antagonist/bloodsucker/proc/RunLair()
	set waitfor = FALSE // Don't make on_gain() wait for this function to finish. This lets this code run on the side.
	while(!AmFinalDeath() && coffin && lair)
		// WAit 2 min and Repeat
		sleep(120)
		// Coffin Moved SOMEHOW?
		if(lair != get_area(coffin))
			if(coffin)
				coffin.UnclaimCoffin()
			//lair = get_area(coffin)
			break // DONE
		var/list/turf/area_turfs = get_area_turfs(lair)
		// Create Dirt etc.
		var/turf/T_Dirty = pick(area_turfs)
		if(T_Dirty && !T_Dirty.density)
			// Default: Dirt
			// CHECK: Cobweb already there?
			//if (!locate(var/obj/effect/decal/cleanable/cobweb) in T_Dirty)	// REMOVED! Cleanables don't stack.
			// STEP ONE: COBWEBS
			// CHECK: Wall to North?
			var/turf/check_N = get_step(T_Dirty, NORTH)
			if(istype(check_N, /turf/closed/wall))
				// CHECK: Wall to West?
				var/turf/check_W = get_step(T_Dirty, WEST)
				if(istype(check_W, /turf/closed/wall))
					new /obj/effect/decal/cleanable/cobweb (T_Dirty)
				// CHECK: Wall to East?
				var/turf/check_E = get_step(T_Dirty, EAST)
				if(istype(check_E, /turf/closed/wall))
					new /obj/effect/decal/cleanable/cobweb/cobweb2 (T_Dirty)
			// STEP TWO: DIRT
			new /obj/effect/decal/cleanable/dirt (T_Dirty)
		// Find Animals in Area
	/*	if(rand(0,2) == 0)
			var/mobCount = 0
			var/mobMax = clamp(area_turfs.len / 25, 1, 4)
			for (var/turf/T in area_turfs)
				if(!T) continue
				var/mob/living/simple_animal/SA = locate() in T
				if(SA)
					mobCount ++
					if (mobCount >= mobMax) // Already at max
						break
			 Spawn One
			if(mobCount < mobMax)
				 Seek Out Location
				while(area_turfs.len > 0)
					var/turf/T = pick(area_turfs) // We use while&pick instead of a for/loop so it's random, rather than from the top of the list.
					if(T && !T.density)
						var/mob/living/simple_animal/SA = /mob/living/simple_animal/mouse // pick(/mob/living/simple_animal/mouse,/mob/living/simple_animal/mouse,/mob/living/simple_animal/mouse, /mob/living/simple_animal/hostile/retaliate/bat) //prob(300) /mob/living/simple_animal/mouse,
						new SA (T)
						break
					area_turfs -= T*/
		// NOTE: area_turfs is now cleared out!
	if(coffin)
		coffin.UnclaimCoffin()
	// Done (somehow)
	lair = null

//Start of Boodsucker construction recipes

/datum/crafting_recipe/bloodsucker/blackcoffin
	name = "Black Coffin"
	result = /obj/structure/closet/crate/coffin/blackcoffin
	tools = list(/obj/item/weldingtool,
				 /obj/item/screwdriver)
	reqs = list(/obj/item/stack/sheet/cloth = 1,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/sheet/metal = 1)
				///obj/item/stack/packageWrap = 8,
				///obj/item/pipe = 2)
	time = 150
	category = CAT_MISC
	always_availible = TRUE

/datum/crafting_recipe/bloodsucker/meatcoffin
	name = "Meat Coffin"
	result =/obj/structure/closet/crate/coffin/meatcoffin
	tools = list(/obj/item/kitchen/knife,
				 /obj/item/kitchen/rollingpin)
	reqs = list(/obj/item/reagent_containers/food/snacks/meat/slab = 5,
				/obj/item/restraints/handcuffs/cable = 1)
	time = 150
	category = CAT_MISC
	always_availible = TRUE

/datum/crafting_recipe/bloodsucker/metalcoffin
	name = "Metal Coffin"
	result =/obj/structure/closet/crate/coffin/metalcoffin
	tools = list(/obj/item/weldingtool,
				 /obj/item/screwdriver)
	reqs = list(/obj/item/stack/sheet/metal = 5)
	time = 100
	category = CAT_MISC
	always_availible = TRUE

/datum/crafting_recipe/bloodsucker/vassalrack
	name = "Persuasion Rack"
	//desc = "For converting crewmembers into loyal Vassals."
	result = /obj/structure/bloodsucker/vassalrack
	tools = list(/obj/item/weldingtool,
				 	//obj/item/screwdriver,
					/obj/item/wrench
					 )
	reqs = list(/obj/item/stack/sheet/mineral/wood = 3,
				/obj/item/stack/sheet/metal = 2,
				/obj/item/restraints/handcuffs/cable = 2,
				//obj/item/storage/belt = 1,
				//obj/item/stack/sheet/animalhide = 1,
				//obj/item/stack/sheet/leather = 1,
				//obj/item/stack/sheet/plasteel = 5
				)
		//parts = list(/obj/item/storage/belt = 1
		//			 )
	time = 150
	category = CAT_MISC
	always_availible = FALSE	// Disabled until learned


/datum/crafting_recipe/bloodsucker/candelabrum
	name = "Candelabrum"
	//desc = "For converting crewmembers into loyal Vassals."
	result = /obj/structure/bloodsucker/candelabrum
	tools = list(/obj/item/weldingtool,
				 /obj/item/wrench
				)
	reqs = list(/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/rods = 1,
				/obj/item/candle = 1
				)
	time = 100
	category = CAT_MISC
	always_availible = FALSE	// Disabled til learned
	//End of Boodsucker construction recipes
