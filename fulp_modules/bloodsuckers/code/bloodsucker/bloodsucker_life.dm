/*
 *		TO PLUG INTO LIFE:
 *
 * Cancel BLOOD life
 * Cancel METABOLISM life   (or find a way to control what gets digested)
 * Create COLDBLOODED trait (thermal homeostasis)
 *
 * 		EXAMINE
 *
 * Show as dead when...
 */

/// Runs from BiologicalLife, handles all the bloodsucker constant proccesses
/datum/antagonist/bloodsucker/proc/LifeTick()
	set waitfor = FALSE // Don't make on_gain() wait for this function to finish. This lets this code run on the side.
	while(owner && !AmFinalDeath())
		if(owner.current.stat == CONSCIOUS && !poweron_feed && !HAS_TRAIT(owner.current, TRAIT_FAKEDEATH))
			AddBloodVolume(passive_blood_drain)
		if(HandleHealing(1))
			if(!notice_healing && owner.current.blood_volume > 0)
				to_chat(owner, "<span class='notice'>The power of your blood begins knitting your wounds...</span>")
				notice_healing = TRUE
		else if(notice_healing)
			notice_healing = FALSE
		HandleStarving() // Handle Low Blood effects
		HandleDeath() // Handle Death
		update_hud() // Standard Update
		if(SSticker.mode.is_daylight() && !HAS_TRAIT(owner.current, TRAIT_FAKEDEATH))
			if(istype(owner.current.loc, /obj/structure/closet/crate/coffin))
				Torpor_Begin()

		sleep(10) // Wait before next pass

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//			BLOOD

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/antagonist/bloodsucker/proc/AddBloodVolume(value)
	owner.current.blood_volume = clamp(owner.current.blood_volume + value, 0, max_blood_volume)
	update_hud()

/// mult: SILENT feed is 1/3 the amount
/datum/antagonist/bloodsucker/proc/HandleFeeding(mob/living/carbon/target, mult=1)
	var/blood_taken = min(feed_amount, target.blood_volume) * mult	// Starts at 15 (now 8 since we doubled the Feed time)
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
		var/fireheal = 0 // BURN: Heal in Coffin while Fakedeath, or when damage above maxhealth (you can never fully heal fire)
		var/amInCoffinWhileTorpor = istype(C.loc, /obj/structure/closet/crate/coffin) && (mult == 0 || HAS_TRAIT(C, TRAIT_FAKEDEATH))
		if(amInCoffinWhileTorpor)
			mult *= 5 // Increase multiplier if we're sleeping in a coffin.
			fireheal = min(C.getFireLoss_nonProsthetic(), actual_regen)
			C.extinguish_mob()
			C.remove_all_embedded_objects() // Remove Embedded!
			owner.current.regenerate_organs() // Heal Organs (will respawn original eyes etc. but we replace right away, next)
			CheckVampOrgans() // Heart, Eyes
			if(check_limbs(costMult))
				return TRUE
		else if(owner.current.stat >= UNCONSCIOUS) // Faster regeneration while unconcious
			mult *= 2
		// BRUTE: Always Heal
		var/bruteheal = min(C.getBruteLoss_nonProsthetic(), actual_regen)
		// Heal if Damaged
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
	for(var/O in C.internal_organs)
		var/obj/item/organ/organ = O
		organ.setOrganDamage(0)
	// NOTE: None of these work to fix Torpor's eye damage.
//	C.cure_blind(EYE_DAMAGE)
//	C.cure_nearsighted(EYE_DAMAGE)
//	C.adjust_blindness(-25)
//	C.adjust_blurriness(-25)
//	C.reagents.add_reagent(/datum/reagent/medicine/oculine,20) // I'm sorry
//	C.update_tint()
//	C.update_sight()
//	C.adjust_blindness(-25)
//	C.adjust_blurriness(-25)
	owner.current.cure_husk()


/*
 * 	// High: 	Faster Healing
 *	// Med: 	Pale
 *	// Low: 	Twitch
 *	// V.Low:   Blur Vision
 *	// EMPTY:	Frenzy!
 */
