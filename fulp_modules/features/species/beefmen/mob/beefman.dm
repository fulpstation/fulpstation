#define BEEFMAN_BLEEDOUT_LEVEL 298.15

/datum/species/beefman
	name = "Beefman"
	plural_form = "Beefmen"
	id = SPECIES_BEEFMAN
	examine_limb_id = SPECIES_BEEFMAN
	sexes = FALSE
	mutant_bodyparts = list(
		"beef_color" = "#e73f4e",
		"beef_eyes" = BEEF_EYES_OLIVES,
		"beef_mouth" = BEEF_MOUTH_SMILE,
	)
	inherent_traits = list(
		TRAIT_EASYDISMEMBER,
		TRAIT_GENELESS,
		TRAIT_RESISTCOLD,
		TRAIT_SLEEPIMMUNE,
		TRAIT_NO_UNDERWEAR,
		TRAIT_MUTANT_COLORS,
		TRAIT_AGENDER,
		TRAIT_FIXED_HAIRCOLOR,
	)
	bodytemp_heat_damage_limit = BEEFMAN_BLEEDOUT_LEVEL
	heatmod = 0.5
	species_language_holder = /datum/language_holder/russian
	mutantbrain = /obj/item/organ/internal/brain/beefman
	mutanttongue = /obj/item/organ/internal/tongue/beefman
	skinned_type = /obj/item/food/meatball
	meat = /obj/item/food/meat/slab
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 0.75
	damage_modifier = -20
	siemens_coeff = 0.7 // base electrocution coefficient
	bodytemp_normal = T20C

	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/beef,\
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/beef,\
		BODY_ZONE_HEAD = /obj/item/bodypart/head/beef,\
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/beef,\
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/beef,\
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/beef,\
	)

	death_sound = 'fulp_modules/features/species/sounds/beef_die.ogg'
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
	var/static/list/tearable_limbs = list(
		BODY_ZONE_PRECISE_MOUTH,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
	)

// Taken from Ethereal
/datum/species/beefman/on_species_gain(mob/living/carbon/human/user, datum/species/old_species, pref_load)
	. = ..()
	RegisterSignal(user, COMSIG_LIVING_HEALTH_UPDATE, PROC_REF(update_beefman_color))
	RegisterSignal(user, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attack_by))
	// Instantly set bodytemp to Beefmen levels to prevent bleeding out roundstart.
	user.bodytemperature = bodytemp_normal
	if(!user.dna.features["beef_color"])
		randomize_features(user)
	update_beefman_color(user)
	for(var/obj/item/bodypart/limb as anything in user.bodyparts)
		if(limb.limb_id != SPECIES_BEEFMAN)
			continue
		limb.update_limb(is_creating = TRUE)

/datum/species/beefman/randomize_features()
	var/list/features = ..()
	features["beef_color"] = pick(GLOB.color_list_beefman[pick(GLOB.color_list_beefman)])
	features["beef_eyes"] = pick(GLOB.eyes_beefman)
	features["beef_mouth"] = pick(GLOB.mouths_beefman)
	return features

/datum/species/beefman/spec_life(mob/living/carbon/human/user)
	. = ..()
	var/searJuices = user.getFireLoss_nonProsthetic() / 30
	if(dehydrated)
		user.adjust_beefman_bleeding(clamp((user.bodytemperature - BEEFMAN_BLEEDOUT_LEVEL) / 20 - searJuices, 2, 10))
		return dehydrated--

	user.adjust_beefman_bleeding(clamp((user.bodytemperature - BEEFMAN_BLEEDOUT_LEVEL) / 20 - searJuices, 0, 5))
	if(user.blood_volume >= BLOOD_VOLUME_NORMAL)
		return
	for(var/obj/item/bodypart/all_bodyparts as anything in user.bodyparts)
		if(all_bodyparts.generic_bleedstacks)
			return
	user.blood_volume += 4

/datum/species/beefman/handle_chemical(datum/reagent/chem, mob/living/carbon/human/user, delta_time, times_fired)
	if(istype(chem, /datum/reagent/saltpetre) || istype(chem, /datum/reagent/consumable/salt))
		if(!dehydrated || SPT_PROB(10, delta_time))
			to_chat(user, span_alert("Your beefy mouth tastes dry."))
		dehydrated++
	return ..()

