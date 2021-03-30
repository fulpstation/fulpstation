/*
 *	The contents of this file were originally licensed under CC-BY-NC-SA 3.0 as part of Goonstation(https://ss13.co).
 *	However, /tg/station and derivative codebases have been granted the right to use this code under the terms of the AGPL.
 *	The original authors are: cogwerks, pistoleer, spyguy, angriestibm, marquesas, and stuntwaffle.
 */

/// Defines the Martial Art - Move to fulp_defines.dm once said file exists -Willard
#define MARTIALART_FULPWRESTLING "Quartermaster Wrestling"
/// How many steps it takes to throw the target - Used for throwing
#define WRESTLING_THROW_STEPS 28


/datum/martial_art/fulpwrestling
	name = "Wrestling"
	id = MARTIALART_FULPWRESTLING
	help_verb = /mob/living/proc/FulpWrestling_help
	smashes_tables = TRUE
	var/datum/action/fulpslam/slam = new/datum/action/fulpslam()
	var/datum/action/fulpdrop/drop = new/datum/action/fulpdrop()

/datum/martial_art/fulpwrestling/proc/check_streak(mob/living/A, mob/living/D)
	switch(streak)
		if("fulpslam")
			streak = ""
			fulpslam(A,D)
			return TRUE
		if("fulpdrop")
			streak = ""
			fulpdrop(A,D)
			return TRUE
	return FALSE

/// Teaches moves
/datum/martial_art/fulpwrestling/teach(mob/living/H, make_temporary = FALSE)
	if(..())
		slam.Grant(H)
		drop.Grant(H)
		RegisterSignal(H, COMSIG_MOB_CLICKON, .proc/check_swing)

/datum/martial_art/fulpwrestling/on_remove(mob/living/H)
	slam.Remove(H)
	drop.Remove(H)
	UnregisterSignal(H, COMSIG_MOB_CLICKON)

/// Slam icon
/datum/action/fulpslam
	name = "Slam (Cinch) - Slam a grappled opponent into the floor."
	button_icon_state = "wrestle_slam"
	icon_icon = 'fulp_modules/QM_wrestling/icons/actions_wrestling.dmi'

