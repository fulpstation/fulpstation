#define HUNTER_SCAN_MIN_DISTANCE 8
#define HUNTER_SCAN_MAX_DISTANCE 35
#define HUNTER_SCAN_PING_TIME 20 //5s update time.

/datum/game_mode
	var/list/datum/mind/monsterhunter = list()

/datum/antagonist/monsterhunter
	name = "Hunter"
	roundend_category = "hunters"
	antagpanel_category = "Monster Hunter"
	job_rank = ROLE_MONSTERHUNTER
	var/list/datum/action/powers = list() // Purchased powers
	var/datum/martial_art/my_kungfu // Hunters know a lil kung fu.
	var/bad_dude = FALSE // Every first hunter spawned is a SHIT LORD.

/datum/antagonist/bloodsucker/apply_innate_effects(mob/living/mob_override)
	return

//This handles the removal of antag huds/special abilities
/datum/antagonist/bloodsucker/remove_innate_effects(mob/living/mob_override)
	return

/datum/antagonist/monsterhunter/on_gain()
	SSticker.mode.monsterhunter += owner
	// Hunter Pinpointer
	owner.current.apply_status_effect(/datum/status_effect/agent_pinpointer/hunter_edition)
	// Give Hunter Power
	var/datum/action/P = new /datum/action/bloodsucker/trackvamp
	P.Grant(owner.current)
	// Give Hunter Martial Arts
	if (rand(1,2) == 1)
		var/datum/martial_art/pick_type = pick(/datum/martial_art/cqc, /datum/martial_art/krav_maga, /datum/martial_art/krav_maga, /datum/martial_art/wrestling, /datum/martial_art/hunterfu)  // /datum/martial_art/boxing  <--- doesn't include grabbing, so don't use!
		my_kungfu = new pick_type //pick (/datum/martial_art/boxing, /datum/martial_art/cqc) // ick_type
		my_kungfu.teach(owner.current, 0)
	// Give Hunter Objective
	var/datum/objective/bloodsucker/monsterhunter/monsterhunter_objective = new
	monsterhunter_objective.owner = owner
	monsterhunter_objective.generate_objective()
	objectives += monsterhunter_objective
	// Badguy Hunter? (Give him BADGUY objectives)
	if(bad_dude)
		// Stolen DIRECTLY from datum_traitor.dm
		if(prob(15) && !(locate(/datum/objective/download) in objectives) && !(owner.assigned_role in list("Research Director", "Scientist", "Roboticist", "Geneticist")))
			var/datum/objective/download/download_objective = new
			download_objective.owner = owner
			download_objective.gen_amount_goal()
			objectives += download_objective
		else
			var/datum/objective/steal/steal_objective = new
			steal_objective.owner = owner
			steal_objective.find_target()
			objectives += steal_objective
	return ..()


/datum/antagonist/monsterhunter/on_removal()
	// Clear Antag
	SSticker.mode.monsterhunter -= owner
	owner.special_role = null
	if(!LAZYLEN(owner.antag_datums))
		owner.current.remove_from_current_living_antags()
	if(!silent && owner.current)
		farewell()
	// Master Pinpointer
	owner.current.remove_status_effect(/datum/status_effect/agent_pinpointer/hunter_edition)
	// Remove martial arts
	if(owner.current)
		for (var/datum/action/bloodsucker/P in owner.current.actions)
			P.Remove(owner.current)
		my_kungfu.remove(owner.current)
	// Remove Hunter Objectives
	remove_objective()
	return ..()

/datum/antagonist/monsterhunter/proc/add_objective(datum/objective/O)
	objectives += O

/datum/antagonist/monsterhunter/proc/remove_objective()
	for(var/O in objectives)
		objectives -= O
		qdel(O)

/datum/antagonist/monsterhunter/greet()
	var/monsterhunter_greet
	monsterhunter_greet += "<span class='userdanger'>You are a fearless Monster Hunter!</span>"
	monsterhunter_greet += "<span class='announce'>You know there's one or more filthy creature onboard the station, though their identities elude you.</span><br>"
	monsterhunter_greet += "<span class='announce'>It's your job to root them out, destroy their nests, and save the crew.</span><br>"
	monsterhunter_greet += "<span class='announce'>Use <b>WHATEVER MEANS NECESSARY</b> to find these creatures, no matter who gets hurt or what you have to destroy to do it.</span><br>"
	monsterhunter_greet += "<span class='announce'>There are greater stakes at hand than the safety of the station!</span><br>"
	monsterhunter_greet += "<span class='announce'>However, security may detain you if they discover your mission.</span><br>"
	if(my_kungfu != null)
		monsterhunter_greet += "<span class='boldannounce'>Hunter Tip: Use your [my_kungfu.name] techniques to give you an advantage over the enemy.</span><br>"
	to_chat(owner, monsterhunter_greet)

