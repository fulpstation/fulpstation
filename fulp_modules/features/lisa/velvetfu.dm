#define RECEDING_STANCE "receding stance"
#define TWISTED_STANCE "twisted stance"
#define FLYING_AXEKICK_COMBO "HD"
#define GOAT_HEADBUTT_COMBO "DG"
#define FULL_THRUST_COMBO "GH"
#define MINOR_IRIS_COMBO "HHH"

/datum/martial_art/velvetfu
	name = "Velvet-Fu"
	id = MARTIALART_VELVETFU
	help_verb = /mob/living/proc/velvetfu_help
	display_combos = TRUE
	allow_temp_override = FALSE
	var/datum/action/receding_stance/recedingstance = new/datum/action/receding_stance()
	var/datum/action/twisted_stance/twistedstance = new/datum/action/twisted_stance()

/datum/martial_art/velvetfu/teach(mob/living/H, make_temporary = FALSE)
	if(..())
		to_chat(H, span_userdanger("You've mastered Velvet-Fu!"))
		recedingstance.Grant(H)
		twistedstance.Grant(H)

/datum/martial_art/velvetfu/on_remove(mob/living/H)
	to_chat(H, span_userdanger("You've forgotten Velvet-Fu..."))
	recedingstance.Remove(H)
	twistedstance.Remove(H)

/datum/martial_art/velvetfu/proc/check_streak(mob/living/A, mob/living/D)
	if(findtext(streak, FLYING_AXEKICK_COMBO))
		streak = ""
		flyingAxekick(A,D)
		return TRUE
	if(findtext(streak, GOAT_HEADBUTT_COMBO))
		streak = ""
		goatHeadbutt(A,D)
		return TRUE
	if(findtext(streak, FULL_THRUST_COMBO))
		streak = ""
		fullThrust(A,D)
		return TRUE
	if(findtext(streak, MINOR_IRIS_COMBO))
		streak = ""
		minorIris(A,D)
	return FALSE


/*
 *	# Stances:
 *
 *	Stances are the main way to regain SP. There are other, non martial-art ways, but we shouldn't punish people for stacking these.
 *	Receding will require standing still, while Twisted will deal Brute damage to the user.
 *	While twisted, further twisting will allow you to recover stamina at a cheaper cost. This is cancelled by either using Receding, or a combo.
 *	Overall, on its own, these can be quite balanced.
 */

/// Receding Stance
/datum/action/receding_stance
	name = "Receding Stance - Regenerates Stamina, takes time to do."
	icon_icon = 'fulp_modules/features/lisa/icons/stances.dmi'
	button_icon_state = "receding_stance"
	var/stancing = FALSE

/datum/action/receding_stance/Trigger(mob/living/user = owner)
	if(owner.incapacitated())
		to_chat(owner, span_warning("You can't do stances while incapacitated..."))
		return
	if(stancing)
		to_chat(owner, span_warning("You're already stancing."))
		return
	owner.visible_message(
		span_danger("[owner] moves back and begins to form a stance."),
		span_userdanger("<b><i>You backpedal and begin to form your stance.</i></b>"),
	)
	stancing = TRUE
	if(do_after(owner, 3 SECONDS))
		owner.visible_message(
			span_danger("[owner] focuses on his stance."),
			span_userdanger("You focus on your stance. Stamina..."),
		)
		owner.mind.martial_art.streak = RECEDING_STANCE
		user.adjustStaminaLoss(-40)
		stancing = FALSE
	else
		owner.visible_message(span_danger("[owner] stops moving back.</i></b>"))
		stancing = FALSE
		return

/// Twisted Stance
/datum/action/twisted_stance
	name = "Twisted Stance - Regenerates a lot of stamina, deals brute damage."
	icon_icon = 'fulp_modules/features/lisa/icons/stances.dmi'
	button_icon_state = "twisted_stance"

/datum/action/twisted_stance/Trigger(mob/living/user = owner)
	if(owner.incapacitated())
		to_chat(owner, span_warning("You can't do stances while incapacitated..."))
		return
	if(owner.mind.martial_art.streak == TWISTED_STANCE)
		owner.visible_message(
			span_danger("[owner] suddenly twists themselves even further!"),
			span_userdanger("You twist yourself even further!"),
		)
		user.adjustStaminaLoss(-40)
		user.apply_damage(8, BRUTE, BODY_ZONE_CHEST, wound_bonus = CANT_WOUND)
		return
	owner.visible_message(
		span_danger("[owner] suddenly twists and turns, what a strange stance!"),
		span_userdanger("You twist and turn, your twisted stance is done!"),
	)
	owner.mind.martial_art.streak = TWISTED_STANCE
	user.adjustStaminaLoss(-40)
	user.apply_damage(18, BRUTE, BODY_ZONE_CHEST, wound_bonus = CANT_WOUND)
	addtimer(CALLBACK(src, .proc/untwist), 15 SECONDS)

