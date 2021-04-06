#define BODYSLAM_COMBO "GH"
#define STAKESTAB_COMBO "HH"
#define NECKSNAP_COMBO "GD"
#define HOLYKICK_COMBO "DG"

/// From CQC.dm
/datum/martial_art/hunterfu
	name = "Hunter-Fu"
	id = MARTIALART_HUNTERFU
	help_verb = /mob/living/carbon/human/proc/hunterfu_help
	block_chance = 60
	allow_temp_override = TRUE
	smashes_tables = FALSE
	var/old_grab_state = null

/datum/martial_art/hunterfu/proc/check_streak(mob/living/A, mob/living/D)
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

/datum/martial_art/hunterfu/proc/BodySlam(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	if(D.body_position == STANDING_UP)
		D.visible_message("<span class='danger'>[A] slams both them and [D] into the ground!</span>", \
						"<span class='userdanger'>You're slammed into the ground by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", null, A)
		to_chat(A, "<span class='danger'>You slam [D] into the ground!</span>")
		if(D.mind.has_antag_datum(/datum/antagonist/changeling))
			to_chat(D, "<span class='cultlarge'>Our DNA shakes as we are body slammed!</span>")
			D.apply_damage(15, A.get_attack_type())
			D.Paralyze(60)
			A.Paralyze(25)
			return
		else
			D.Paralyze(40)
			A.Paralyze(25)
		playsound(get_turf(A), 'sound/weapons/slam.ogg', 50, TRUE, -1)
		log_combat(A, D, "bodyslammed (Hunter-Fu)")
	return TRUE

/datum/martial_art/hunterfu/proc/StakeStab(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	if(!D.stat)
		D.visible_message("<span class='danger'>[A] stabs [D] in the heart!</span>", \
						"<span class='userdanger'>You're staked in the heart by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
		to_chat(A, "<span class='danger'>You stab [D] viciously!</span>")
		if(D.mind.has_antag_datum(/datum/antagonist/changeling))
			to_chat(D, "<span class='danger'>Their arm tears through our monstrous form!</span>")
			D.apply_damage(25, A.get_attack_type())
			return
		if(D.mind.has_antag_datum(/datum/antagonist/bloodsucker))
			to_chat(D, "<span class='cultlarge'>Their arm stakes straight into our undead flesh!</span>")
			D.apply_damage(20, BURN)
			D.apply_damage(10, A.get_attack_type())
			return
		else
			D.apply_damage(15, A.get_attack_type())
		playsound(get_turf(A), 'sound/weapons/bladeslice.ogg', 50, TRUE, -1)
		log_combat(A, D, "stakestabbed (Hunter-Fu)")
	return TRUE

/datum/martial_art/hunterfu/proc/NeckSnap(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	if(!D.stat)
		D.visible_message("<span class='danger'>[A] snapped [D]'s neck!</span>", \
						"<span class='userdanger'>Your neck is snapped by [A]!</span>", "<span class='hear'>You hear a snap!</span>", COMBAT_MESSAGE_RANGE, A)
		to_chat(A, "<span class='danger'>You snap [D]'s neck!</span>")
		if(D.mind.has_antag_datum(/datum/antagonist/changeling))
			to_chat(D, "<span class='warning'>Our monstrous form protects us from being put to sleep!</span>")
			return
		if(D.mind.has_antag_datum(/datum/antagonist/heretic))
			to_chat(D, "<span class='cultlarge'>The power of the Codex Cicatrix flares as we are swiftly put to sleep!</span>")
			D.apply_damage(15, A.get_attack_type())
			D.SetSleeping(50)
			return
		if(D.mind.has_antag_datum(/datum/antagonist/bloodsucker))
			to_chat(D, "<span class='warning'>Our undead form protects us from being put to sleep!</span>")
			return
		else
			D.SetSleeping(45)
		playsound(get_turf(A), 'sound/effects/snap.ogg', 50, TRUE, -1)
		log_combat(A, D, "neck snapped (Hunter-Fu)")
	return TRUE

/datum/martial_art/hunterfu/proc/HolyKick(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	if(!D.stat)
		D.visible_message("<span class='warning'>[A] kicks [D], splashing holy water in every direction!</span>", \
						"<span class='userdanger'>You're kicked by [A], with holy water dripping down on you!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", null, A)
		to_chat(A, "<span class='danger'>You holy kick [D]!</span>")
		if(D.mind.has_antag_datum(/datum/antagonist/heretic))
			to_chat(D, "<span class='cultlarge'>The holy water burns our flesh!</span>")
			D.apply_damage(25, BURN)
			D.adjustStaminaLoss(60)
			D.Paralyze(20)
			return
		if(D.mind.has_antag_datum(/datum/antagonist/bloodsucker))
			to_chat(D, "<span class='warning'>This just seems like regular water...</span>")
			return
		if(D.mind.has_antag_datum(/datum/antagonist/cult))
			for(var/datum/action/innate/cult/blood_magic/BD in D.actions)
				to_chat(D, "<span class='cultlarge'>Our blood rites falter as the holy water drips onto our body!</span>")
				for(var/datum/action/innate/cult/blood_spell/BS in BD.spells)
					qdel(BS)
			D.adjustStaminaLoss(60)
			D.Paralyze(20)
			return
		if(D.mind.has_antag_datum(/datum/antagonist/wizard) || (/datum/antagonist/wizard/apprentice))
			to_chat(D, "<span class='danger'>The holy water seems to be muting us somehow!</span>")
			var/mob/living/carbon/human/C = D // I guess monkey wizards aren't getting affected.
			if(C.silent <= 10)
				C.silent = clamp(C.silent + 10, 0, 10)
			D.adjustStaminaLoss(60)
			D.Paralyze(20)
			return
		else
			D.adjustStaminaLoss(60)
			D.Paralyze(20)
		playsound(get_turf(A), 'sound/weapons/slash.ogg', 50, TRUE, -1)
		log_combat(A, D, "holy kicked (Hunter-Fu)")
	return TRUE

/datum/martial_art/hunterfu/disarm_act(mob/living/A, mob/living/D)
	add_to_streak("D",D)
	log_combat(A, D, "disarmed (Hunter-Fu)")
	if(check_streak(A,D))
		return TRUE
	else
		return FALSE

/datum/martial_art/hunterfu/harm_act(mob/living/A, mob/living/D)
	if(!can_use(A))
		return FALSE
	add_to_streak("H",D)
	log_combat(A, D, "attacked (Hunter-Fu)")
	if(check_streak(A,D))
		return TRUE
	else
		return FALSE

/datum/martial_art/hunterfu/grab_act(mob/living/A, mob/living/D)
	if(A!=D && can_use(A)) // A!=D prevents grabbing yourself
		add_to_streak("G",D)
		if(check_streak(A,D)) // If a combo is made no grab upgrade is done
			return TRUE
		old_grab_state = A.grab_state
		D.grabbedby(A, 1)
		if(old_grab_state == GRAB_PASSIVE)
			D.drop_all_held_items()
			A.setGrabState(GRAB_AGGRESSIVE) // Instant agressive grab
			log_combat(A, D, "grabbed", addition="aggressively")
			D.visible_message("<span class='warning'>[A] violently grabs [D]!</span>", \
							"<span class='userdanger'>You're grabbed violently by [A]!</span>", "<span class='hear'>You hear sounds of aggressive fondling!</span>", COMBAT_MESSAGE_RANGE, A)
			to_chat(A, "<span class='danger'>You violently grab [D]!</span>")
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
	to_chat(usr, "<span class='notice'>Stake Stab</span>: Harm Harm. Stabs opponent with your bare fist, as strong as a Stake.")
	to_chat(usr, "<span class='notice'>Neck Snap</span>: Grab Disarm. Snaps an opponents neck, knocking them out.")
	to_chat(usr, "<span class='notice'>Holy Kick</span>: Disarm Grab. Splashes the user with Holy Water, removing Cult Spells, while dealing stamina damage.")

	to_chat(usr, "<b><i>In addition, by having your throw mode on, you take a defensive position, allowing you to block and sometimes even counter attacks done to you.</i></b>")
