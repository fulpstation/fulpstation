/datum/species/beefman
	name = "Beefman"
	id = SPECIES_BEEFMAN
	limbs_id = "beefman"
	say_mod = "gurgles"
	sexes = FALSE
	default_color = "#e73f4e"
	species_traits = list(
		NOEYESPRITES,
		NO_UNDERWEAR,
		DYNCOLORS,
		AGENDER,
		HAS_FLESH,
		HAS_BONE,
	)
	mutant_bodyparts = list(
		"beefcolor" = "Medium Rare",
		"beefeyes" = "Olives",
		"beefmouth" = "Smile",
		"beef_trauma" = "Strangers",
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
		OFFSET_SUIT = list(0,2),
		OFFSET_NECK = list(0,3),
	)

	bruising_desc = "tenderizing"
	burns_desc = "searing"
	cellulardamage_desc = "meat degradation"

	species_language_holder = /datum/language_holder/russian
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
	armor = -2
	punchdamagelow = 1
	punchdamagehigh = 5
	siemens_coeff = 0.7 // base electrocution coefficient
	bodytemp_normal = T20C

	bodypart_overides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/beef,\
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/beef,\
		BODY_ZONE_HEAD = /obj/item/bodypart/head/beef,\
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/beef,\
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/beef,\
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/beef,\
	)
	deathsound = 'fulp_modules/features/species/sounds/beef_die.ogg'
	attack_sound = 'fulp_modules/features/species/sounds/beef_hit.ogg'
	grab_sound = 'fulp_modules/features/species/sounds/beef_grab.ogg'
	special_step_sounds = list(
		'fulp_modules/features/species/sounds/footstep_splat1.ogg',
		'fulp_modules/features/species/sounds/footstep_splat2.ogg',
		'fulp_modules/features/species/sounds/footstep_splat3.ogg',
		'fulp_modules/features/species/sounds/footstep_splat4.ogg',
	)

	///Dehydration caused by consuming Salt. Causes bleeding and affects how much they will bleed.
	var/dehydrated = 0
	///List of all limbs that can be removed and replaced at will.
	var/list/tearable_limbs = list(
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
	)

// Taken from Ethereal
/datum/species/beefman/on_species_gain(mob/living/carbon/human/user, datum/species/old_species, pref_load)
	. = ..()

	// Instantly set bodytemp to Beefmen levels to prevent bleeding out roundstart.
	user.bodytemperature = T20C

	// Missing Defaults in DNA? Randomize!
	proof_beefman_features(user.dna.features)
	set_beef_color(user)
	user.gain_trauma(user.dna.features["beef_trauma"], TRAUMA_RESILIENCE_ABSOLUTE)
	user.gain_trauma(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/species/beefman/on_species_loss(mob/living/carbon/human/user, datum/species/new_species, pref_load)
	user.cure_trauma_type(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)
	user.cure_trauma_type(user.dna.features["beef_trauma"], TRAUMA_RESILIENCE_ABSOLUTE)
	return ..()

/datum/species/beefman/spec_life(mob/living/carbon/human/user)
	. = ..()
	///How much we should bleed out, taking Burn damage into account.
	var/searJuices = user.getFireLoss_nonProsthetic() / 30

	// Bleed out those juices by warmth, minus burn damage. If we are salted - bleed more
	if(dehydrated > 0)
		user.adjust_beefman_bleeding(clamp((user.bodytemperature - 297.15) / 20 - searJuices, 2, 10))
		dehydrated -= 0.5
	else
		user.adjust_beefman_bleeding(clamp((user.bodytemperature - 297.15) / 20 - searJuices, 0, 5))

	// Replenish Blood Faster! (But only if you actually make blood)
	var/bleed_rate = 0
	for(var/obj/item/bodypart/all_bodyparts as anything in user.bodyparts)
		bleed_rate += all_bodyparts.generic_bleedstacks

/datum/species/beefman/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/user, delta_time, times_fired)
	// Salt HURTS
	if(istype(chem, /datum/reagent/saltpetre) || istype(chem, /datum/reagent/consumable/salt))
		user.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		if(DT_PROB(10, delta_time) || dehydrated == 0)
			to_chat(user, span_alert("Your beefy mouth tastes dry."))
		dehydrated++
	// Regain BLOOD
	else if(istype(chem, /datum/reagent/consumable/nutriment))
		if(user.blood_volume < BLOOD_VOLUME_NORMAL)
			user.blood_volume += 5
			user.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)

	. = ..()