/datum/action/twisted_stance/proc/untwist()
	owner.visible_message(
		span_danger("[owner] suddenly untwists in pain."),
		span_userdanger("You untwist yourself in pain!"),
	)
	if(owner.mind.martial_art.streak == TWISTED_STANCE)
		owner.mind.martial_art.streak = ""


/*
 *	# Moves:
 *
 *	Flying Axe Kick - Deals Brute and causes bleeding.
 *	Goat Headbutt - Deals Brute and stuns, in exchange for causing Brute to the user.
 *	Full Thrust - Deals Brute and has a chance to knock the opponent down.
 *	Minor Iris - Deals a ton of armor penetrating slash brute. The only attack that has a 100% guarantee to have all its effects.
 */

/// Flying Axe Kick
/datum/martial_art/velvetfu/proc/flyingAxekick(mob/living/A, mob/living/D)
	log_combat(A, D, "flying kick (Velvet-Fu)")
	D.visible_message(
		span_danger("[A] flying kicks [D], such skill!"),
		span_userdanger("Your neck is flying kicked by [A]!"),
		span_hear("You hear a sickening sound of flesh hitting flesh!"),
		COMBAT_MESSAGE_RANGE, A,
	)
	to_chat(A, span_danger("You flying kick [D]!"))
	A.adjustStaminaLoss(50)
	if(prob(70))
		var/obj/item/bodypart/limb = D.get_bodypart(ran_zone(A.zone_selected))
		var/datum/wound/slash/moderate/crit_wound = new
		crit_wound.apply_wound(limb)
	D.apply_damage(15, A.get_attack_type(), wound_bonus = CANT_WOUND)
	playsound(get_turf(A), 'sound/weapons/slice.ogg', 50, TRUE, -1)
	return TRUE

/// Goat Headbutt
/datum/martial_art/velvetfu/proc/goatHeadbutt(mob/living/A, mob/living/D)
	log_combat(A, D, "goat headbutt (Velvet-Fu)")
	D.visible_message(
		span_danger("[A] headbutts [D]!"),
		span_userdanger("You're headbutted by [A]!"),
		span_hear("You hear a sickening sound of flesh hitting flesh!"),
		COMBAT_MESSAGE_RANGE, A,
	)
	to_chat(A, span_danger("You swiftly headbutt [D]!"))
	A.apply_damage(18, BRUTE, BODY_ZONE_HEAD, wound_bonus = CANT_WOUND)
	A.adjustStaminaLoss(20)
	if(prob(60) && !D.stat)
		D.Paralyze(3 SECONDS)
		D.Jitter(5 SECONDS)
	/// Tell them in big text that they failed, since the effects aren't instantly visible like the others.
	else
		to_chat(A, span_userdanger("You fail to stun [D]!"))
	D.apply_damage(10, A.get_attack_type(), BODY_ZONE_CHEST, wound_bonus = CANT_WOUND)
	playsound(get_turf(A), 'sound/effects/hit_punch.ogg', 50, TRUE, -1)
	return TRUE

/// Full Thrust
/datum/martial_art/velvetfu/proc/fullThrust(mob/living/A, mob/living/D)
	log_combat(A, D, "full thrust (Velvet-Fu)")
	D.visible_message(
		span_danger("[A] thrusts into [D]!)"),
		span_userdanger("You're thrusted by [A]!"),
		span_hear("You hear a sickening sound of flesh hitting flesh!"),
		COMBAT_MESSAGE_RANGE, A,
	)
	to_chat(A, span_danger("You quickly and fashionably thrust into [D]!"))
	A.adjustStaminaLoss(60)
	if(prob(70) && !D.stat)
		D.Knockdown(4 SECONDS)
	D.apply_damage(10, A.get_attack_type(), BODY_ZONE_CHEST, wound_bonus = CANT_WOUND)
	playsound(get_turf(A), 'sound/weapons/cqchit1.ogg', 50, TRUE, -1)
	return TRUE

/// Minor Iris
/datum/martial_art/velvetfu/proc/minorIris(mob/living/A, mob/living/D)
	log_combat(A, D, "minor iris (Velvet-Fu)")
	D.visible_message(
		span_danger("[A] slashes [D] rapidly and repeatedly!"),
		span_userdanger("You're slashed several times by [A]!"),
		span_hear("You hear several sickening sounds of flesh slashing flesh!"),
		COMBAT_MESSAGE_RANGE, A,
	)
	to_chat(A, span_danger("You swiftly and repeatedly slash at [D], truly a master attack!"))
	A.adjustStaminaLoss(80)
	var/obj/item/bodypart/limb = D.get_bodypart(ran_zone(A.zone_selected))
	var/datum/wound/slash/moderate/crit_wound = new
	crit_wound.apply_wound(limb)
	D.apply_damage(30, A.get_attack_type(), wound_bonus = CANT_WOUND)
	playsound(get_turf(A), 'sound/weapons/bladeslice.ogg', 50, TRUE, -1)
	return TRUE


