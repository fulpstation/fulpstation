/*************** Research Designs ***************/

/datum/design/energysniper
	name = "Energy Sniper Rifle"
	desc = "An advanced piece of weaponry forged on Mars in 40th Millenia."
	id = "energysniper"
	construction_time = 200
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 12000, /datum/material/glass = 8000, /datum/material/diamond = 5000, /datum/material/uranium = 10000, /datum/material/silver = 5000, /datum/material/gold = 5000)
	build_path = /obj/item/gun/energy/sniper
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

//Organs
/datum/techweb_node/cyber_organs_ultra
	id = "cyber_organs_ultra"
	display_name = "Quadro-Cybernetic Organs"
	description = "An advanced set of cybernetic organs, used by a group of religious fanatics on Mars."
	prereq_ids = list("cyber_organs_upgraded", "mars_tech")
	design_ids = list("cybernetic_heart_tier4", "cybernetic_lungs_tier4")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

/datum/design/cybernetic_heart/tier4
	name = "Quadro-Cybernetic Heart"
	desc = "An electronic device designed to mimic the functions of an organic human heart. Can inject with set of chemicals when user enter critical condition and regenerate the dose later."
	id = "cybernetic_heart_tier4"
	construction_time = 100
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000, /datum/material/silver=500, /datum/material/gold=500, /datum/material/uranium=500, /datum/material/diamond=500)
	build_path = /obj/item/organ/heart/cybernetic/tier4

/datum/design/cybernetic_lungs/tier4
	name = "Quadro-Cybernetic Lungs"
	desc = "Advanced set of cybernetic lungs capable of filtering high amounts of toxins, cold and heat in the air. This one is capable of working with as low as 6KPa of oxygen. Supplies the body with salbutamol, should the user enter critical condition."
	id = "cybernetic_lungs_tier4"
	construction_time = 100
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000, /datum/material/silver=500, /datum/material/gold=500, /datum/material/uranium=500, /datum/material/diamond=500)
	build_path = /obj/item/organ/lungs/cybernetic/tier4

//Implants
/datum/techweb_node/mars_cyber_implants
	id = "mars_cyber_implants"
	display_name = "Marsian Cybernetic Implants"
	description = "Highly advanced cybernetic implants used to improve efficiency to the maximum."
	prereq_ids = list("combat_cyber_implants", "mars_tech")
	design_ids = list("ci-reviver-plus", "ci-surgery-plus")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

