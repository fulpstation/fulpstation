/datum/antagonist/werewolf/process(seconds_per_tick)
	if(!owner.current)
		return

	if(!werewolf_den_area)
		return

	if(get_area(owner.current) != werewolf_den_area)
		return
	var/mob/living/carbon/target = owner.current
	target.adjustBruteLoss(-1 * WEREWOLF_DEN_BASE_HEAL_PER_TICK * seconds_per_tick)
	target.adjustFireLoss(-1 * WEREWOLF_DEN_BASE_HEAL_PER_TICK * seconds_per_tick)
	target.adjustToxLoss(-1 * WEREWOLF_DEN_BASE_HEAL_PER_TICK * seconds_per_tick)



/// Returns TRUE if the werewolf can make their den here
/datum/antagonist/werewolf/proc/is_valid_den_area(area/potential_den)
	if(potential_den.outdoors)
		to_chat(owner.current, span_warning("You can't make your den outside!"))
		return FALSE

	var/datum/antagonist/werewolf/ww_datum = is_werewolf_den(potential_den)
	if(ww_datum)
		if(ww_datum == src)
			to_chat(owner.current, span_warning("You've already claimed this area as your den!"))
			return FALSE
		to_chat(owner.current, span_warning("This area has been claimed by another werewolf!"))
		return FALSE

	return TRUE

/datum/antagonist/werewolf/proc/claim_area_as_den(area/potential_den)
	if(!is_valid_den_area(potential_den))
		return FALSE

	unclaim_current_den()
	// Set the new den area
	werewolf_den_area = potential_den
	RegisterSignal(potential_den, COMSIG_AREA_ENTERED, PROC_REF(on_den_entered))
	START_PROCESSING(SSaura, src)

/datum/antagonist/werewolf/proc/unclaim_current_den()
	if(!werewolf_den_area)
		return

	UnregisterSignal(werewolf_den_area, COMSIG_AREA_ENTERED)
	STOP_PROCESSING(SSaura, src)
	werewolf_den_area = null

/datum/mood_event/werewolf_den_negative
	description = "Ugh, it smells terrible in here!"
	mood_change = -2
	timeout = 1 MINUTES

/datum/mood_event/werewolf_den_positive
	description = "Ahh, smells like home!"
	mood_change = 2
	timeout = 1 MINUTES

/datum/antagonist/werewolf/proc/on_den_entered(area/new_area, atom/movable/arrived)
	SIGNAL_HANDLER
	if(isliving(arrived))
		var/mob/living/target = arrived
		if(target == owner.current)
			target.add_mood_event("werewolf_smell", /datum/mood_event/werewolf_den_positive)
			return

		if(HAS_TRAIT(target, TRAIT_STRONG_SNIFFER))
			target.add_mood_event("werewolf_smell", /datum/mood_event/werewolf_den_negative)
