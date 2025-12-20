/datum/action/cooldown/bloodsucker/targeted/hecata/necromancy
	name = "Necromancy"
	button_icon_state = "power_necromancy"
	desc = "Raise the dead as temporary vassals, or revive a dead vassal as a zombie permanently. Temporary vassals last longer as this ability ranks up."
	power_explanation = "Necromancy:\n\
		Click on a corpse in order to attempt to resurrect them.\n\
		Non-vassals will become temporary zombies that will follow your orders. Dead vassals are also turned, but last permanently.\n\
		Temporary vassals tend to not last long, their form quickly falling apart, make sure you set them out to do what you want as soon as possible.\n\
		Vassaling people this way does not grant ranks. In addition, after their time is up they will die and no longer be your vassal."
	check_flags = BP_CANT_USE_IN_TORPOR|BP_CANT_USE_IN_FRENZY|BP_CANT_USE_WHILE_UNCONSCIOUS
	power_flags = BP_AM_STATIC_COOLDOWN
	bloodcost = 35
	cooldown_time = 45 SECONDS
	target_range = 1
	prefire_message = "Select a target."

	/// The number of people "revived" with this power.
	/// Used to determine Hecata clan objective completion status.
	var/revive_count = 0

/datum/action/cooldown/bloodsucker/targeted/hecata/necromancy/CheckValidTarget(atom/target_atom)
	. = ..()
	if(!.)
		return FALSE
	return isliving(target_atom)

/datum/action/cooldown/bloodsucker/targeted/hecata/necromancy/CheckCanTarget(mob/living/carbon/target_atom)
	. = ..()
	if(!.)
		return FALSE
	// No mind
	if(!target_atom.mind)
		to_chat(owner, span_warning("[target_atom] is mindless."))
		return FALSE
	// Bloodsucker
	if(IS_BLOODSUCKER(target_atom))
		to_chat(owner, span_notice("Bloodsuckers are immune to [src]."))
		return FALSE
	// Alive
	if(target_atom.stat != DEAD)
		to_chat(owner, span_notice("[target_atom] is still alive."))
		return FALSE
	return TRUE

/datum/action/cooldown/bloodsucker/targeted/hecata/necromancy/FireTargetedPower(atom/target_atom)
	. = ..()
	var/mob/living/target = target_atom
	var/mob/living/user = owner
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(target.stat == DEAD && user.Adjacent(target))
		owner.balloon_alert(owner, "attempting to revive...")
		if(!do_after(user, 6 SECONDS, target,  NONE, TRUE))
			return FALSE
		if(IS_VASSAL(target))
			power_activated_sucessfully()
			owner.balloon_alert(owner, "we revive [target]!")
			zombify(target)
			revive_count++ //counts a succesful necromancy towards your objective progress
			return
		if(IS_MONSTERHUNTER(target))
			owner.balloon_alert(owner, "their body refuses to react...")
			DeactivatePower()
			return
		zombify(target)
		bloodsuckerdatum.make_vassal(target)
		power_activated_sucessfully()
		revive_count++ //counts a succesful necromancy towards your objective progress
		to_chat(user, span_warning("We revive [target]!"))
		var/living_time
		switch(level_current)
			if(0)
				living_time = 2 MINUTES
			if(1)
				living_time = 5 MINUTES
			if(2)
				living_time = 8 MINUTES
			if(3)
				living_time = 11 MINUTES
			if(4)
				living_time = 14 MINUTES
			else
				living_time = 17 MINUTES //in general, they don't last long, make the most of them.
		addtimer(CALLBACK(src, PROC_REF(end_necromance), target), living_time)
	else //extra check, but this shouldn't happen
		owner.balloon_alert(owner, "out of range/not dead.")
		return FALSE
	DeactivatePower()

/datum/action/cooldown/bloodsucker/targeted/hecata/necromancy/proc/end_necromance(mob/living/victim)
	victim.mind.remove_antag_datum(/datum/antagonist/vassal)
	to_chat(victim, span_warning("You feel the shadows around you weaken, your form falling limp like a puppet cut from its strings!"))
	victim.set_species(/datum/species/human/krokodil_addict) //they will turn into a fake zombie on death, that still retains blood and isnt so powerful.
	victim.death()

/datum/action/cooldown/bloodsucker/targeted/hecata/necromancy/proc/zombify(mob/living/victim)
	victim.mind.grab_ghost()
	victim.set_species(/datum/species/zombie/hecata) //imitation zombies that shamble around and beat people with their fists
	victim.revive(HEAL_ALL)
	victim.visible_message(span_danger("[victim.name] suddenly convulses, as [victim.p_they()] stagger to [victim.p_their()] feet and gain a ravenous hunger in [victim.p_their()] eyes!"), span_alien("You RISE!"))
	playsound(get_turf(victim), 'sound/effects/hallucinations/far_noise.ogg', 50, 1)
	to_chat(victim, span_warning("Your broken form is picked up by strange shadows. If you were previously not a vassal, it is unlikely these shadows will be strong enough to keep you going for very long."))
	to_chat(victim, span_notice("You are resilient to many things like the vacuum of space, can punch harder, and can take more damage before dropping. However, you are unable to use guns and are slower."))
