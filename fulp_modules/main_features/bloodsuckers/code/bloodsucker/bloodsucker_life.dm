/*
 *		TO PLUG INTO LIFE:
 *
 * Cancel BLOOD life
 * Cancel METABOLISM life   (or find a way to control what gets digested)
 *
 * 		EXAMINE
 *
 * Show as dead when...
 */

/// Runs from BiologicalLife, handles all Bloodsucker constant proccesses.
/datum/antagonist/bloodsucker/proc/LifeTick()
	if(!owner || AmFinalDeath)
		return
	/// Deduct Blood
	if(owner.current.stat == CONSCIOUS && !poweron_feed && !HAS_TRAIT(owner.current, TRAIT_NODEATH))
		AddBloodVolume(passive_blood_drain) // -.1 currently
	if(HandleHealing(1))
		if(!notice_healing && owner.current.blood_volume > 0)
			to_chat(owner, "<span class='notice'>The power of your blood begins knitting your wounds...</span>")
			notice_healing = TRUE
	else if(notice_healing)
		notice_healing = FALSE
	/// In a Frenzy? Take damage, to encourage them to Feed as soon as possible.
	if(Frenzied)
		owner.current.adjustFireLoss(3)
	/// Special check, Tremere Bloodsuckers burn while in the Chapel
	if(my_clan == CLAN_TREMERE)
		var/area/A = get_area(owner.current)
		if(istype(A, /area/service/chapel))
			to_chat(owner.current, "<span class='warning'>You don't belong in holy areas!</span>")
			owner.current.adjustFireLoss(10)
			owner.current.adjust_fire_stacks(2)
			owner.current.IgniteMob()
	/// Standard Updates
	HandleDeath()
	HandleStarving()
	HandleTorpor()
	update_hud()

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//			BLOOD

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/antagonist/bloodsucker/proc/AddBloodVolume(value)
	owner.current.blood_volume = clamp(owner.current.blood_volume + value, 0, max_blood_volume)
	update_hud()

/// mult: SILENT feed is 1/3 the amount
/datum/antagonist/bloodsucker/proc/HandleFeeding(mob/living/carbon/target, mult=1)
	/// Starts at 15 (now 8 since we doubled the Feed time)
	var/blood_taken = min(feed_amount, target.blood_volume) * mult
	target.blood_volume -= blood_taken
	// Simple Animals lose a LOT of blood, and take damage. This is to keep cats, cows, and so forth from giving you insane amounts of blood.
	if(!ishuman(target))
		target.blood_volume -= (blood_taken / max(target.mob_size, 0.1)) * 3.5 // max() to prevent divide-by-zero
		target.apply_damage_type(blood_taken / 3.5) // Don't do too much damage, or else they die and provide no blood nourishment.
		if(target.blood_volume <= 0)
			target.blood_volume = 0
			target.death(0)
	///////////
	// Shift Body Temp (toward Target's temp, by volume taken)
	owner.current.bodytemperature = ((owner.current.blood_volume * owner.current.bodytemperature) + (blood_taken * target.bodytemperature)) / (owner.current.blood_volume + blood_taken)
	// our volume * temp, + their volume * temp, / total volume
	///////////
	// Reduce Value Quantity
	if(target.stat == DEAD) // Penalty for Dead Blood
		blood_taken /= 3
	if(!ishuman(target)) // Penalty for Non-Human Blood
		blood_taken /= 2
	//if (!iscarbon(target)) // Penalty for Animals (they're junk food)
	// Apply to Volume
	AddBloodVolume(blood_taken)
	// Reagents (NOT Blood!)
	if(target.reagents && target.reagents.total_volume)
		target.reagents.trans_to(owner.current, INGEST, 1) // Run transfer of 1 unit of reagent from them to me.
	owner.current.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, 1) // Play THIS sound for user only. The "null" is where turf would go if a location was needed. Null puts it right in their head.

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//			HEALING

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/// NOTE: Mult of 0 is just a TEST to see if we are injured and need to go into Torpor!
/// It is called from your coffin on close (by you only)
/datum/antagonist/bloodsucker/proc/HandleHealing(mult = 1)
	var/actual_regen = bloodsucker_regen_rate + additional_regen
	if(poweron_masquerade|| owner.current.AmStaked())
		return FALSE
	if(owner.current.reagents.has_reagent(/datum/reagent/consumable/garlic))
		return FALSE
	if(HAS_TRAIT(owner.current, TRAIT_TOXINLOVER)) // Removes slimeperson bonus
		REMOVE_TRAIT(owner.current, TRAIT_TOXINLOVER, SPECIES_TRAIT)
	owner.current.adjustCloneLoss(-1 * (actual_regen * 4) * mult, 0)
	owner.current.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1 * (actual_regen * 4) * mult) //adjustBrainLoss(-1 * (actual_regen * 4) * mult, 0)
	if(iscarbon(owner.current)) // Damage Heal: Do I have damage to ANY bodypart?
		var/mob/living/carbon/C = owner.current
		var/costMult = 1 // Coffin makes it cheaper
		var/bruteheal = min(C.getBruteLoss_nonProsthetic(), actual_regen) // BRUTE: Always Heal
		var/fireheal = 0 // BURN: Heal in Coffin while Fakedeath, or when damage above maxhealth (you can never fully heal fire)
		/// Checks if you're in a coffin here, additionally checks for Torpor right below it.
		var/amInCoffinWhileTorpor = istype(C.loc, /obj/structure/closet/crate/coffin)
		if(amInCoffinWhileTorpor && HAS_TRAIT(C, TRAIT_NODEATH))
			fireheal = min(C.getFireLoss_nonProsthetic(), actual_regen)
			mult *= 5 // Increase multiplier if we're sleeping in a coffin.
			C.extinguish_mob()
			C.remove_all_embedded_objects() // Remove Embedded!
			CheckVampOrgans() // Heart
			if(check_limbs(costMult))
				return TRUE
		/// In Torpor, but not in a Coffin? Heal faster anyways.
		else if(HAS_TRAIT(C, TRAIT_NODEATH))
			mult *= 3
		/// Heal if Damaged
		if(bruteheal + fireheal > 0) // Just a check? Don't heal/spend, and return.
			// We have damage. Let's heal (one time)
			C.adjustBruteLoss(-bruteheal * mult, forced=TRUE) // Heal BRUTE / BURN in random portions throughout the body.
			C.adjustFireLoss(-fireheal * mult, forced=TRUE)
			AddBloodVolume((bruteheal * -0.5 + fireheal * -1) / mult * costMult) // Costs blood to heal
			return TRUE

