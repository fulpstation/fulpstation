/// Keyed list of preset sources to configuration instance
GLOBAL_LIST_INIT(preset_fish_sources,init_fishing_configurations())

/// These are shared between their spots
/proc/init_fishing_configurations()
	. = list()

	var/datum/fish_source/ocean/beach/beach_preset = new
	.[FISHING_SPOT_PRESET_BEACH] = beach_preset

	var/datum/fish_source/lavaland/lava_preset = new
	.[FISHING_SPOT_PRESET_LAVALAND_LAVA] = lava_preset

	var/datum/fish_source/chasm/chasm_preset = new
	.[FISHING_SPOT_PRESET_CHASM] = chasm_preset

/// Where the fish actually come from - every fishing spot has one assigned but multiple fishing holes can share single source, ie single shared one for ocean/lavaland river
/datum/fish_source
	/// Fish catch weight table - these are relative weights
	var/list/fish_table = list()
	/// If a key from fish_table is present here, that fish is availible in limited quantity and is reduced by one on successful fishing
	var/list/fish_counts = list()
	/// Text shown as baloon alert when you roll a dud in the table
	var/duds = list("it was nothing", "the hook is empty")
	/// Baseline difficulty for fishing in this spot
	var/fishing_difficulty = FISHING_DEFAULT_DIFFICULTY
	/// How the spot type is described in fish catalog section about fish sources, will be skipped if null
	var/catalog_description
	/// Background image name from /datum/asset/simple/fishing_minigame
	var/background = "fishing_background_default"

/// Can we fish in this spot at all. Returns DENIAL_REASON or null if we're good to go
/datum/fish_source/proc/reason_we_cant_fish(obj/item/fishing_rod/rod, mob/fisherman)
	return rod.reason_we_cant_fish(src)


/// DIFFICULTY = (SPOT_BASE_VALUE + FISH_MODIFIER + ROD_MODIFIER + FAV/DISLIKED_BAIT_MODIFIER + TRAITS_ADDITIVE) * TRAITS_MULTIPLICATIVE , For non-fish it's just SPOT_BASE_VALUE
/datum/fish_source/proc/calculate_difficulty(result, obj/item/fishing_rod/rod, mob/fisherman)
	. = fishing_difficulty

	if(!ispath(result,/obj/item/fish))
		// In the future non-fish rewards can have variable difficulty calculated here
		return

	var/list/fish_list_properties = collect_fish_properties()
	var/obj/item/fish/caught_fish = result
	// Baseline fish difficulty
	. += initial(caught_fish.fishing_difficulty_modifier)
	. += rod.difficulty_modifier

	if(rod.bait)
		var/obj/item/bait = rod.bait
		//Fav bait makes it easier
		var/list/fav_bait = fish_list_properties[caught_fish][NAMEOF(caught_fish, favorite_bait)]
		for(var/bait_identifer in fav_bait)
			if(is_matching_bait(bait, bait_identifer))
				. += FAV_BAIT_DIFFICULTY_MOD
				break
		//Disliked bait makes it harder
		var/list/disliked_bait = fish_list_properties[caught_fish][NAMEOF(caught_fish, disliked_bait)]
		for(var/bait_identifer in disliked_bait)
			if(is_matching_bait(bait, bait_identifer))
				. += DISLIKED_BAIT_DIFFICULTY_MOD
				break

	// Matching/not matching fish traits and equipment
	var/list/fish_traits = fish_list_properties[caught_fish][NAMEOF(caught_fish, fishing_traits)]

	var/additive_mod = 0
	var/multiplicative_mod = 1
	for(var/fish_trait in fish_traits)
		var/datum/fishing_trait/trait = new fish_trait
		var/list/mod = trait.difficulty_mod(rod, fisherman)
		additive_mod += mod[ADDITIVE_FISHING_MOD]
		multiplicative_mod *= mod[MULTIPLICATIVE_FISHING_MOD]

	. += additive_mod
	. *= multiplicative_mod

/// In case you want more complex rules for specific spots
/datum/fish_source/proc/roll_reward(obj/item/fishing_rod/rod, mob/fisherman)
	return pick_weight(get_modified_fish_table(rod,fisherman))

/// Gives out the reward if possible
/datum/fish_source/proc/dispense_reward(reward_path, mob/fisherman)
	if((reward_path in fish_counts)) // This is limited count result
		if(fish_counts[reward_path] > 0)
			fish_counts[reward_path] -= 1
		else
			reward_path = FISHING_DUD //Ran out of these since rolling (multiple fishermen on same source most likely)
	if(ispath(reward_path))
		if(ispath(reward_path,/obj/item))
			var/obj/item/reward = new reward_path(get_turf(fisherman))
			if(ispath(reward_path,/obj/item/fish))
				var/obj/item/fish/caught_fish = reward
				caught_fish.randomize_weight_and_size()
				//fish caught signal if needed goes here and/or fishing achievements
			//Try to put it in hand
			fisherman.put_in_hands(reward)
			fisherman.balloon_alert(fisherman, "caught [reward]!")
		else //If someone adds fishing out carp/chests/singularities or whatever just plop it down on the fisher's turf
			fisherman.balloon_alert(fisherman, "caught something!")
			new reward_path(get_turf(fisherman))
	else if (reward_path == FISHING_DUD)
		//baloon alert instead
		fisherman.balloon_alert(fisherman,pick(duds))

