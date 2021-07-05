/*
/datum/species
	var/bruising_desc = "bruising"
	var/burns_desc = "burns"
	var/cellulardamage_desc = "cellular damage"

/datum/species/beefman
	name = "Beefman"
	id = "beefman"
	limbs_id = "beefman"
	say_mod = "gurgles"
	sexes = FALSE
	default_color = "e73f4e"
	species_traits = list(NOEYESPRITES, NO_UNDERWEAR, DYNCOLORS, AGENDER, HAS_FLESH, HAS_BONE)
	mutant_bodyparts = list("beefcolor" = "Medium Rare","beefmouth" = "Smile1", "beefeyes" = "Olives")
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER,
		TRAIT_RESISTCOLD,
		TRAIT_CAN_STRIP,
		TRAIT_EASYDISMEMBER,
		TRAIT_SLEEPIMMUNE,
	)
	offset_features = list(OFFSET_UNIFORM = list(0,2), OFFSET_ID = list(0,2), OFFSET_GLOVES = list(0,-4), OFFSET_GLASSES = list(0,3), OFFSET_EARS = list(0,3), OFFSET_SHOES = list(0,0), \
						   OFFSET_S_STORE = list(0,2), OFFSET_FACEMASK = list(0,3), OFFSET_HEAD = list(0,3), OFFSET_FACE = list(0,3), OFFSET_BELT = list(0,3), OFFSET_BACK = list(0,2), \
						   OFFSET_SUIT = list(0,2), OFFSET_NECK = list(0,3))

	skinned_type = /obj/item/food/meatball // NO SKIN //  /obj/item/stack/sheet/animalhide/human
	meat = /obj/item/food/meat/slab //What the species drops on gibbing
	toxic_food = DAIRY | PINEAPPLE //NONE
	disliked_food = VEGETABLES | FRUIT | CLOTH // | FRIED// GROSS | RAW
	liked_food = RAW | MEAT // JUNKFOOD | FRIED
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	attack_verb = "meat"
	payday_modifier = 0.75 //-- "Equality"
	speedmod = -0.2 // this affects the race's speed. positive numbers make it move slower, negative numbers make it move faster
	armor = -2 // overall defense for the race... or less defense, if it's negative.
	punchdamagelow = 1 //lowest possible punch damage. if this is set to 0, punches will always miss
	punchdamagehigh = 5 // 10 //highest possible punch damage
	siemens_coeff = 0.7 // Due to lack of density.   //base electrocution coefficient
	deathsound = 'fulp_modules/main_features/beefmen/sounds/beef_die.ogg'
	attack_sound = 'fulp_modules/main_features/beefmen/sounds/beef_hit.ogg'
	special_step_sounds = list('fulp_modules/main_features/beefmen/sounds/footstep_splat1.ogg','fulp_modules/main_features/beefmen/sounds/footstep_splat2.ogg','fulp_modules/main_features/beefmen/sounds/footstep_splat3.ogg','fulp_modules/main_features/beefmen/sounds/footstep_splat4.ogg')//Sounds to override barefeet walkng
	grab_sound = 'fulp_modules/main_features/beefmen/sounds/beef_grab.ogg' //Special sound for grabbing
	species_language_holder = /datum/language_holder/russian //--Speak Russian
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
	BODY_ZONE_CHEST = /obj/item/bodypart/chest/beef)

/proc/proof_beefman_features(list/inFeatures)
	// Missing Defaults in DNA? Randomize!
	if(inFeatures["beefcolor"] == null || inFeatures["beefcolor"] == "")
		inFeatures["beefcolor"] = GLOB.color_list_beefman[pick(GLOB.color_list_beefman)]
	if(inFeatures["beefeyes"] == null || inFeatures["beefeyes"] == "")
		inFeatures["beefeyes"] = pick(GLOB.eyes_beefman)
	if(inFeatures["beefmouth"] == null || inFeatures["beefmouth"] == "")
		inFeatures["beefmouth"] = pick(GLOB.mouths_beefman)

/mob/living/carbon/human/proc/adjust_bl_all(type = "add", amount)
	for(var/i in bodyparts)
		var/obj/item/bodypart/BP = i
		switch(type)
			if ("+")
				BP.generic_bleedstacks += amount
			if ("=")
				BP.generic_bleedstacks = amount
			if ("-")
				BP.generic_bleedstacks -= amount

/datum/species/beefman/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	// Missing Defaults in DNA? Randomize!
	proof_beefman_features(C.dna.features)

	. = ..()

	if(ishuman(C)) // Taken DIRECTLY from ethereal!
		var/mob/living/carbon/human/H = C

		set_beef_color(H)

		// 2) BODYPARTS
		C.part_default_head = /obj/item/bodypart/head/beef
		C.part_default_chest = /obj/item/bodypart/chest/beef
		C.part_default_l_arm = /obj/item/bodypart/l_arm/beef
		C.part_default_r_arm = /obj/item/bodypart/r_arm/beef
		C.part_default_l_leg = /obj/item/bodypart/l_leg/beef
		C.part_default_r_leg = /obj/item/bodypart/r_leg/beef
		C.ReassignForeignBodyparts()

	// Be Spooked but Educated
	if (SStraumas.phobia_types && SStraumas.phobia_types.len) // NOTE: ONLY if phobias have been defined! For some reason, sometimes this gets FUCKED??
		C.gain_trauma(/datum/brain_trauma/mild/phobia/strangers, TRAUMA_RESILIENCE_ABSOLUTE)
		C.gain_trauma(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)
		C.gain_trauma(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/species/proc/set_beef_color(mob/living/carbon/human/H)
	return // Do Nothing

/datum/species/beefman/set_beef_color(mob/living/carbon/human/H)
	// Called on Assign, or on Color Change (or any time proof_beefman_features() is used, such as in bs_veil.dm)
	fixed_mut_color = H.dna.features["beefcolor"]
	default_color = fixed_mut_color

/mob/living/carbon/proc/ReassignForeignBodyparts() //This proc hurts me so much, it used to be worse, this really should be a list or something
	var/obj/item/bodypart/head = get_bodypart(BODY_ZONE_HEAD)
	if (head?.type != part_default_head)  // <----- I think :? is used for procs instead of .? ...but apparently BYOND does that swap for you. //(!istype(get_bodypart(BODY_ZONE_HEAD), part_default_head))
		qdel(head)
		var/obj/item/bodypart/limb = new part_default_head
		limb.replace_limb(src,TRUE)
	var/obj/item/bodypart/chest = get_bodypart(BODY_ZONE_CHEST)
	if (chest?.type != part_default_chest)
		qdel(chest)
		var/obj/item/bodypart/limb = new part_default_chest
		limb.replace_limb(src,TRUE)
	var/obj/item/bodypart/l_arm = get_bodypart(BODY_ZONE_L_ARM)
	if (l_arm?.type != part_default_l_arm)
		qdel(l_arm)
		var/obj/item/bodypart/limb = new part_default_l_arm
		limb.replace_limb(src,TRUE)
	var/obj/item/bodypart/r_arm = get_bodypart(BODY_ZONE_R_ARM)
	if (r_arm?.type != part_default_r_arm)
		qdel(r_arm)
		var/obj/item/bodypart/limb = new part_default_r_arm
		limb.replace_limb(src,TRUE)
	var/obj/item/bodypart/l_leg = get_bodypart(BODY_ZONE_L_LEG)
	if (l_leg?.type != part_default_l_leg)
		qdel(l_leg)
		var/obj/item/bodypart/limb = new part_default_l_leg
		limb.replace_limb(src,TRUE)
	var/obj/item/bodypart/r_leg = get_bodypart(BODY_ZONE_R_LEG)
	if (r_leg?.type != part_default_r_leg)
		qdel(r_leg)
		var/obj/item/bodypart/limb = new part_default_r_leg
		limb.replace_limb(src,TRUE)

/datum/species/beefman/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	..()

	// 2) BODYPARTS
	C.part_default_head = /obj/item/bodypart/head
	C.part_default_chest = /obj/item/bodypart/chest
	C.part_default_l_arm = /obj/item/bodypart/l_arm
	C.part_default_r_arm = /obj/item/bodypart/r_arm
	C.part_default_l_leg = /obj/item/bodypart/l_leg
	C.part_default_r_leg = /obj/item/bodypart/r_leg
	C.ReassignForeignBodyparts()

	// Resolve Trauma
	C.cure_trauma_type(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)
	C.cure_trauma_type(/datum/brain_trauma/mild/phobia/strangers, TRAUMA_RESILIENCE_ABSOLUTE)
	C.cure_trauma_type(/datum/brain_trauma/mild/hallucinations, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/species/beefman/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_beefman_name(gender)
	return capitalize(beefman_name(gender))

/datum/species/beefman/spec_life(mob/living/carbon/human/H)	// This is your life ticker.
	..()
	// 		** BLEED YOUR JUICES **         //-- BODYTEMP_NORMAL = 293.15

	// Step 1) Being burned keeps the juices in.
	var/searJuices = H.getFireLoss_nonProsthetic() / 30 //-- Now that is a lot of damage

	// Step 2) Bleed out those juices by warmth, minus burn damage. If we are salted - bleed more
	if (dehydrate > 0)
		H.adjust_bl_all("=", clamp((H.bodytemperature - 297.15) / 20 - searJuices, 2, 10))
		dehydrate -= 0.5
	else
		H.adjust_bl_all("=", clamp((H.bodytemperature - 297.15) / 20 - searJuices, 0, 5))

	// Replenish Blood Faster! (But only if you actually make blood)
	var/bleed_rate = 0
	for(var/i in H.bodyparts)
		var/obj/item/bodypart/BP = i
		bleed_rate += BP.generic_bleedstacks

/datum/species/beefman/before_equip_job(datum/job/J, mob/living/carbon/human/H)

	// Pre-Equip: Give us a sash so we don't end up with a Uniform!
	var/obj/item/clothing/under/bodysash/newSash
	switch(J.title)

		// Assistant
		if("Assistant")
			newSash = new /obj/item/clothing/under/bodysash()
		// Captain
		if("Captain")
			newSash = new /obj/item/clothing/under/bodysash/captain()
		// Security
		if("Head of Security")
			newSash = new /obj/item/clothing/under/bodysash/hos()
		if("Warden")
			newSash = new /obj/item/clothing/under/bodysash/warden()
		if("Security Officer")
			newSash = new /obj/item/clothing/under/bodysash/security()
		if("Detective")
			newSash = new /obj/item/clothing/under/bodysash/detective()
		if("Brig Physician")
			newSash = new /obj/item/clothing/under/bodysash/brigdoc()
		if("Deputy")
			newSash = new /obj/item/clothing/under/bodysash/deputy()

		// Medical
		if("Chief Medical Officer")
			newSash = new /obj/item/clothing/under/bodysash/cmo()
		if("Medical Doctor")
			newSash = new /obj/item/clothing/under/bodysash/medical()
		if("Chemist")
			newSash = new /obj/item/clothing/under/bodysash/chemist()
		if("Virologist")
			newSash = new /obj/item/clothing/under/bodysash/virologist()
		if("Paramedic")
			newSash = new /obj/item/clothing/under/bodysash/paramedic()

		// Engineering
		if("Chief Engineer")
			newSash = new /obj/item/clothing/under/bodysash/ce()
		if("Station Engineer")
			newSash = new /obj/item/clothing/under/bodysash/engineer()
		if("Atmospheric Technician")
			newSash = new /obj/item/clothing/under/bodysash/atmos()

		// Science
		if("Research Director")
			newSash = new /obj/item/clothing/under/bodysash/rd()
		if("Scientist")
			newSash = new /obj/item/clothing/under/bodysash/scientist()
		if("Roboticist")
			newSash = new /obj/item/clothing/under/bodysash/roboticist()
		if("Geneticist")
			newSash = new /obj/item/clothing/under/bodysash/geneticist()

		// Supply/Service
		if("Head of Personnel")
			newSash = new /obj/item/clothing/under/bodysash/hop()
		if("Quartermaster")
			newSash = new /obj/item/clothing/under/bodysash/qm()
		if("Cargo Technician")
			newSash = new /obj/item/clothing/under/bodysash/cargo()
		if("Shaft Miner")
			newSash = new /obj/item/clothing/under/bodysash/miner()

		// Clown
		if("Clown")
			newSash = new /obj/item/clothing/under/bodysash/clown()
		// Mime
		if("Mime")
			newSash = new /obj/item/clothing/under/bodysash/mime()

		if("Prisoner")
			newSash = new /obj/item/clothing/under/bodysash/prisoner()
		if("Cook")
			newSash = new /obj/item/clothing/under/bodysash/cook()
		if("Bartender")
			newSash = new /obj/item/clothing/under/bodysash/bartender()
		if("Chaplain")
			newSash = new /obj/item/clothing/under/bodysash/chaplain()
		if("Curator")
			newSash = new /obj/item/clothing/under/bodysash/curator()
		if("Lawyer")
			newSash = new /obj/item/clothing/under/bodysash/lawyer()
		if("Botanist")
			newSash = new /obj/item/clothing/under/bodysash/botanist()
		if("Janitor")
			newSash = new /obj/item/clothing/under/bodysash/janitor()
		if("Psychologist")
			newSash = new /obj/item/clothing/under/bodysash/psychologist()

		// Civilian
		else
			newSash = new /obj/item/clothing/under/bodysash/civilian()

	// Destroy Original Uniform (there probably isn't one though)

	if (H.w_uniform)
		qdel(H.w_uniform)
	// Equip New
	H.equip_to_slot_or_del(newSash, ITEM_SLOT_ICLOTHING, TRUE) // TRUE is whether or not this is "INITIAL", as in startup
	return ..()


/datum/species/beefman/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	. = ..() // Let species run its thing by default, TRUST ME
	// Salt HURTS
	if(chem.type == /datum/reagent/saltpetre || chem.type == /datum/reagent/consumable/salt)
		H.adjustToxLoss(0.5, 0) // adjustFireLoss
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		if (prob(5) || dehydrate == 0)
			to_chat(H, "<span class='alert'>Your beefy mouth tastes dry.<span>")
		dehydrate ++
		return TRUE
	// Regain BLOOD
	if(istype(chem, /datum/reagent/consumable/nutriment) || istype(chem, /datum/reagent/iron))
		if (H.blood_volume < BLOOD_VOLUME_NORMAL)
			H.blood_volume += 5
			H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
			return TRUE


//////////////////
// ATTACK PROCS //
//////////////////
/datum/species/beefman/help(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	// Bleed On
	if (user != target && user.is_bleeding())
		target.add_mob_blood(user)
	return ..()

/datum/species/beefman/grab(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	// Bleed On
	if (user != target && user.is_bleeding())
		target.add_mob_blood(user) //  from atoms.dm, this is how you bloody something!
	return ..()

/datum/species/beefman/disarm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	// Targeting Self? With "DISARM"
	if (user == target)
		var/target_zone = user.zone_selected
		var/list/allowedList = list ( BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG )
		var/obj/item/bodypart/affecting = user.get_bodypart(check_zone(user.zone_selected)) //stabbing yourself always hits the right target

		if ((target_zone in allowedList) && affecting)

			if (user.handcuffed)
				to_chat(user, "<span class='alert'>You can't get a good enough grip with your hands bound.</span>")
				return FALSE

			// Robot Arms Fail
			if (affecting.status != BODYPART_ORGANIC)
				to_chat(user, "That thing is on there good. It's not coming off with a gentle tug.")
				return FALSE

			// Pry it off...
			user.visible_message("[user] grabs onto [p_their()] own [affecting.name] and pulls.", "<span class='notice'>You grab hold of your [affecting.name] and yank hard.</span>")
			if (!do_mob(user,target))
				return TRUE

			user.visible_message("[user]'s [affecting.name] comes right off in their hand.", "<span class='notice'>Your [affecting.name] pops right off.</span>")
			playsound(get_turf(user), 'fulp_modules/main_features/beefmen/sounds/beef_hit.ogg', 40, 1)

			// Destroy Limb, Drop Meat, Pick Up
			var/obj/item/I = affecting.drop_limb() //  <--- This will return a meat vis drop_meat(), even if only Beefman limbs return anything. If this was another species' limb, it just comes off.
			if (istype(I, /obj/item/food/meat/slab))
				user.put_in_hands(I)

			return TRUE
	return ..()

/datum/species/beefman/spec_unarmedattacked(mob/living/carbon/human/user, mob/living/carbon/human/target)
	// Bleed On
	if (user != target && user.is_bleeding())
		target.add_mob_blood(user) //  from atoms.dm, this is how you bloody something!s
	return ..()


/datum/species/beefman/proc/handle_limb_mashing()
	SIGNAL_HANDLER

/datum/species/beefman/spec_attacked_by(obj/item/I, mob/living/user, obj/item/bodypart/affecting, mob/living/carbon/human/H, modifiers)
	handle_limb_mashing()
	// MEAT LIMBS: If our limb is missing, and we're using meat, stick it in!
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		return
	if(H.stat < DEAD && !affecting && istype(I, /obj/item/food/meat/slab))
		var/target_zone = user.zone_selected
		var/list/limbs = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)

		if((target_zone in limbs))
			if(user == H)
				user.visible_message("[user] begins mashing [I] into [H]'s torso.", "<span class='notice'>You begin mashing [I] into your torso.</span>")
			else
				user.visible_message("[user] begins mashing [I] into [H]'s torso.", "<span class='notice'>You begin mashing [I] into [H]'s torso.</span>")

			// Leave Melee Chain (so deleting the meat doesn't throw an error) <--- aka, deleting the meat that called this very proc.
			spawn(1)
				if(do_mob(user,H))
					// Attach the part!
					var/obj/item/bodypart/newBP = H.newBodyPart(target_zone, FALSE)
					H.visible_message("The meat sprouts digits and becomes [H]'s new [newBP.name]!", "<span class='notice'>The meat sprouts digits and becomes your new [newBP.name]!</span>")
					newBP.attach_limb(H)
					newBP.give_meat(H, I)
					playsound(get_turf(H), 'fulp_modules/main_features/beefmen/sounds/beef_grab.ogg', 50, 1)

			return TRUE // True CANCELS the sequence.

	return ..() // TRUE FALSE
*/
			//// OUTSIDE PROCS ////




