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
		to_chat(H, "<span class='userdanger'>You've mastered Velvet-Fu!</span>")
		recedingstance.Grant(H)
		twistedstance.Grant(H)

/datum/martial_art/velvetfu/on_remove(mob/living/H)
	to_chat(H, "<span class='userdanger'>You've forgotten Velvet-Fu...'</span>")
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
	icon_icon = 'fulp_modules/features/lisa/sprites/stances.dmi'
	button_icon_state = "receding_stance"
	var/stancing = FALSE

/datum/action/receding_stance/Trigger(mob/living/user = owner)
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't do stances while incapacitated...</span>")
		return
	if(stancing)
		to_chat(owner, "<span class='warning'>You're already stancing.</span>")
		return
	owner.visible_message("<span class='danger'>[owner] moves back and begins to form a stance.</span>", \
	"<b><i>You backpedal and begin to form your stance.</i></b>")
	stancing = TRUE
	if(do_after(owner, 3 SECONDS))
		owner.visible_message("<span class='danger'>[owner] focuses on his stance.</span>", \
		"<b><i>You focus on your stance. Stamina...</i></b>")
		owner.mind.martial_art.streak = RECEDING_STANCE
		user.adjustStaminaLoss(-40)
		stancing = FALSE
	else
		owner.visible_message("<span class='danger'>[owner] stops moving back.</i></b>")
		stancing = FALSE
		return

/// Twisted Stance
/datum/action/twisted_stance
	name = "Twisted Stance - Regenerates a lot of stamina, deals brute damage."
	icon_icon = 'fulp_modules/features/lisa/sprites/stances.dmi'
	button_icon_state = "twisted_stance"

/datum/action/twisted_stance/Trigger(mob/living/user = owner)
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't do stances while incapacitated...</span>")
		return
	if(owner.mind.martial_art.streak == TWISTED_STANCE)
		owner.visible_message("<span class='danger'>[owner] suddenly twists themselves even further!</span>", \
		"<b>You twist yourself even further!</b>")
		user.adjustStaminaLoss(-40)
		user.apply_damage(8, BRUTE, BODY_ZONE_CHEST, wound_bonus = CANT_WOUND)
		return
	owner.visible_message("<span class='danger'>[owner] suddenly twists and turns, what a strange stance!</span>", \
	"<b>You twist and turn, your twisted stance is done!</b>")
	owner.mind.martial_art.streak = TWISTED_STANCE
	user.adjustStaminaLoss(-40)
	user.apply_damage(18, BRUTE, BODY_ZONE_CHEST, wound_bonus = CANT_WOUND)
	addtimer(CALLBACK(src, .proc/untwist), 15 SECONDS)

/datum/action/twisted_stance/proc/untwist()
	owner.visible_message("<span class='danger'>[owner] suddenly untwists in pain.</span>", \
	"<b>You untwist yourself in pain!</b>")
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
	D.visible_message("<span class='danger'>[A] flying kicks [D], such skill!</span>", \
					"<span class='userdanger'>Your neck is flying kicked by [A]!</span>", \
					"<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You flying kick [D]!</span>")
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
	D.visible_message("<span class='danger'>[A] headbutts [D]!</span>", \
					"<span class='userdanger'>You're headbutted by [A]!</span>", \
					"<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You swiftly headbutt [D]!</span>")
	A.apply_damage(18, BRUTE, BODY_ZONE_HEAD, wound_bonus = CANT_WOUND)
	A.adjustStaminaLoss(20)
	if(prob(60) && !D.stat)
		D.Paralyze(3 SECONDS)
		D.Jitter(5 SECONDS)
	/// Tell them in big text that they failed, since the effects aren't instantly visible like the others.
	else
		to_chat(A, "<span class='userdanger'>You fail to stun [D]!</span>")
	D.apply_damage(10, A.get_attack_type(), BODY_ZONE_CHEST, wound_bonus = CANT_WOUND)
	playsound(get_turf(A), 'sound/effects/hit_punch.ogg', 50, TRUE, -1)
	return TRUE

/// Full Thrust
/datum/martial_art/velvetfu/proc/fullThrust(mob/living/A, mob/living/D)
	log_combat(A, D, "full thrust (Velvet-Fu)")
	D.visible_message("<span class='danger'>[A] thrusts into [D]!</span>", \
					"<span class='userdanger'>You're thrusted by [A]!</span>", \
					"<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You quickly and fashionably thrust into [D]!</span>")
	A.adjustStaminaLoss(60)
	if(prob(70) && !D.stat)
		D.Knockdown(4 SECONDS)
	D.apply_damage(10, A.get_attack_type(), BODY_ZONE_CHEST, wound_bonus = CANT_WOUND)
	playsound(get_turf(A), 'sound/weapons/cqchit1.ogg', 50, TRUE, -1)
	return TRUE

