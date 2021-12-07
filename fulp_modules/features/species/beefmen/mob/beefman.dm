/datum/species/beefman
	name = "Beefman"
	id = SPECIES_BEEFMAN
	limbs_id = "beefman"
	say_mod = "gurgles"
	sexes = FALSE
	default_color = "#e73f4e"
	species_traits = list(NOEYESPRITES, NO_UNDERWEAR, DYNCOLORS, AGENDER, HAS_FLESH, HAS_BONE)
	mutant_bodyparts = list(
		"beefcolor" = "Medium Rare",
		"beefmouth" = "Smile1",
		"beefeyes" = "Olives",
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_EASYDISMEMBER,
		TRAIT_GENELESS,
		TRAIT_RESISTCOLD,
		TRAIT_SLEEPIMMUNE,
	)
	offset_features = list(
		OFFSET_ID = list(0,2),
		OFFSET_GLOVES = list(0,-4),
		OFFSET_GLASSES = list(0,3),
		OFFSET_EARS = list(0,3),
		OFFSET_SHOES = list(0,0),
		OFFSET_S_STORE = list(0,2),
		OFFSET_FACEMASK = list(0,3),
		OFFSET_HEAD = list(0,3),
		OFFSET_FACE = list(0,3),
		OFFSET_BELT = list(0,3),
		OFFSET_NECK = list(0,3),
	)

	mutanttongue = /obj/item/organ/tongue/beefman
	skinned_type = /obj/item/food/meatball
	meat = /obj/item/food/meat/slab
	toxic_food = DAIRY | PINEAPPLE
	disliked_food = VEGETABLES | FRUIT | CLOTH
	liked_food = RAW | MEAT | FRIED
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	attack_verb = "meat"
	payday_modifier = 0.75
	speedmod = -0.2
	armor = -2 // overall defense for the race... or less defense, if it's negative.
	punchdamagelow = 1 //lowest possible punch damage. if this is set to 0, punches will always miss
	punchdamagehigh = 5 //highest possible punch damage
	siemens_coeff = 0.7 // Due to lack of density. - base electrocution coefficient
	deathsound = 'fulp_modules/features/species/sounds/beef_die.ogg'
	attack_sound = 'fulp_modules/features/species/sounds/beef_hit.ogg'
	grab_sound = 'fulp_modules/features/species/sounds/beef_grab.ogg'
	special_step_sounds = list(
		'fulp_modules/features/species/sounds/footstep_splat1.ogg',
		'fulp_modules/features/species/sounds/footstep_splat2.ogg',
		'fulp_modules/features/species/sounds/footstep_splat3.ogg',
		'fulp_modules/features/species/sounds/footstep_splat4.ogg',
	)
	species_language_holder = /datum/language_holder/russian
	bodytemp_normal = T20C

	var/dehydrate = 0
	    // list( /datum/brain_trauma/mild/phobia/strangers, /datum/brain_trauma/mild/phobia/doctors, /datum/brain_trauma/mild/phobia/authority )

	// Take care of your meat, everybody
	bruising_desc = "tenderizing"
	burns_desc = "searing"
	cellulardamage_desc = "meat degradation"

	bodypart_overides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/beef,\
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/beef,\
		BODY_ZONE_HEAD = /obj/item/bodypart/head/beef,\
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/beef,\
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/beef,\
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/beef,\
	)

/mob/living/carbon/human/proc/adjust_beefman_bleeding(amount)
	for(var/all_bodyparts in bodyparts)
		var/obj/item/bodypart/chosen_bodypart = all_bodyparts
		chosen_bodypart.generic_bleedstacks = amount

///When interacting with another person, you will bleed over them.
/datum/species/beefman/proc/bleed_over_target(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target && user.is_bleeding())
		target.add_mob_blood(user)

// Taken from Ethereal
/datum/species/beefman/on_species_gain(mob/living/carbon/human/user, datum/species/old_species, pref_load)
	. = ..()
	// 1) BODYPARTS
	user.part_default_head = /obj/item/bodypart/head/beef
	user.part_default_chest = /obj/item/bodypart/chest/beef
	user.part_default_l_arm = /obj/item/bodypart/l_arm/beef
	user.part_default_r_arm = /obj/item/bodypart/r_arm/beef
	user.part_default_l_leg = /obj/item/bodypart/l_leg/beef
	user.part_default_r_leg = /obj/item/bodypart/r_leg/beef
//	user.ReassignForeignBodyparts()

	// 2) Load it all
	proof_beefman_features(user.dna.features) // Missing Defaults in DNA? Randomize!
	set_beef_color(user)

	// Be Spooked but Educated