/datum/antagonist/bloodsucker/proc/check_limbs(costMult)
	var/limb_regen_cost = 50 * costMult
	var/mob/living/carbon/C = owner.current
	var/list/missing = C.get_missing_limbs()
	if(missing.len && C.blood_volume < limb_regen_cost + 5)
		return FALSE
	for(var/targetLimbZone in missing) // 1) Find ONE Limb and regenerate it.
		C.regenerate_limb(targetLimbZone, FALSE) // regenerate_limbs() <--- If you want to EXCLUDE certain parts, do it like this ----> regenerate_limbs(0, list("head"))
		AddBloodVolume(50)
		var/obj/item/bodypart/L = C.get_bodypart(targetLimbZone) // 2) Limb returns Damaged
		L.brute_dam = 60
		to_chat(C, "<span class='notice'>Your flesh knits as it regrows your [L]!</span>")
		playsound(C, 'sound/magic/demon_consume.ogg', 50, TRUE)
		return TRUE

/datum/antagonist/bloodsucker/proc/CureDisabilities()
	var/mob/living/carbon/C = owner.current
	/// Remove their husk first, so everything else can work
	C.cure_husk()
	/// Now repair their organs - Note that Bloodsuckers currently (if intended) don't regenerate lost organs.
	for(var/O in C.internal_organs) // NOTE: Giving them passive organ regeneration will cause Torpor to spam /datum/client_colour/monochrome at you!
		var/obj/item/organ/organ = O
		organ.setOrganDamage(0)
	/// Torpor revives the dead once complete.
	if(C.stat == DEAD)
		C.revive(full_heal = FALSE, admin_revive = FALSE)
	/// Clear all Wounds
	for(var/i in C.all_wounds)
		var/datum/wound/iter_wound = i
		iter_wound.remove_wound()
	/// Remove Body Eggs & Zombie tumors - From panacea.dm
	var/list/bad_organs = list(
		C.getorgan(/obj/item/organ/body_egg),
		C.getorgan(/obj/item/organ/zombie_infection))
	for(var/tumors in bad_organs)
		var/obj/item/organ/yucky_organs = tumors
		if(!istype(yucky_organs))
			continue
		yucky_organs.Remove(C)
		yucky_organs.forceMove(get_turf(C))

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//			DEATH

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/// FINAL DEATH
/datum/antagonist/bloodsucker/proc/HandleDeath()
	/// Not "Alive"?
	if(!owner.current || !isliving(owner.current) || isbrain(owner.current) || !get_turf(owner.current))
		FinalDeath()
		return
	/// Fire Damage? (above double health)
	if(owner.current.getFireLoss() >= owner.current.maxHealth * 2.5)
		FinalDeath()
		return
	/// Staked while "Temp Death" or Asleep
	if(owner.current.StakeCanKillMe() && owner.current.AmStaked())
		FinalDeath()
		return
	/// Not organic/living? (Zombie/Skeleton/Plasmaman)
	if(!(owner.current.mob_biotypes & MOB_ORGANIC))
		FinalDeath()
		return
	/* !! Removed due to killing Slimepeople. Replaced with the ORGANIG check above. Torpor should be checking their organs anyways.
	// Missing Brain or Heart?
	if(!owner.current.HaveBloodsuckerBodyparts())
		FinalDeath()
		return
	*/
	/*
	// Disable Powers: Masquerade * NOTE * This should happen as a FLAW!
	if(stat >= UNCONSCIOUS)
		for(var/datum/action/bloodsucker/masquerade/P in powers)
			P.Deactivate()
	*/
	/// Temporary Death? Convert to Torpor.
	if(owner.current.stat == DEAD)
		var/mob/living/carbon/human/H = owner.current
		/// We won't use the spam check if they're on masquerade, we want to spam them until they notice, else they'll cry to me about shit being broken.
		if(poweron_masquerade)
			to_chat(H, "<span class='warning'>Your wounds will not heal until you disable the <span class='boldnotice'>Masquerade</span> power.</span>")
		else if(!HAS_TRAIT(H, TRAIT_NODEATH))
			if(HandleHealing(1))
				to_chat(H, "<span class='danger'>Your immortal body will not yet relinquish your soul to the abyss. You enter Torpor.</span>")
				Torpor_Begin()
				return

