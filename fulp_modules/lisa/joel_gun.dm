/obj/item/gun/ballistic/revolver/joel
	icon = 'icons/obj/guns/ballistic.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi' /// We probably don't want to change these...
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	icon_state = "revolver"
	name = "\improper Bolt action pistol"
	desc = "The most powerful handgun in Olathe. It's best not to waste the only bullet."
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/c22
	var/used_ability = FALSE

/// To prevent ability spam.
/obj/item/gun/ballistic/revolver/joel/proc/clear_cooldown()
	used_ability = FALSE

/// Load It In
/obj/item/gun/ballistic/revolver/joel/attackby(obj/item/A, mob/user, params)
	..()
	user.visible_message("<span class='danger'>[user.name] puts the bullet in [src]!</span>",\
	 "<span class='userdanger'>You put the bullet in [src]!</span>",\
	 "<span class='hear'>You hear metal clanking...</span>")
	var/mob/living/carbon/C = user
	C.adjustBruteLoss(-10)
	playsound(src, 'fulp_modules/lisa/Sounds/gunload.ogg', 20, FALSE, -5)
	update_appearance()
	A.update_appearance()
	return

/// Gun Reveal + Gun Toss
/obj/item/gun/ballistic/revolver/joel/attack_self(mob/user)
	if(!used_ability)
		if(HAS_TRAIT(user, TRAIT_GUNFLIP)) /// If you have a holster, use gun reveal.
			user.visible_message("<span class='danger'>[user.name] opens their holster and pulls out [src]!</span>",\
			 "<span class='userdanger'>You reveal your [src]!</span>",\
			 "<span class='hear'>You hear metal clanking...</span>")
			for(var/mob/living/carbon/L in viewers(7, user))
				if(prob(10) && !(L == user))
					to_chat(L, "<span class='warning'>Seeing [src] revealed in such a manner disgusts you!</span>")
					L.vomit(stun = FALSE)
			playsound(src, 'fulp_modules/lisa/Sounds/gunreveal.ogg', 20, FALSE, -5)
			used_ability = TRUE
			addtimer(CALLBACK(src, .proc/clear_cooldown), 5 SECONDS)
			return
		else /// Otherwise, use Gun Toss.
			user.visible_message("<span class='danger'>[user.name] throws [src] around!</span>",\
			 "<span class='userdanger'>You taunt with [src]!</span>",\
			 "<span class='hear'>You hear metal clanking...</span>")
			for(var/mob/living/L in viewers(7, user))
				L.face_atom(user)
				L.do_alert_animation()
			playsound(src, 'fulp_modules/lisa/Sounds/guntoss.ogg', 50, FALSE, -5)
			used_ability = TRUE
			addtimer(CALLBACK(src, .proc/clear_cooldown), 5 SECONDS)
			var/mob/living/carbon/C = user
			C.adjustStaminaLoss(-25)
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
		victim.Stun(rand(10, 25))
	used_ability = TRUE
	addtimer(CALLBACK(src, .proc/clear_cooldown), 5 SECONDS)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/// Prevents the gun from being fired.
/obj/item/gun/ballistic/revolver/joel/afterattack(atom/target, mob/living/user, flag, params)
	. = ..(null, user, flag, params)
	if(flag)
		if(!(target in user.contents) && ismob(target))
			if(user.combat_mode)
				return
	if(!chambered) /// Can shoot if its empty, we don't care!
		user.visible_message("<span class='danger'>*click*</span>")
		playsound(loc, 'fulp_modules/lisa/Sounds/gunclick.ogg', 50, FALSE, -5)
		return
	if(target)
		to_chat(user, "<span class='warning'>You don't want to waste [src]'s only bullet!</span>")
		return

/*
 *	Below is the cylinder, bullet and casing.
 *	We're using unique ones so people cant get more bullets for anything, yada yada, whatever.
 *	Unique gun, unique single bullet. You lose it, it's gone.
 */

/// Cylinder
/obj/item/ammo_box/magazine/internal/cylinder/c22
	name = "\improper Russian revolver cylinder"
	ammo_type = /obj/item/ammo_casing/c22
	caliber = CALIBER_45
	max_ammo = 1
	multiload = FALSE

/// Bullet casing & Bullet
/obj/item/ammo_casing/c22
	name = "5.6mm bullet casing"
	desc = "An incredibly rare type of bullet."
	caliber = CALIBER_45
	projectile_type = /obj/projectile/bullet/c22

/// This isnt meant to be fired, so do 0 damage.
/obj/projectile/bullet/c22
	name = "5.6mm bullet"
	damage = 0