//	user.gain_trauma(pick(startTraumas))
	user.gain_trauma(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
	user.gain_trauma(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/species/beefman/get_features()
	var/list/features = ..()
	features += "feature_beefcolor"
	features += "feature_beefeyes"
	features += "feature_beefmouth"

	return features

/datum/species/proc/set_beef_color(mob/living/carbon/human/user)
	return // Do Nothing

/datum/species/beefman/set_beef_color(mob/living/carbon/human/user)
	// Called on Assign, or on Color Change (or any time proof_beefman_features() is used, such as in bs_veil.dm)
	fixed_mut_color = user.dna.features["beefcolor"]
	default_color = fixed_mut_color

/mob/living/carbon/proc/ReassignForeignBodyparts()
	var/all_bodyparts = list(
		BODY_ZONE_HEAD,
		BODY_ZONE_CHEST,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
	)
	for(var/obj/item/bodypart/current_bodyparts as anything in all_bodyparts)
		var/bodypart_checking = "part_default_[current_bodyparts]"
		if(current_bodyparts != bodypart_checking)
			qdel(current_bodyparts)
			var/obj/item/bodypart/limb = new bodypart_checking
			limb.replace_limb(src, TRUE)

/datum/species/beefman/on_species_loss(mob/living/carbon/human/user, datum/species/new_species, pref_load)
	. = ..()

	// 2) BODYPARTS
	user.part_default_head = /obj/item/bodypart/head
	user.part_default_chest = /obj/item/bodypart/chest
	user.part_default_l_arm = /obj/item/bodypart/l_arm
	user.part_default_r_arm = /obj/item/bodypart/r_arm
	user.part_default_l_leg = /obj/item/bodypart/l_leg
	user.part_default_r_leg = /obj/item/bodypart/r_leg
//	user.ReassignForeignBodyparts()

	// Resolve Trauma
	user.cure_trauma_type(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)
	user.cure_trauma_type(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/species/beefman/spec_life(mob/living/carbon/human/user)
	. = ..()

	// Step 1) Being burned keeps the juices in.
	var/searJuices = user.getFireLoss_nonProsthetic() / 30

	// Step 2) Bleed out those juices by warmth, minus burn damage. If we are salted - bleed more
	if(dehydrate > 0)
		user.adjust_beefman_bleeding(clamp((user.bodytemperature - 297.15) / 20 - searJuices, 2, 10))
		dehydrate -= 0.5
	else
		user.adjust_beefman_bleeding(clamp((user.bodytemperature - 297.15) / 20 - searJuices, 0, 5))

	// Replenish Blood Faster! (But only if you actually make blood)
	var/bleed_rate = 0
	for(var/all_bodyparts in user.bodyparts)
		var/obj/item/bodypart/chosen_bodypart = all_bodyparts
		bleed_rate += chosen_bodypart.generic_bleedstacks

/datum/species/beefman/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/user)
	. = ..() // Let species run its thing by default, TRUST ME
	// Salt HURTS
	if(chem.type == /datum/reagent/saltpetre || chem.type == /datum/reagent/consumable/salt)
		user.adjustToxLoss(0.5, 0) // adjustFireLoss
		user.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		if(prob(5) || dehydrate == 0)
			to_chat(user, span_alert("Your beefy mouth tastes dry."))
		dehydrate ++
		return TRUE
	// Regain BLOOD
	if(istype(chem, /datum/reagent/consumable/nutriment) || istype(chem, /datum/reagent/iron))
		if(user.blood_volume < BLOOD_VOLUME_NORMAL)
			user.blood_volume += 5
			user.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
			return TRUE

////////
//LIFE//
////////

//////////////////
// ATTACK PROCS //
//////////////////
/datum/species/beefman/help(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	// Bleed On
	bleed_over_target(user, target)
	return ..()

/datum/species/beefman/grab(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	bleed_over_target(user, target)
	return ..()

/datum/species/beefman/spec_unarmedattacked(mob/living/carbon/human/user, mob/living/carbon/human/target)
	bleed_over_target(user, target)
	return ..()

/datum/species/beefman/disarm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if(user != target)
		return ..()
	var/target_zone = user.zone_selected
	var/list/allowed_limbs = list(
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
	)
	var/obj/item/bodypart/affecting = user.get_bodypart(check_zone(user.zone_selected))
	if(!(target_zone in allowed_limbs) || !affecting)
		return FALSE
	if(user.handcuffed)
		to_chat(user, span_alert("You can't get a good enough grip with your hands bound."))
		return FALSE
	if(affecting.status != BODYPART_ORGANIC)
		to_chat(user, "That thing is on there good. It's not coming off with a gentle tug.")
		return FALSE

	// Pry it off...
	user.visible_message(
		span_notice("[user] grabs onto [p_their()] own [affecting.name] and pulls."),
		span_notice("You grab hold of your [affecting.name] and yank hard."))
	if(!do_mob(user, target))
		return FALSE
	user.visible_message(
		span_notice("[user]'s [affecting.name] comes right off in their hand."),
		span_notice("Your [affecting.name] pops right off."))
	playsound(get_turf(user), 'fulp_modules/features/species/sounds/beef_hit.ogg', 40, 1)

	// Destroy Limb, Drop Meat, Pick Up
	var/obj/item/dropped_meat = affecting.drop_limb() //  <--- This will return a meat vis drop_meat(), even if only Beefman limbs return anything. If this was another species' limb, it just comes off.
	if(istype(dropped_meat, /obj/item/food/meat/slab))
		user.put_in_hands(dropped_meat)
	return TRUE

/datum/species/beefman/spec_attacked_by(obj/item/meat_slab, mob/living/user, obj/item/bodypart/affecting, mob/living/carbon/human/beefboy)
	if(affecting || !istype(meat_slab, /obj/item/food/meat/slab))
		return ..()
	var/target_zone = user.zone_selected
	var/list/limbs = list(
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
	)
	if(!(target_zone in limbs))
		return FALSE

	user.visible_message(
		span_notice("[user] begins mashing [meat_slab] into [beefboy]'s torso."),
		span_notice("You begin mashing [meat_slab] into [beefboy]'s torso."))
	// Leave Melee Chain (so deleting the meat doesn't throw an error) <--- aka, deleting the meat that called this very proc.
	if(!do_mob(user, beefboy))
		return FALSE

	// Attach the part!
	var/obj/item/bodypart/new_bodypart = beefboy.newBodyPart(target_zone, FALSE)
	beefboy.visible_message(
		span_notice("The meat sprouts digits and becomes [beefboy]'s new [new_bodypart.name]!"),
		span_notice("The meat sprouts digits and becomes your new [new_bodypart.name]!"),
	)
	new_bodypart.attach_limb(beefboy)
	new_bodypart.give_meat(beefboy, meat_slab)
	playsound(get_turf(beefboy), 'fulp_modules/features/species/sounds/beef_grab.ogg', 50, 1)
	return TRUE // True CANCELS the sequence.

//// OUTSIDE PROCS ////

/datum/species/beefman/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_beefman_name()

	var/randname = beefman_name()

	return randname

// taken from _HELPERS/mobs.dm
/proc/random_unique_beefman_name(attempts_to_find_unique_name=10)
	for(var/i in 1 to attempts_to_find_unique_name)
		. = capitalize(beefman_name())

		if(!findname(.))
			break

// taken from _HELPERS/names.dm
/proc/beefman_name()
	if(prob(50))
		return "[pick(GLOB.experiment_names)] \Roman[rand(1,49)] [pick(GLOB.russian_names)]"
	return "[pick(GLOB.experiment_names)] \Roman[rand(1,49)] [pick(GLOB.beef_names)]"


// INTEGRATION //

// NOTE: the proc for a bodypart appearing on a mob is get_limb_icon() in bodypart.dm    !! We tracked it from limb_augmentation.dm -> carbon/update_icons.dm -> bodyparts.dm
// Return what the robot part should look like on the current mob.
/obj/item/bodypart/proc/ReturnLocalAugmentIcon()
	// Default: No Owner  --> use default
	if (!owner)
		return icon_robotic

	// Return Part
	var/obj/item/bodypart/bpType
	if (body_zone == BODY_ZONE_HEAD)
		bpType = owner.part_default_head
	if (body_zone == BODY_ZONE_CHEST)
		bpType = owner.part_default_chest
	if (body_zone == BODY_ZONE_L_ARM)
		bpType = owner.part_default_l_arm
	if (body_zone == BODY_ZONE_R_ARM)
		bpType = owner.part_default_r_arm
	if (body_zone == BODY_ZONE_L_LEG)
		bpType = owner.part_default_l_leg
	if (body_zone == BODY_ZONE_R_LEG)
		bpType = owner.part_default_r_leg

	if (bpType)
		return initial(bpType.icon_robotic)

	// Fail? Default
	return icon_robotic


/mob/living/carbon/human/species/beefman
	race = /datum/species/beefman

/obj/item/organ/tongue/beefman
	name = "meaty tongue"
	desc = "A meaty and thick muscle typically found in Beefmen."
	icon = 'fulp_modules/features/species/icons/mob/beef_tongue.dmi'
	icon_state = "beef_tongue"
	say_mod = "gurgles"
	taste_sensitivity = 15
	modifies_speech = TRUE
	languages_native = list(/datum/language/russian)
	var/static/list/languages_possible_meat = typecacheof(list(
		/datum/language/common,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/piratespeak,
		/datum/language/moffic,
		/datum/language/sylvan,
		/datum/language/shadowtongue,
		/datum/language/terrum,
		/datum/language/nekomimetic,
		/datum/language/russian,
		/datum/language/buzzwords,
	))

/obj/item/organ/tongue/beefman/Initialize(mapload)
    . = ..()
    languages_possible = languages_possible_meat


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

	//Checks tile for cloning pod, if found then limb stays limb. Stops cloner from breaking beefmen making them useless after being cloned.
//	var/turf/current_turf = get_turf(src)
//	for(var/obj/machinery/machines in current_turf)
//		if(istype(machines, /obj/machinery/clonepod))
//			return FALSE

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

/// from dismemberment.dm
/obj/item/bodypart/chest/beef/drop_limb(special)
	amCondemned = TRUE
	var/mob/owner_cache = owner
	..() // Create Meat, Remove Limb
	return drop_meat(owner_cache)

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
