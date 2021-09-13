/obj/item/gun/ballistic/revolver/joel
	icon = 'fulp_modules/features/lisa/icons/joel.dmi'
	load_sound = 'fulp_modules/features/lisa/sounds/gunload.ogg'
	eject_sound = 'fulp_modules/features/lisa/sounds/empty.ogg'
	icon_state = "revolver"
	name = "\improper Bolt Action pistol"
	desc = "The most powerful handgun in Olathe. It's best not to waste the only bullet."
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/c22
	custom_premium_price = PAYCHECK_HARD * 1.75
	var/used_ability = FALSE

/obj/item/gun/ballistic/revolver/joel/proc/clear_cooldown()
	if(used_ability)
		used_ability = FALSE

/obj/item/gun/ballistic/revolver/joel/proc/velvet_check(mob/living/target)
	if(target.mind && istype(target.mind.martial_art, /datum/martial_art/velvetfu))
		return TRUE
	return FALSE

/obj/item/gun/ballistic/revolver/joel/attackby(obj/item/A, mob/user, params)
	if(!istype(A, /obj/item/ammo_casing/c22))
		return
	if(get_ammo(countchambered = TRUE) >= 1)
		to_chat(user, span_warning("[src] already has a bullet loaded!"))
		return
	// Load It In
	user.visible_message(
		span_danger("[user.name] puts the bullet in [src]!"),
		span_userdanger("You put the bullet in [src]!"),
		span_hear("You hear metal clanking..."),
		COMBAT_MESSAGE_RANGE,
	)
	. = ..()
	clear_cooldown()
	A.update_appearance()

/obj/item/gun/ballistic/revolver/joel/attack_self(mob/living/carbon/user)
	if(used_ability)
		..()
		return
	// If you have a holster, you'll spin it instead, you're experienced.
	if(HAS_TRAIT(user, TRAIT_GUNFLIP))
		user.visible_message(
			span_danger("[user.name] spins [src] around like mad!"),
			span_userdanger("You spin [src] around!"),
			span_hear("You hear metal clanking..."),
			COMBAT_MESSAGE_RANGE,
		)
		for(var/mob/living/L in viewers(7, user))
			L.face_atom(user)
			L.do_alert_animation()
		playsound(src, 'fulp_modules/features/lisa/sounds/gunreveal.ogg', 20, FALSE, -5)
		user.adjustStaminaLoss(-10)
	// Otherwise, we'll perform Gun Toss.
	else
		user.visible_message(
			span_danger("[user.name] throws [src] around!"),
			span_userdanger("You toss [src] around!"),
			span_hear("You hear metal clanking..."),
			COMBAT_MESSAGE_RANGE,
		)
		for(var/mob/living/L in viewers(7, user))
			L.face_atom(user)
			L.do_alert_animation()
		playsound(src, 'fulp_modules/features/lisa/sounds/guntoss.ogg', 50, FALSE, -5)
		user.adjustStaminaLoss(-10)
		user.drop_all_held_items()
	used_ability = TRUE
	addtimer(CALLBACK(src, .proc/clear_cooldown), 6 SECONDS)

/obj/item/gun/ballistic/revolver/joel/AltClick(mob/user)
	if(used_ability)
		..()
		return
	// Gun reveal (If you have a holster)
	if(HAS_TRAIT(user, TRAIT_GUNFLIP))
		user.visible_message(
			span_danger("[user.name] opens their holster and pulls out [src]!"),
			span_userdanger("You reveal [src] from your holster!"),
			span_hear("You hear metal clanking..."),
			COMBAT_MESSAGE_RANGE,
		)
		for(var/mob/living/carbon/human/L in viewers(7, user))
			if(prob(15) && !(L == user) && !(L.stat) && !velvet_check(L))
				to_chat(L, span_warning("Seeing [src] revealed in such a manner disgusts you!"))
				L.vomit(0, FALSE, FALSE, 3, TRUE, harm = FALSE)
		playsound(src, 'fulp_modules/features/lisa/sounds/gunreveal.ogg', 20, FALSE, -5)

	// No holster? Use mind games instead
	else
		user.visible_message(
			span_danger("[user.name] stares deeply around [user.p_them()]selves!"),
			span_userdanger("You stare directly into the souls of those around you."),
			span_hear("You hear metal clanking..."),
			COMBAT_MESSAGE_RANGE,
		)
		for(var/mob/living/H in viewers(1, user))
			if(prob(75) && !(H == user) && H.stat <= CONSCIOUS && !velvet_check(H))
				to_chat(H, span_warning("You feel terrifyingly spooked by [user.name]!"))
				var/throwtarget = get_edge_target_turf(user, get_dir(user, get_step_away(H, user)))
				H.throw_at(throwtarget, 3, 2)
	used_ability = TRUE
	addtimer(CALLBACK(src, .proc/clear_cooldown), 10 SECONDS)

