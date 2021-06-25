/datum/action/bloodsucker/feed
	name = "Feed"
	desc = "Draw the heartsblood of living victims in your grasp.<br><b>None/Passive:</b> Feed silently and unnoticed by your victim.<br><b>Aggressive: </b>Subdue your target quickly."
	button_icon_state = "power_feed"
	bloodcost = 0
	cooldown = 30
	amToggle = TRUE
	bloodsucker_can_buy = FALSE
	can_use_w_stake = TRUE
	cooldown_static = TRUE
	can_use_in_frenzy = TRUE

	///Distance before silent feeding is noticed.
	var/notice_range = 2
	///So we can validate more than just the guy we're grappling.
	var/mob/living/feed_target
	///If you started grappled, then ending it will end your Feed.
	var/target_grappled = FALSE
	///Am I Silent?
	var/amSilent = FALSE
	///How much Blood did I drink? This is used for logs
	var/amount_taken = 0
	///The initial wait before you start drinking blood.
	var/feed_time
	///Quantity to take per tick, based on Silent/Frenzied or not.
	var/blood_take_mult
	/// CHECKS - To prevent spam.
	var/warning_target_inhuman = FALSE
	var/warning_target_dead = FALSE
	var/warning_full = FALSE
	var/warning_target_bloodvol = 99999

/datum/action/bloodsucker/feed/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return
	// Wearing mask
	var/mob/living/L = owner
	if(L.is_mouth_covered())
		if(display_error)
			to_chat(owner, span_warning("You cannot feed with your mouth covered! Remove your mask."))
		return FALSE
	// Find my Target!
	if(!FindMyTarget(display_error)) // Sets feed_target within after Validating
		return FALSE
		// Not in correct state
	// DONE!
	return TRUE

/// Called twice: validating a subtle victim, or validating your grapple victim.
/datum/action/bloodsucker/feed/proc/ValidateTarget(mob/living/target, display_error)
	// Bloodsuckers + Animals MUST be grabbed aggressively!
	if(!owner.pulling || target == owner.pulling && owner.grab_state < GRAB_AGGRESSIVE)
		// NOTE: It's OKAY that we are checking if(!target) below, AFTER animals here. We want passive check vs animal to warn you first, THEN the standard warning.
		// Animals:
		if(isliving(target) && !iscarbon(target))
			if(display_error)
				to_chat(owner, span_warning("Lesser beings require a tighter grip."))
			return FALSE
		// Bloodsuckers:
		else if(ishuman(target))
			var/mob/living/carbon/human/H = target
			if(!H.can_inject(owner, BODY_ZONE_CHEST, INJECT_CHECK_PENETRATE_THICK))
				return FALSE
			if(IS_BLOODSUCKER(target))
				if(display_error)
					to_chat(owner, span_warning("Other Bloodsuckers will not fall for your subtle approach."))
				return FALSE
	// Must have Target
	if(!target) // || !ismob(target)
		if(display_error)
			to_chat(owner, span_warning("You must be next to or grabbing a victim to feed from them."))
		return FALSE
	// Not even living!
	if(!isliving(target) || issilicon(target))
		if(display_error)
			to_chat(owner, span_warning("You may only feed from living beings."))
		return FALSE
	if(target.blood_volume <= 0)
		if(display_error)
			to_chat(owner, span_warning("Your victim has no blood to take."))
		return FALSE
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(!H.can_inject(owner, BODY_ZONE_HEAD, INJECT_CHECK_PENETRATE_THICK) && target == owner.pulling && owner.grab_state < GRAB_AGGRESSIVE)
			return FALSE
		if(NOBLOOD in H.dna.species.species_traits)// || owner.get_blood_id() != target.get_blood_id())
			if(display_error)
				to_chat(owner, span_warning("Your victim's blood is not suitable for you to take."))
			return FALSE
	// Special Check: If you're part of the Ventrue clan, they can't be mindless!
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner)
	if(bloodsuckerdatum && bloodsuckerdatum.my_clan == CLAN_VENTRUE && !bloodsuckerdatum.Frenzied)
		if(!target.mind)
			if(display_error)
				to_chat(owner, span_warning("The thought of drinking blood from the mindsless leaves a distasteful feeling in your mouth."))
			return FALSE
	return TRUE

