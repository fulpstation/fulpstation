/datum/species/plasmaman
	name = "Plasmaman"
	id = "plasmaman"
	say_mod = "rattles"
	sexes = 0
	meat = /obj/item/stack/sheet/mineral/plasma
	species_traits = list(NOBLOOD,NOTRANSSTING, HAS_BONE)
	// plasmemes get hard to wound since they only need a severe bone wound to dismember, but unlike skellies, they can't pop their bones back into place
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_RESISTCOLD, TRAIT_RADIMMUNE, TRAIT_GENELESS, TRAIT_NOHUNGER, TRAIT_HARDLY_WOUNDED)

	inherent_biotypes = MOB_HUMANOID|MOB_MINERAL
	mutantlungs = /obj/item/organ/lungs/plasmaman
	mutanttongue = /obj/item/organ/tongue/bone/plasmaman
	mutantliver = /obj/item/organ/liver/plasmaman
	mutantstomach = /obj/item/organ/stomach/bone/plasmaman
	burnmod = 1.5
	heatmod = 1.5
	brutemod = 1.5
	payday_modifier = 0.75
	breathid = "tox"
	damage_overlay_type = ""//let's not show bloody wounds or burns over bones.
	var/internal_fire = FALSE //If the bones themselves are burning clothes won't help you much
	disliked_food = FRUIT | CLOTH
	liked_food = VEGETABLES
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC
	outfit_important_for_life = /datum/outfit/plasmaman
	species_language_holder = /datum/language_holder/skeleton

	// Body temperature for Plasmen is much lower human as they can handle colder environments
	bodytemp_normal = (BODYTEMP_NORMAL - 40)
	// The minimum amount they stabilize per tick is reduced making hot areas harder to deal with
	bodytemp_autorecovery_min = 2
	// They are hurt at hot temps faster as it is harder to hold their form
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 20) // about 40C
	// This effects how fast body temp stabilizes, also if cold resit is lost on the mob
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 50) // about -50c

	ass_image = 'icons/ass/assplasma.png'

/datum/species/plasmaman/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	C.set_safe_hunger_level()

/datum/species/plasmaman/spec_life(mob/living/carbon/human/H, delta_time, times_fired)
	var/atmos_sealed = CanIgniteMob(H) && (isclothing(H.wear_suit) && H.wear_suit.clothing_flags & STOPSPRESSUREDAMAGE) && (isclothing(H.head) && H.head.clothing_flags & STOPSPRESSUREDAMAGE)
	if(!atmos_sealed && (!istype(H.w_uniform, /obj/item/clothing/under/plasmaman) || !istype(H.head, /obj/item/clothing/head/helmet/space/plasmaman) || !istype(H.gloves, /obj/item/clothing/gloves)))
		var/datum/gas_mixture/environment = H.loc.return_air()
		if(environment?.total_moles())
			if(environment.gases[/datum/gas/hypernoblium] && (environment.gases[/datum/gas/hypernoblium][MOLES]) >= 5)
				if(H.on_fire && H.fire_stacks > 0)
					H.adjust_fire_stacks(-10 * delta_time)
			else if(!HAS_TRAIT(H, TRAIT_NOFIRE))
				if(environment.gases[/datum/gas/oxygen] && (environment.gases[/datum/gas/oxygen][MOLES]) >= 1) //Same threshhold that extinguishes fire
					H.adjust_fire_stacks(0.25 * delta_time)
					if(!H.on_fire && H.fire_stacks > 0)
						H.visible_message("<span class='danger'>[H]'s body reacts with the atmosphere and bursts into flames!</span>","<span class='userdanger'>Your body reacts with the atmosphere and bursts into flame!</span>")
					H.IgniteMob()
					internal_fire = TRUE
	else if(H.fire_stacks)
		var/obj/item/clothing/under/plasmaman/P = H.w_uniform
		if(istype(P))
			P.Extinguish(H)
			internal_fire = FALSE
	else
		internal_fire = FALSE
	H.update_fire()

/datum/species/plasmaman/handle_fire(mob/living/carbon/human/H, delta_time, times_fired, no_protection = FALSE)
	if(internal_fire)
		no_protection = TRUE
	. = ..()

/datum/species/plasmaman/before_equip_job(datum/job/J, mob/living/carbon/human/H, visualsOnly = FALSE)
	if(J.plasmaman_outfit)
		H.equipOutfit(J.plasmaman_outfit, visualsOnly)
	H.internal = H.get_item_for_held_index(2)
	H.update_internals_hud_icon(1)

/datum/species/plasmaman/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_plasmaman_name()

	var/randname = plasmaman_name()

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/plasmaman/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H, delta_time, times_fired)
	. = ..()
	if(istype(chem, /datum/reagent/toxin/plasma))
		H.reagents.remove_reagent(chem.type, chem.metabolization_rate * delta_time)
		for(var/i in H.all_wounds)
			var/datum/wound/iter_wound = i
			iter_wound.on_xadone(4 * REAGENTS_EFFECT_MULTIPLIER * delta_time) // plasmamen use plasma to reform their bones or whatever
		return TRUE
	if(istype(chem, /datum/reagent/toxin/bonehurtingjuice))
		H.adjustStaminaLoss(7.5 * REAGENTS_EFFECT_MULTIPLIER * delta_time, 0)
		H.adjustBruteLoss(0.5 * REAGENTS_EFFECT_MULTIPLIER * delta_time, 0)
		if(DT_PROB(10, delta_time))
			switch(rand(1, 3))
				if(1)
					H.say(pick("oof.", "ouch.", "my bones.", "oof ouch.", "oof ouch my bones."), forced = /datum/reagent/toxin/bonehurtingjuice)
				if(2)
					H.manual_emote(pick("oofs silently.", "looks like their bones hurt.", "grimaces, as though their bones hurt."))
				if(3)
					to_chat(H, "<span class='warning'>Your bones hurt!</span>")
		if(chem.overdosed)
			if(DT_PROB(2, delta_time) && iscarbon(H)) //big oof
				var/selected_part = pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG) //God help you if the same limb gets picked twice quickly.
				var/obj/item/bodypart/bp = H.get_bodypart(selected_part) //We're so sorry skeletons, you're so misunderstood
				if(bp)
					playsound(H, get_sfx("desecration"), 50, TRUE, -1) //You just want to socialize
					H.visible_message("<span class='warning'>[H] rattles loudly and flails around!!</span>", "<span class='danger'>Your bones hurt so much that your missing muscles spasm!!</span>")
					H.say("OOF!!", forced=/datum/reagent/toxin/bonehurtingjuice)
					bp.receive_damage(200, 0, 0) //But I don't think we should
				else
					to_chat(H, "<span class='warning'>Your missing arm aches from wherever you left it.</span>")
					H.emote("sigh")
		H.reagents.remove_reagent(chem.type, chem.metabolization_rate * delta_time)
		return TRUE