/// Steady Aim
/obj/item/gun/ballistic/revolver/joel/attack_secondary(mob/living/victim, mob/living/user, params)
	if(used_ability)
		to_chat(user, span_warning("You have to wait before using an ability!"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(user == victim)
		to_chat(user,span_warning("You can't steady aim yourself!"))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	user.visible_message(
		span_danger("[user.name] holds [victim.name] at gunpoint!"),
		span_userdanger("You hold [victim.name] up at gunpoint!"),
		span_hear("You hear metal clanking..."),
		COMBAT_MESSAGE_RANGE,
	)
	playsound(loc, 'fulp_modules/features/lisa/sounds/steadyaim.ogg', 50, FALSE, -5)
	if(prob(50) && !velvet_check(victim))
		victim.Stun(rand(10, 20))
	used_ability = TRUE
	addtimer(CALLBACK(src, .proc/clear_cooldown), 8 SECONDS)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/// Prevents the gun from being fired.
/obj/item/gun/ballistic/revolver/joel/afterattack(atom/target, mob/living/user, flag, params)
	// Can pull the trigger if it's empty since we don't care
	if(!chambered)
		user.visible_message(span_danger("*click*"))
		playsound(loc, 'fulp_modules/features/lisa/sounds/gunclick.ogg', 50, FALSE, -5)
		return
	if(used_ability)
		to_chat(user, span_warning("You don't want to waste [src]'s only bullet!"))
		return
	if(!target)
		return
	// Misdirection (Scholar of the Wilbur Sin attack)
	user.visible_message(
		span_danger("[user.name] looks around themselves."),
		span_userdanger("You look for something to point [src] at."),
	)
	playsound(loc, 'fulp_modules/features/lisa/sounds/misdirect.ogg', 50, FALSE, -5)
	used_ability = TRUE
	addtimer(CALLBACK(src, .proc/clear_cooldown), 7 SECONDS)

	if(!do_after(user, 0.4 SECONDS, target = src, progress = FALSE))
		return

	user.setDir(turn(user.dir, 90))
	if(!do_after(user, 0.3 SECONDS, target = src, progress = FALSE))
		return

	user.setDir(turn(user.dir, -90))
	if(!do_after(user, 0.3 SECONDS, target = src, progress = FALSE))
		return

	user.setDir(turn(user.dir, 90))
	if(!do_after(user, 0.3 SECONDS, target = src, progress = FALSE))
		return

	user.setDir(turn(user.dir, -90))
	if(!do_after(user, 0.3 SECONDS, target = src, progress = FALSE))
		return

	user.emote("gasp")
	user.visible_message(
		span_danger("[user.name] quickly points their gun towards [target]!"),
		span_userdanger("You misdirect [src] towards [target]!"),
		span_hear("You hear a gasp..."),
	)
	// Everyone directly next to it will move
	for(var/mob/living/H in view(1, target))
		if(!(H == user) && H.stat <= CONSCIOUS && !velvet_check(H))
			H.visible_message(
				span_danger("You quickly jump towards [target]!"),
				span_userdanger("[H] quickly jumps towards [target]!"),
				span_hear("You hear aggressive shuffling!"),
				COMBAT_MESSAGE_RANGE,
			)
			H.forceMove(target)
	// Everoyne else will just notice it
	for(var/mob/living/L in viewers(5, target))
		L.face_atom(target)
		L.do_alert_animation()

/obj/item/gun/ballistic/revolver/joel/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	add_fingerprint(user)
	to_chat(user, "<span class='warning'>You don't want to waste [src]'s only bullet!</span>")
	return


/*
 *	# Cylinder, bullet & casing.
 *
 *	We're using unique ones so people cant get more bullets for anything, yada yada, whatever.
 *	Unique gun, unique single bullet. You lose it, it's gone.
 */

/// Cylinder
/obj/item/ammo_box/magazine/internal/cylinder/c22
	name = "\improper Bolt Action revolver cylinder"
	ammo_type = /obj/item/ammo_casing/c22
	caliber = CALIBER_C22
	max_ammo = 1
	multiload = FALSE

/// Bullet casing & Bullet
/obj/item/ammo_casing/c22
	name = "5.6mm bullet casing"
	desc = "An incredibly rare type of bullet."
	caliber = CALIBER_C22
	projectile_type = /obj/projectile/bullet/c22

/// This isnt meant to be fired, so do 0 damage.
/obj/projectile/bullet/c22
	name = "5.6mm bullet"
	damage = 0
