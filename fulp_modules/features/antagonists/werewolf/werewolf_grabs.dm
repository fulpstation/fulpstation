// Grab code is pretty much just copied from xenos

// Need to add on to this for werewolves to be able to grab
/mob/living/carbon/human/CtrlClick(mob/user)
	. = ..()
	if(IS_WEREWOLF_MOB(user))
		var/mob/living/carbon/werewolf/ww = user
		if(ww.grab(src))
			ww.changeNext_move(CLICK_CD_MELEE)
			return TRUE

/mob/living/carbon/werewolf/proc/grab(mob/living/carbon/human/target)
	if(target.check_block(src, 0, "[target]'s grab"))
		return FALSE
	target.grabbedby(src)
	return TRUE

// /mob/living/carbon/werewolf/setGrabState(newstate)
// 	if(newstate == grab_state)
// 		return
// 	if(newstate > GRAB_AGGRESSIVE)
// 		newstate = GRAB_AGGRESSIVE
// 	SEND_SIGNAL(src, COMSIG_MOVABLE_SET_GRAB_STATE, newstate)
// 	. = grab_state
// 	grab_state = newstate
// 	switch(grab_state) // Current state.
// 		if(GRAB_PASSIVE)
// 			REMOVE_TRAIT(pulling, TRAIT_IMMOBILIZED, CHOKEHOLD_TRAIT)
// 			if(. >= GRAB_NECK) // Previous state was a a neck-grab or higher.
// 				REMOVE_TRAIT(pulling, TRAIT_FLOORED, CHOKEHOLD_TRAIT)
// 		if(GRAB_AGGRESSIVE)
// 			if(. >= GRAB_NECK) // Grab got downgraded.
// 				REMOVE_TRAIT(pulling, TRAIT_FLOORED, CHOKEHOLD_TRAIT)
// 			else // Grab got upgraded from a passive one.
// 				ADD_TRAIT(pulling, TRAIT_IMMOBILIZED, CHOKEHOLD_TRAIT)
// 		if(GRAB_NECK, GRAB_KILL)
// 			if(. <= GRAB_AGGRESSIVE)
// 				ADD_TRAIT(pulling, TRAIT_FLOORED, CHOKEHOLD_TRAIT)