/datum/design/cyberimp_reviver_plus
	name = "Reviver Implant PLUS"
	desc = "This implant will attempt to heal you REALLY FAST if you lose consciousness. For the true warriors!"
	id = "ci-reviver-plus"
	construction_time = 100
	materials = list(/datum/material/iron = 2000, /datum/material/glass = 2000, /datum/material/uranium = 1500, /datum/material/gold = 1000, /datum/material/diamond=500)
	build_path = /obj/item/organ/cyberimp/chest/reviver/plus
	build_type = PROTOLATHE | MECHFAB
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/cyberimp_surgical_plus
	name = "Advanced Surgical Toolset Implant"
	desc = "A set of advanced surgical tools hidden behind a concealed panel on the user's arm."
	id = "ci-surgery-plus"
	construction_time = 100
	materials = list(/datum/material/iron = 5000, /datum/material/glass = 2500, /datum/material/silver = 2000, /datum/material/gold = 1000)
	build_path = /obj/item/organ/cyberimp/arm/surgery/plus
	build_type = PROTOLATHE | MECHFAB
	category = list("Misc", "Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/***************** T4 cybernetics *****************/

//Heart
/obj/item/organ/heart/cybernetic/tier4
	name = "quadro-cybernetic heart"
	desc = "An electronic device designed to mimic the functions of an organic human heart. Can inject with set of chemicals when user enter critical condition and regenerate the dose later."
	icon = 'fulp_modules/features/tech_cult/icons/tier4_organs.dmi'
	icon_state = "heart-c-u3"
	maxHealth = 3 * STANDARD_ORGAN_THRESHOLD
	dose_available = TRUE
	emp_vulnerability = 5

/obj/item/organ/heart/cybernetic/tier4/on_life()
	. = ..()
	if(dose_available && owner.health <= owner.crit_threshold)
		used_dose()

/obj/item/organ/heart/cybernetic/tier4/used_dose()
	. = ..()
	owner.reagents.add_reagent(/datum/reagent/medicine/atropine, 5)
	owner.reagents.add_reagent(/datum/reagent/medicine/sal_acid, 3)
	owner.reagents.add_reagent(/datum/reagent/medicine/oxandrolone, 3)
	addtimer(VARSET_CALLBACK(src, dose_available, TRUE), 2 MINUTES)

//Lungs
/obj/item/organ/lungs/cybernetic/tier4
	name = "quadro-cybernetic lungs"
	desc = "Advanced set of cybernetic lungs capable of filtering high amounts of toxins, cold and heat in the air. This one is capable of working with as low as 6KPa of oxygen. Supplies the body with salbutamol, should the user enter critical condition."
	icon_state = "lungs-c-u2"
	safe_toxins_max = 50
	safe_co2_max = 50
	safe_oxygen_min = 6
	maxHealth = 3 * STANDARD_ORGAN_THRESHOLD
	emp_vulnerability = 5

	var/dose_available = TRUE

	cold_level_1_threshold = 140
	cold_level_2_threshold = 80
	cold_level_3_threshold = 30
	heat_level_1_threshold = 800
	heat_level_2_threshold = 1600
	heat_level_3_threshold = 2400

/obj/item/organ/lungs/cybernetic/tier4/on_life()
	. = ..()
	if(dose_available && owner.health <= owner.crit_threshold)
		used_dose()

/obj/item/organ/lungs/cybernetic/tier4/proc/used_dose()
	owner.reagents.add_reagent(/datum/reagent/medicine/salbutamol, 5)
	dose_available = FALSE
	addtimer(VARSET_CALLBACK(src, dose_available, TRUE), 2 MINUTES)

// Reviver Implant PLUS
/obj/item/organ/cyberimp/chest/reviver/plus
	name = "Reviver implant PLUS"
	desc = "This implant will attempt to heal you REALLY FAST if you lose consciousness. For the true warriors!"
	implant_color = "#CC0605" //Cooler red

/obj/item/organ/cyberimp/chest/reviver/plus/on_life()
	if(reviving)
		switch(owner.stat)
			if(UNCONSCIOUS, HARD_CRIT)
				addtimer(CALLBACK(src, .proc/heal), 2 SECONDS)
			else
				COOLDOWN_START(src, reviver_cooldown, revive_cost)
				reviving = FALSE
				to_chat(owner, "<span class='notice'>Your reviver implant shuts down and starts recharging. It will be ready again in [DisplayTimeText(revive_cost)].</span>")
		return

	if(!COOLDOWN_FINISHED(src, reviver_cooldown) || owner.suiciding)
		return

	switch(owner.stat)
		if(UNCONSCIOUS, HARD_CRIT)
			revive_cost = 0
			reviving = TRUE
			to_chat(owner, "<span class='notice'>You feel a faint buzzing as your reviver implant starts patching your wounds...</span>")

/obj/item/organ/cyberimp/chest/reviver/plus/heal()
	var/list/parts = owner.get_damaged_bodyparts(TRUE, TRUE, status = BODYPART_ROBOTIC)
	if(owner.getToxLoss())
		owner.adjustToxLoss(-3, TRUE)
		revive_cost += 30
	if(owner.getOxyLoss())
		owner.adjustOxyLoss(-10, TRUE) //REAL fast
		revive_cost += 5
	if(parts.len > 0)
		for(var/obj/item/bodypart/L in parts)
			L.heal_damage(2, 2, null, BODYPART_ROBOTIC)
			revive_cost += 20
	if(!parts.len)
		if(owner.getBruteLoss())
			owner.adjustBruteLoss(-5, TRUE)
			revive_cost += 50
		if(owner.getFireLoss())
			owner.adjustFireLoss(-5, TRUE)
			revive_cost += 50

//Advanced Surgical Toolset Implant
/obj/item/organ/cyberimp/arm/surgery/plus
	name = "advanced surgical toolset implant"
	desc = "A set of advanced surgical tools hidden behind a concealed panel on the user's arm."
	contents = newlist(/obj/item/retractor/advanced/augment, /obj/item/surgicaldrill/advanced/augment, /obj/item/scalpel/advanced/augment, /obj/item/surgical_drapes)

/obj/item/retractor/advanced/augment
	toolspeed = 0.3 //I AM SPEED!!

/obj/item/surgicaldrill/advanced/augment
	toolspeed = 0.3 //Still not as fast as alien tools though.

/obj/item/scalpel/advanced/augment
	toolspeed = 0.3

/***************** Armor *****************/

//Basic
/obj/item/clothing/suit/hooded/techpriest/armor/plate
	name = "armored techpriest robes"
	desc = "An armored version of robes worn by followers of the machine god."
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/pickaxe, /obj/item/organ/regenerative_core/legion, /obj/item/kitchen/knife/combat/bone, /obj/item/kitchen/knife/combat/survival, /obj/item/gun/energy)
	armor = list(MELEE = 30, BULLET = 10, LASER = 20, ENERGY = 30, BOMB = 30, BIO = 60, RAD = 30, FIRE = 60, ACID = 60)
	hoodtype = /obj/item/clothing/head/hooded/techpriest/armor/plate
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	cold_protection = CHEST|GROIN|LEGS|ARMS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|ARMS
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/hooded/techpriest/armor/plate/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/hooded/techpriest/armor/plate
	name = "armored techpriest's hood"
	desc = "An armored version of hood worn by followers of the machine god."
	armor = list(MELEE = 30, BULLET = 10, LASER = 20, ENERGY = 30, BOMB = 30, BIO = 60, RAD = 30, FIRE = 60, ACID = 60)
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT

/obj/item/clothing/head/hooded/techpriest/armor/plate/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/hooded/techpriest/armor/lead
	name = "blessed tech robes"
	desc = "From the rage of the beast, Machine God protect us."
	armor = list(MELEE = 40, BULLET = 20, LASER = 20, ENERGY = 30, BOMB = 50, BIO = 100, RAD = 40, FIRE = 100, ACID = 100)
	hoodtype = /obj/item/clothing/head/hooded/techpriest/armor/lead
	cold_protection = CHEST|GROIN|LEGS|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	transparent_protection = HIDEGLOVES|HIDESUITSTORAGE|HIDEJUMPSUIT|HIDESHOES
	var/suit_faction = TECH_CULT_FACTION

/obj/item/clothing/suit/hooded/techpriest/armor/lead/Initialize()
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, ITEM_SLOT_OCLOTHING, INFINITY, FALSE)

/obj/item/clothing/head/hooded/techpriest/armor/lead
	name = "blessed tech hood"
	desc = "From the weakness of the mind, Omnissiah set us free."
	armor = list(MELEE = 40, BULLET = 20, LASER = 20, ENERGY = 30, BOMB = 50, BIO = 100, RAD = 40, FIRE = 100, ACID = 100)
	heat_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	transparent_protection = HIDEMASK

/obj/item/clothing/suit/hooded/techpriest/armor/lead/equipped(mob/living/user, slot)
	. = ..()
	if(!(suit_faction in user.faction))
		to_chat(user, "<span class='warning'>The machine god will never allow this!</span>")
		user.dropItemToGround(src, TRUE)
		user.Paralyze(3 SECONDS)
		user.Dizzy(5 SECONDS)
	else
		if(!(user.mind.holy_role))
			to_chat(user, "<span class='warning'>Your time will come later.</span>")
			user.dropItemToGround(src, TRUE)
			user.Paralyze(3 SECONDS)
			user.Dizzy(5 SECONDS)

/***************** Credo Omnissiah *****************/

/obj/item/storage/book/bible/omnissiah
	name = "Credo Omnissiah"
	desc = "The holy book of Cult Mechanicum."
	deity_name = "Omnissiah"
	icon_state = "scientology"
	inhand_icon_state = "scientology"

