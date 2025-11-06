#define FEED_NOTICE_RANGE 2
#define FEED_DEFAULT_TIMER (10 SECONDS)

/datum/action/cooldown/bloodsucker/feed
	name = "Feed"
	desc = "Feed blood off of a living creature."
	button_icon_state = "power_feed"
	power_explanation = "Feed:\n\
		Activate Feed while next to someone and you will begin to feed blood off of them.\n\
		The time needed before you start feeding decrases as you gain ranks.\n\
		Feeding off of someone while you have them aggressively grabbed will put them to sleep.\n\
		While feeding, you can't speak, as your mouth is covered.\n\
		Feeding while nearby (2 tiles away from) a mortal who is unaware of Bloodsuckers' existence will cause a Masquerade infraction\n\
		If you get too many Masquerade infractions, you will break the Masquerade.\n\
		If you are in desperate need of blood, mice can be fed off of— at a cost..."
	power_flags = BP_AM_TOGGLE|BP_AM_STATIC_COOLDOWN
	check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_WHILE_STAKED|BP_CANT_USE_WHILE_INCAPACITATED|BP_CANT_USE_WHILE_UNCONSCIOUS
	purchase_flags = BLOODSUCKER_CAN_BUY|BLOODSUCKER_DEFAULT_POWER
	bloodcost = 0
	cooldown_time = 15 SECONDS
	///Amount of blood taken, reset after each Feed. Used (mostly) for logging.
	var/blood_taken = 0
	///The amount of Blood a target has since our last feed, this loops and lets us not spam alerts of low blood.
	var/warning_target_bloodvol = BLOOD_VOLUME_MAX_LETHAL
	///Reference to the target we've fed off of
	var/datum/weakref/target_ref
	///Are we feeding with passive grab or not?
	var/silent_feed = TRUE