/datum/action/fulpslam/Trigger()
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't WRESTLE while you're OUT FOR THE COUNT.</span>")
		return
	if(owner.mind.martial_art.streak == "fulpslam")
		owner.visible_message("<span class='danger'>[owner] assumes a neutral stance.</span>", "<b><i>Your next attack is cleared.</i></b>")
		owner.mind.martial_art.streak = ""
	else
		owner.visible_message("<span class='danger'>[owner] prepares to BODY SLAM!</span>", "<b><i>Your next attack will be a BODY SLAM.</i></b>")
		owner.mind.martial_art.streak = "fulpslam"

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
/// Slam
/datum/martial_art/fulpwrestling/proc/fulpslam(mob/living/A, mob/living/D)
	if(!D)
		return
	if(!A.pulling || A.pulling != D)
		to_chat(A, "<span class='warning'>You need to have [D] in a cinch!</span>")
		return
	D.forceMove(A.loc)
	A.setDir(get_dir(A, D))
	D.setDir(get_dir(D, A))
	D.visible_message("<span class='danger'>[A] lifts [D] up!</span>", \
					"<span class='userdanger'>You're lifted up by [A]!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", null, A)
	to_chat(A, "<span class='danger'>You lift [D] up!</span>")
	FlipAnimation()
	for(var/i = 0, i < 3, i++)
		if(A && D)
			A.pixel_y += 3
			D.pixel_y += 3
			A.setDir(turn(A.dir, 90))
			D.setDir(turn(D.dir, 90))
			switch (A.dir)
				if(NORTH)
					D.pixel_x = A.pixel_x
				if(SOUTH)
					D.pixel_x = A.pixel_x
				if(EAST)
					D.pixel_x = A.pixel_x - 8
				if(WEST)
					D.pixel_x = A.pixel_x + 8
			if(get_dist(A, D) > 1)
				to_chat(A, "<span class='warning'>[D] is too far away!</span>")
				A.pixel_x = A.base_pixel_x
				A.pixel_y = A.base_pixel_y
				D.pixel_x = D.base_pixel_x
				D.pixel_y = D.base_pixel_y
				return
			if(!isturf(A.loc) || !isturf(D.loc))
				to_chat(A, "<span class='warning'>You can't slam [D] here!</span>")
				A.pixel_x = A.base_pixel_x
				A.pixel_y = A.base_pixel_y
				D.pixel_x = D.base_pixel_x
				D.pixel_y = D.base_pixel_y
				return
		else
			if(A)
				A.pixel_x = A.base_pixel_x
				A.pixel_y = A.base_pixel_y
			if(D)
				D.pixel_x = D.base_pixel_x
				D.pixel_y = D.base_pixel_y
			return
		sleep(1)
	if(A && D)
		A.pixel_x = A.base_pixel_x
		A.pixel_y = A.base_pixel_y
		D.pixel_x = D.base_pixel_x
		D.pixel_y = D.base_pixel_y

		if(get_dist(A, D) > 1)
			to_chat(A, "<span class='warning'>[D] is too far away!</span>")
			return
		if(!isturf(A.loc) || !isturf(D.loc))
			to_chat(A, "<span class='warning'>You can't slam [D] here!</span>")
			return
		D.forceMove(A.loc)
		var/fluff = "body-slam"
		D.visible_message("<span class='danger'>[A] [fluff] [D]!</span>", \
						"<span class='userdanger'>You're [fluff]ed by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
		to_chat(A, "<span class='danger'>You [fluff] [D]!</span>")
		playsound(A.loc, "swing_hit", 50, TRUE)
		if(!D.stat)
			D.emote("scream")
			D.Paralyze(30)
			D.adjustBruteLoss(rand(10,15))
		else
			D.adjustBruteLoss(rand(10,15))
	else
		if(A)
			A.pixel_x = A.base_pixel_x
			A.pixel_y = A.base_pixel_y
		if(D)
			D.pixel_x = D.base_pixel_x
			D.pixel_y = D.base_pixel_y

	log_combat(A, D, "body-slammed (Wrestling)")
	return

/datum/martial_art/fulpwrestling/proc/FlipAnimation(mob/living/D)
	set waitfor = FALSE
	if(D)
		animate(D, transform = matrix(180, MATRIX_ROTATE), time = 1, loop = 0)
	if(do_after(D, 10 SECONDS))
		if(D)
			animate(D, transform = null, time = 1, loop = 0)

/// Drop
/datum/martial_art/fulpwrestling/proc/fulpdrop(mob/living/A, mob/living/D)
	if(!D)
		return
	var/obj/surface = null
	var/turf/ST = null
	var/falling = 0

	for(var/obj/O in oview(1, A))
		if(O.density == 1)
			if(O == A)
				continue
			if(O == D)
				continue
			if(O.opacity)
				continue
			else
				surface = O
				ST = get_turf(O)
				break

	if(surface && (ST && isturf(ST)))
		A.forceMove(ST)
		A.visible_message("<span class='danger'>[A] climbs onto [surface]!</span>", \
						"<span class='danger'>You climb onto [surface]!</span>")
		A.pixel_y = A.base_pixel_y + 10
		falling = 1
		if(do_after(A, 1 SECONDS))
		if(A && D)
			if((falling == 0 && get_dist(A, D) > 1) || (falling == 1 && get_dist(A, D) > 2)) // We climbed onto stuff.
				A.pixel_y = A.base_pixel_y
				if(falling == 1)
					A.visible_message("<span class='danger'>...and dives head-first into the ground, ouch!</span>", \
									"<span class='userdanger'>...and dive head-first into the ground, ouch!</span>")
					A.adjustBruteLoss(rand(10,15))
					A.Paralyze(40)
				to_chat(A, "<span class='warning'>[D] is too far away!</span>")
				return
			if(!isturf(A.loc) || !isturf(D.loc))
				A.pixel_y = A.base_pixel_y
				to_chat(A, "<span class='warning'>You can't drop onto [D] from here!</span>")
				return
			if(A)
				animate(A, transform = matrix(90, MATRIX_ROTATE), time = 1, loop = 0)
			sleep(10)
			if(A)
				animate(A, transform = null, time = 1, loop = 0)

			A.forceMove(D.loc)
			D.visible_message("<span class='danger'>[A] leg-drops [D]!</span>", \
							"<span class='userdanger'>You're leg-dropped by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", null, A)
			to_chat(A, "<span class='danger'>You leg-drop [D]!</span>")
			playsound(A.loc, "swing_hit", 50, TRUE)
			A.emote("scream")

			if(falling == 1)
				if(D.stat)
					D.adjustBruteLoss(rand(15,20))
			else
				D.adjustBruteLoss(rand(15,20))
			D.Paralyze(30)
			A.pixel_y = A.base_pixel_y
		else
			if(A)
				A.pixel_y = A.base_pixel_y
		log_combat(A, D, "leg-dropped (Wrestling)")
		return

/// Run a barrage of checks to see if any given click is actually able to swing
/datum/martial_art/fulpwrestling/proc/check_swing(mob/living/user, atom/clicked_atom, params)
	SIGNAL_HANDLER

	var/list/modifiers = params2list(params)
	if(modifiers["alt"] || modifiers["shift"] || modifiers["ctrl"] || modifiers["middle"])
		return
	if(!user.in_throw_mode || user.get_active_held_item())
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
/datum/martial_art/fulpwrestling/harm_act(mob/living/A, mob/living/D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "harmed (Wrestling)")
	..()

/datum/martial_art/fulpwrestling/disarm_act(mob/living/A, mob/living/D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "disarmed (Wrestling)")
	..()

/datum/martial_art/fulpwrestling/grab_act(mob/living/A, mob/living/D)
	if(check_streak(A,D))
		return TRUE
	if(A.pulling == D)
		return TRUE
	A.start_pulling(D)
	D.visible_message("<span class='danger'>[A] gets [D] in a cinch!</span>", \
					"<span class='userdanger'>You're put into a cinch by [A]!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You get [D] in a cinch!</span>")
	D.Stun(rand(20,40))
	log_combat(A, D, "grabbed (Wrestling)")
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

/mob/living/proc/FulpWrestling_help()
	set name = "Recall Teachings"
	set desc = "Remember how to Wrestle."
	set category = "Wrestling"
	to_chat(usr, "<b><i>You flex your muscles and have a revelation...</i></b>")

	to_chat(usr, "<span class='notice'>Clinch</span>: Grab. Instantly grabs someone, stunning them. Throw intent to launch them.")
	to_chat(usr, "<span class='notice'>Drop</span>: Slam a grappled opponent into the floor.")
	to_chat(usr, "<span class='notice'>Slam</span>: Smash down onto an opponent.")