/// If I'm not grabbing someone, find me someone nearby.
/datum/action/bloodsucker/feed/proc/FindMyTarget(display_error)
	// Default
	feed_target = null
	target_grappled = FALSE
	// If you are pulling a mob, that's your target. If you don't like it, then release them.
	if(owner.pulling && ismob(owner.pulling))
		// Check grapple target Valid
		if(!ValidateTarget(owner.pulling, display_error)) // Grabbed targets display error.
			return FALSE
		target_grappled = TRUE
		feed_target = owner.pulling
		return TRUE
	// Find Targets
	var/list/mob/living/seen_targets = view(1, owner)
	var/list/mob/living/seen_mobs = list()
	for(var/mob/living/M in seen_targets)
		if(isliving(M) && M != owner)
			seen_mobs += M
	// None Seen!
	if(seen_mobs.len == 0)
		if(display_error)
			to_chat(owner, span_warning("You must be next to or grabbing a victim to feed from them."))
		return FALSE
	// Check Valids...
	var/list/targets_valid = list()
	var/list/targets_dead = list()
	for(var/mob/living/M in seen_mobs)
		// Check adjecent Valid target
		if(M != owner && ValidateTarget(M, display_error = FALSE)) // Do NOT display errors. We'll be doing this again in CheckCanUse(), which will rule out grabbed targets.
			// Prioritize living, but remember dead as backup
			if(M.stat < DEAD)
				targets_valid += M
			else
				targets_dead += M
	// No Living? Try dead.
	if(targets_valid.len == 0 && targets_dead.len > 0)
		targets_valid = targets_dead
	// No Targets
	if(targets_valid.len == 0)
		// Did I see targets? Then display at least one error
		if(seen_mobs.len > 1)
			if (display_error)
				to_chat(owner, span_warning("None of these are valid targets to feed from subtly."))
		else
			ValidateTarget(seen_mobs[1], display_error)
		return FALSE
	//BLOODSUCKER_TRAIT Too Many Targets
	// else if (targets.len > 1)
	//	if (display_error)
	//		to_chat(owner, span_warning("You are adjecent to too many witnesses. Either grab your victim or move away."))
	//	return FALSE
	// One Target!
	else
		feed_target = pick(targets_valid)//targets[1]
		return TRUE

/datum/action/bloodsucker/feed/ActivatePower(mob/living/user = owner)
//	set waitfor = FALSE   <---- DONT DO THIS! We WANT this power to hold up Activate(), so Deactivate() can happen after.
	var/mob/living/target = feed_target // Stored during CheckCanUse(). Can be a grabbed OR adjecent character.
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	// Am I SECRET or LOUD? It stays this way the whole time! I must END IT to try it the other way.
	if(!bloodsuckerdatum?.Frenzied && (!target_grappled || owner.grab_state <= GRAB_PASSIVE)) // && iscarbon(target) // Non-carbons (animals) not passive. They go straight into aggressive.
		amSilent = TRUE

	if(bloodsuckerdatum?.Frenzied)
		blood_take_mult = 2
		feed_time = 8
	else if(!amSilent)
		blood_take_mult = 1
		feed_time = 25 - (2.5 * level_current)
	else
		blood_take_mult = 0.3
		feed_time = 45 - (2.5 * level_current)
	feed_time = max(8, feed_time)

	if(amSilent)
		to_chat(user, span_notice("You lean quietly toward [target] and secretly draw out your fangs..."))
	else
		to_chat(user, span_warning("You pull [target] close to you and draw out your fangs..."))
	if(!do_mob(user, target, feed_time, NONE, TRUE, extra_checks = CALLBACK(src, .proc/ContinueActive, user, target)))
		to_chat(user, span_warning("Your feeding was interrupted."))
		DeactivatePower(user)
		return
	// Put target to Sleep (Bloodsuckers are immune to their own bite's sleep effect)
	if(!amSilent)
		// Sleep & paralysis, this is also given during UsePower.
		ApplyVictimEffects(target)
		// Pull target to you if they don't take up space.
		if(!target.density)
			target.Move(user.loc)
	// Broadcast Message
	if(amSilent)
		//if (!iscarbon(target))
		//	user.visible_message(span_notice("[user] shifts [target] closer to [user.p_their()] mouth."),
		//					 	 span_notice("You secretly slip your fangs into [target]'s flesh."),
		//					 	 vision_distance = 2, ignored_mobs=target) // Only people who AREN'T the target will notice this action.
		//else
		var/deadmessage = target.stat == DEAD ? "" : " <i>[target.p_they(TRUE)] looks dazed, and will not remember this.</i>"
		user.visible_message(span_notice("[user] puts [target]'s wrist up to [user.p_their()] mouth."), \
						 	 span_notice("You slip your fangs into [target]'s wrist.[deadmessage]"), \
						 	 vision_distance = notice_range, ignored_mobs = target) // Only people who AREN'T the target will notice this action.
		// Warn Feeder about Witnesses...
		var/was_unnoticed = TRUE
		for(var/mob/living/M in viewers(notice_range, owner) - owner - target)
			if(M.client && !M.has_unlimited_silicon_privilege && !M.eye_blind && !M.mind.has_antag_datum(/datum/antagonist/bloodsucker))
				was_unnoticed = FALSE
				break
		if(was_unnoticed)
			to_chat(user, span_notice("You think no one saw you..."))
		else
			to_chat(user, span_warning("Someone may have noticed..."))

	else						 // /atom/proc/visible_message(message, self_message, blind_message, vision_distance, ignored_mobs)
		user.visible_message(span_warning("[user] closes [user.p_their()] mouth around [target]'s neck!"), \
						 span_warning("You sink your fangs into [target]'s neck."))

	// Activate Effects