//Large copy-pasta from religion_sects.dm
/obj/item/storage/book/bible/omnissiah/bless(mob/living/L, mob/living/user)
	if(iscyborg(L))
		var/mob/living/silicon/robot/R = L
		var/charge_amt = 100
		R.cell?.charge += charge_amt
		R.visible_message("<span class='notice'>[user] charges [R] with the power of Omnissiah!</span>")
		to_chat(R, "<span class='boldnotice'>You are charged by the power of Omnissiah!</span>")
		SEND_SIGNAL(R, COMSIG_ADD_MOOD_EVENT, "blessing", /datum/mood_event/blessing)
		playsound(user, 'sound/effects/bang.ogg', 25, TRUE, -1)
		return TRUE
	if(!ishuman(L))
		return
	var/mob/living/carbon/human/H = L

	var/did_we_charge = FALSE
	var/obj/item/organ/stomach/ethereal/eth_stomach = H.getorganslot(ORGAN_SLOT_STOMACH)
	if(istype(eth_stomach))
		eth_stomach.adjust_charge(3)
		did_we_charge = TRUE

	var/obj/item/bodypart/BP = H.get_bodypart(user.zone_selected)
	if(BP.status != BODYPART_ROBOTIC)
		if(!did_we_charge)
			to_chat(user, "<span class='warning'>Omnissiah scoffs at the idea of healing such fleshy matter!</span>")
		else
			H.visible_message("<span class='notice'>[user] charges [H] with the power of Omnissiah!</span>")
			to_chat(H, "<span class='boldnotice'>You feel charged by the power of Omnissiah!</span>")
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "blessing", /datum/mood_event/blessing)
			playsound(user, 'sound/machines/synth_yes.ogg', 25, TRUE, -1)
		return TRUE

	if(BP.heal_damage(10,10,null,BODYPART_ROBOTIC))
		H.update_damage_overlays()

	H.visible_message("<span class='notice'>[user] [did_we_charge ? "repairs" : "repairs and charges"] [H] with the power of Omnissiah!</span>")
	to_chat(H, "<span class='boldnotice'>The inner machinations of Omnissiah [did_we_charge ? "repairs" : "repairs and charges"] you!</span>")
	playsound(user, 'sound/effects/bang.ogg', 25, TRUE, -1)
	SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "blessing", /datum/mood_event/blessing)
	return TRUE

/***************** Spell *****************/

/obj/item/book/granter/spell/omnissiah
	name = "Encrypted book"
	desc = "The book filled with highly-technical religious texts, allowing a higher tech priests to directly interpret the word of the Machine God itself."
	spell = /obj/effect/proc_holder/spell/aoe_turf/conjure/tech
	spellname = "holy gift"
	icon_state ="bookcharge"
	remarks = list(
		"But will it make me a mech?",
		"I could've just used the exosuit fabricator, huh?",
		"All-powerful god, send me a honkbot!",
		"So it is a pocket robotics factory.",
		"This page is just full of binary code...",
		"Can it give me a laser arm?",
		"But can I get combat implants this way?",
	)

/obj/item/book/granter/spell/omnissiah/recoil(mob/living/user)
	. = ..()
	to_chat(user,"<span class='warning'>You're knocked down!</span>")
	user.Paralyze(5 SECONDS)

/obj/effect/proc_holder/spell/aoe_turf/conjure/tech
	name = "Gift of the Omnissiah"
	desc = "This spell allows the user to receive a gift from the unknown dimension."
	school = "conjuration"
	charge_max = 1800
	clothes_req = FALSE
	invocation = "BI NA'Y RE"
	invocation_type = "shout"
	range = 0
	summon_type = list(/obj/effect/spawner/lootdrop/omnissiah)
	action_icon_state = "emp"
	cast_sound = 'sound/magic/disable_tech.ogg'

/obj/effect/spawner/lootdrop/omnissiah
	name = "omnissiah gift spawner"
	lootdoubles = FALSE
	loot = list(
		/obj/item/stack/sheet/iron/twenty = 68,
		/mob/living/simple_animal/bot/medbot = 60,
		/mob/living/simple_animal/bot/cleanbot = 56,
		/obj/item/paicard = 52,
		/mob/living/simple_animal/bot/honkbot = 48,
		/obj/item/robot_suit/prebuilt = 40,
		/obj/item/mmi/posibrain = 34,
		/obj/item/organ/heart/cybernetic/tier4 = 13,
		/obj/item/organ/lungs/cybernetic/tier4 = 13,
		/obj/item/organ/cyberimp/chest/reviver/plus = 11,
		/obj/item/organ/cyberimp/arm/surgery/plus = 11,
		/obj/item/organ/cyberimp/arm/gun/laser = 2,
		/obj/item/organ/cyberimp/arm/combat = 1,
	)