/datum/action/cooldown/bloodsucker/feed/can_use(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	if(target_ref) //already sucking blood.
		return FALSE
	if(user.is_mouth_covered() && !isplasmaman(user))
		owner.balloon_alert(owner, "mouth covered!")
		return FALSE
	if(bloodsuckerdatum_power?.my_clan?.blood_drink_type == BLOODSUCKER_DRINK_PAINFUL && owner.grab_state <= GRAB_PASSIVE)
		owner.balloon_alert(owner, "can't silent feed!")
		return FALSE
	//Find target, it will alert what the problem is, if any.
	if(!find_target())
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/feed/ContinueActive(mob/living/user, mob/living/target)
	if(!target)
		return FALSE
	if(!user.Adjacent(target))
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/feed/DeactivatePower()
	var/mob/living/user = owner
	var/atom/feed_target
	if(target_ref)
		feed_target = target_ref.resolve()
	if(!isnull(feed_target) && isliving(feed_target))
		var/mob/living/living_feed_target = feed_target
		log_combat(user, living_feed_target, "fed on blood", addition="(and took [blood_taken] blood)")
		to_chat(user, span_notice("You slowly release [living_feed_target]."))
		if(living_feed_target.stat == DEAD && blood_taken > 0)
			user.add_mood_event("drankkilled", /datum/mood_event/drankkilled)
			bloodsuckerdatum_power.AddHumanityLost(10)

	target_ref = null
	warning_target_bloodvol = BLOOD_VOLUME_MAX_LETHAL
	blood_taken = 0
	REMOVE_TRAIT(user, TRAIT_IMMOBILIZED, FEED_TRAIT)
	REMOVE_TRAIT(user, TRAIT_MUTE, FEED_TRAIT)
	return ..()

/datum/action/cooldown/bloodsucker/feed/ActivatePower(trigger_flags)
	/// The initial version of "feed_target" before it's set as a "/mob/living"
	var/atom/feed_target_atom = target_ref.resolve()
	if(istype(feed_target_atom, /obj/effect/decal/cleanable/blood))
		if(!owner.get_organ_slot(ORGAN_SLOT_TONGUE))
			owner.balloon_alert(owner, "no tongue!")
			DeactivatePower()
			return

		var/obj/effect/decal/cleanable/blood/blood_decal = feed_target_atom
		if(bloodsuckerdatum_power.frenzied)
			tackle_feed_target()
		owner.visible_message(
			span_warning("[owner] starts licking [blood_decal] off the [blood_decal.loc.name]!"),
			span_notice("You start licking [blood_decal] off the [blood_decal.loc.name]."),
		)

		var/time_to_lick = (1 SECONDS + (ceil(blood_decal.bloodiness/20) SECONDS))
		if(do_after(owner, time_to_lick, blood_decal))
			bloodsuckerdatum_power.AddHumanityLost(0.1) // They lose Humanity regardless of drinking type because it's funny.
			owner.visible_message(
				span_warning("[owner] licks [blood_decal] off the [blood_decal.loc.name]!"),
				span_notice("You lick [blood_decal] off the [blood_decal.loc.name]."),
			)
			DeactivatePower()
			// "Bloodiness" is not an accurate reflection of blood decal volume, but it's
			// the best thing available to go off of. We
			bloodsuckerdatum_power.AddBloodVolume(ceil(blood_decal.bloodiness/50))
			blood_decal.Destroy()

		return

	/// Past this point our "feed_target" can only be a living mob.
	var/mob/living/feed_target = target_ref.resolve()
	if(istype(feed_target, /mob/living/basic/mouse))
		to_chat(owner, span_notice("You recoil at the taste of a lesser lifeform."))
		if(bloodsuckerdatum_power.my_clan && bloodsuckerdatum_power.my_clan.blood_drink_type != BLOODSUCKER_DRINK_INHUMANELY)
			var/mob/living/user = owner
			user.add_mood_event("drankblood", /datum/mood_event/drankblood_bad)
			bloodsuckerdatum_power.AddHumanityLost(1)
		bloodsuckerdatum_power.AddBloodVolume(25)
		DeactivatePower()
		feed_target.death()
		return

	if(feed_target.blood_volume <= 0)
		owner.balloon_alert(owner, "no blood!")
		DeactivatePower()
		return

	var/feed_timer = clamp(round(FEED_DEFAULT_TIMER / (1.25 * (level_current || 1))), 1, FEED_DEFAULT_TIMER)
	if(bloodsuckerdatum_power.frenzied)
		feed_timer = 2 SECONDS

	owner.balloon_alert(owner, "feeding off [feed_target]...")
	if(!do_after(owner, feed_timer, feed_target, NONE, TRUE, hidden = TRUE))
		owner.balloon_alert(owner, "feed stopped")
		DeactivatePower()
		return
	if(owner.pulling == feed_target && owner.grab_state >= GRAB_AGGRESSIVE)
		if(!IS_BLOODSUCKER(feed_target) && !IS_VASSAL(feed_target) && !IS_MONSTERHUNTER(feed_target))
			feed_target.Unconscious((5 + level_current) SECONDS)
		if(!feed_target.density)
			feed_target.Move(owner.loc)
		owner.visible_message(
			span_warning("[owner] closes [owner.p_their()] mouth around [feed_target]'s neck!"),
			span_warning("You sink your fangs into [feed_target]'s neck."))
		silent_feed = FALSE //no more mr nice guy
	else
		// Only people who AREN'T the target will notice this action.
		var/dead_message = feed_target.stat != DEAD ? " <i>[feed_target.p_they(TRUE)] looks dazed, and will not remember this.</i>" : ""
		owner.visible_message(
			span_notice("[owner] puts [feed_target]'s wrist up to [owner.p_their()] mouth."), \
			span_notice("You slip your fangs into [feed_target]'s wrist.[dead_message]"), \
			vision_distance = FEED_NOTICE_RANGE, ignored_mobs = feed_target)

	//check if we were seen
	for(var/mob/living/watchers in oviewers(FEED_NOTICE_RANGE) - feed_target)
		if(!watchers.client)
			continue
		if(issilicon(watchers) || isdrone(watchers) || isbot(watchers))
			continue
		if(watchers.stat >= DEAD)
			continue
		if(watchers.is_blind() || watchers.is_nearsighted_currently())
			continue
		if(IS_BLOODSUCKER(watchers) || IS_VASSAL(watchers) || HAS_TRAIT(watchers.mind, TRAIT_BLOODSUCKER_HUNTER))
			continue
		owner.balloon_alert(owner, "feed noticed!")
		bloodsuckerdatum_power.give_masquerade_infraction()
		break

	ADD_TRAIT(owner, TRAIT_MUTE, FEED_TRAIT)
	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, FEED_TRAIT)
	return ..()