//	target.add_trait(TRAIT_MUTE, BLOODSUCKER_TRAIT)  // <----- Make mute a power you buy?

	// FEEEEEEEEED!! //
	bloodsuckerdatum?.poweron_feed = TRUE
	ADD_TRAIT(user, TRAIT_MUTE, BLOODSUCKER_TRAIT) // My mouth is full!
	ADD_TRAIT(user, TRAIT_IMMOBILIZED, BLOODSUCKER_TRAIT) // Prevents spilling blood accidentally.
	. = ..()

/datum/action/bloodsucker/feed/UsePower(mob/living/user)
	var/mob/living/target = feed_target
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(user)
	var/datum/antagonist/vassal/vassaldatum = IS_VASSAL(user)
//	if(!..()) // We're using our own checks below, becuase we have a TARGET to keep track of.
//		return

	// Did we deactivate this manually? Let's end it here.
	if(!active)
		return
	if(!ContinueActive(user, target))
		if(amSilent)
			to_chat(user, "<span class='warning'>Your feeding has been interrupted...but [target.p_they()] didn't seem to notice you.<span>")
		else
			to_chat(user, "<span class='warning'>Your feeding has been interrupted!</span>")
			user.visible_message("<span class='danger'>[user] is ripped from [target]'s throat. [target.p_their(TRUE)] blood sprays everywhere!</span>", \
					 			 "<span class='userdanger'>Your teeth are ripped from [target]'s throat. [target.p_their(TRUE)] blood sprays everywhere!</span>")
			// Deal Damage to Target (should have been more careful!)
			if(iscarbon(target))
				var/mob/living/carbon/C = target
				C.bleed(15)
			playsound(get_turf(target), 'sound/effects/splat.ogg', 40, 1)
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				var/obj/item/bodypart/head_part = H.get_bodypart(BODY_ZONE_HEAD)
				if(head_part)
					head_part.generic_bleedstacks += 5
			target.add_splatter_floor(get_turf(target))
			user.add_mob_blood(target) // Put target's blood on us. The donor goes in the ( )
			target.add_mob_blood(target)
			target.apply_damage(10, BRUTE, BODY_ZONE_HEAD, wound_bonus = CANT_WOUND)
			INVOKE_ASYNC(target, /mob.proc/emote, "scream")
		DeactivatePower(user)
		return

	///////////////////////////////////////////////////////////
	// 		Handle Feeding! User & Victim Effects (per tick)
	bloodsuckerdatum?.HandleFeeding(target, blood_take_mult)
	vassaldatum?.HandleFeeding(target, blood_take_mult)
	amount_taken += amSilent ? 0.3 : 1
	if(!amSilent)
		ApplyVictimEffects(target) // Sleep, paralysis, immobile, unconscious, and mute

	///////////////////////////////////////////////////////////
	// MOOD EFFECTS //
	// Drank good blood? - GOOD
	if(amount_taken > 5 && target.stat < DEAD && ishuman(target))
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "drankblood", /datum/mood_event/drankblood)
	// Drank mindless as Ventrue? - BAD
	if(!target.mind && bloodsuckerdatum?.my_clan == CLAN_VENTRUE)
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "drankblood", /datum/mood_event/drankblood_bad)
		if(!warning_target_inhuman)
			to_chat(user, "<span class='notice'>You feel disgusted at the taste of a non-sentient creature.</span>")
			warning_target_inhuman = TRUE
	// Dead Blood? - BAD
	if(target.stat >= DEAD)
		if(ishuman(target))
			SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "drankblood", /datum/mood_event/drankblood_dead)
		if(!warning_target_dead)
			to_chat(user, "<span class='notice'>Your victim is dead. [target.p_their(TRUE)] blood barely nourishes you.</span>")
			warning_target_dead = TRUE
	// Drank off of a non-carbon? - BAD
	if(!ishuman(target))
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "drankblood", /datum/mood_event/drankblood_bad)
		if(!warning_target_inhuman)
			to_chat(user, "<span class='notice'>You recoil at the taste of a lesser lifeform.</span>")
			warning_target_inhuman = TRUE

	// Blood Remaining? (Carbons/Humans only)
	else if(!IS_BLOODSUCKER(target))
		if(target.blood_volume <= BLOOD_VOLUME_BAD && warning_target_bloodvol > BLOOD_VOLUME_BAD)
			to_chat(user, "<span class='warning'>Your victim's blood volume is fatally low!</span>")
		else if(target.blood_volume <= BLOOD_VOLUME_OKAY && warning_target_bloodvol > BLOOD_VOLUME_OKAY)
			to_chat(user, "<span class='warning'>Your victim's blood volume is dangerously low.</span>")
		else if(target.blood_volume <= BLOOD_VOLUME_SAFE && warning_target_bloodvol > BLOOD_VOLUME_SAFE)
			to_chat(user, "<span class='notice'>Your victim's blood is at an unsafe level.</span>")
		warning_target_bloodvol = target.blood_volume // If we had a warning to give, it's been given by now.
	// Full?
	if(bloodsuckerdatum && user.blood_volume >= bloodsuckerdatum.max_blood_volume && !warning_full)
		to_chat(user, "<span class='notice'>You are full. Further blood will be wasted.</span>")
		warning_full = TRUE
	// Done?
	if(target.blood_volume <= 0)
		to_chat(user, "<span class='notice'>You have bled your victim dry.</span>")
		DeactivatePower(user)
		return

	// Blood Gulp Sound
	owner.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, TRUE)
	if(!amSilent)
		target.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, TRUE)

	addtimer(CALLBACK(src, .proc/UsePower, user), 2 SECONDS) // Every 2 seconds