/datum/species/beefman/handle_mutant_bodyparts(mob/living/carbon/human/source, forced_colour)
	. = ..()
	var/list/bodyparts_to_add = mutant_bodyparts.Copy()
	var/list/relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	var/list/standing = list()

	source.remove_overlay(BODY_BEHIND_LAYER)
	source.remove_overlay(BODY_ADJ_LAYER)
	source.remove_overlay(BODY_FRONT_LAYER)

	if(!mutant_bodyparts || HAS_TRAIT(source, TRAIT_INVISIBLE_MAN))
		return

	if(!bodyparts_to_add)
		return

	var/g = (source.physique == FEMALE) ? "f" : "m"

	for(var/layer in relevent_layers)
		var/layertext = mutant_bodyparts_layertext(layer)

		for(var/bodypart in bodyparts_to_add)
			var/datum/sprite_accessory/accessory
			switch(bodypart)
				if("beef_eyes")
					if(source.get_organ_slot(ORGAN_SLOT_EYES)) // Only draw eyes if we got em
						accessory = GLOB.eyes_beefman[source.dna.features["beef_eyes"]]
				if("beef_mouth")
					accessory = GLOB.mouths_beefman[source.dna.features["beef_mouth"]]

			if(!accessory || accessory.icon_state == "none")
				continue

			var/mutable_appearance/accessory_overlay = mutable_appearance(accessory.icon, layer = -layer)

			if(accessory.gender_specific)
				accessory_overlay.icon_state = "[g]_[bodypart]_[accessory.icon_state]_[layertext]"
			else
				accessory_overlay.icon_state = "m_[bodypart]_[accessory.icon_state]_[layertext]"

			if(accessory.em_block)
				accessory_overlay.overlays += emissive_blocker(accessory_overlay.icon, accessory_overlay.icon_state, accessory_overlay.alpha)

			if(accessory.center)
				accessory_overlay = center_image(accessory_overlay, accessory.dimension_x, accessory.dimension_y)

			if(!(HAS_TRAIT(source, TRAIT_HUSK)))
				if(!forced_colour)
					switch(accessory.color_src)
						if(MUTANT_COLOR)
							if(fixed_mut_color)
								accessory_overlay.color = fixed_mut_color
							else
								accessory_overlay.color = source.dna.features["mcolor"]
						if(HAIR_COLOR)
							if(hair_color_mode == USE_MUTANT_COLOR)
								accessory_overlay.color = source.dna.features["mcolor"]
							else if(hair_color_mode == USE_FIXED_MUTANT_COLOR)
								accessory_overlay.color = fixed_mut_color
							else
								accessory_overlay.color = source.hair_color
						if(FACIAL_HAIR_COLOR)
							accessory_overlay.color = source.facial_hair_color
						if(EYE_COLOR)
							accessory_overlay.color = source.eye_color_left
				else
					accessory_overlay.color = forced_colour
			standing += accessory_overlay

			if(accessory.hasinner)
				var/mutable_appearance/inner_accessory_overlay = mutable_appearance(accessory.icon, layer = -layer)
				if(accessory.gender_specific)
					inner_accessory_overlay.icon_state = "[g]_[bodypart]inner_[accessory.icon_state]_[layertext]"
				else
					inner_accessory_overlay.icon_state = "m_[bodypart]inner_[accessory.icon_state]_[layertext]"

				if(accessory.center)
					inner_accessory_overlay = center_image(inner_accessory_overlay, accessory.dimension_x, accessory.dimension_y)

				standing += inner_accessory_overlay

		source.overlays_standing[layer] = standing.Copy()
		standing = list()

	source.apply_overlay(BODY_BEHIND_LAYER)
	source.apply_overlay(BODY_ADJ_LAYER)
	source.apply_overlay(BODY_FRONT_LAYER)

/datum/species/beefman/proc/update_beefman_color(mob/living/carbon/human/beefman)
	SIGNAL_HANDLER
	var/my_color = beefman.dna.features["beef_color"]
	if(isnull(my_color))
		return
	fixed_mut_color = my_color

/datum/species/beefman/get_features()
	var/list/features = ..()
	features += "feature_beef_color"
	features += "feature_beef_eyes"
	features += "feature_beef_mouth"
	features += "feature_beef_trauma"

	return features