/datum/action/cooldown/bloodsucker/feed/process(seconds_per_tick)
	if(!active) //If we aren't active (running on SSfastprocess)
		return ..() //Manage our cooldown timers
	var/mob/living/user = owner
	var/mob/living/feed_target = target_ref.resolve()
	if(!ContinueActive(user, feed_target))
		if(!silent_feed)
			user.visible_message(
				span_warning("[user] is ripped from [feed_target]'s throat. [feed_target.p_their(TRUE)] blood sprays everywhere!"),
				span_warning("Your teeth are ripped from [feed_target]'s throat. [feed_target.p_their(TRUE)] blood sprays everywhere!"))
			// Deal Damage to Target (should have been more careful!)
			if(iscarbon(feed_target))
				var/mob/living/carbon/carbon_target = feed_target
				carbon_target.bleed(15)
			playsound(get_turf(feed_target), 'sound/effects/splat.ogg', 40, TRUE)
			if(ishuman(feed_target))
				var/mob/living/carbon/human/target_user = feed_target
				var/obj/item/bodypart/head_part = target_user.get_bodypart(BODY_ZONE_HEAD)
				if(head_part)
					head_part.generic_bleedstacks += 5
			feed_target.add_splatter_floor(get_turf(feed_target))
			user.add_mob_blood(feed_target) // Put target's blood on us. The donor goes in the ( )
			feed_target.add_mob_blood(feed_target)
			feed_target.apply_damage(10, BRUTE, BODY_ZONE_HEAD, wound_bonus = CANT_WOUND)
			INVOKE_ASYNC(feed_target, TYPE_PROC_REF(/mob, emote), "scream")
		DeactivatePower()
		return

	var/feed_strength_mult = 0
	if(bloodsuckerdatum_power.frenzied)
		feed_strength_mult = 2
	else if(owner.pulling == feed_target && owner.grab_state >= GRAB_AGGRESSIVE)
		feed_strength_mult = 1
	else
		feed_strength_mult = 0.3
	blood_taken += bloodsuckerdatum_power.handle_feeding(feed_target, feed_strength_mult, level_current)

	if(feed_strength_mult > 5 && feed_target.stat < DEAD)
		user.add_mood_event("drankblood", /datum/mood_event/drankblood)
	// Drank mindless as Ventrue? - BAD
	if((bloodsuckerdatum_power.my_clan && bloodsuckerdatum_power.my_clan.blood_drink_type == BLOODSUCKER_DRINK_SNOBBY) && !feed_target.mind)
		user.add_mood_event("drankblood", /datum/mood_event/drankblood_bad)
	if(feed_target.stat >= DEAD)
		user.add_mood_event("drankblood", /datum/mood_event/drankblood_dead)

	if(!IS_BLOODSUCKER(feed_target))
		if(feed_target.blood_volume <= BLOOD_VOLUME_BAD && warning_target_bloodvol > BLOOD_VOLUME_BAD)
			owner.balloon_alert(owner, "your victim's blood is fatally low!")
		else if(feed_target.blood_volume <= BLOOD_VOLUME_OKAY && warning_target_bloodvol > BLOOD_VOLUME_OKAY)
			owner.balloon_alert(owner, "your victim's blood is dangerously low.")
		else if(feed_target.blood_volume <= BLOOD_VOLUME_SAFE && warning_target_bloodvol > BLOOD_VOLUME_SAFE)
			owner.balloon_alert(owner, "your victim's blood is at an unsafe level.")
		warning_target_bloodvol = feed_target.blood_volume

	if(bloodsuckerdatum_power.bloodsucker_blood_volume >= bloodsuckerdatum_power.max_blood_volume)
		user.balloon_alert(owner, "full on blood!")
		DeactivatePower()
		return
	if(feed_target.blood_volume <= 0)
		user.balloon_alert(owner, "no blood left!")
		DeactivatePower()
		return
	owner.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, TRUE)
	//play sound to target to show they're dying.
	if(owner.pulling == feed_target && owner.grab_state >= GRAB_AGGRESSIVE)
		feed_target.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, TRUE)