/// NOTE: We only care about pulling if target started off that way. Mostly only important for Aggressive feed.
/datum/action/bloodsucker/feed/ContinueActive(mob/living/user, mob/living/target)
	if(!target)
		return FALSE
	if(!user.Adjacent(target))
		return FALSE
	if(!target_grappled || user.pulling) // Active, and still antag
		return ..()

/// Bloodsuckers not affected by "the Kiss" of another vampire
/datum/action/bloodsucker/feed/proc/ApplyVictimEffects(mob/living/target)
	if(!IS_BLOODSUCKER(target))
		target.Unconscious(50,0)
		target.Paralyze(40 + 5 * level_current,1) // NOTE: This is based on level of power!
		if(ishuman(target))
			target.adjustStaminaLoss(5, forced = TRUE) // Base Stamina Damage

/datum/action/bloodsucker/feed/DeactivatePower(mob/living/user = owner)
	var/mob/living/target = feed_target
	. = ..() // activate = FALSE

	if(target) // Check: Otherwise it runtimes if you fail to feed on someone.
		if(amSilent)
			to_chat(user, "<span class='notice'>You slowly release [target]'s wrist." + (target.stat == 0 ? " [target.p_their(TRUE)] face lacks expression, like you've already been forgotten.</span>" : ""))
		else
			user.visible_message("<span class='warning'>[user] unclenches their teeth from [target]'s neck.</span>", \
								 "<span class='warning'>You retract your fangs and release [target] from your bite.</span>")
		log_combat(owner, target, "fed on blood", addition="(and took [amount_taken] blood)")
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	// No longer Feeding
	if(bloodsuckerdatum)
		bloodsuckerdatum.poweron_feed = FALSE
	// Reset ALL checks for next time the Power is used.
	amSilent = FALSE
	warning_target_inhuman = FALSE
	warning_target_dead = FALSE
	warning_full = FALSE
	feed_target = null
	warning_target_bloodvol = 99999
	// Let me move!
	REMOVE_TRAIT(user, TRAIT_IMMOBILIZED, BLOODSUCKER_TRAIT)
	if(bloodsuckerdatum?.Frenzied)
		return // In a Frenzy? Stay silent.
	// My mouth is no longer full
	REMOVE_TRAIT(owner, TRAIT_MUTE, BLOODSUCKER_TRAIT)