/// I am thirsty for blood!
/datum/antagonist/bloodsucker/proc/HandleStarving()
	// BLOOD_VOLUME_GOOD: [336]  Pale (handled in bloodsucker_integration.dm
	// BLOOD_VOLUME_BAD: [224]  Jitter
	if(owner.current.blood_volume < BLOOD_VOLUME_BAD && !prob(0.5 && HAS_TRAIT(owner, TRAIT_FAKEDEATH)) && !poweron_masquerade)
		owner.current.Jitter(3)
	// BLOOD_VOLUME_SURVIVE: [122]  Blur Vision
	if(owner.current.blood_volume < BLOOD_VOLUME_BAD / 2)
		owner.current.blur_eyes(8 - 8 * (owner.current.blood_volume / BLOOD_VOLUME_BAD))
	// Nutrition
	owner.current.set_nutrition(min(owner.current.blood_volume, NUTRITION_LEVEL_FED)) //The amount of blood is how full we are.
	// A bit higher regeneration based on blood volume
	if(owner.current.blood_volume < 700)
		additional_regen = 0.4
	else if(owner.current.blood_volume < BLOOD_VOLUME_NORMAL)
		additional_regen = 0.3
	else if(owner.current.blood_volume < BLOOD_VOLUME_OKAY)
		additional_regen = 0.2
	else if(owner.current.blood_volume < BLOOD_VOLUME_BAD)
		additional_regen  = 0.1

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//			DEATH

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/// FINAL DEATH
/datum/antagonist/bloodsucker/proc/HandleDeath()
	// Fire Damage? (above double health)
	if(owner.current.getFireLoss() >= owner.current.maxHealth * 3)
		FinalDeath()
		return
	// Staked while "Temp Death" or Asleep
	if(owner.current.StakeCanKillMe() && owner.current.AmStaked())
		FinalDeath()
		return
	// Not "Alive"?
	if(!owner.current || !isliving(owner.current) || isbrain(owner.current) || !get_turf(owner.current))
		FinalDeath()
		return
	// Missing Brain or Heart?
	/* // Disabled due to it killing Slimepeople. They should be getting the organs back when they sleep through Sol anyhow.
	if(!owner.current.HaveBloodsuckerBodyparts())
		FinalDeath()
		return
				// Disable Powers: Masquerade	* NOTE * This should happen as a FLAW!
				//if (stat >= UNCONSCIOUS)
				//	for (var/datum/action/bloodsucker/masquerade/P in powers)
				//		P.Deactivate()
	*/
	// TEMP DEATH
	var/total_brute = owner.current.getBruteLoss_nonProsthetic()
	var/total_burn = owner.current.getFireLoss_nonProsthetic()
	var/total_damage = total_brute + total_burn
	// Died? Convert to Torpor (fake death)
	if(owner.current.stat >= DEAD)
		Torpor_Begin()
		to_chat(owner, "<span class='danger'>Your immortal body will not yet relinquish your soul to the abyss. You enter Torpor.</span>")
		sleep(30) //To avoid spam
		if(poweron_masquerade)
			to_chat(owner, "<span class='warning'>Your wounds will not heal until you disable the <span class='boldnotice'>Masquerade</span> power.</span>")
	// End Torpor:
	else // No damage, AND brute healed and NOT in coffin (since you cannot heal burn)
		if(!SSticker.mode.is_daylight() && HAS_TRAIT(owner.current, TRAIT_FAKEDEATH) && total_damage < owner.current.getMaxHealth())
			if(total_damage <= 0 && total_brute <= 0)
				Torpor_End()
		// Fake Unconscious
		if(poweron_masquerade && total_damage >= owner.current.getMaxHealth() - HEALTH_THRESHOLD_FULLCRIT)
			owner.current.Unconscious(20, 1)

/// Disable ALL Powers
/datum/antagonist/bloodsucker/proc/Torpor_Begin(amInCoffin = FALSE)
	for(var/datum/action/bloodsucker/power in powers)
		if(power.active && !power.can_use_in_torpor)
			power.DeactivatePower()
	if(owner.current.suiciding)
		owner.current.suiciding = FALSE // You'll die, but not for long.
		to_chat(owner.current, "<span class='warning'>Your body keeps you going, even as you try to end yourself.</span>")
	REMOVE_TRAIT(owner.current, TRAIT_SLEEPIMMUNE, BLOODSUCKER_TRAIT) // Go to sleep.
	ADD_TRAIT(owner.current, TRAIT_NODEATH, BLOODSUCKER_TRAIT) // Without this, you'll just keep dying while you recover.
	ADD_TRAIT(owner.current, TRAIT_KNOCKEDOUT, BLOODSUCKER_TRAIT) // Go to sleep.
	ADD_TRAIT(owner.current, TRAIT_FAKEDEATH, BLOODSUCKER_TRAIT) // Come after UNCONSCIOUS or else it fails
	owner.current.Jitter(0)

