/datum/species/beefman
	name = "Beefman"
	id = "beefman"
	limbs_id = "beefman"
	say_mod = "gurgles"
	sexes = FALSE
	default_color = "e73f4e"
	mutant_bodyparts = list("beefcolor" = "Medium Rare","beefmouth" = "Smile1", "beefeyes" = "Olives")
	species_traits = list(
		NOEYESPRITES,
		NO_UNDERWEAR,
		DYNCOLORS,
		AGENDER,
		HAS_FLESH,
		HAS_BONE,
	)

	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_RESISTCOLD,
		TRAIT_CAN_STRIP,
		TRAIT_EASYDISMEMBER,
		TRAIT_SLEEPIMMUNE,
	)
	offset_features = list(
		OFFSET_UNIFORM = list(0,2), OFFSET_ID = list(0,2), OFFSET_GLOVES = list(0,-4),
		OFFSET_GLASSES = list(0,3), OFFSET_EARS = list(0,3), OFFSET_SHOES = list(0,0),
		OFFSET_S_STORE = list(0,2), OFFSET_FACEMASK = list(0,3), OFFSET_HEAD = list(0,3),
		OFFSET_FACE = list(0,3), OFFSET_BELT = list(0,3), OFFSET_BACK = list(0,2),
		OFFSET_SUIT = list(0,2), OFFSET_NECK = list(0,3),
	)

	skinned_type = /obj/item/food/meatball
	meat = /obj/item/food/meat/slab
	toxic_food = DAIRY | PINEAPPLE
	disliked_food = VEGETABLES | FRUIT | CLOTH
	liked_food = RAW | MEAT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	attack_verb = "meat"
	payday_modifier = 0.75
	speedmod = -0.2
	armor = -20
	punchdamagelow = 1
	punchdamagehigh = 5
	siemens_coeff = 0.7 // Due to lack of density.
	deathsound = 'fulp_modules/main_features/species/beefman/sounds/beef_die.ogg'
	attack_sound = 'fulp_modules/main_features/species/beefman/sounds/beef_hit.ogg'
	special_step_sounds = list(
		'fulp_modules/main_features/species/beefman/sounds/footstep_splat1.ogg',
		'fulp_modules/main_features/species/beefman/sounds/footstep_splat2.ogg',
		'fulp_modules/main_features/species/beefman/sounds/footstep_splat3.ogg',
		'fulp_modules/main_features/species/beefman/sounds/footstep_splat4.ogg',
	)
	grab_sound = 'fulp_modules/main_features/species/beefman/sounds/beef_grab.ogg'
	species_language_holder = /datum/language_holder/russian
	mutanttongue = /obj/item/organ/tongue/beef
	bodytemp_normal = T20C

	bruising_desc = "tenderizing"
	burns_desc = "searing"
	cellulardamage_desc = "meat degradation"

	var/dehydrate = 0
	var/list/trauma_list = list(
		/datum/brain_trauma/mild/hallucinations,
		/datum/brain_trauma/special/bluespace_prophet/phobetor,
	)

/proc/proof_beefman_features(list/inFeatures)
	if(inFeatures["beefcolor"] == null || inFeatures["beefcolor"] == "")
		inFeatures["beefcolor"] = GLOB.color_list_beefman[pick(GLOB.color_list_beefman)]
	if(inFeatures["beefeyes"] == null || inFeatures["beefeyes"] == "")
		inFeatures["beefeyes"] = pick(GLOB.beefman_eyes_list)
	if(inFeatures["beefmouth"] == null || inFeatures["beefmouth"] == "")
		inFeatures["beefmouth"] = pick(GLOB.beefman_mouth_list)

/datum/species/beefman/proc/adjust_bleeding(mob/living/carbon/human/beefman, type = "+", amount)
	for(var/obj/item/bodypart/limb in beefman.bodyparts)
		switch(type)
			if ("+")
				limb.generic_bleedstacks += amount
			if ("=")
				limb.generic_bleedstacks = amount
			if ("-")
				limb.generic_bleedstacks -= amount

