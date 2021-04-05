/*
 *	The contents of this file were originally licensed under CC-BY-NC-SA 3.0 as part of Goonstation(https://ss13.co).
 *	However, /tg/station and derivative codebases have been granted the right to use this code under the terms of the AGPL.
 *	The original authors are: cogwerks, pistoleer, spyguy, angriestibm, marquesas, and stuntwaffle.
 */

/// Defines the Martial Art
#define MARTIALART_FULPWRESTLING "Quartermaster Wrestling"
/// How many steps it takes to throw the target - Used for throwing
#define WRESTLING_THROW_STEPS 28


/datum/martial_art/fulpwrestling
	name = "Quartermaster Wrestling"
	id = MARTIALART_FULPWRESTLING
	smashes_tables = TRUE
	var/datum/action/fulpdrop/drop = new/datum/action/fulpdrop()
	var/list/valid_areas = list(/area/cargo)

/datum/martial_art/fulpwrestling/proc/check_streak(mob/living/user, mob/living/target)
	if(!can_use(user))
		return FALSE
	switch(streak)
		if("fulpdrop")
			streak = ""
			fulpdrop(user,target)
			return TRUE
	return FALSE

/// Teaches moves
/datum/martial_art/fulpwrestling/teach(mob/living/user, make_temporary = FALSE)
	if(..())
		drop.Grant(user)
		RegisterSignal(user, COMSIG_MOB_CLICKON, .proc/check_swing)

/datum/martial_art/fulpwrestling/on_remove(mob/living/user)
	drop.Remove(user)
	UnregisterSignal(user, COMSIG_MOB_CLICKON)

/// Drop icon
/datum/action/fulpdrop
	name = "Drop - Smash down onto an opponent."
	button_icon_state = "wrestle_drop"
	icon_icon = 'fulp_modules/QM_wrestling/icons/actions_wrestling.dmi'

/datum/action/fulpdrop/Trigger()
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't WRESTLE while you're OUT FOR THE COUNT.</span>")
		return
	if(owner.mind.martial_art.streak == "fulpdrop")
		owner.visible_message("<span class='danger'>[owner] assumes a neutral stance.</span>", "<b><i>Your next attack is cleared.</i></b>")
		owner.mind.martial_art.streak = ""
	else
		owner.visible_message("<span class='danger'>[owner] prepares to LEG DROP!</span>", "<b><i>Your next attack will be a LEG DROP.</i></b>")
		owner.mind.martial_art.streak = "fulpdrop"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Drop
/datum/martial_art/fulpwrestling/proc/fulpdrop(mob/living/user, mob/living/target)
	if(!can_use(user))
		return FALSE
	if(!target)
		return
	var/obj/surface = null
	var/turf/ST = null
	var/falling = 0

	for(var/obj/O in oview(1, user))
		if(O.density == 1)
			if(O == user)
				continue
			if(O == target)
				continue
			if(O.opacity)
				continue
			else
				surface = O
				ST = get_turf(O)
				break

	if(surface && (ST && isturf(ST)))
		user.forceMove(ST)
		user.visible_message("<span class='danger'>[user] climbs onto [surface]!</span>", \
						"<span class='danger'>You climb onto [surface]!</span>")
		user.pixel_y = user.base_pixel_y + 10
		falling = 1
		sleep(10)
	if(user && target)
		if((falling == 0 && get_dist(user, target) > 1) || (falling == 1 && get_dist(user, target) > 2)) // We climbed onto stuff.
			user.pixel_y = user.base_pixel_y
			if(falling == 1)
				user.visible_message("<span class='danger'>...and dives head-first into the ground, ouch!</span>", \
								"<span class='userdanger'>...and dive head-first into the ground, ouch!</span>")
				user.adjustBruteLoss(rand(10,15))
				user.Paralyze(40)
			to_chat(user, "<span class='warning'>[target] is too far away!</span>")
			return
		if(!isturf(user.loc) || !isturf(target.loc))
			user.pixel_y = user.base_pixel_y
			to_chat(user, "<span class='warning'>You can't drop onto [target] from here!</span>")
			return
		if(user)
			animate(user, transform = matrix(90, MATRIX_ROTATE), time = 1, loop = 0)
		sleep(10)
		if(user)
			animate(user, transform = null, time = 1, loop = 0)

		user.forceMove(target.loc)
		target.visible_message("<span class='danger'>[user] leg-drops [target]!</span>", \
						"<span class='userdanger'>You're leg-dropped by [user]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", null, user)
		to_chat(user, "<span class='danger'>You leg-drop [target]!</span>")
		playsound(user.loc, "swing_hit", 50, TRUE)
		user.emote("scream")

		if(falling == 1)
			if(target.stat)
				target.adjustBruteLoss(rand(15,20))
		else
			target.adjustBruteLoss(rand(15,20))
		target.Paralyze(30)
		user.pixel_y = user.base_pixel_y
	else
		if(user)
			user.pixel_y = user.base_pixel_y
	log_combat(user, target, "leg-dropped (Wrestling)")
	return