/mob/living/carbon/human/species/beefman
	race = /datum/species/beefman

/**
 * PREFS STUFF
 */

/datum/species/beefman/get_species_description()
	return "Thanks to being made entirely out of beef, Beefman's brains are deeply flawed, \
		causing them to suffer constant hallucinations and 'tears in reality'"

/datum/species/beefman/get_species_lore()
	return list(
		"On a very quiet day, the Russian-famous Fiddler Diner was serving food to the crew, when they realized they ran out of burger ingredients. \
		After drawing straws, the Cook was sent to fetch some more meat from the Morgue, unaware of the events that will transpire. \
		'It's normal for the Kitchen to grab dead bodies, right? It's not like they need them... Right?' The Cook thought, \
		inattentively grabbing the first body they could find, trying to get this over with before it becomes a memory. \
		What the Cook hadn't noticed, the Morgue's tray was green, the body was filled with a soul, one that was begging not to be gibbed.",

		"The Cook one'd and two'd the body into the gibber and turned it on, the grinder struggling to keep up on its unupgraded parts. \
		Once the whole body entered the machine, it suddenly stopped working, and instead started spitting the meat back out, as if it was in reverse... \
		The Cook looked over to see what was going on, but the slab of meat looked back, with massive eyes.",

		"After a quick confiscation from the Russian Sol Government, most records of 'Beefmen' have gone dark, \
		with minor glimpses of 'Sleep Experiments' going around. \
		One thing is certain though, a rise of gibbers on-board Russian stations, which was followed by a rise in Beefmen. \
		No one knows what happened during this era, but when the program finally ended and they were allowed into society, \
		none of them were able to live 'normally'. Their complete inability to sleep, but their power in traversing the 'Phobetor Tear' \
		immediately started popping everywhere, and has been at the	forefront of galaxy-wide investigations of their anatomy and the experiments.",
	)

/datum/species/beefman/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		//Positive
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "handshake",
			SPECIES_PERK_NAME = "Beefy Limbs",
			SPECIES_PERK_DESC = "Beefmen are able to tear off and put limbs back on at will. They do this by targetting their limb and right clicking.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "running",
			SPECIES_PERK_NAME = "Runners",
			SPECIES_PERK_DESC = "Beefmen are 20% faster than most other species.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "temperature-low",
			SPECIES_PERK_NAME = "Cold Loving",
			SPECIES_PERK_DESC = "Beefmen are completely immune to the cold. Low temperatures even prevent bleeding.",
		),
		//Neutral
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = "link",
			SPECIES_PERK_NAME = "Phobetor Tears",
			SPECIES_PERK_DESC = "Beefmen can see and use Phobetor tears, small tears in reality, \
				that teleport them to the other end of the tear. This can only be done when no one is watching.",
		),
		//Negative
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "shield-alt",
			SPECIES_PERK_NAME = "Boneless Meat",
			SPECIES_PERK_DESC = "Beefmen's meat is not well guarded, causing them to take 20% more damage.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "tint",
			SPECIES_PERK_NAME = "Juice Bleeding",
			SPECIES_PERK_DESC = "Beefmen will begin to bleed out when their temperature is above [BEEFMAN_BLEEDOUT_LEVEL-T0C] Celsius. \
				Burn damage will prevent bleeding.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "briefcase-medical",
			SPECIES_PERK_NAME = "Mentally unfit",
			SPECIES_PERK_DESC = "Beefmen suffer from a permanent brain trauma \
				that can't be repaired under normal circumstances.",
		),
	)

	return to_add

/**
 * BEEFMAN UNIQUE PROCS AND INTEGRATION
 */

/mob/living/carbon/human/proc/adjust_beefman_bleeding(amount)
	for(var/obj/item/bodypart/all_bodyparts as anything in bodyparts)
		all_bodyparts.setBleedStacks(amount)

