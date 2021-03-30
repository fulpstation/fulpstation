/*
 *	The contents of this file were originally licensed under CC-BY-NC-SA 3.0 as part of Goonstation(https://ss13.co).
 *	However, /tg/station and derivative codebases have been granted the right to use this code under the terms of the AGPL.
 *	The original authors are: cogwerks, pistoleer, spyguy, angriestibm, marquesas, and stuntwaffle.
 *	If you make a derivative work from this code, you must include this notification header alongside it.
 */

/// Defines the Martial Art - Move to fulp_defines.dm once said file exists -Willard
#define MARTIALART_FULPWRESTLING "Quartermaster Wrestling"

/datum/martial_art/fulpwrestling
	name = "Wrestling"
	id = MARTIALART_QMWRESTLING
	help_verb = /mob/living/proc/FulpWrestling_help
	smashes_tables = TRUE
	var/datum/action/slam/slam = new/datum/action/fulpslam()
	var/datum/action/drop/drop = new/datum/action/fulpdrop()

/datum/martial_art/fulpwrestling/proc/check_streak(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	if(findtext("fulpdrop"))
		streak = ""
		Drop(A,D)
		return TRUE
	if(findtext("fulpslam"))
		streak = ""
		Slam(A,D)
/*		return TRUE
	if(findtext(streak,RESTRAIN_COMBO))
		streak = ""
		Restrain(A,D)
		return TRUE
	if(findtext(streak,PRESSURE_COMBO))
		streak = ""
		Pressure(A,D)
		return TRUE
	if(findtext(streak,CONSECUTIVE_COMBO))
		streak = ""
		Consecutive(A,D)
*/
	return FALSE

/// Teaches moves
/datum/martial_art/fulpwrestling/teach(mob/living/H, make_temporary = FALSE)
	. = ..()
	if(!.)
		return
	to_chat(H, "<span class='userdanger'>SNAP INTO A THIN TIM!</span>")
	fulpdrop.Grant(H)
	fulpslam.Grant(H)

/datum/martial_art/fulpwrestling/on_remove(mob/living/H)
	. = ..()
	to_chat(H, "<span class='userdanger'>You no longer feel that the tower of power is too sweet to be sour...</span>")
	fulpdrop.Remove(H)
	fulpslam.Remove(H)

/// Slam icon
/datum/action/fulpslam
	name = "Slam (Cinch) - Slam a grappled opponent into the floor."
	button_icon_state = "wrestle_slam"
	icon_icon = 'fulp_modules/QM_wrestling/icons/actions_wrestling.dmi'

/datum/action/fulpslam/Trigger()
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't WRESTLE while you're OUT FOR THE COUNT.</span>")
		return
	owner.visible_message("<span class='danger'>[owner] prepares to BODY SLAM!</span>", "<b><i>Your next attack will be a BODY SLAM.</i></b>")
	var/mob/living/H = owner
	H.mind.martial_art.streak = "slam"

/// Drop icon
/datum/action/fulpdrop
	name = "Drop - Smash down onto an opponent."
	button_icon_state = "wrestle_drop"
	icon_icon = 'fulp_modules/QM_wrestling/icons/actions_wrestling.dmi'

/datum/action/fulpdrop/Trigger()
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't WRESTLE while you're OUT FOR THE COUNT.</span>")
		return
	owner.visible_message("<span class='danger'>[owner] prepares to LEG DROP!</span>", "<b><i>Your next attack will be a LEG DROP.</i></b>")
	var/mob/living/H = owner
	H.mind.martial_art.streak = "drop"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Slam
/datum/martial_art/fulpwrestling/proc/slam(mob/living/A, mob/living/D)
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
		addtimer(CALLBACK(src, .proc/perform_slam), 1 SECONDS)

/datum/martial_art/fulpwrestling/proc/perform_slam(mob/living/A, mob/living/D)
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
			D.Paralyze(40)
			D.adjustBruteLoss(rand(10,20))
		else
			D.adjustBruteLoss(rand(10,20))
	else
		if (A)
			A.pixel_x = A.base_pixel_x
			A.pixel_y = A.base_pixel_y
		if (D)
			D.pixel_x = D.base_pixel_x
			D.pixel_y = D.base_pixel_y

	log_combat(A, D, "body-slammed")
	return

/// Drop
/datum/martial_art/fulpwrestling/proc/drop(mob/living/A, mob/living/D)
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
		addtimer(CALLBACK(src, .proc/perform_drop), 10 SECONDS)

/datum/martial_art/fulpwrestling/proc/perform_drop(mob/living/A, mob/living/D)
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
				D.adjustBruteLoss(rand(20,30))
		else
			D.adjustBruteLoss(rand(20,30))
		D.Paralyze(30)
		A.pixel_y = A.base_pixel_y
	else
		if(A)
			A.pixel_y = A.base_pixel_y
	log_combat(A, D, "leg-dropped")
	return

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Intents
/datum/martial_art/fulpwrestling/harm_act(mob/living/A, mob/living/D)
	if(check_streak(A,D))
		return TRUE
	add_to_streak("H",D)
	log_combat(A, D, "harmed (Wrestling)")
	..()

/datum/martial_art/fulpwrestling/disarm_act(mob/living/A, mob/living/D)
	if(check_streak(A,D))
		return TRUE
	add_to_streak("D",D)
	log_combat(A, D, "disarmed (Wrestling)")
	..()

/datum/martial_art/fulpwrestling/grab_act(mob/living/A, mob/living/D)
	if(check_streak(A,D))
		return TRUE
	add_to_streak("G",D)
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
/obj/item/storage/belt/champion/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_BELT)
		if(user.mind && user.mind.assigned_role == "Quartermaster")
			var/datum/martial_art/fulpwrestling/wrestling = new()
			var/mob/living/H = user
			wrestling.teach(H, TRUE)
	return

/obj/item/storage/belt/champion/dropped(mob/user)
	. = ..()
	var/mob/living/H = user
	if(H.get_item_by_slot(ITEM_SLOT_BELT) == src)
		if(user.mind && user.mind.assigned_role == "Quartermaster")
			wrestle.remove(H)
	return

/mob/living/proc/FulpWrestling_help()
	set name = "Recall Teachings"
	set desc = "Remember how to Wrestle."
	set category = "Wrestling"
	to_chat(usr, "<b><i>You flex your muscles and have a revelation...</i></b>")

	to_chat(usr, "<span class='notice'>Clinch</span>: Grab. Passively gives you a chance to immediately aggressively grab someone. Not always successful.")
	to_chat(usr, "<span class='notice'>Suplex</span>: Disarm someone you are grabbing. Suplexes your target to the floor. Greatly injures them and leaves both you and your target on the floor.")
	to_chat(usr, "<span class='notice'>Advanced grab</span>: Grab. Passively causes stamina damage when grabbing someone.")