/*
 *	High: 	Faster Healing
 *	Med: 	Pale
 *	Low: 	Twitch
 *	V.Low:   Blur Vision
 *	EMPTY:	Frenzy!
 */

/// I am thirsty for blood!
/datum/antagonist/bloodsucker/proc/HandleStarving()
	if(!owner.current || AmFinalDeath)
		return

	/// Nutrition - The amount of blood is how full we are.
	owner.current.set_nutrition(min(owner.current.blood_volume, NUTRITION_LEVEL_FED))

	// BLOOD_VOLUME_GOOD: [336]  Pale (handled in bloodsucker_integration.dm)

	// BLOOD_VOLUME_BAD: [224]  Jitter
	if(owner.current.blood_volume < BLOOD_VOLUME_BAD && !prob(0.5 && HAS_TRAIT(owner, TRAIT_NODEATH)) && !poweron_masquerade)
		owner.current.Jitter(3)

	/// Blood Volume: 250 - Exit Frenzy (If in one) This is really high because we want this to be enough to kill the poor soul they feed off of.
	if(owner.current.blood_volume >= 250 && Frenzied)
		Frenzy_End()

	// BLOOD_VOLUME_SURVIVE: [122]  Blur Vision
	if(owner.current.blood_volume < BLOOD_VOLUME_SURVIVE)
		owner.current.blur_eyes(8 - 8 * (owner.current.blood_volume / BLOOD_VOLUME_BAD))

	/// Frenzy & Regeneration - The more blood, the better the Regeneration, get too low blood, and you enter Frenzy.
	if(owner.current.blood_volume < 25 && !Frenzied)
		Frenzy_Start()
	else if(owner.current.blood_volume < 100 && my_clan == CLAN_BRUJAH && !Frenzied)
		Frenzy_Start()
	else if(owner.current.blood_volume < BLOOD_VOLUME_BAD)
		additional_regen = 0.1
	else if(owner.current.blood_volume < BLOOD_VOLUME_OKAY)
		additional_regen = 0.2
	else if(owner.current.blood_volume < BLOOD_VOLUME_NORMAL)
		additional_regen = 0.3
	else if(owner.current.blood_volume < 700)
		additional_regen = 0.4

