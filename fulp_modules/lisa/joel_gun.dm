/obj/item/gun/ballistic/revolver/joel
	icon = 'icons/obj/guns/ballistic.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi' /// We probably don't want to change these...
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	load_sound = 'fulp_modules/lisa/Sounds/gunload.ogg'
	eject_sound = 'fulp_modules/lisa/Sounds/empty.ogg'
	icon_state = "revolver"
	name = "\improper Bolt Action pistol"
	desc = "The most powerful handgun in Olathe. It's best not to waste the only bullet."
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/c22
	custom_price = PAYCHECK_EASY
	var/used_ability = FALSE

/// To prevent ability spam.
/obj/item/gun/ballistic/revolver/joel/proc/clear_cooldown()
	if(used_ability)
		used_ability = FALSE

/// Load It In
/obj/item/gun/ballistic/revolver/joel/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(!istype(A, /obj/item/ammo_casing/c22))
		return
	if(get_ammo() > 0)
		to_chat(user, "<span class='warning'>[src] already has a bullet loaded!</span>")
		return
	user.visible_message("<span class='danger'>[user.name] puts the bullet in [src]!</span>",\
	 "<span class='userdanger'>You put the bullet in [src]!</span>",\
	 "<span class='hear'>You hear metal clanking...</span>")
	clear_cooldown() /// Instantly give their ability back.
	update_appearance()
	A.update_appearance()
	return

/// Gun Reveal + Gun Toss
/obj/item/gun/ballistic/revolver/joel/attack_self(mob/user)
	if(!used_ability)
		if(HAS_TRAIT(user, TRAIT_GUNFLIP)) /// If you have a holster, use gun reveal.
			user.visible_message("<span class='danger'>[user.name] opens their holster and pulls out [src]!</span>",\
			 "<span class='userdanger'>You reveal [src] from your holster!</span>",\
			 "<span class='hear'>You hear metal clanking...</span>")
			for(var/mob/living/carbon/human/L in viewers(7, user))
				if(prob(15) && !(L == user) && !(L.stat))
					to_chat(L, "<span class='warning'>Seeing [src] revealed in such a manner disgusts you!</span>")
					if(!L.mind || !istype(L.mind.martial_art, /datum/martial_art/velvetfu))
						L.vomit(0, FALSE, FALSE, 3, TRUE, harm = FALSE)
			playsound(src, 'fulp_modules/lisa/Sounds/gunreveal.ogg', 20, FALSE, -5)
			used_ability = TRUE
			addtimer(CALLBACK(src, .proc/clear_cooldown), 5 SECONDS)
			return
		else /// Otherwise, use Gun Toss.
			user.visible_message("<span class='danger'>[user.name] throws [src] around!</span>",\
			 "<span class='userdanger'>You toss [src] around!</span>",\
			 "<span class='hear'>You hear metal clanking...</span>")
			for(var/mob/living/L in viewers(7, user))
				L.face_atom(user)
				L.do_alert_animation()
			playsound(src, 'fulp_modules/lisa/Sounds/guntoss.ogg', 50, FALSE, -5)
			var/mob/living/carbon/C = user
			used_ability = TRUE
			addtimer(CALLBACK(src, .proc/clear_cooldown), 3 SECONDS)
			C.adjustStaminaLoss(-10)
			C.drop_all_held_items()
			return
	..()

/// Steady Aim
/obj/item/gun/ballistic/revolver/joel/attack_secondary(mob/living/victim, mob/living/user, params)
	if(used_ability)
		to_chat(user, "<span class='warning'>You have to wait before using an ability!</span>")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(user == victim)
		to_chat(user,"<span class='warning'>You can't steady aim yourself!</span>")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	user.visible_message("<span class='danger'>[user.name] holds [victim.name] at gunpoint!</span>",\
	 "<span class='userdanger'>You hold [victim.name] up at gunpoint!</span>",\
	 "<span class='hear'>You hear metal clanking...</span>")
	playsound(loc, 'fulp_modules/lisa/Sounds/steadyaim.ogg', 50, FALSE, -5)
	if(prob(50))
		victim.Stun(rand(10, 20))
	used_ability = TRUE
	addtimer(CALLBACK(src, .proc/clear_cooldown), 8 SECONDS)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/// Prevents the gun from being fired.
/obj/item/gun/ballistic/revolver/joel/afterattack(atom/target, mob/living/user, flag, params)
	if(!chambered) /// Can shoot if its empty, we don't care!
		user.visible_message("<span class='danger'>*click*</span>")
		playsound(loc, 'fulp_modules/lisa/Sounds/gunclick.ogg', 50, FALSE, -5)
		return
	if(used_ability)
		to_chat(user, "<span class='warning'>You don't want to waste [src]'s only bullet!</span>")
		return
	if(target) /// Misdirection (Scholar of the Wilbur Sin exclusive)
		user.visible_message("<span class='danger'>[user.name] looks around themselves.</span>",\
		 "<span class='userdanger'>You look for something to point [src] at.</span>")
		playsound(loc, 'fulp_modules/lisa/Sounds/misdirect.ogg', 50, FALSE, -5)
		if(do_after(user, 0.5 SECONDS, target = src))
			user.setDir(turn(user.dir, 90))
		if(do_after(user, 0.3 SECONDS, target = src))
			user.setDir(turn(user.dir, -90))
		if(do_after(user, 0.3 SECONDS, target = src))
			user.setDir(turn(user.dir, 90))
		if(do_after(user, 0.3 SECONDS, target = src))
			user.setDir(turn(user.dir, -90))
		if(do_after(user, 0.3 SECONDS, target = src))
			user.emote("gasp")
			user.visible_message("<span class='danger'>[user.name] quickly points their gun towards [target]!</span>",\
			 "<span class='userdanger'>You misdirect [src] towards [target]!</span>",\
			 "<span class='hear'>You hear a gasp...</span>")
			for(var/mob/living/H in view(1, target))
				if(user.body_position == STANDING_UP)
					user.visible_message("<span class='danger'>You quickly jump towards [target]!</span>",\
					 "<span class='userdanger'>[H] quickly jumps towards [target]!</span>",\
					 "<span class='hear'>You hear aggressive shuffling!</span>")
					H.Move(target)
			for(var/mob/living/L in viewers(5, target))
				L.face_atom(target)
				L.do_alert_animation()
		used_ability = TRUE
		addtimer(CALLBACK(src, .proc/clear_cooldown), 7 SECONDS)
		return

/obj/item/gun/ballistic/revolver/joel/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	add_fingerprint(user)
	playsound(loc, 'fulp_modules/lisa/Sounds/gunclick.ogg', 50, FALSE, -5)
	to_chat(user, "<span class='warning'>You don't want to waste [src]'s only bullet!</span>")


/*
 *	Cylinder, bullet & casing.
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

/// This isnt meant to be fired, so do 0 damage. This can technically be fired by dual wielding, so they'll have a nice surprise of a big load of nothing if they do.
/obj/projectile/bullet/c22
	name = "5.6mm bullet"
	damage = 0