///When interacting with another person, you will bleed over them.
/datum/species/beefman/proc/bleed_over_target(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		target.add_mob_blood(user)

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

/**
 * ATTACK PROCS
 */
/datum/species/beefman/help(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	bleed_over_target(user, target)
	return ..()

/datum/species/beefman/disarm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if(user != target)
		return ..()
	var/target_zone = user.zone_selected
	var/obj/item/bodypart/affecting = user.get_bodypart(check_zone(target_zone))
	if(!(target_zone in tearable_limbs) || !affecting)
		return FALSE
	if(!IS_ORGANIC_LIMB(affecting))
		to_chat(user, "That thing is on there good. It's not coming off with a gentle tug.")
		return FALSE

	// Pry it off...
	if(target_zone == BODY_ZONE_PRECISE_MOUTH)
		var/obj/item/organ/internal/tongue/tongue = user.get_organ_by_type(/obj/item/organ/internal/tongue)
		if(!tongue)
			return FALSE
		user.visible_message(
			span_notice("[user] grabs onto [p_their()] own tongue and pulls."),
			span_notice("You grab hold of your tongue and yank hard."))
		if(!do_after(user, 1 SECONDS, target))
			return FALSE
		var/obj/item/food/meat/slab/meat = new /obj/item/food/meat/slab
		tongue.Remove(user)
		user.put_in_hands(meat)
		playsound(get_turf(user), 'fulp_modules/features/species/sounds/beef_hit.ogg', 40, 1)
		return TRUE
	user.visible_message(
		span_notice("[user] grabs onto [p_their()] own [affecting.name] and pulls."),
		span_notice("You grab hold of your [affecting.name] and yank hard."))
	if(!do_after(user, 3 SECONDS, target))
		return FALSE
	user.visible_message(
		span_notice("[user]'s [affecting.name] comes right off in their hand."),
		span_notice("Your [affecting.name] pops right off."))
	playsound(get_turf(user), 'fulp_modules/features/species/sounds/beef_hit.ogg', 40, 1)
	// Destroy Limb, Drop Meat, Pick Up
	var/obj/item/food/meat/slab/dropped_meat = affecting.drop_limb()
	//This will return a meat vis drop_meat(), even if only Beefman limbs return anything. If this was another species' limb, it just comes off.
	if(dropped_meat)
		user.put_in_hands(dropped_meat)
	return TRUE

/datum/species/beefman/proc/on_attack_by(mob/living/carbon/human/beefboy, obj/item/meat, mob/living/carbon/human/attacker, params)
	if(!istype(meat, /obj/item/food/meat/slab))
		return
	var/target_zone = attacker.zone_selected
	if(target_zone == BODY_ZONE_PRECISE_MOUTH && beefboy.get_organ_by_type(/obj/item/organ/internal/tongue))
		return
	var/obj/item/bodypart/affecting = beefboy.get_bodypart(check_zone(target_zone))
	if(!(target_zone in tearable_limbs))
		return
	if(affecting && (!(target_zone == BODY_ZONE_PRECISE_MOUTH) || beefboy.get_organ_by_type(/obj/item/organ/internal/tongue)))
		return
	attacker.visible_message(
		span_notice("[attacker] begins mashing [meat] into [beefboy]."),
		span_notice("You begin mashing [meat] into [beefboy]."))

	if(!do_after(attacker, 2 SECONDS, beefboy))
		return FALSE

	if(target_zone == BODY_ZONE_PRECISE_MOUTH)
		var/obj/item/organ/internal/tongue/beefman/new_tongue = new()
		new_tongue.Insert(attacker)
		attacker.visible_message(
			span_notice("The [meat] sprouts and becomes [beefboy]'s new [new_tongue.name]!"),
			span_notice("The [meat] successfully fuses with your mouth!"))
	else
		var/obj/item/bodypart/new_bodypart = beefboy.newBodyPart(target_zone)
		beefboy.visible_message(
			span_notice("The meat sprouts digits and becomes [beefboy]'s new [new_bodypart.name]!"),
			span_notice("The meat sprouts digits and becomes your new [new_bodypart.name]!"))
		new_bodypart.try_attach_limb(beefboy)
		new_bodypart.update_limb(is_creating = TRUE)
		new_bodypart.give_meat(beefboy, meat)

	qdel(meat)
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
		if(JOB_CAPTAIN)
			new_sash = new /obj/item/clothing/under/bodysash/captain()
		// Security
		if(JOB_HEAD_OF_SECURITY)
			new_sash = new /obj/item/clothing/under/bodysash/security/hos()
		if(JOB_WARDEN)
			new_sash = new /obj/item/clothing/under/bodysash/security/warden()
		if(JOB_SECURITY_OFFICER)
			new_sash = new /obj/item/clothing/under/bodysash/security()
		if(JOB_DETECTIVE)
			new_sash = new /obj/item/clothing/under/bodysash/security/detective()

		// Medical
		if(JOB_CHIEF_MEDICAL_OFFICER)
			new_sash = new /obj/item/clothing/under/bodysash/medical/cmo()
		if(JOB_MEDICAL_DOCTOR)
			new_sash = new /obj/item/clothing/under/bodysash/medical()
		if(JOB_CHEMIST)
			new_sash = new /obj/item/clothing/under/bodysash/medical/chemist()
		if(JOB_PARAMEDIC)
			new_sash = new /obj/item/clothing/under/bodysash/medical/paramedic()

		// Engineering
		if(JOB_CHIEF_ENGINEER)
			new_sash = new /obj/item/clothing/under/bodysash/engineer/ce()
		if(JOB_STATION_ENGINEER)
			new_sash = new /obj/item/clothing/under/bodysash/engineer()
		if(JOB_ATMOSPHERIC_TECHNICIAN)
			new_sash = new /obj/item/clothing/under/bodysash/engineer/atmos()

		// Science
		if(JOB_RESEARCH_DIRECTOR)
			new_sash = new /obj/item/clothing/under/bodysash/rd()
		if(JOB_SCIENTIST)
			new_sash = new /obj/item/clothing/under/bodysash/scientist()
		if(JOB_ROBOTICIST)
			new_sash = new /obj/item/clothing/under/bodysash/roboticist()
		if(JOB_GENETICIST)
			new_sash = new /obj/item/clothing/under/bodysash/geneticist()

		// Supply
		if(JOB_HEAD_OF_PERSONNEL)
			new_sash = new /obj/item/clothing/under/bodysash/hop()
		if(JOB_QUARTERMASTER)
			new_sash = new /obj/item/clothing/under/bodysash/qm()
		if(JOB_CARGO_TECHNICIAN)
			new_sash = new /obj/item/clothing/under/bodysash/cargo()
		if(JOB_SHAFT_MINER)
			new_sash = new /obj/item/clothing/under/bodysash/miner()

		// Service
		if(JOB_CLOWN)
			new_sash = new /obj/item/clothing/under/bodysash/clown()
		if(JOB_MIME)
			new_sash = new /obj/item/clothing/under/bodysash/mime()
		if(JOB_COOK)
			new_sash = new /obj/item/clothing/under/bodysash/cook()
		if(JOB_BARTENDER)
			new_sash = new /obj/item/clothing/under/bodysash/bartender()
		if(JOB_CHAPLAIN)
			new_sash = new /obj/item/clothing/under/bodysash/chaplain()
		if(JOB_CURATOR)
			new_sash = new /obj/item/clothing/under/bodysash/curator()
		if(JOB_LAWYER)
			new_sash = new /obj/item/clothing/under/bodysash/lawyer()
		if(JOB_BOTANIST)
			new_sash = new /obj/item/clothing/under/bodysash/botanist()
		if(JOB_JANITOR)
			new_sash = new /obj/item/clothing/under/bodysash/janitor()
		if(JOB_PSYCHOLOGIST)
			new_sash = new /obj/item/clothing/under/bodysash/psychologist()

		// Assistant
		if(JOB_ASSISTANT)
			new_sash = new /obj/item/clothing/under/bodysash()
		if(JOB_PRISONER)
			new_sash = new /obj/item/clothing/under/bodysash/prisoner()
			if(!visuals_only)
				var/obj/item/implant/tracking/tracking_implant = new()
				tracking_implant.implant(equipping, null, TRUE)
		else
			new_sash = new /obj/item/clothing/under/bodysash/civilian()

	if(equipping.w_uniform)
		qdel(equipping.w_uniform)
	// Equip New
	equipping.equip_to_slot_or_del(new_sash, ITEM_SLOT_ICLOTHING, TRUE) // TRUE is whether or not this is "INITIAL", as in startup
	return ..()

#undef BEEFMAN_BLEEDOUT_LEVEL