/// Frenzy's End is in HandleStarving.
/datum/antagonist/bloodsucker/proc/Frenzy_Start()
	to_chat(owner.current, "<span class='userdanger'><FONT size = 3>Blood! You need Blood, now! You enter a total Frenzy!</span>")
	to_chat(owner.current, "<span class='announce'>* Bloodsucker Tip: While in Frenzy, you instantly Aggresively grab, cannot speak, hear, get stunned, or use any powers outside of Feed.</span><br>")
	/// Disable ALL Powers
	for(var/datum/action/bloodsucker/power in powers)
		if(power.active)
			power.DeactivatePower()
	owner.current.add_client_colour(/datum/client_colour/cursed_heart_blood)//bloodlust) <-- You can barely see shit, cant even see anyone to feed off of them.
	ADD_TRAIT(owner.current, TRAIT_MUTE, BLOODSUCKER_TRAIT)
	ADD_TRAIT(owner.current, TRAIT_DEAF, BLOODSUCKER_TRAIT)
	ADD_TRAIT(owner.current, TRAIT_STUNIMMUNE, BLOODSUCKER_TRAIT)
	/// Congratulations, you are the dumbest guy in Town.
	if(HAS_TRAIT(owner.current, TRAIT_ADVANCEDTOOLUSER))
		REMOVE_TRAIT(owner.current, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
	frenzygrab.teach(owner.current, TRUE)
	Frenzied = TRUE

/datum/antagonist/bloodsucker/proc/Frenzy_End()
	to_chat(owner.current, "<span class='warning'>You suddenly come back to your senses...</span>")
	owner.current.remove_client_colour(/datum/client_colour/cursed_heart_blood)
	REMOVE_TRAIT(owner.current, TRAIT_MUTE, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(owner.current, TRAIT_DEAF, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(owner.current, TRAIT_STUNIMMUNE, BLOODSUCKER_TRAIT)
	/// Congratulations, you know now how to read again!
	if(!HAS_TRAIT(owner.current, TRAIT_ADVANCEDTOOLUSER))
		ADD_TRAIT(owner.current, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
	frenzygrab.remove(owner.current)
	owner.current.Dizzy(5 SECONDS)
	owner.current.Paralyze(3 SECONDS)
	Frenzied = FALSE

/datum/antagonist/bloodsucker/proc/HandleTorpor()
	if(!owner.current || AmFinalDeath)
		return
	/// We have to use carbon here, otherwise we use the mob/living one, which is an empty return.
	var/mob/living/carbon/B = owner.current
	var/total_brute = B.getBruteLoss_nonProsthetic()
	var/total_burn = B.getFireLoss_nonProsthetic()
	var/total_damage = total_brute + total_burn
	if(istype(owner.current.loc, /obj/structure/closet/crate/coffin))
		if(!HAS_TRAIT(owner.current, TRAIT_NODEATH))
			/// Staked? Dont heal
			if(owner.current.AmStaked())
				to_chat(owner.current, "<span class='userdanger'>You are staked! Remove the offending weapon from your heart before sleeping.</span>")
				return
			/// Otherwise, check for Sol, or if injured enough to enter Torpor.
			if(clan.bloodsucker_sunlight.amDay || total_damage >= 10)
				to_chat(owner.current, "<span class='notice'>You enter the horrible slumber of deathless Torpor. You will heal until you are renewed.</span>")
				Torpor_Begin()
	/// If it's not Sol and you have 0 Brute damage, check to End Torpor.
	if(!clan.bloodsucker_sunlight.amDay && total_brute <= 10)
		if(HAS_TRAIT(owner.current, TRAIT_NODEATH))
			Check_End_Torpor()

/datum/antagonist/bloodsucker/proc/Torpor_Begin()
	/// Force them to go to sleep
	REMOVE_TRAIT(owner.current, TRAIT_SLEEPIMMUNE, BLOODSUCKER_TRAIT)
	/// Without this, you'll just keep dying while you recover.
	ADD_TRAIT(owner.current, TRAIT_NODEATH, BLOODSUCKER_TRAIT)
	ADD_TRAIT(owner.current, TRAIT_FAKEDEATH, BLOODSUCKER_TRAIT)
	ADD_TRAIT(owner.current, TRAIT_DEATHCOMA, BLOODSUCKER_TRAIT)
	owner.current.Jitter(0)
	/// Disable ALL Powers
	for(var/datum/action/bloodsucker/power in powers)
		if(power.active && !power.can_use_in_torpor)
			power.DeactivatePower()

/datum/antagonist/bloodsucker/proc/Check_End_Torpor()
	/// Sol ended OR Have 0 Brute damage, and you're not in a Coffin? End Torpor.
	if(!istype(owner.current.loc, /obj/structure/closet/crate/coffin))
		Torpor_End()
	else
	/// You are in a Coffin, so instead we'll take Burn into account, too.
		var/mob/living/carbon/B = owner.current
		var/total_brute = B.getBruteLoss_nonProsthetic()
		var/total_burn = B.getFireLoss_nonProsthetic()
		var/total_damage = total_brute + total_burn
		if(!clan.bloodsucker_sunlight.amDay && total_damage <= 10)
			Torpor_End()

/datum/antagonist/bloodsucker/proc/Torpor_End()
	to_chat(owner.current, "<span class='warning'>You have recovered from Torpor.</span>")
	REMOVE_TRAIT(owner.current, TRAIT_DEATHCOMA, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(owner.current, TRAIT_FAKEDEATH, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(owner.current, TRAIT_NODEATH, BLOODSUCKER_TRAIT)
	ADD_TRAIT(owner.current, TRAIT_SLEEPIMMUNE, BLOODSUCKER_TRAIT)
	CureDisabilities()

/// Gibs the Bloodsucker, roundremoving them.
/datum/antagonist/bloodsucker/proc/FinalDeath()
	if(AmFinalDeath)
		return
	/// We are dead now.
	AmFinalDeath = TRUE
	/// Check for non carbons.
	if(!iscarbon(owner.current))
		owner.current.gib()
		return
	playsound(get_turf(owner.current), 'sound/effects/tendril_destroyed.ogg', 60, 1)
	owner.current.drop_all_held_items()
	owner.current.unequip_everything()
	var/mob/living/carbon/C = owner.current
	C.remove_all_embedded_objects()
	/// Free my Vassals!
	FreeAllVassals()
	/// Elders get Dusted
	if(bloodsucker_level >= 4)
		owner.current.visible_message("<span class='warning'>[owner.current]'s skin crackles and dries, their skin and bones withering to dust. A hollow cry whips from what is now a sandy pile of remains.</span>", \
			 "<span class='userdanger'>Your soul escapes your withering body as the abyss welcomes you to your Final Death.</span>", \
			 "<span class='italics'>You hear a dry, crackling sound.</span>")
		addtimer(CALLBACK(owner.current, /mob/living/proc/dust), 5 SECONDS, TIMER_UNIQUE | TIMER_STOPPABLE)
	/// Fledglings get Gibbed
	else
		owner.current.visible_message("<span class='warning'>[owner.current]'s skin bursts forth in a spray of gore and detritus. A horrible cry echoes from what is now a wet pile of decaying meat.</span>", \
			 "<span class='userdanger'>Your soul escapes your withering body as the abyss welcomes you to your Final Death.</span>", \
			 "<span class='italics'>You hear a wet, bursting sound.</span>")
		owner.current.gib(TRUE, FALSE, FALSE)
	playsound(owner.current, 'sound/effects/tendril_destroyed.ogg', 40, TRUE)

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//			HUMAN FOOD

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/// This isnt ever called, someone should really add it eventually...
/mob/proc/CheckBloodsuckerEatFood(food_nutrition)
	if(!isliving(src))
		return
	var/mob/living/L = src
	if(!IS_BLOODSUCKER(L))
		return
	// We're a bloodsucker? Try to eat food...
	var/datum/antagonist/bloodsucker/B = L.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	B.handle_eat_human_food(food_nutrition)


/datum/antagonist/bloodsucker/proc/handle_eat_human_food(food_nutrition, puke_blood = TRUE, masquerade_override) // Called from snacks.dm and drinks.dm
	set waitfor = FALSE
	if(!owner.current || !iscarbon(owner.current))
		return
	var/mob/living/carbon/C = owner.current
	// Remove Nutrition, Give Bad Food
	C.adjust_nutrition(-food_nutrition)
	foodInGut += food_nutrition
	// Already ate some bad clams? Then we can back out, because we're already sick from it.
	if(foodInGut != food_nutrition)
		return
	// Haven't eaten, but I'm in a Human Disguise.
	else if(poweron_masquerade && !masquerade_override)
		to_chat(C, "<span class='notice'>Your stomach turns, but your \"human disguise\" keeps the food down...for now.</span>")
	// Keep looping until we purge. If we have activated our Human Disguise, we ignore the food. But it'll come up eventually...
	var/sickphase = 0
	while(foodInGut && do_mob(C, C, 5 SECONDS, timed_action_flags = (IGNORE_USER_LOC_CHANGE|IGNORE_TARGET_LOC_CHANGE|IGNORE_HELD_ITEM|IGNORE_INCAPACITATED), progress = FALSE))
		C.adjust_disgust(10 * sickphase)
		// Wait an interval...
		sleep(50 + 50 * sickphase) // At intervals of 100, 150, and 200. (10 seconds, 15 seconds, and 20 seconds)
		// Died? Cancel
		if(C.stat == DEAD)
			return
		// Put up disguise? Then hold off the vomit.
		if(poweron_masquerade && !masquerade_override)
			if(sickphase > 0)
				to_chat(C, "<span class='notice'>Your stomach settles temporarily. You regain your composure...for now.</span>")
			sickphase = 0
			continue
		switch(sickphase)
			if(1)
				to_chat(C, "<span class='warning'>You feel unwell. You can taste ash on your tongue.</span>")
				C.Stun(10)
			if(2)
				to_chat(C, "<span class='warning'>Your stomach turns. Whatever you ate tastes of grave dirt and brimstone.</span>")
				C.Dizzy(15)
				C.Stun(13)
			if(3)
				to_chat(C, "<span class='warning'>You purge the food of the living from your viscera! You've never felt worse.</span>")
				 //Puke blood only if puke_blood is true, and loose some blood, else just puke normally.
				if(puke_blood)
					C.blood_volume = max(0, C.blood_volume - foodInGut * 2)
					C.vomit(foodInGut * 4, foodInGut * 2, 0)
				else
					C.vomit(foodInGut * 4, FALSE, 0)
				C.Stun(30)
				//C.Dizzy(50)
				foodInGut = 0
				SEND_SIGNAL(C, COMSIG_ADD_MOOD_EVENT, "vampdisgust", /datum/mood_event/bloodsucker_disgust)
		sickphase++

/// Bloodsuckers moodlets
/datum/mood_event/drankblood
	description = "<span class='nicegreen'>I have fed greedly from that which nourishes me.</span>\n"
	mood_change = 10
	timeout = 8 MINUTES

/datum/mood_event/drankblood_bad
	description = "<span class='boldwarning'>I drank the blood of a lesser creature. Disgusting.</span>\n"
	mood_change = -4
	timeout = 5 MINUTES

/datum/mood_event/drankblood_dead
	description = "<span class='boldwarning'>I drank dead blood. I am better than this.</span>\n"
	mood_change = -7
	timeout = 8 MINUTES

/datum/mood_event/drankblood_synth
	description = "<span class='boldwarning'>I drank synthetic blood. What is wrong with me?</span>\n"
	mood_change = -7
	timeout = 8 MINUTES

/datum/mood_event/madevamp
	description = "<span class='boldwarning'>A soul has been cursed to undeath by my own hand.</span>\n"
	mood_change = -10
	timeout = 10 MINUTES

/datum/mood_event/vampatefood
	description = "<span class='boldwarning'>Mortal nourishment no longer sustains me. I feel unwell.</span>\n"
	mood_change = -6
	timeout = 8 MINUTES

/datum/mood_event/coffinsleep
	description = "<span class='nicegreen'>I slept in a coffin during the day. I feel whole again.</span>\n"
	mood_change = 10
	timeout = 10 MINUTES

/datum/mood_event/daylight_1
	description = "<span class='boldwarning'>I slept poorly in a makeshift coffin during the day.</span>\n"
	mood_change = -3
	timeout = 8 MINUTES

/datum/mood_event/daylight_2
	description = "<span class='boldwarning'>I have been scorched by the unforgiving rays of the sun.</span>\n"
	mood_change = -6
	timeout = 15 MINUTES

/datum/mood_event/bloodsucker_disgust
	description = "<span class='boldwarning'>Something I recently ate was horrifyingly disgusting.</span>\n"
	mood_change = -5
	timeout = 5 MINUTES

/// Candelabrum
/datum/mood_event/vampcandle
	description = "<span class='boldwarning'>Something is making your mind feel... loose.</span>\n"
	mood_change = -15
	timeout = 4 MINUTES

/// Frenzy's instant aggro grabs
/datum/martial_art/frenzygrab
	name = "Frenzy Grab"
	id = MARTIALART_FRENZYGRAB

/datum/martial_art/frenzygrab/grab_act(mob/living/user, mob/living/target)
	if(user != target)
		target.grabbedby(user)
		target.grippedby(user, instant = TRUE)
		return TRUE
	..()
