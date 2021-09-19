/obj/item/bodypart
	var/obj/item/food/meat/slab/myMeatType // For remembering what kind of meat this was made of. Default is base meat slab.
	var/amCondemned = FALSE // I'm about to be destroyed. Don't add blood to me, and throw null error crap next tick.
	var/meat_on_drop = FALSE

/obj/item/bodypart/drop_limb(special)
	..()
	if(meat_on_drop)
		amCondemned = TRUE
		myMeatType = /obj/item/food/meat/slab
		return drop_meat(owner)

/obj/item/bodypart/add_mob_blood(mob/living/M) // Cancel adding blood if I'm deletin (throws errors)
	if(amCondemned)
		return FALSE
	..()

/obj/item/bodypart/proc/give_meat(mob/living/carbon/human/H, obj/item/food/meat/slab/inMeatObj)
	amCondemned = TRUE

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

	qdel(inMeatObj)


/obj/item/bodypart/proc/drop_meat(mob/inOwner)

	if (status != BODYPART_ORGANIC)
		return FALSE

	// If not 0% health, let's do it!
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (myMeatType != null && percentHealth > 0)

		var/obj/item/food/meat/slab/newMeat = new myMeatType(src.loc)

		. = newMeat // Return MEAT

	qdel(src)