/datum/species/beefman/get_features()
	var/list/features = ..()
	features += "feature_beefcolor"
	features += "feature_beefeyes"
	features += "feature_beefmouth"
	features += "feature_beef_trauma"

	return features

/datum/species/beefman/random_name(gender, unique, lastname)
	if(unique)
		return random_unique_beefman_name()
	var/randname = beefman_name()
	return randname

/mob/living/carbon/human/species/beefman
	race = /datum/species/beefman

/**
 * BEEFMAN UNIQUE PROCS AND INTEGRATION
 */

/mob/living/carbon/human/proc/adjust_beefman_bleeding(amount)
	for(var/obj/item/bodypart/all_bodyparts as anything in bodyparts)
		all_bodyparts.generic_bleedstacks = amount

///When interacting with another person, you will bleed over them.
/datum/species/beefman/proc/bleed_over_target(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target && user.is_bleeding())
		target.add_mob_blood(user)

///Called on Assign, or on Color Change (or any time proof_beefman_features() is used)
/datum/species/beefman/proc/set_beef_color(mob/living/carbon/human/user)
	fixed_mut_color = user.dna.features["beefcolor"]
	default_color = fixed_mut_color

// Taken from _HELPERS/mobs.dm
/proc/random_unique_beefman_name(attempts_to_find_unique_name = 10)
	for(var/i in 1 to attempts_to_find_unique_name)
		. = capitalize(beefman_name())
		if(!findname(.))
			break

// Taken from _HELPERS/names.dm
/proc/beefman_name()
	if(prob(50))
		return "[pick(GLOB.experiment_names)] \Roman[rand(1,49)] [pick(GLOB.russian_names)]"
	return "[pick(GLOB.experiment_names)] \Roman[rand(1,49)] [pick(GLOB.beef_names)]"

// Missing Defaults in DNA? Randomize!
/proc/proof_beefman_features(list/inFeatures)
	if(inFeatures["beefcolor"] == null || inFeatures["beefcolor"] == "")
		inFeatures["beefcolor"] = GLOB.color_list_beefman[pick(GLOB.color_list_beefman)]
	if(inFeatures["beefeyes"] == null || inFeatures["beefeyes"] == "")
		inFeatures["beefeyes"] = pick(GLOB.eyes_beefman)
	if(inFeatures["beefmouth"] == null || inFeatures["beefmouth"] == "")
		inFeatures["beefmouth"] = pick(GLOB.mouths_beefman)
	if(inFeatures["beef_trauma"] == null || inFeatures["beef_trauma"] == "")
		inFeatures["beef_trauma"] = GLOB.beefmen_traumas[pick(GLOB.beefmen_traumas)]

/**
 * ATTACK PROCS
 */