/datum/antagonist/monsterhunter/farewell()
	to_chat(owner, "<span class='userdanger'>Your hunt has ended: you are no longer a monster hunter!</span>")

// TAKEN FROM:  /datum/action/changeling/pheromone_receptors    // pheromone_receptors.dm      for a version of tracking that Changelings have!
/datum/status_effect/agent_pinpointer/hunter_edition
	alert_type = /atom/movable/screen/alert/status_effect/agent_pinpointer/hunter_edition
	minimum_range = HUNTER_SCAN_MIN_DISTANCE
	tick_interval = HUNTER_SCAN_PING_TIME
	duration = 160 // Lasts 10s
	range_fuzz_factor = 5//PINPOINTER_EXTRA_RANDOM_RANGE

/atom/movable/screen/alert/status_effect/agent_pinpointer/hunter_edition
	name = "Monster Tracking"
	desc = "You always know where the hellspawn are."

/datum/status_effect/agent_pinpointer/hunter_edition/on_creation(mob/living/new_owner, ...)
	..()

	// Pick target
	var/turf/my_loc = get_turf(owner)
	var/list/mob/living/carbon/vamps = list()

	for(var/datum/mind/M in SSticker.mode.bloodsuckers)
		if (!M.current || M.current == owner || !get_turf(M.current) || !get_turf(new_owner))
			continue
		var/datum/antagonist/bloodsucker/antag_datum = M.has_antag_datum(ANTAG_DATUM_BLOODSUCKER)
		if(!istype(antag_datum))
			continue
		var/their_loc = get_turf(M.current)
		var/distance = get_dist_euclidian(my_loc, their_loc)
		if (distance < HUNTER_SCAN_MAX_DISTANCE)
			vamps[M.current] = (HUNTER_SCAN_MAX_DISTANCE ** 2) - (distance ** 2)
	// Found one!
	if(vamps.len)
		scan_target = pickweight(vamps) //Point at a 'random' vamp, biasing heavily towards closer ones.
		to_chat(owner, "<span class='warning'>You detect signs of monsters to the <b>[dir2text(get_dir(my_loc,get_turf(scan_target)))]!</b></span>")
	// Will yield a "?"
	else
		to_chat(owner, "<span class='notice'>There are no monsters nearby.</span>")
	// Force Point-To Immediately
	point_to_target()

/datum/status_effect/agent_pinpointer/hunter_edition/scan_for_target()
	// Lose target? Done. Otherwise, scan for target's current position.
	if (!scan_target && owner)
		owner.remove_status_effect(/datum/status_effect/agent_pinpointer/hunter_edition)

	// NOTE: Do NOT run ..(), or else we'll remove our target.


/datum/status_effect/agent_pinpointer/hunter_edition/Destroy()
	if (scan_target)
		to_chat(owner, "<span class='notice'>You've lost the trail.</span>")
	..()

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/action/bloodsucker/trackvamp/
	name = "Track Monster"//"Cellular Emporium"
	desc = "Take a moment to look for clues of any nearby monsters.<br>These creatures are slippery, and often look like the crew."
	button_icon = 'icons/mob/actions/actions_bloodsucker.dmi'	//This is the file for the BACKGROUND icon
	background_icon_state = "vamp_power_off"		//And this is the state for the background icon
	icon_icon = 'icons/mob/actions/actions_bloodsucker.dmi'		//This is the file for the ACTION icon
	button_icon_state = "power_hunter" 				//And this is the state for the action icon
	amToggle = FALSE  // Action-Related
	cooldown = 300 // 10 ticks, 1 second.
	bloodcost = 0

/datum/action/bloodsucker/trackvamp/ActivatePower()
	var/mob/living/user = owner
	to_chat(user, "<span class='notice'>You look around, scanning your environment and discerning signs of any filthy, wretched affronts to the natural order.</span>")

	if (!do_mob(user,owner,80))
		return
	// Add Power
	// REMOVED //user.apply_status_effect(/datum/status_effect/agent_pinpointer/hunter_edition)
	// We don't track direction anymore!
	// Return text indicating direction
	display_proximity()
	// NOTE: DON'T DEACTIVATE!
	//DeactivatePower()