/// Cached fish list properties so we don't have to initalize fish every time, init deffered
GLOBAL_LIST(fishing_property_cache)

/// Awful workaround around initial(x.list_variable) not being a thing while trying to keep some semblance of being structured
/proc/collect_fish_properties()
	if(GLOB.fishing_property_cache == null)
		var/list/fish_property_table = list()
		for(var/fish_type in subtypesof(/obj/item/fish))
			var/obj/item/fish/fish = new fish_type(null)
			fish_property_table[fish_type] = list()
			fish_property_table[fish_type][NAMEOF(fish, favorite_bait)] = fish.favorite_bait.Copy()
			fish_property_table[fish_type][NAMEOF(fish, disliked_bait)] = fish.disliked_bait.Copy()
			fish_property_table[fish_type][NAMEOF(fish, fishing_traits)] = fish.fishing_traits.Copy()
			QDEL_NULL(fish)
		GLOB.fishing_property_cache = fish_property_table
	return GLOB.fishing_property_cache

/// Checks if bait matches identifier from fav/disliked bait list
/datum/fish_source/proc/is_matching_bait(obj/item/bait, identifier)
	if(ispath(identifier)) //Just a path
		return istype(bait, identifier)
	if(islist(identifier))
		var/list/special_identifier = identifier
		switch(special_identifier["Type"])
			if("Foodtype")
				var/obj/item/food/food_bait = bait
				return istype(food_bait) && food_bait.foodtypes & special_identifier["Value"]
			else
				CRASH("Unknown bait identifier in fish favourite/disliked list")
	else
		return HAS_TRAIT(bait, identifier)

/// Builds a fish weights table modified by bait/rod/user properties
/datum/fish_source/proc/get_modified_fish_table(obj/item/fishing_rod/rod, mob/fisherman)
	var/obj/item/bait = rod.bait

	var/list/fish_list_properties = collect_fish_properties()

	var/list/final_table = fish_table.Copy()
	for(var/result in final_table)
		if((result in fish_counts) && fish_counts[result] <= 0) //ran out of these, ignore
			final_table -= result
			continue

		final_table[result] *= rod.multiplicative_fish_bonus(result, src)
		final_table[result] += rod.additive_fish_bonus(result, src) //Decide on order here so it can be multiplicative
		if(result == FISHING_DUD)
			//Modify dud result
			//Bait quality reduces dud chance heavily.
			if(bait)
				if(HAS_TRAIT(bait, GREAT_QUALITY_BAIT_TRAIT))
					final_table[result] *= 0.1
				else if(HAS_TRAIT(bait, GOOD_QUALITY_BAIT_TRAIT))
					final_table[result] *= 0.3
				else if(HAS_TRAIT(bait, BASIC_QUALITY_BAIT_TRAIT))
					final_table[result] *= 0.5
			else
				final_table[result] *= 10 //Fishing without bait is not going to be easy
		else if(ispath(result, /obj/item/fish))
			//Modify fish roll chance
			var/obj/item/fish/caught_fish = result

			if(bait)
				//Bait matching likes doubles the chance
				var/list/fav_bait = fish_list_properties[result][NAMEOF(caught_fish, favorite_bait)]
				for(var/bait_identifer in fav_bait)
					if(is_matching_bait(bait, bait_identifer))
						final_table[result] *= 2
						break // could compound possibly
				//Bait matching dislikes
				var/list/disliked_bait = fish_list_properties[result][NAMEOF(caught_fish, disliked_bait)]
				for(var/bait_identifer in disliked_bait)
					if(is_matching_bait(bait, bait_identifer))
						final_table[result] *= 0.5
						break // same question as above

			// Apply fishing trait modifiers
			var/list/fish_traits = fish_list_properties[caught_fish][NAMEOF(caught_fish, fishing_traits)]
			var/additive_mod = 0
			var/multiplicative_mod = 1
			for(var/fish_trait in fish_traits)
				var/datum/fishing_trait/trait = new fish_trait
				var/list/mod = trait.catch_weight_mod(rod, fisherman)
				additive_mod += mod[ADDITIVE_FISHING_MOD]
				multiplicative_mod *= mod[MULTIPLICATIVE_FISHING_MOD]

			final_table[result] += additive_mod
			final_table[result] *= multiplicative_mod

		if(final_table[result] <= 0)
			final_table -= result
	return final_table
