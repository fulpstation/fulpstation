/obj/item/bodypart
	var/obj/item/food/meat/slab/myMeatType = /obj/item/food/meat/slab // For remembering what kind of meat this was made of. Default is base meat slab.
	var/amCondemned = FALSE // I'm about to be destroyed. Don't add blood to me, and throw null error crap next tick.

	//var/species_id_original = "human" 	// So we know to whom we originally belonged. This swaps freely until the DROP LOCK below is set.
	var/organicDropLocked = FALSE   	// When set to TRUE, that means this part has been CLAIMED by the race that dropped it.
	var/prevOrganicState				// Remember each organic icon as you build it; if this limb drops, its stuck with that forever.
	var/prevOrganicState_Aux			// The hand sprite
	var/prevOrganicIcon

/obj/item/bodypart/add_mob_blood(mob/living/user) // Cancel adding blood if I'm deletin (throws errors)
	if(!amCondemned)
		. = ..()


/**
 * # MEAT-TO-LIMB
 * 1) Save Meat's type
 * 2) Get all original Reagent TYPES from "list_reagents" on the meat itself - these reagents (TYPEPATHS) have the starter values. Save those values.
 * 3) Sort through thisMeat.reagents.reagent_list, which has ALL CURRENT reagents (ACTUAL DATUMS) inside the meat. Add up all those values.
 * 3) Percent = Compare the STARTER VALUES in list_reagents against the CURRENT VALUES in thisMeat.reagents.reagent_list/
 * 4) Inject ALL OTHER CHEMS into bloodstream
 *
 * # LIMB-TO-MEAT
 * 1) Create new meat
 * 2) Sort through all reagent datums in newMeat.list_reagents and adjust each version in newMeat.reagents.reagent_list/(REAGENT)/.volume
 * 3) Apply a small part of my body's metabolic reagents to the meat. Check how Feed does this.
 */

///Meat has been assigned to this NEW limb! Give it meat and damage me as needed.
/obj/item/bodypart/proc/give_meat(mob/living/carbon/human/beefboy, obj/item/food/meat/slab/inMeatObj)
	// Assign Type
	myMeatType = inMeatObj.type

		// Adjust Health (did you eat some of this?)

	// Get Original Amount
	var/amountOriginal
	for(var/reagents in inMeatObj.food_reagents) // List of TYPES and the starting AMOUNTS
		amountOriginal += inMeatObj.food_reagents[reagents]
	// Get Current Amount (of original reagents only)
	var/amountCurrent
	for(var/datum/reagent/extra_reagents in inMeatObj.reagents.reagent_list) // Actual REAGENT DATUMS and their VOLUMES
		// This datum exists in the original list?
		if(locate(extra_reagents.type) in inMeatObj.food_reagents)
			amountCurrent += extra_reagents.volume
			// Remove it from Meat (all others are about to be injected)
			inMeatObj.reagents.remove_reagent(extra_reagents.type, extra_reagents.volume)
	inMeatObj.reagents.update_total()
	// Set Health:
	var/percentDamage = 1 - amountCurrent / amountOriginal
	receive_damage(brute = max_damage * percentDamage)
	if(percentDamage >= 0.9)
		to_chat(owner, span_alert("It's almost completely useless. That [inMeatObj.name] was no good!"))
	else if(percentDamage > 0.5)
		to_chat(owner, span_alert("It's riddled with bite marks."))
	else if(percentDamage > 0)
		to_chat(owner, span_alert("It looks a little eaten away, but it'll do."))

	// Apply meat's Reagents to Me
	if(inMeatObj.reagents && inMeatObj.reagents.total_volume)
//		inMeatObj.reagents.reaction(owner, INJECT, inMeatObj.reagents.total_volume) // Run Reaction: what happens when what they have mixes with what I have?	DEAD CODE MUST REWORK
		inMeatObj.reagents.trans_to(owner, inMeatObj.reagents.total_volume)	// Run transfer of 1 unit of reagent from them to me.

	qdel(inMeatObj)


/obj/item/bodypart/proc/drop_meat(mob/inOwner)

	// Not Organic? ABORT! Robotic stays robotic, desnt delete and turn to meat.
	if(status != BODYPART_ORGANIC)
		return FALSE

	// If not 0% health, let's do it!
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if(myMeatType != null && percentHealth > 0)

		// Create Meat
		var/obj/item/food/meat/slab/newMeat = new myMeatType(src.loc)// /obj/item/food/meat/slab(src.loc)

		// Adjust Reagents by Health Percent
		for(var/datum/reagent/reagents in newMeat.reagents.reagent_list)
			reagents.volume *= percentHealth
		newMeat.reagents.update_total()

		// Apply my Reagents to Meat
		if(inOwner.reagents && inOwner.reagents.total_volume)
//			inOwner.reagents.reaction(newMeat, INJECT, 20 / inOwner.reagents.total_volume) // Run Reaction: what happens when what they have mixes with what I have?	DEAD CODE MUST REWORK
			inOwner.reagents.trans_to(newMeat, 20)	// Run transfer of 1 unit of reagent from them to me.

		. = newMeat // Return MEAT

	qdel(src)
//	QDEL_IN(src,1) // Delete later. If we do it now, we screw up the "attack chain" that called this meat to attack the Beefman's stump.

///Limbs
/obj/item/bodypart/head/beef
	icon = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_greyscale = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_robotic = 'fulp_modules/features/species/icons/mob/beefman_bodyparts_robotic.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

/obj/item/bodypart/chest/beef
	icon = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_greyscale = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_robotic = 'fulp_modules/features/species/icons/mob/beefman_bodyparts_robotic.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

/obj/item/bodypart/r_arm/beef
	icon = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_greyscale = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_robotic = 'fulp_modules/features/species/icons/mob/beefman_bodyparts_robotic.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

/// from dismemberment.dm
/obj/item/bodypart/r_arm/beef/drop_limb(special)
	amCondemned = TRUE
	var/mob/owner_cache = owner
	..() // Create Meat, Remove Limb
	return drop_meat(owner_cache)

/obj/item/bodypart/l_arm/beef
	icon = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_greyscale = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_robotic = 'fulp_modules/features/species/icons/mob/beefman_bodyparts_robotic.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

// from dismemberment.dm
/obj/item/bodypart/l_arm/beef/drop_limb(special)
	amCondemned = TRUE
	var/mob/owner_cache = owner
	..() // Create Meat, Remove Limb
	return drop_meat(owner_cache)

/obj/item/bodypart/r_leg/beef
	icon = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_greyscale = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_robotic = 'fulp_modules/features/species/icons/mob/beefman_bodyparts_robotic.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

/// from dismemberment.dm
/obj/item/bodypart/r_leg/beef/drop_limb(special)
	amCondemned = TRUE
	var/mob/owner_cache = owner
	..() // Create Meat, Remove Limb
	return drop_meat(owner_cache)

/obj/item/bodypart/l_leg/beef
	icon = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_greyscale = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_robotic = 'fulp_modules/features/species/icons/mob/beefman_bodyparts_robotic.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

/// from dismemberment.dm
/obj/item/bodypart/l_leg/beef/drop_limb(special)
	amCondemned = TRUE
	var/mob/owner_cache = owner
	..() // Create Meat, Remove Limb
	return drop_meat(owner_cache)
