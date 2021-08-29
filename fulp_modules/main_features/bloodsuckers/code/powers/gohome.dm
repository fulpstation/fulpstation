/datum/action/bloodsucker/gohome
	name = "Vanishing Act"
	desc = "As dawn aproaches, disperse into mist and return directly to your Lair.<br><b>WARNING:</b> You will drop <b>ALL</b> of your possessions if observed by mortals."
	button_icon_state = "power_gohome"
	background_icon_state_on = "vamp_power_off_oneshot"
	background_icon_state_off = "vamp_power_off_oneshot"
	power_explanation = "<b>Vanishing Act</b>: \n\
		Activating Vanishing Act will, after a short delay, teleport the user to their <b>Claimed Coffin</b>. \n\
		The power will cancel out if the <b>Claimed Coffin</b> is somehow destroyed. \n\
		Immediately after activating, lights around the user will begin to flicker. \n\
		Once the user teleports to their coffin, in their place will be a Rat or Bat."
	bloodcost = 100
	/// It'll never come back.
	cooldown = 99999
	amSingleUse = TRUE

	/// You only get this if you've claimed a lair, and only just before sunrise.
	bloodsucker_can_buy = FALSE
	can_use_in_torpor = TRUE
	can_use_w_immobilize = TRUE
	must_be_concious = FALSE

/datum/action/bloodsucker/gohome/CheckCanUse(display_error)
	if(!..())
		return FALSE
	/// Have No Lair (NOTE: You only got this power if you had a lair, so this means it's destroyed)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(!istype(bloodsuckerdatum) || !bloodsuckerdatum.coffin)
		if(display_error)
			owner.balloon_alert(owner, "your coffin has been destroyed!")
		return FALSE
	return TRUE

/datum/action/bloodsucker/gohome/proc/flicker_lights(flicker_range, beat_volume)
	for(var/obj/machinery/light/L in view(flicker_range, get_turf(owner)))
	playsound(get_turf(owner), 'sound/effects/singlebeat.ogg', beat_volume, 1)

/// IMPORTANT: Check for lair at every step! It might get destroyed.
/datum/action/bloodsucker/gohome/ActivatePower(mob/living/carbon/user = owner)
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(owner)
	to_chat(user, "<span class='notice'>You focus on separating your consciousness from your physical form...</span>")
	/// STEP ONE: Flicker Lights
	flicker_lights(3, 20)
	sleep(50)
	flicker_lights(4, 40)
	sleep(50)
	flicker_lights(4, 60)
	for(var/obj/machinery/light/L in view(6, get_turf(owner)))
		L.flicker(5)
	playsound(get_turf(owner), 'sound/effects/singlebeat.ogg', 60, 1)
	/// STEP TWO: Lights OFF?
	/// CHECK: Still have Coffin?
	if(!bloodsuckerdatum?.coffin)
		to_chat(user, "<span class='warning'>Your coffin has been destroyed! You no longer have a destination.</span>")
		return FALSE
	if(!owner)
		return
	/// SEEN?: (effects ONLY if there are witnesses! Otherwise you just POOF)

	/// Do Effects (seen by anyone)
	var/am_seen = FALSE
	/// Drop Stuff (seen by non-vamp)
	var/drop_item = FALSE
	/// Only check if I'm not in a Locker or something.
	if(isturf(owner.loc))
		/// A) Check for Darkness (we can just leave)
		var/turf/T = get_turf(user)
		if(T && T.lighting_object && T.get_lumcount()>= 0.1)
			/// B) Check for Viewers
			for(var/mob/living/M in viewers(world.view, get_turf(owner)) - owner)
				if(M.client && !M.has_unlimited_silicon_privilege && !M.eye_blind)
					am_seen = TRUE
					if (!M.mind.has_antag_datum(/datum/antagonist/bloodsucker))
						drop_item = TRUE
						break
	/// LOSE CUFFS
	if(user.handcuffed)
		var/obj/O = user.handcuffed
		user.dropItemToGround(O)
	if(user.legcuffed)
		var/obj/O = user.legcuffed
		user.dropItemToGround(O)
	/// SEEN!
	if(drop_item)
		// DROP: Clothes, held items, and cuffs etc
		// NOTE: Taken from unequip_everything() in inventory.dm. We need to
		// *force* all items to drop, so we had to just gut the code out of it.
		var/list/items = list()
		items |= user.get_equipped_items()
		for(var/I in items)
			user.dropItemToGround(I,TRUE)
		for(var/obj/item/I in owner.held_items)	//drop_all_held_items()
			user.dropItemToGround(I, TRUE)
	/// POOF EFFECTS
	if(am_seen)
		playsound(get_turf(owner), 'sound/magic/summon_karp.ogg', 60, 1)
		var/datum/effect_system/steam_spread/puff = new /datum/effect_system/steam_spread/()
		puff.effect_type = /obj/effect/particle_effect/smoke/vampsmoke
		puff.set_up(3, 0, get_turf(owner))
		puff.start()

	/// STEP FIVE: Create animal at prev location
	var/mob/living/simple_animal/SA = pick(/mob/living/simple_animal/mouse,/mob/living/simple_animal/mouse,/mob/living/simple_animal/mouse, /mob/living/simple_animal/hostile/retaliate/bat) //prob(300) /mob/living/simple_animal/mouse,
	new SA (owner.loc)
	/// TELEPORT: Move to Coffin & Close it!
	user.set_resting(TRUE, TRUE, FALSE)
	do_teleport(owner, bloodsuckerdatum.coffin, no_effects = TRUE, forced = TRUE, channel = TELEPORT_CHANNEL_QUANTUM)
	user.Stun(3 SECONDS, TRUE)
	/// CLOSE LID: If fail, force me in.
	if(!bloodsuckerdatum.coffin.close(owner))
		/// Puts me inside.
		bloodsuckerdatum.coffin.insert(owner)
		playsound(bloodsuckerdatum.coffin.loc, bloodsuckerdatum.coffin.close_sound, 15, 1, -3)
		bloodsuckerdatum.coffin.opened = FALSE
		bloodsuckerdatum.coffin.density = TRUE
		bloodsuckerdatum.coffin.update_icon()
		/// Lock Coffin
		bloodsuckerdatum.coffin.LockMe(owner)
		bloodsuckerdatum.Check_Begin_Torpor(FALSE) // Are we meant to enter Torpor here?
	. = ..()