/datum/action/cooldown/bloodsucker/feed/proc/find_target()
	if(owner.pulling && isliving(owner.pulling))
		if(!can_feed_from(owner.pulling, give_warnings = TRUE))
			return FALSE
		target_ref = WEAKREF(owner.pulling)
		return TRUE

	var/list/close_living_mobs = list()
	var/list/close_dead_mobs = list()
	for(var/mob/living/near_targets in oview(1, owner))
		if(!owner.Adjacent(near_targets))
			continue
		if(near_targets.stat)
			close_living_mobs |= near_targets
		else
			close_dead_mobs |= near_targets

	// Check living first
	for(var/mob/living/suckers in close_living_mobs)
		if(can_feed_from(suckers))
			target_ref = WEAKREF(suckers)
			return TRUE

	// If not, check dead
	for(var/mob/living/suckers in close_dead_mobs)
		if(can_feed_from(suckers))
			target_ref = WEAKREF(suckers)
			return TRUE

	// If neither living or dead are present, check the floor for fresh blood decals.
	var/list/close_blood_decals = list()
	for(var/obj/effect/decal/cleanable/blood/blood_decal in oview(1, owner))
		if(!owner.Adjacent(blood_decal))
			continue
		if(blood_decal.bloodiness < 20) // Essentially if it's dry.
			continue
		else
			close_blood_decals |= blood_decal

	if(length(close_blood_decals))
		var/obj/effect/decal/cleanable/blood/random_blood_decal = pick(close_blood_decals)
		if(can_feed_from(random_blood_decal))
			target_ref = WEAKREF(random_blood_decal)
			return TRUE

	// Nothing to suck blood from.
	return FALSE

/datum/action/cooldown/bloodsucker/feed/proc/can_feed_from(atom/target, give_warnings = FALSE)
	if(istype(target, /mob/living/basic/mouse) || istype(target, /obj/effect/decal/cleanable/blood))
		if(bloodsuckerdatum_power.my_clan && bloodsuckerdatum_power.my_clan.blood_drink_type == BLOODSUCKER_DRINK_SNOBBY)
			if(give_warnings)
				owner.balloon_alert(owner, "too disgusting!")
			return FALSE
		return TRUE

	// Mice/blood checks done, only humans are otherwise allowed
	if(!ishuman(target))
		return FALSE

	var/mob/living/carbon/human/target_user = target
	if(!(target_user.dna?.species) || !(target_user.mob_biotypes & MOB_ORGANIC))
		if(give_warnings)
			owner.balloon_alert(owner, "no blood!")
		return FALSE
	if(!target_user.can_inject(owner, BODY_ZONE_HEAD, INJECT_CHECK_PENETRATE_THICK))
		if(give_warnings)
			owner.balloon_alert(owner, "suit too thick!")
		return FALSE
	if((bloodsuckerdatum_power.my_clan && bloodsuckerdatum_power.my_clan.blood_drink_type == BLOODSUCKER_DRINK_SNOBBY) && !target_user.mind && !bloodsuckerdatum_power.frenzied)
		if(give_warnings)
			owner.balloon_alert(owner, "cant drink from mindless!")
		return FALSE
	return TRUE

/// Makes our owner tackle our feed target.
/// Derived from 'code\datums\components\tackle.dm'
/datum/action/cooldown/bloodsucker/feed/proc/tackle_feed_target()
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/human_owner = owner
	var/atom/feed_target = target_ref.resolve()

	human_owner.face_atom(feed_target)

	playsound(human_owner, 'sound/items/weapons/thudswoosh.ogg', 40, TRUE, -1)

	var/leap_word = isfelinid(human_owner) || HAS_TRAIT(human_owner, TRAIT_TACKLING_TAILED_POUNCE) ? "pounce" : "leap" //If cat, "pounce" instead of "leap".
	if(can_see(human_owner, feed_target, 7))
		human_owner.visible_message(span_warning("[human_owner] [leap_word]s at [feed_target]!"), span_danger("You [leap_word] at [feed_target]!"))
	else
		human_owner.visible_message(span_warning("[human_owner] [leap_word]s!"), span_danger("You [leap_word]!"))
	human_owner.Knockdown(1 SECONDS, ignore_canstun = TRUE)
	human_owner.adjustStaminaLoss(25)
	human_owner.throw_at(feed_target, 4, 1, human_owner, FALSE)

#undef FEED_NOTICE_RANGE
#undef FEED_DEFAULT_TIMER
