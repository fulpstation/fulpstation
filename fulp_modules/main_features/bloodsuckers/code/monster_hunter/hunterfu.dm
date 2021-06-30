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
	if(D.body_position == STANDING_UP)
		D.visible_message(span_danger("[A] slams both them and [D] into the ground!"), \
						span_userdanger("You're slammed into the ground by [A]!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), null, A)
		to_chat(A, span_danger("You slam [D] into the ground!"))
		playsound(get_turf(A), 'sound/weapons/slam.ogg', 50, TRUE, -1)
		log_combat(A, D, "bodyslammed (Hunter-Fu)")
		if(!D.mind)
			D.Paralyze(40)
			A.Paralyze(25)
			return TRUE
		if(D.mind.has_antag_datum(/datum/antagonist/changeling))
			to_chat(D, span_cultlarge("Our DNA shakes as we are body slammed!"))
			D.apply_damage(15, A.get_attack_type())
			D.Paralyze(60)
			A.Paralyze(25)
			return TRUE
		else
			D.Paralyze(40)
			A.Paralyze(25)
	else
		harm_act(A, D)
	return TRUE

/datum/martial_art/hunterfu/proc/StakeStab(mob/living/A, mob/living/D)
	D.visible_message(span_danger("[A] stabs [D] in the heart!"), \
					span_userdanger("You're staked in the heart by [A]!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, A)
	to_chat(A, span_danger("You stab [D] viciously!"))
	playsound(get_turf(A), 'sound/weapons/bladeslice.ogg', 50, TRUE, -1)
	log_combat(A, D, "stakestabbed (Hunter-Fu)")
	if(!D.mind)
		D.apply_damage(15, A.get_attack_type())
		return TRUE
	if(D.mind.has_antag_datum(/datum/antagonist/changeling))
		to_chat(D, span_danger("Their arm tears through our monstrous form!"))
		D.apply_damage(25, A.get_attack_type())
		return TRUE
	if(D.mind.has_antag_datum(/datum/antagonist/bloodsucker))
		to_chat(D, span_cultlarge("Their arm stakes straight into our undead flesh!"))
		D.apply_damage(20, BURN)
		D.apply_damage(10, A.get_attack_type())
		return TRUE
	else
		D.apply_damage(15, A.get_attack_type())
	return TRUE

/datum/martial_art/hunterfu/proc/NeckSnap(mob/living/A, mob/living/D)
	if(!D.stat)
		D.visible_message(span_danger("[A] snapped [D]'s neck!"), \
						span_userdanger("Your neck is snapped by [A]!"), span_hear("You hear a snap!"), COMBAT_MESSAGE_RANGE, A)
		to_chat(A, span_danger("You snap [D]'s neck!"))
		playsound(get_turf(A), 'sound/effects/snap.ogg', 50, TRUE, -1)
		log_combat(A, D, "neck snapped (Hunter-Fu)")
		if(!D.mind)
			D.SetSleeping(45)
			playsound(get_turf(A), 'sound/effects/snap.ogg', 50, TRUE, -1)
			log_combat(A, D, "neck snapped (Hunter-Fu)")
			return TRUE
		if(D.mind.has_antag_datum(/datum/antagonist/changeling))
			to_chat(D, span_warning("Our monstrous form protects us from being put to sleep!"))
			return TRUE
		if(D.mind.has_antag_datum(/datum/antagonist/heretic))
			to_chat(D, span_cultlarge("The power of the Codex Cicatrix flares as we are swiftly put to sleep!"))
			D.apply_damage(15, A.get_attack_type())
			D.SetSleeping(50)
			return TRUE
		if(D.mind.has_antag_datum(/datum/antagonist/bloodsucker))
			to_chat(D, span_warning("Our undead form protects us from being put to sleep!"))
			return TRUE
		else
			D.SetSleeping(45)
	return TRUE

/datum/martial_art/hunterfu/proc/HolyKick(mob/living/A, mob/living/D)
	D.visible_message(span_warning("[A] kicks [D], splashing holy water in every direction!"), \
					span_userdanger("You're kicked by [A], with holy water dripping down on you!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), null, A)
	to_chat(A, span_danger("You holy kick [D]!"))
	playsound(get_turf(A), 'sound/weapons/slash.ogg', 50, TRUE, -1)
	log_combat(A, D, "holy kicked (Hunter-Fu)")
	if(!D.mind)
		D.adjustStaminaLoss(60)
		D.Paralyze(20)
		return TRUE
	if(D.mind.has_antag_datum(/datum/antagonist/heretic))
		to_chat(D, span_cultlarge("The holy water burns our flesh!"))
		D.apply_damage(25, BURN)
		D.adjustStaminaLoss(60)
		D.Paralyze(20)
		return TRUE
	if(D.mind.has_antag_datum(/datum/antagonist/bloodsucker))
		var/datum/antagonist/bloodsucker/bloodsuckerdatum = IS_BLOODSUCKER(D)
		if(bloodsuckerdatum.my_clan == CLAN_TREMERE)
			to_chat(D, span_cultlarge("The holy water burns our flesh!"))
			D.apply_damage(25, BURN)
			D.adjustStaminaLoss(60)
			D.Paralyze(20)
			return TRUE
		else
			to_chat(D, span_warning("This just seems like regular water..."))
			return TRUE
	if(D.mind.has_antag_datum(/datum/antagonist/cult))
		for(var/datum/action/innate/cult/blood_magic/BD in D.actions)
			to_chat(D, span_cultlarge("Our blood rites falter as the holy water drips onto our body!"))
			for(var/datum/action/innate/cult/blood_spell/BS in BD.spells)
				qdel(BS)
		D.adjustStaminaLoss(60)
		D.Paralyze(20)
		return TRUE
	if(D.mind.has_antag_datum(/datum/antagonist/wizard) || (/datum/antagonist/wizard/apprentice))
		to_chat(D, span_danger("The holy water seems to be muting us somehow!"))
		var/mob/living/carbon/human/C = D // I guess monkey wizards aren't getting affected.
		if(C.silent <= 10)
			C.silent = clamp(C.silent + 10, 0, 10)
		D.adjustStaminaLoss(60)
		D.Paralyze(20)
		return TRUE
	else
		D.adjustStaminaLoss(60)
		D.Paralyze(20)
	return TRUE

/// Intents
/datum/martial_art/hunterfu/disarm_act(mob/living/A, mob/living/D)
	add_to_streak("D",D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "disarmed (Hunter-Fu)")
	return ..()

/datum/martial_art/hunterfu/harm_act(mob/living/A, mob/living/D)
	add_to_streak("H",D)
	if(check_streak(A,D))
		return TRUE
	var/obj/item/bodypart/affecting = D.get_bodypart(ran_zone(A.zone_selected))
	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
	var/atk_verb = pick("kick", "chop", "hit", "slam")
	D.visible_message(span_danger("[A] [atk_verb]s [D]!"), \
					span_userdanger("[A] [atk_verb]s you!"), null, null, A)
	to_chat(A, span_danger("You [atk_verb] [D]!"))
	D.apply_damage(rand(10,15), BRUTE, affecting, wound_bonus = CANT_WOUND)
	playsound(get_turf(D), 'sound/weapons/punch1.ogg', 25, TRUE, -1)
	log_combat(A, D, "harmed (Hunter-Fu)")
	return TRUE

/datum/martial_art/hunterfu/grab_act(mob/living/A, mob/living/D)
	if(A!=D && can_use(A))
		add_to_streak("G",D)
		if(check_streak(A,D)) // If a combo is made no grab upgrade is done
			return TRUE
		old_grab_state = A.grab_state
		D.grabbedby(A, 1)
		if(old_grab_state == GRAB_PASSIVE)
			D.drop_all_held_items()
			A.setGrabState(GRAB_AGGRESSIVE) // Instant agressive grab
			log_combat(A, D, "grabbed (Hunter-Fu)")
			D.visible_message(span_warning("[A] violently grabs [D]!"), \
							span_userdanger("You're grabbed violently by [A]!"), span_hear("You hear sounds of aggressive fondling!"), COMBAT_MESSAGE_RANGE, A)
			to_chat(A, span_danger("You violently grab [D]!"))
		return TRUE
	..()

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
