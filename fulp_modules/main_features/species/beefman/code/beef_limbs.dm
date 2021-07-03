/obj/item/bodypart
	var/obj/item/food/meat/slab/myMeatType // For remembering what kind of meat this was made of. Default is base meat slab.
	var/amCondemned = FALSE // I'm about to be destroyed. Don't add blood to me, and throw null error crap next tick.
	var/meat_on_drop = FALSE

/obj/item/bodypart/drop_limb(special)
	var/mob/owner_cache = owner
	. = ..()
	if(meat_on_drop)
		return drop_meat(owner_cache)


/obj/item/bodypart/add_mob_blood(mob/living/M) // Cancel adding blood if I'm deletin (throws errors)
	if (!amCondemned)
		..()

/mob/living/carbon
	// Type References for Bodyparts
	var/obj/item/bodypart/head/part_default_head = /obj/item/bodypart/head
	var/obj/item/bodypart/chest/part_default_chest = /obj/item/bodypart/chest
	var/obj/item/bodypart/l_arm/part_default_l_arm = /obj/item/bodypart/l_arm
	var/obj/item/bodypart/r_arm/part_default_r_arm = /obj/item/bodypart/r_arm
	var/obj/item/bodypart/l_leg/part_default_l_leg = /obj/item/bodypart/l_leg
	var/obj/item/bodypart/r_leg/part_default_r_leg = /obj/item/bodypart/r_leg


		// MEAT-TO-LIMB
		// 1) Save Meat's type
		// 2) Get all original Reagent TYPES from "list_reagents" on the meat itself - these reagents (TYPEPATHS) have the starter values. Save those values.
		// 3) Sort through thisMeat.reagents.reagent_list, which has ALL CURRENT reagents (ACTUAL DATUMS) inside the meat. Add up all those values.
		// 3) Percent = Compare the STARTER VALUES in list_reagents against the CURRENT VALUES in thisMeat.reagents.reagent_list/
		// 4) Inject ALL OTHER CHEMS into bloodstream

		// LIMB-TO-MEAT
		// 1) Create new meat
		// 2) Sort through all reagent datums in newMeat.list_reagents and adjust each version in newMeat.reagents.reagent_list/(REAGENT)/.volume
		// 3) Apply a small part of my body's metabolic reagents to the meat. Check how Feed does this.

// Meat has been assigned to this NEW limb! Give it meat and damage me as needed.

/obj/item/bodypart/proc/give_meat(mob/living/carbon/human/H, obj/item/food/meat/slab/inMeatObj)

	// Get Original Amount
	var/amountOriginal
	var/amountCurrent
	if(inMeatObj.food_reagents)
		for(var/meat_reagent in inMeatObj.food_reagents)
			amountOriginal += inMeatObj.food_reagents[meat_reagent]

	if(inMeatObj.reagents.reagent_list)

		for(var/datum/reagent/chemicals in inMeatObj.reagents.reagent_list)
			if (locate(chemicals.type) in inMeatObj.food_reagents)
				amountCurrent += chemicals.volume
				inMeatObj.reagents.remove_reagent(chemicals.type, chemicals.volume)

	inMeatObj.reagents.update_total()
	// Set Health:
	var/percentDamage = 1 - amountCurrent / amountOriginal
	receive_damage(brute = max_damage * percentDamage)
	if(percentDamage >= 0.9)
		to_chat(owner, "<span class='alert'>It's almost completely useless. That [inMeatObj.name] was no good!</span>")
	else if(percentDamage > 0.5)
		to_chat(owner, "<span class='alert'>It's riddled with bite marks.</span>")
	else if(percentDamage > 0)
		to_chat(owner, "<span class='alert'>It looks a little eaten away, but it'll do.</span>")

	if(inMeatObj.reagents.total_volume)
		inMeatObj.reagents.trans_to(owner, inMeatObj.reagents.total_volume)	// Run transfer of 1 unit of reagent from them to me.

	qdel(inMeatObj)