/// Minor Iris
/datum/martial_art/velvetfu/proc/minorIris(mob/living/A, mob/living/D)
	log_combat(A, D, "minor iris (Velvet-Fu)")
	D.visible_message("<span class='danger'>[A] slashes [D] rapidly and repeatedly!</span>", \
					"<span class='userdanger'>You're slashed several times by [A]!</span>", \
					"<span class='hear'>You hear several sickening sounds of flesh slashing flesh!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You swiftly and repeatedly slash at [D], truly a master attack!</span>")
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
	D.visible_message("<span class='danger'>[A] [picked_hit_type]ed [D]!</span>", \
					"<span class='userdanger'>You're [picked_hit_type]ed by [A]!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You [picked_hit_type] [D]!</span>")
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
	D.visible_message("<span class='danger'>[A] [picked_hit_type]ed [D]!</span>", \
					"<span class='userdanger'>You're [picked_hit_type]ed by [A]!</span>", \
					"<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You [picked_hit_type] [D]!</span>")
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
	D.visible_message("<span class='danger'>[A] silken wrists [D]!</span>", \
					"<span class='userdanger'>You're silken wristed by [A]!</span>", \
					"<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, A)
	to_chat(A, "<span class='danger'>You silken wrist [D]!</span>")
	playsound(D, 'sound/weapons/punch1.ogg', 50, TRUE, -1)
	return TRUE


/*
 *	# Help, Granters & Uplink Items
 *
 *	We are giving this item to Janitors since Alex is a trashman.
 *	This is cheap, compared to other martial arts, but then again the martial art is a cheap knockoff.
 *	The granter itself is a VHS tape, like the one Alex learns Velvet-Fu from.
 */

/mob/living/proc/velvetfu_help()
	set name = "Recall Teachings"
	set desc = "Remember the martial techniques of Velvet-Fu."
	set category = "VelvetFu"

	to_chat(usr, "<b><i>You try to remember the VHS tapes of Velvet-Fu...</i></b>\n\
	<span class='notice'>Iron Hoof</span>: Disarm/Grab/Harm while opponent is down, though Disarm works best.\n\
	<span class='notice'>Flying Axe Kick</span>: Harm Disarm. Deals damage and causes bleeding. Costs 50 Stamina.\n\
	<span class='notice'>Goat Headbutt</span>: Disarm Grab. Deals brute while stunning your opponent. Costs 20 Stamina and 18 Brute.\n\
	<span class='notice'>Full Thrust</span>: Grab Harm. Deals brute and has a chance to knock your opponent down. Costs 60 Stamina.\n\
	<span class='notice'>Minor Iris</span>: Harm Harm Harm. Devastatingly slashes your opponent. Costs 80 Stamina.\n\
	<span class='notice'>Receding Stance</span>: Regenerates 40 Stamina. Requires standing still.\n\
	<span class='notice'>Twisted Stance</span>: Regenerates 40 Stamina. Deals brute damage.</span>")

/obj/item/book/granter/martial/velvetfu
	martial = /datum/martial_art/velvetfu
	name = "Hollywood VHS tape"
	martialname = "velvet-fu"
	desc = "A VHS tape labelled 'Grand-Master's Course'. This seems modified, causing it to beam the content straight into your eyes."
	icon = 'fulp_modules/features/lisa/sprites/casette.dmi'
	icon_state = "velvet"
	greet = "You've finished watching the Velvet-Fu VHS tape."
	remarks = list("Smooth as Velvet...", "Show me your stance!", "Left Jab!", "Right Jab!", "Kick, kick!", "Ah, so fast...", "Now forget the basics!", "...But remember the style!")

/obj/item/book/granter/martial/velvetfu/onlearned(mob/living/carbon/user)
	..()
	if(oneuse == TRUE)
		desc = "A VHS tape labelled 'Grand-Master's Course'. The film seems ripped out, and can't be put back in."
		name = "Broken VHS tape"
		icon_state = "velvet_used"

/datum/uplink_item/stealthy_weapons/velvetfu
	name = "Velvet-Fu VHS tape"
	desc = "Velvet-Fu is a knock-off Martial Art straight from Hollywood. \
			Has a notice, 'Removes your ability to Grab and Disarm'. \
			Now specially modified to beam its knowledge directly into your eyes, removing the need for a TV."
	item = /obj/item/book/granter/martial/velvetfu
	cost = 8
	surplus = 0
	restricted_roles = list("Janitor")