/datum/action/bloodsucker/trackvamp/proc/display_proximity()
	// Pick target
	var/turf/my_loc = get_turf(owner)
	//var/list/mob/living/carbon/vamps = list()
	var/best_dist = 9999
	var/mob/living/best_vamp

	// Track ALL MONSTERS in Game Mode
	var/list/datum/mind/monsters = list()
	monsters += SSticker.mode.bloodsuckers
	monsters += SSticker.mode.cult
	monsters += SSticker.mode.wizards
	monsters += SSticker.mode.apprentices
	// monsters += ROLE_HERETIC // Disabled, not working (Heretics) var/list/culties
	//monsters += SSticker.mode.changelings(ROLE_CHANGELING) // Disabled, not working
	//
	for(var/datum/mind/M in monsters)
		if (!M.current || M.current == owner)//   || !get_turf(M.current) || !get_turf(owner))
			continue
		for(var/a in M.antag_datums)
			var/datum/antagonist/antag_datum = a // var/datum/antagonist/antag_datum = M.has_antag_datum(ANTAG_DATUM_BLOODSUCKER)
			if(!istype(antag_datum) || antag_datum.AmFinalDeath())
				continue
			var/their_loc = get_turf(M.current)
			var/distance = get_dist_euclidian(my_loc, their_loc)
			// Found One: Closer than previous/max distance
			if (distance < best_dist && distance <= HUNTER_SCAN_MAX_DISTANCE)
				best_dist = distance
				best_vamp = M.current
				break // Stop searching through my antag datums and go to the next guy

	// Found one!
	if(best_vamp)
		var/distString = best_dist <= HUNTER_SCAN_MAX_DISTANCE / 2 ? "<b>somewhere closeby!</b>" : "somewhere in the distance."
		//to_chat(owner, "<span class='warning'>You detect signs of Bloodsuckers to the <b>[dir2text(get_dir(my_loc,get_turf(targetVamp)))]!</b></span>")
		to_chat(owner, "<span class='warning'>You detect signs of monsters [distString]</span>")

	// Will yield a "?"
	else
		to_chat(owner, "<span class='notice'>There are no monsters nearby.</span>")






////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// From martial.dm

#define BODYSLAM_COMBO "GH"
#define STAKESTAB_COMBO "HH"
#define NECKSNAP_COMBO "GD"
#define HOLYKICK_COMBO "DG"

/datum/martial_art/hunterfu
	name = "Hunter-Fu"
	id = "MARTIALART_HUNTER" //ID, used by mind/has_martialart
	help_verb = /mob/living/carbon/human/proc/hunterfu_help
	block_chance = 60
	allow_temp_override = TRUE
	smashes_tables = FALSE
	var/restraining = FALSE
	var/old_grab_state = null

/datum/martial_art/hunterfu/reset_streak(mob/living/carbon/human/new_target)
	. = ..()
	restraining = FALSE

/datum/martial_art/hunterfu/proc/check_streak(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!can_use(A))
		return FALSE
	if(findtext(streak,BODYSLAM_COMBO))
		streak = ""
		BodySlam(A,D)
		return TRUE
	if(findtext(streak,STAKESTAB_COMBO))
		streak = ""
		StakeStab(A,D)
		return TRUE
	if(findtext(streak,NECKSNAP_COMBO))
		streak = ""
		NeckSnap(A,D)
		return TRUE
	if(findtext(streak,HOLYKICK_COMBO))
		streak = ""
		HolyKick(A,D)
		return TRUE
	return FALSE

/datum/martial_art/hunterfu/proc/BodySlam(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!can_use(A))
		return FALSE
	if(D.body_position == STANDING_UP)
		D.visible_message("<span class='danger'>[A] slams both them and [D] into the ground!</span>", \
						"<span class='userdanger'>You're slammed into the ground by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", null, A)
		to_chat(A, "<span class='danger'>You slam [D] into the ground!</span>")
		playsound(get_turf(A), 'sound/weapons/slam.ogg', 50, TRUE, -1)
		D.apply_damage(10, BRUTE)
		D.Paralyze(60)
		A.Paralyze(40)
		log_combat(A, D, "bodyslammed (Hunter-Fu)")
	return TRUE