/obj/item/bodypart/proc/drop_meat(mob/inOwner)

	//Checks tile for cloning pod, if found then limb stays limb. Stops cloner from breaking beefmen making them useless after being cloned.
	//var/turf/T = get_turf(src)
	//for(var/obj/machinery/M in T)
	//	if(istype(M,/obj/machinery/clonepod))
	//		return FALSE

	// Not Organic? ABORT! Robotic stays robotic, desnt delete and turn to meat.
	if (status != BODYPART_ORGANIC)
		return FALSE

	// If not 0% health, let's do it!
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (myMeatType != null && percentHealth > 0)

		// Create Meat
		var/obj/item/food/meat/slab/newMeat =	new myMeatType(src.loc)///obj/item/food/meat/slab(src.loc)

		// Adjust Reagents by Health Percent
		for (var/datum/reagent/R in newMeat.reagents.reagent_list)
			R.volume *= percentHealth
		newMeat.reagents.update_total()

		// Apply my Reagents to Meat
		if(inOwner.reagents?.total_volume)
			//inOwner.reagents.reaction(newMeat, INJECT, 20 / inOwner.reagents.total_volume) // Run Reaction: what happens when what they have mixes with what I have?	DEAD CODE MUST REWORK
			inOwner.reagents.trans_to(newMeat, 20)	// Run transfer of 1 unit of reagent from them to me.

		. = newMeat // Return MEAT

	qdel(src)
	//QDEL_IN(src,1) // Delete later. If we do it now, we screw up the "attack chain" that called this meat to attack the Beefman's stump.

///Limbs
/obj/item/bodypart/head/beef
	icon = 'fulp_modules/main_features/species/beefman/icons/mob/beefman_bodyparts.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

/obj/item/bodypart/chest/beef
	icon = 'fulp_modules/main_features/species/beefman/icons/mob/beefman_bodyparts.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

/// from dismemberment.dm
// /obj/item/bodypart/chest/beef/drop_limb(special)
// 	amCondemned = TRUE
// 	var/mob/owner_cache = owner
// 	..() // Create Meat, Remove Limb
// 	return drop_meat(owner_cache)

/obj/item/bodypart/r_arm/beef
	icon = 'fulp_modules/main_features/species/beefman/icons/mob/beefman_bodyparts.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

/// from dismemberment.dm
// /obj/item/bodypart/r_arm/beef/drop_limb(special)
// 	amCondemned = TRUE
// 	var/mob/owner_cache = owner
// 	..() // Create Meat, Remove Limb
// 	return drop_meat(owner_cache)

/obj/item/bodypart/l_arm/beef
	icon = 'fulp_modules/main_features/species/beefman/icons/mob/beefman_bodyparts.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

// from dismemberment.dm
// /obj/item/bodypart/l_arm/beef/drop_limb(special)
// 	amCondemned = TRUE
// 	var/mob/owner_cache = owner
// 	..() // Create Meat, Remove Limb
// 	return drop_meat(owner_cache)

/obj/item/bodypart/r_leg/beef
	icon = 'fulp_modules/main_features/species/beefman/icons/mob/beefman_bodyparts.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

/// from dismemberment.dm
// /obj/item/bodypart/r_leg/beef/drop_limb(special)
// 	amCondemned = TRUE
// 	var/mob/owner_cache = owner
// 	..() // Create Meat, Remove Limb
// 	return drop_meat(owner_cache)

/obj/item/bodypart/l_leg/beef
	icon = 'fulp_modules/main_features/species/beefman/icons/mob/beefman_bodyparts.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

/// from dismemberment.dm
// /obj/item/bodypart/l_leg/beef/drop_limb(special)
// 	amCondemned = TRUE
// 	var/mob/owner_cache = owner
// 	..() // Create Meat, Remove Limb
// 	return drop_meat(owner_cache)
