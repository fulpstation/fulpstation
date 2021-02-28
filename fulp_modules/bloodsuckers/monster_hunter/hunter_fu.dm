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
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = D.mind.has_antag_datum(/datum/antagonist/bloodsucker)
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