/*
 *	# Intents:
 *
 *	Intents are meant to be what the Combo Dial is in Lisa the Pointless
 *	Grabbing and Disarming both aren't possible. These are replaced with different versions of Harm.
 */

/datum/martial_art/velvetfu/disarm_act(mob/living/A, mob/living/D)
	if(HAS_TRAIT(A, TRAIT_PACIFISM))
		return FALSE
	var/datum/dna/dna = A.has_dna()
	if(dna?.check_mutation(HULK))
		return FALSE
	add_to_streak("D",D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "disarmed (Velvet-Fu)")
	A.do_attack_animation(D)
	var/picked_hit_type = "side kick"
	var/bonus_damage = 10 // Kicking deals more damage
	if(D.body_position == LYING_DOWN)
		bonus_damage += 8
		picked_hit_type = "iron hoov"
	D.apply_damage(bonus_damage, A.get_attack_type())
	D.visible_message(
		span_danger("[A] [picked_hit_type]ed [D]!"),
		span_userdanger("You're [picked_hit_type]ed by [A]!"),
		span_hear("You hear a sickening sound of flesh hitting flesh!"),
		COMBAT_MESSAGE_RANGE, A,
	)
	to_chat(A, span_danger("You [picked_hit_type] [D]!"))
	playsound(D, 'sound/weapons/punch1.ogg', 50, TRUE, -1)
	return TRUE

/datum/martial_art/velvetfu/grab_act(mob/living/A, mob/living/D)
	if(HAS_TRAIT(A, TRAIT_PACIFISM))
		return FALSE
	var/datum/dna/dna = A.has_dna()
	if(dna?.check_mutation(HULK))
		return FALSE
	add_to_streak("G",D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "grabbed (Velvet-Fu)")
	A.do_attack_animation(D)
	var/picked_hit_type = pick("ascending claw", "descending claw")
	D.apply_damage(10, A.get_attack_type())
	D.visible_message(
		span_danger("[A] [picked_hit_type]ed [D]!"),
		span_userdanger("You're [picked_hit_type]ed by [A]!"),
		span_hear("You hear a sickening sound of flesh hitting flesh!"),
		COMBAT_MESSAGE_RANGE, A,
	)
	to_chat(A, span_danger("You [picked_hit_type] [D]!"))
	playsound(D, 'sound/weapons/punch1.ogg', 50, TRUE, -1)
	return TRUE

/datum/martial_art/velvetfu/harm_act(mob/living/A, mob/living/D)
	var/datum/dna/dna = A.has_dna()
	if(dna?.check_mutation(HULK))
		return FALSE
	add_to_streak("H",D)
	if(check_streak(A,D))
		return TRUE
	log_combat(A, D, "harmed (Velvet-Fu)")
	A.do_attack_animation(D)
	D.apply_damage(10, A.get_attack_type())
	D.visible_message(
		span_danger("[A] silken wrists [D]!"),
		span_userdanger("You're silken wristed by [A]!"),
		span_hear("You hear a sickening sound of flesh hitting flesh!"),
		COMBAT_MESSAGE_RANGE, A,
	)
	to_chat(A, span_danger("You silken wrist [D]!"))
	playsound(D, 'sound/weapons/punch1.ogg', 50, TRUE, -1)
	return TRUE

/mob/living/proc/velvetfu_help()
	set name = "Recall Teachings"
	set desc = "Remember the martial techniques of Velvet-Fu."
	set category = "VelvetFu"

	to_chat(usr, span_notice("<b><i>You try to remember the VHS tapes of Velvet-Fu...</i></b>\n\
	Iron Hoof: Disarm/Grab/Harm while opponent is down, though Disarm works best.\n\
	Flying Axe Kick: Harm Disarm. Deals damage and causes bleeding. Costs 50 Stamina.\n\
	Goat Headbutt: Disarm Grab. Deals brute while stunning your opponent. Costs 20 Stamina and 18 Brute.\n\
	Full Thrust: Grab Harm. Deals brute and has a chance to knock your opponent down. Costs 60 Stamina.\n\
	Minor Iris: Harm Harm Harm. Devastatingly slashes your opponent. Costs 80 Stamina.\n\
	Receding Stance: Regenerates 40 Stamina. Requires standing still.\n\
	Twisted Stance: Regenerates 40 Stamina. Deals brute damage."))

#undef RECEDING_STANCE
#undef TWISTED_STANCE
#undef FLYING_AXEKICK_COMBO
#undef GOAT_HEADBUTT_COMBO
#undef FULL_THRUST_COMBO
#undef MINOR_IRIS_COMBO