/// Run a barrage of checks to see if any given click is actually able to swing
/datum/martial_art/fulpwrestling/proc/check_swing(mob/living/user, atom/clicked_atom, params)
	SIGNAL_HANDLER

	var/list/modifiers = params2list(params)
	if(!can_use(user))
		return FALSE
	if(modifiers["alt"] || modifiers["shift"] || modifiers["ctrl"] || modifiers["middle"])
		return
	if(!user.throw_mode || user.get_active_held_item())
		return
	if(user.grab_state < GRAB_PASSIVE || !iscarbon(user.pulling) || user.buckled || user.incapacitated())
		return

	var/mob/living/carbon/possible_throwable = user.pulling

	user.face_atom(clicked_atom)
	INVOKE_ASYNC(src, .proc/setup_swing, user, possible_throwable)
	return(COMSIG_MOB_CANCEL_CLICKON)

/// Do a short 2 second do_after before starting the actual swing
/datum/martial_art/fulpwrestling/proc/setup_swing(mob/living/user, mob/living/target)
	var/original_dir = user.dir

	target.forceMove(user.loc)
	target.setDir(get_dir(target, user))

	target.Stun(2 SECONDS)
	target.visible_message("<span class='danger'>[user] starts grasping [target]...</span>", \
					"<span class='userdanger'>[user] begins grasping you!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", null, user)
	to_chat(user, "<span class='danger'>You start grasping [target]...</span>")

	if(!do_after(user, 2 SECONDS, target))
		target.visible_message("<span class='danger'>[target] breaks free of [user]'s grasp!</span>", \
					"<span class='userdanger'>You break free from [user]'s grasp!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", null, user)
		to_chat(user, "<span class='danger'>You lose your grasp on [target]!</span>")
		return

	// we're officially a-go!
	target.Paralyze(8 SECONDS)
	target.visible_message("<span class='danger'>[user] starts spinning [target] around!</span>", \
					"<span class='userdanger'>[user] starts spinning you around!</span>", "<span class='hear'>You hear wooshing sounds!</span>", null, user)
	to_chat(user, "<span class='danger'>You start spinning [target] around!</span>")
	user.emote("scream")
	target.emote("scream")
	swing_loop(user, target, 0, original_dir)

/datum/martial_art/fulpwrestling/proc/swing_loop(mob/living/user, mob/living/target, step, original_dir)
	if(!target || !user || user.incapacitated())
		return
	if(get_dist(user,target) > 1 || !isturf(user.loc) || !isturf(target.loc))
		to_chat(user, "<span class='warning'>You lose your grasp on [target]!</span>")
		return

	var/delay = 5
	switch(step)
		if(24 to INFINITY)
			delay = 0.1
		if(20 to 23)
			delay = 0.5
		if(16 to 19)
			delay = 1
		if(13 to 15)
			delay = 2
		if(8 to 12)
			delay = 3
		if(4 to 7)
			delay = 3.5
		if(0 to 3)
			delay = 4

	user.setDir(turn(user.dir, 90))
	var/turf/current_spin_turf = target.loc
	var/turf/intermediate_spin_turf = get_step(target, user.dir) // The diagonal
	var/turf/next_spin_turf = get_step(user, user.dir)

	if((isturf(current_spin_turf) && current_spin_turf.Exit(target)) && (isturf(next_spin_turf) && next_spin_turf.Enter(target)))
		target.forceMove(next_spin_turf)
		target.face_atom(user)

	var/list/collateral_check = intermediate_spin_turf.contents + next_spin_turf.contents // Check the cardinal and the diagonal tiles we swung past
	var/turf/collat_throw_target = get_edge_target_turf(target, get_dir(current_spin_turf, next_spin_turf)) // What direction we're swinging

	for(var/mob/living/collateral_mob in collateral_check)
		if(!collateral_mob.density || collateral_mob == target)
			continue

		target.adjustBruteLoss(step*0.5)
		playsound(collateral_mob,'sound/weapons/punch1.ogg',50,TRUE)
		log_combat(user, collateral_mob, "has smacked with swung victim (Wrestling)")
		log_combat(user, target, "has smacked this person into someone while being swung (Wrestling)")

		if(collateral_mob == user)
			user.visible_message("<span class='warning'>[user] smacks [user.p_them()]self with [target]!</span>", "<span class='userdanger'>You end up smacking [target] into yourself!</span>", ignored_mobs = target)
			to_chat(target, "<span class='userdanger'>[user] smacks you into [user.p_them()]self, turning you free!</span>")
			user.adjustBruteLoss(step)
			return

		target.visible_message("<span class='warning'>[user] swings [target] directly into [collateral_mob], sending [collateral_mob.p_them()] flying!</span>", \
			"<span class='userdanger'>You're smacked into [collateral_mob]!</span>", ignored_mobs = collateral_mob)
		to_chat(collateral_mob, "<span class='userdanger'>[user] swings [target] directly into you, sending you flying!</span>")

		collateral_mob.adjustBruteLoss(step*0.5)
		collateral_mob.throw_at(collat_throw_target, round(step * 0.25) + 1, round(step * 0.25) + 1)
		step -= 5
		delay += 5

	step++
	if(step >= WRESTLING_THROW_STEPS)
		finish_swing(user, target, original_dir)
	else if(step < 0)
		user.visible_message("<span class='danger'>[user] loses [user.p_their()] momentum on [target]!</span>", "<span class='warning'>You lose your momentum on swinging [target]!</span>", ignored_mobs = target)
		to_chat(target, "<span class='userdanger'>[user] loses [user.p_their()] momentum and lets go of you!</span>")
	else
		addtimer(CALLBACK(src, .proc/swing_loop, user, target, step, original_dir), delay)