/datum/antagonist/bloodsucker/proc/Torpor_End()
	REMOVE_TRAIT(owner.current, TRAIT_FAKEDEATH, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(owner.current, TRAIT_KNOCKEDOUT, BLOODSUCKER_TRAIT)
	REMOVE_TRAIT(owner.current, TRAIT_NODEATH, BLOODSUCKER_TRAIT)
	ADD_TRAIT(owner.current, TRAIT_SLEEPIMMUNE, BLOODSUCKER_TRAIT) // Wake up
	to_chat(owner, "<span class='warning'>You have recovered from Torpor.</span>")
	CureDisabilities()
	owner.current.update_sight()
	owner.current.reload_fullscreen()

/// Standard Antags can be dead OR final death
/datum/antagonist/proc/AmFinalDeath()
 	return owner && (owner.current && owner.current.stat >= DEAD || owner.AmFinalDeath())

/datum/antagonist/bloodsucker/AmFinalDeath()
 	return owner && owner.AmFinalDeath()

/datum/mind/proc/AmFinalDeath()
 	return !current || QDELETED(current) || !isliving(current) || isbrain(current) || !get_turf(current) // NOTE: "isliving()" is not the same as STAT == CONSCIOUS. This is to make sure you're not a BORG (aka silicon)

/// Dont bother if we are already supposed to be dead
/datum/antagonist/bloodsucker/proc/FinalDeath()
	if(FinalDeath)
		return
	FinalDeath = TRUE //We are now supposed to die. Lets not spam it.
	if(!iscarbon(owner.current)) //Check for non carbons.
		owner.current.gib()
		return
	playsound(get_turf(owner.current), 'sound/effects/tendril_destroyed.ogg', 60, 1)
	owner.current.drop_all_held_items()
	owner.current.unequip_everything()
	var/mob/living/carbon/C = owner.current
	C.remove_all_embedded_objects()
	// Free my Vassals!
	FreeAllVassals()
	// Elders get Dusted
	if(bloodsucker_level >= 4)
		owner.current.visible_message("<span class='warning'>[owner.current]'s skin crackles and dries, their skin and bones withering to dust. A hollow cry whips from what is now a sandy pile of remains.</span>", \
			 "<span class='userdanger'>Your soul escapes your withering body as the abyss welcomes you to your Final Death.</span>", \
			 "<span class='italics'>You hear a dry, crackling sound.</span>")
		sleep(50)
		owner.current.dust()
	// Fledglings get Gibbed
	else
		owner.current.visible_message("<span class='warning'>[owner.current]'s skin bursts forth in a spray of gore and detritus. A horrible cry echoes from what is now a wet pile of decaying meat.</span>", \
			 "<span class='userdanger'>Your soul escapes your withering body as the abyss welcomes you to your Final Death.</span>", \
			 "<span class='italics'>You hear a wet, bursting sound.</span>")
		owner.current.gib(TRUE, FALSE, FALSE)
	playsound(owner.current, 'sound/effects/tendril_destroyed.ogg', 40, TRUE)

/// Prevents Slimeperson 'gaming
/datum/species/jelly/slime/spec_life(mob/living/carbon/human/H)
	if(HAS_TRAIT(H, TRAIT_NOPULSE)) // Fulpstation Bloodsuckers edit
		return

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//			HUMAN FOOD

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* /// What even is this? It's never called...
/mob/proc/CheckBloodsuckerEatFood(food_nutrition)
	if(!isliving(src))
		return
	var/mob/living/L = src
	if(!AmBloodsucker(L))
		return
	// We're a bloodsucker? Try to eat food...
	var/datum/antagonist/bloodsucker/B = L.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	B.handle_eat_human_food(food_nutrition)
*/

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
	while(foodInGut)
		sleep(50)
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

/datum/mood_event/vampcandle
	description = "<span class='umbra'>Something is making your mind feel... loose.</span>\n"
	mood_change = -15
	timeout = 5 MINUTES

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

/// Prevents using a Memento Mori
/obj/item/clothing/neck/necklace/memento_mori/memento(mob/living/carbon/human/user)
	if(user.mind.has_antag_datum(/datum/antagonist/bloodsucker))
		to_chat(user, "<span class='warning'>You fiddle around with the pendant, but it doesn't react.</span>")
		return
	to_chat(user, "<span class='warning'>You feel your life being drained by the pendant...</span>")
	if(do_after(user, 40, target = user))
		to_chat(user, "<span class='notice'>Your lifeforce is now linked to the pendant! You feel like removing it would kill you, and yet you instinctively know that until then, you won't die.</span>")
		ADD_TRAIT(user, TRAIT_NODEATH, "memento_mori")
		ADD_TRAIT(user, TRAIT_NOHARDCRIT, "memento_mori")
		ADD_TRAIT(user, TRAIT_NOCRITDAMAGE, "memento_mori")
		icon_state = "memento_mori_active"
		active_owner = user