/datum/species/beefman/help(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	bleed_over_target(user, target)
	..()

/datum/species/beefman/grab(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	bleed_over_target(user, target)
	..()

/datum/species/beefman/spec_unarmedattacked(mob/living/carbon/human/user, mob/living/carbon/human/target)
	bleed_over_target(user, target)
	..()

/datum/species/beefman/disarm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if(user != target)
		return ..()
	var/target_zone = user.zone_selected
	var/obj/item/bodypart/affecting = user.get_bodypart(check_zone(user.zone_selected))
	if(!(target_zone in tearable_limbs) || !affecting)
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
	var/obj/item/dropped_meat = affecting.drop_limb()
	//This will return a meat vis drop_meat(), even if only Beefman limbs return anything. If this was another species' limb, it just comes off.
	if(istype(dropped_meat, /obj/item/food/meat/slab))
		user.put_in_hands(dropped_meat)
	return TRUE

/datum/species/beefman/spec_attacked_by(obj/item/meat_slab, mob/living/user, obj/item/bodypart/affecting, mob/living/carbon/human/beefboy)
	if(affecting || !istype(meat_slab, /obj/item/food/meat/slab))
		return ..()
	var/target_zone = user.zone_selected
	if(!(target_zone in tearable_limbs))
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
		span_notice("The meat sprouts digits and becomes your new [new_bodypart.name]!"))
	new_bodypart.attach_limb(beefboy)
	new_bodypart.give_meat(beefboy, meat_slab)
	qdel(meat_slab)
	playsound(get_turf(beefboy), 'fulp_modules/features/species/sounds/beef_grab.ogg', 50, 1)
	return TRUE


/**
 * EQUIPMENT
 *
 * We equip Beefmen's sashes as they spawn in.
 */
/datum/species/beefman/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)
	// Pre-Equip: Give us a sash so we don't end up with a Uniform!
	var/obj/item/clothing/under/bodysash/new_sash
	switch(job.title)
		// Captain
		if("Captain")
			new_sash = new /obj/item/clothing/under/bodysash/captain()
		// Security
		if("Head of Security")
			new_sash = new /obj/item/clothing/under/bodysash/security/hos()
		if("Warden")
			new_sash = new /obj/item/clothing/under/bodysash/security/warden()
		if("Security Officer")
			new_sash = new /obj/item/clothing/under/bodysash/security()
		if("Detective")
			new_sash = new /obj/item/clothing/under/bodysash/security/detective()
		if("Brig Physician")
			new_sash = new /obj/item/clothing/under/bodysash/security/brigdoc()

		// Subtype - Deputies
		if("Deputy")
			new_sash = new /obj/item/clothing/under/bodysash/security/deputy()
		if("Engineering Deputy")
			new_sash = new /obj/item/clothing/under/bodysash/security/deputy()
		if("Medical Deputy")
			new_sash = new /obj/item/clothing/under/bodysash/security/deputy()
		if("Science Deputy")
			new_sash = new /obj/item/clothing/under/bodysash/security/deputy()
		if("Supply Deputy")
			new_sash = new /obj/item/clothing/under/bodysash/security/deputy()

		// Medical
		if("Chief Medical Officer")
			new_sash = new /obj/item/clothing/under/bodysash/medical/cmo()
		if("Medical Doctor")
			new_sash = new /obj/item/clothing/under/bodysash/medical()
		if("Chemist")
			new_sash = new /obj/item/clothing/under/bodysash/medical/chemist()
		if("Virologist")
			new_sash = new /obj/item/clothing/under/bodysash/medical/virologist()
		if("Paramedic")
			new_sash = new /obj/item/clothing/under/bodysash/medical/paramedic()

		// Engineering
		if("Chief Engineer")
			new_sash = new /obj/item/clothing/under/bodysash/engineer/ce()
		if("Station Engineer")
			new_sash = new /obj/item/clothing/under/bodysash/engineer()
		if("Atmospheric Technician")
			new_sash = new /obj/item/clothing/under/bodysash/engineer/atmos()

		// Science
		if("Research Director")
			new_sash = new /obj/item/clothing/under/bodysash/rd()
		if("Scientist")
			new_sash = new /obj/item/clothing/under/bodysash/scientist()
		if("Roboticist")
			new_sash = new /obj/item/clothing/under/bodysash/roboticist()
		if("Geneticist")
			new_sash = new /obj/item/clothing/under/bodysash/geneticist()

		// Supply
		if("Head of Personnel")
			new_sash = new /obj/item/clothing/under/bodysash/hop()
		if("Quartermaster")
			new_sash = new /obj/item/clothing/under/bodysash/qm()
		if("Cargo Technician")
			new_sash = new /obj/item/clothing/under/bodysash/cargo()
		if("Shaft Miner")
			new_sash = new /obj/item/clothing/under/bodysash/miner()

		// Service
		if("Clown")
			new_sash = new /obj/item/clothing/under/bodysash/clown()
		if("Mime")
			new_sash = new /obj/item/clothing/under/bodysash/mime()
		if("Cook")
			new_sash = new /obj/item/clothing/under/bodysash/cook()
		if("Bartender")
			new_sash = new /obj/item/clothing/under/bodysash/bartender()
		if("Chaplain")
			new_sash = new /obj/item/clothing/under/bodysash/chaplain()
		if("Curator")
			new_sash = new /obj/item/clothing/under/bodysash/curator()
		if("Lawyer")
			new_sash = new /obj/item/clothing/under/bodysash/lawyer()
		if("Botanist")
			new_sash = new /obj/item/clothing/under/bodysash/botanist()
		if("Janitor")
			new_sash = new /obj/item/clothing/under/bodysash/janitor()
		if("Psychologist")
			new_sash = new /obj/item/clothing/under/bodysash/psychologist()

		// Assistant
		if("Assistant")
			new_sash = new /obj/item/clothing/under/bodysash()
		if("Prisoner")
			new_sash = new /obj/item/clothing/under/bodysash/prisoner()

		else
			new_sash = new /obj/item/clothing/under/bodysash/civilian()

	if(equipping.w_uniform)
		qdel(equipping.w_uniform)
	// Equip New
	equipping.equip_to_slot_or_del(new_sash, ITEM_SLOT_ICLOTHING, TRUE) // TRUE is whether or not this is "INITIAL", as in startup
	return ..()