/// Time to toss the victim at high speed
/datum/martial_art/fulpwrestling/proc/finish_swing(mob/living/user, mob/living/target, original_dir)
	if(!target || !user || user.incapacitated())
		return
	if(get_dist(user, target) > 1 || !isturf(user.loc) || !isturf(target.loc))
		to_chat(user, "<span class='warning'>You lose your grasp on [target]!</span>")
		return

	user.setDir(original_dir)
	target.forceMove(user.loc)
	target.visible_message("<span class='danger'>[user] throws [target]!</span>", \
					"<span class='userdanger'>You're thrown by [user]!</span>", "<span class='hear'>You hear aggressive shuffling and a loud thud!</span>", null, user)
	to_chat(user, "<span class='danger'>You throw [target]!</span>")
	playsound(user.loc, "swing_hit", 50, TRUE)
	var/turf/T = get_edge_target_turf(user, user.dir)
	if(!isturf(T))
		return
	if(!target.stat)
		target.emote("scream")
	target.throw_at(T, 10, 6, user, TRUE, TRUE)
	log_combat(user, target, "has thrown (Wrestling)")

#undef WRESTLING_THROW_STEPS

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Intents
/datum/martial_art/fulpwrestling/harm_act(mob/living/user, mob/living/target)
	if(!can_use(user))
		return FALSE
	if(check_streak(user,target))
		return TRUE
	log_combat(user, target, "harmed (Wrestling)")
	..()

/datum/martial_art/fulpwrestling/disarm_act(mob/living/user, mob/living/target)
	if(!can_use(user))
		return FALSE
	if(check_streak(user,target))
		return TRUE
	log_combat(user, target, "disarmed (Wrestling)")
	..()

/datum/martial_art/fulpwrestling/grab_act(mob/living/user, mob/living/target)
	if(!can_use(user))
		return FALSE
	if(check_streak(user,target))
		return TRUE
	if(user.pulling == target)
		return TRUE
	user.start_pulling(target)
	target.visible_message("<span class='danger'>[user] gets [target] in a cinch!</span>", \
					"<span class='userdanger'>You're put into a cinch by [user]!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", COMBAT_MESSAGE_RANGE, user)
	to_chat(user, "<span class='danger'>You get [target] in a cinch!</span>")
	log_combat(user, target, "grabbed (Wrestling)")
	return TRUE

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Adds the Wrestling to the belt
/obj/item/storage/belt/champion
	var/datum/martial_art/fulpwrestling/wrestling = new

/obj/item/storage/belt/champion/equipped(mob/living/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_BELT)
		if(user.mind && user.mind.assigned_role == "Quartermaster")
			wrestling.teach(user, TRUE)
	return

/obj/item/storage/belt/champion/dropped(mob/living/user)
	. = ..()
	if(wrestling)
		wrestling.remove(user)
	return

/// Prevents the Quartermaster from using it outside of Cargo.
/datum/martial_art/fulpwrestling/can_use(mob/living/user)
	if(!is_type_in_list(get_area(user), valid_areas))
		return FALSE
	return ..()
