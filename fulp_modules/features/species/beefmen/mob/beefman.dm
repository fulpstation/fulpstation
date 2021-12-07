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

	deathsound = 'fulp_modules/features/species/sounds/beef_die.ogg'
	attack_sound = 'fulp_modules/features/species/sounds/beef_hit.ogg'
	grab_sound = 'fulp_modules/features/species/sounds/beef_grab.ogg'
	special_step_sounds = list(
		'fulp_modules/features/species/sounds/footstep_splat1.ogg',
		'fulp_modules/features/species/sounds/footstep_splat2.ogg',
		'fulp_modules/features/species/sounds/footstep_splat3.ogg',
		'fulp_modules/features/species/sounds/footstep_splat4.ogg',
	)
	bodytemp_normal = T20C
	bodypart_overides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/beef,\
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/beef,\
		BODY_ZONE_HEAD = /obj/item/bodypart/head/beef,\
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/beef,\
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/beef,\
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/beef,\
	)
	var/dehydrate = 0
//	list(/datum/brain_trauma/mild/phobia/strangers, /datum/brain_trauma/mild/phobia/doctors, /datum/brain_trauma/mild/phobia/authority)

/datum/species/beefman/get_features()
	var/list/features = ..()
	features += "feature_beefcolor"
	features += "feature_beefeyes"
	features += "feature_beefmouth"

	return features

/datum/species/beefman/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_beefman_name()

	var/randname = beefman_name()
	return randname

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

	// 2) Load it all
	proof_beefman_features(user.dna.features) // Missing Defaults in DNA? Randomize!
	set_beef_color(user)

	// Be Spooked but Educated
//	user.gain_trauma(pick(startTraumas))
	user.gain_trauma(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
	user.gain_trauma(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/species/beefman/on_species_loss(mob/living/carbon/human/user, datum/species/new_species, pref_load)
	. = ..()

	// 2) BODYPARTS
	user.part_default_head = /obj/item/bodypart/head
	user.part_default_chest = /obj/item/bodypart/chest
	user.part_default_l_arm = /obj/item/bodypart/l_arm
	user.part_default_r_arm = /obj/item/bodypart/r_arm
	user.part_default_l_leg = /obj/item/bodypart/l_leg
	user.part_default_r_leg = /obj/item/bodypart/r_leg

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
		dehydrate++
		return TRUE
	// Regain BLOOD
	if(istype(chem, /datum/reagent/consumable/nutriment) || istype(chem, /datum/reagent/iron))
		if(user.blood_volume < BLOOD_VOLUME_NORMAL)
			user.blood_volume += 5
			user.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
			return TRUE

/mob/living/carbon/human/proc/adjust_beefman_bleeding(amount)
	for(var/all_bodyparts in bodyparts)
		var/obj/item/bodypart/chosen_bodypart = all_bodyparts
		chosen_bodypart.generic_bleedstacks = amount

///When interacting with another person, you will bleed over them.
/datum/species/beefman/proc/bleed_over_target(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target && user.is_bleeding())
		target.add_mob_blood(user)

/datum/species/beefman/proc/set_beef_color(mob/living/carbon/human/user)
	// Called on Assign, or on Color Change (or any time proof_beefman_features() is used)
	fixed_mut_color = user.dna.features["beefcolor"]
	default_color = fixed_mut_color

//////////////////
// ATTACK PROCS //
//////////////////
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
	var/obj/item/dropped_meat = affecting.drop_limb()//This will return a meat vis drop_meat(), even if only Beefman limbs return anything. If this was another species' limb, it just comes off.
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
		span_notice("The meat sprouts digits and becomes your new [new_bodypart.name]!"))
	new_bodypart.attach_limb(beefboy)
	new_bodypart.give_meat(beefboy, meat_slab)
	playsound(get_turf(beefboy), 'fulp_modules/features/species/sounds/beef_grab.ogg', 50, 1)
	return TRUE

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