/datum/martial_art/hunterfu/proc/StakeStab(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!can_use(A))
		return FALSE
	if(!D.stat)
		D.visible_message("<span class='danger'>[A] stabs [D] in the heart!</span>", \
						"<span class='userdanger'>You're stabbed in the heart by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
		to_chat(A, "<span class='danger'>You stab [D] in the heart!</span>")
		playsound(get_turf(A), 'sound/weapons/bladeslice.ogg', 50, TRUE, -1)
		D.apply_damage(15, A.dna.species.attack_type)
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = D.mind.has_antag_datum(ANTAG_DATUM_BLOODSUCKER)
		if(bloodsuckerdatum)
			D.apply_damage(50, A.dna.species.attack_type)
		log_combat(A, D, "stakestabbed (Hunter-Fu)")
	return TRUE

/datum/martial_art/hunterfu/proc/NeckSnap(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!can_use(A))
		return FALSE
	log_combat(A, D, "neck snapped (Hunter-Fu)")
	D.visible_message("<span class='danger'>[A] snapped [D]'s neck!</span>", \
					"<span class='userdanger'>Your neck is snapped by [A]!</span>", "<span class='hear'>You hear a snap!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You snap [D]'s neck!</span>")
	D.SetSleeping(60)
	playsound(get_turf(A), 'sound/effects/snap.ogg', 50, TRUE, -1)
	return TRUE

/datum/martial_art/hunterfu/proc/HolyKick(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(restraining)
		return
	if(!can_use(A))
		return FALSE
	if(!D.stat)
		log_combat(A, D, "holy kicked (Hunter-Fu)")
		D.visible_message("<span class='warning'>[A] kicks [D], splashing holy water in every direction!</span>", \
						"<span class='userdanger'>You're kicked by [A], with holy water dripping down on you!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", null, A)
		to_chat(A, "<span class='danger'>You holy kick [D]!</span>")
		D.adjustStaminaLoss(60)
		D.Paralyze(50)
		if(iscultist(D))
			for(var/datum/action/innate/cult/blood_magic/BD in D.actions)
				to_chat(D, "<span class='cultlarge'>Your blood rites falter as the holy water drips onto your body!</span>")
				for(var/datum/action/innate/cult/blood_spell/BS in BD.spells)
					qdel(BS)
		restraining = TRUE
		addtimer(VARSET_CALLBACK(src, restraining, FALSE), 50, TIMER_UNIQUE)
	return TRUE

/datum/martial_art/hunterfu/disarm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	add_to_streak("D",D)
	log_combat(A, D, "disarmed (Hunter-Fu)")
	if(check_streak(A,D))
		return TRUE
	else
		return FALSE

/datum/martial_art/hunterfu/harm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!can_use(A))
		return FALSE
	add_to_streak("H",D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "attacked (Hunter-Fu)")
	A.do_attack_animation(D)
	var/picked_hit_type = pick("fighter-fu'd", "staked", "assaulted", "hunted")
	var/bonus_damage = 13
	if(D.body_position == LYING_DOWN)
		bonus_damage += 5
		picked_hit_type = "stomp"
	D.apply_damage(bonus_damage, BRUTE)
	if(picked_hit_type == "kick" || picked_hit_type == "stomp")
		playsound(get_turf(D), 'sound/weapons/cqchit2.ogg', 50, TRUE, -1)
	else
		playsound(get_turf(D), 'sound/weapons/cqchit1.ogg', 50, TRUE, -1)
	D.visible_message("<span class='danger'>[A] [picked_hit_type]ed [D]!</span>", \
					"<span class='userdanger'>You're [picked_hit_type]ed by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You [picked_hit_type] [D]!</span>")
	return TRUE

/datum/martial_art/hunterfu/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(A.a_intent == INTENT_GRAB && A!=D && can_use(A)) // A!=D prevents grabbing yourself
		add_to_streak("G",D)
		if(check_streak(A,D)) //if a combo is made no grab upgrade is done
			return TRUE
		log_combat(A, D, "grabbed (Hunter-Fu)")
		old_grab_state = A.grab_state
		D.grabbedby(A, 1)
		if(old_grab_state == GRAB_PASSIVE)
			D.drop_all_held_items()
			A.setGrabState(GRAB_AGGRESSIVE) //Instant agressive grab if on grab intent
			D.visible_message("<span class='danger'>[A] gets [D] by surprise with a grab!</span>", \
					"<span class='userdanger'>You're taken by surprise when [A] grabs you!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", COMBAT_MESSAGE_RANGE, A)
			to_chat(A, "<span class='danger'>You quickly grab hold of [D]!</span>")
			D.Stun(rand(15,25))
		return TRUE
	else
		return FALSE

/datum/martial_art/hunterfu/add_to_streak(element,mob/living/carbon/human/D)
	if(D != current_target)
		current_target = D
		streak = ""
	streak = streak+element
	if(length_char(streak) > max_streak_length)
		streak = streak[1]
	return

/mob/living/carbon/human/proc/hunterfu_help()
	set name = "Remember The Basics"
	set desc = "You try to remember some of the basics of Hunter-Fu."
	set category = "Hunter-Fu"
	to_chat(usr, "<b><i>You try to remember some of the basics of Hunter-Fu.</i></b>")

	to_chat(usr, "<span class='notice'>Body Slam</span>: Grab Harm. Slam opponent into the ground, knocking you both down.")
	to_chat(usr, "<span class='notice'>Stake Stab</span>: Harm Harm. Stabs opponent with your bare fist, as strong as a Stake. Deals heavy damage to Bloodsuckers.")
	to_chat(usr, "<span class='notice'>Neck Snap</span>: Grab Disarm. Snaps an opponents neck, temporarily knocking them out.")
	to_chat(usr, "<span class='notice'>Holy Kick</span>: Disarm Grab. Splashes the user with Holy Water, removing Cult Spells, while dealing stamina damage.")

	to_chat(usr, "<b><i>In addition, by having your throw mode on, you take a defensive position, allowing you to block and sometimes even counter attacks done to you.</i></b>")