/datum/species/beefman/on_species_gain(mob/living/carbon/human/user, datum/species/old_species, pref_load)
	// Missing Defaults in DNA? Randomize!
	proof_beefman_features(user.dna.features)

	. = ..()

	fixed_mut_color = user.dna.features["beefcolor"]
	default_color = fixed_mut_color

	for(var/traumas in trauma_list)
		user.gain_trauma(traumas, TRAUMA_RESILIENCE_ABSOLUTE)

	for(var/obj/item/bodypart/limb in user.bodyparts)
		limb.heavy_brute_msg = "mincemeat"
		limb.heavy_burn_msg = "burned to a crisp"

		if(istype(limb, /obj/item/bodypart/head) || istype(limb, /obj/item/bodypart/chest))
			continue

		limb.meat_on_drop = TRUE


/datum/species/beefman/on_species_loss(mob/living/carbon/human/user, datum/species/new_species, pref_load)
	..()

	for(var/traumas in trauma_list)
		user.cure_trauma_type(traumas, TRAUMA_RESILIENCE_ABSOLUTE)

	for(var/obj/item/bodypart/limbs in user.bodyparts)
		limbs.heavy_brute_msg = initial(limbs.heavy_brute_msg)
		limbs.heavy_burn_msg = initial(limbs.heavy_burn_msg)
		limbs.amCondemned = FALSE
		limbs.meat_on_drop = FALSE
		// UnregisterSignal(user, COMSIG_CARBON_REMOVE_LIMB, .proc/on_limb_drop)

/datum/species/beefman/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_beefman_name(gender)
	return capitalize(beefman_name(gender))

/datum/species/beefman/spec_life(mob/living/carbon/human/beefboy)
	..()
	var/searJuices = beefboy.getFireLoss_nonProsthetic() / 30 //-- Now that is a lot of damage

	if (dehydrate > 0)
		adjust_bleeding(beefboy, "=", clamp((beefboy.bodytemperature - 297.15) / 20 - searJuices, 2, 10))
		dehydrate -= 0.5
	else
		adjust_bleeding(beefboy, "=", clamp((beefboy.bodytemperature - 297.15) / 20 - searJuices, 0, 5))

	// Replenish Blood Faster! (But only if you actually make blood)
	var/bleed_rate = 0
	for(var/obj/item/bodypart/limb in beefboy.bodyparts)
		bleed_rate += limb.generic_bleedstacks

/datum/species/beefman/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/beefboy)
	. = ..()
	// Salt HURTS
	if(chem.type == /datum/reagent/saltpetre || chem.type == /datum/reagent/consumable/salt)
		beefboy.adjustToxLoss(0.5, 0) // adjustFireLoss
		beefboy.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		if (prob(5) || dehydrate == 0)
			to_chat(beefboy, "<span class='alert'>Your beefy mouth tastes dry.<span>")
		dehydrate ++
		return TRUE
	// Regain BLOOD
	if(istype(chem, /datum/reagent/consumable/nutriment) || istype(chem, /datum/reagent/iron))
		if (beefboy.blood_volume < BLOOD_VOLUME_NORMAL)
			beefboy.blood_volume += 5
			beefboy.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
			return TRUE


/proc/random_unique_beefman_name(gender, attempts_to_find_unique_name=10)
	for(var/i in 1 to attempts_to_find_unique_name)
		. = capitalize(beefman_name(gender))

		if(!findname(.))
			break

/proc/beefman_name()
	if(prob(50))
		return "[pick(GLOB.experiment_names)] \Roman[rand(1, 49)] [pick(GLOB.russian_names)]"
	else
		return "[pick(GLOB.experiment_names)] \Roman[rand(1, 49)] [pick(GLOB.beef_names)]"
			// INTEGRATION //

/mob/living/carbon/human/species/beefman
	race = /datum/species/beefman
