/obj/item/bodypart
	///The slab of meat this limb was made out of.
	var/obj/item/food/meat/slab/myMeatType = /obj/item/food/meat/slab


/**
 * # MEAT-TO-LIMB
 * 1) Save Meat's type
 * 2) Get all original Reagent TYPES from "list_reagents" on the meat itself - these reagents (TYPEPATHS) have the starter values. Save those values.
 * 3) Sort through thisMeat.reagents.reagent_list, which has ALL CURRENT reagents (ACTUAL DATUMS) inside the meat. Add up all those values.
 * 3) Percent = Compare the STARTER VALUES in list_reagents against the CURRENT VALUES in thisMeat.reagents.reagent_list/
 * 4) Inject ALL OTHER CHEMS into bloodstream
 *
 */

///Meat has been assigned to this NEW limb! Give it meat and damage me as needed.
/obj/item/bodypart/proc/give_meat(mob/living/carbon/human/beefboy, obj/item/food/meat/slab/inMeatObj) // <--- not touched yet
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
		inMeatObj.reagents.trans_to(owner, inMeatObj.reagents.total_volume)	// Run transfer of 1 unit of reagent from them to me.

	qdel(inMeatObj)


/**
 * # LIMB-TO-MEAT
 * 1) Create new meat
 * 2) Sort through all reagent datums in new_meat.list_reagents and adjust each version in new_meat.reagents.reagent_list/(REAGENT)/.volume
 * 3) Apply a small part of my body's metabolic reagents to the meat. Check how Feed does this.
 */

/obj/item/bodypart/proc/drop_meat(mob/inOwner) // <--- stupid, dumb proc. I hope it dies.
	// Not Organic? ABORT! Robotic stays robotic, desnt delete and turn to meat.
	if(status != BODYPART_ORGANIC)
		return FALSE
	// If not 0% health, let's do it!
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if(isnull(myMeatType) || percentHealth <= 0)
		return

	// Create Meat
	var/obj/item/food/meat/slab/new_meat = new myMeatType(inOwner.loc)
	// Adjust Reagents by Health Percent
	for(var/datum/reagent/reagents in new_meat.reagents.reagent_list)
		reagents.volume *= percentHealth
	new_meat.reagents.update_total()
	// Apply my Reagents to Meat
	if(inOwner.reagents && inOwner.reagents.total_volume)
		inOwner.reagents.trans_to(new_meat, 20)	// Run transfer of 1 unit of reagent from them to me.

	. = new_meat // Return MEAT

/**
 * # LIMBS
 *
 * drop_limb() from 'dismemberment.dm'
 * Head and Chest CANNOT be torn off into meat.
 */
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

/obj/item/bodypart/r_arm/beef/drop_limb(special)
	var/mob/living/carbon/owner_cache = owner
	..()
	if(drop_meat(owner_cache))
		qdel(src)

/obj/item/bodypart/l_arm/beef
	icon = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_greyscale = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_robotic = 'fulp_modules/features/species/icons/mob/beefman_bodyparts_robotic.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

/obj/item/bodypart/l_arm/beef/drop_limb(special)
	var/mob/living/carbon/owner_cache = owner
	..()
	if(drop_meat(owner_cache))
		qdel(src)

/obj/item/bodypart/r_leg/beef
	icon = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_greyscale = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_robotic = 'fulp_modules/features/species/icons/mob/beefman_bodyparts_robotic.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

/obj/item/bodypart/r_leg/beef/drop_limb(special)
	var/mob/living/carbon/owner_cache = owner
	..()
	if(drop_meat(owner_cache))
		qdel(src)

/obj/item/bodypart/l_leg/beef
	icon = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_greyscale = 'fulp_modules/features/species/icons/mob/beefman_bodyparts.dmi'
	icon_robotic = 'fulp_modules/features/species/icons/mob/beefman_bodyparts_robotic.dmi'
	heavy_brute_msg = "mincemeat"
	heavy_burn_msg = "burned to a crisp"

/obj/item/bodypart/l_leg/beef/drop_limb(special)
	var/mob/living/carbon/owner_cache = owner
	..()
	if(drop_meat(owner_cache))
		qdel(src)
