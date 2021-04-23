/obj/item/gun/ballistic/revolver/joel
	icon = 'fulp_modules/lisa/Sprites/joel.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi' /// We probably don't want to change these...
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	load_sound = 'fulp_modules/lisa/Sounds/gunload.ogg'
	eject_sound = 'fulp_modules/lisa/Sounds/empty.ogg'
	icon_state = "revolver"
	name = "\improper Bolt Action pistol"
	desc = "The most powerful handgun in Olathe. It's best not to waste the only bullet."
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/c22
	custom_premium_price = PAYCHECK_HARD * 1.75
	var/used_ability = FALSE

/// To prevent ability spam.
/obj/item/gun/ballistic/revolver/joel/proc/clear_cooldown()
	used_ability = FALSE

/// Load It In
/obj/item/gun/ballistic/revolver/joel/attackby(obj/item/A, mob/user, params)
	if(!istype(A, /obj/item/ammo_casing/c22))
		return
	if(get_ammo(countchambered = TRUE) >= 1)
		to_chat(user, "<span class='warning'>[src] already has a bullet loaded!</span>")
		return
	user.visible_message("<span class='danger'>[user.name] puts the bullet in [src]!</span>",\
	 "<span class='userdanger'>You put the bullet in [src]!</span>",\
	 "<span class='hear'>You hear metal clanking...</span>")
	..()
	var/mob/living/carbon/C = user
	C.adjustBruteLoss(-5)
	C.adjustFireLoss(-5)
	A.update_appearance()
	return

/// Gun Spin + Gun Toss
/obj/item/gun/ballistic/revolver/joel/attack_self(mob/user)
	if(!used_ability)
		if(HAS_TRAIT(user, TRAIT_GUNFLIP)) /// If you have a holster, you'll spin it instead, you're experienced.
			user.visible_message("<span class='danger'>[user.name] spins [src] around like mad!</span>",\
			 "<span class='userdanger'>You spin [src] around!</span>",\
			 "<span class='hear'>You hear metal clanking...</span>")
			for(var/mob/living/L in viewers(7, user))
				L.face_atom(user)
				L.do_alert_animation()
			playsound(src, 'fulp_modules/lisa/Sounds/gunreveal.ogg', 20, FALSE, -5)
			var/mob/living/carbon/C = user
			used_ability = TRUE
			addtimer(CALLBACK(src, .proc/clear_cooldown), 6 SECONDS)
			C.adjustStaminaLoss(-10)
			return
		else /// Otherwise, just toss it.
			user.visible_message("<span class='danger'>[user.name] throws [src] around!</span>",\
			 "<span class='userdanger'>You toss [src] around!</span>",\
			 "<span class='hear'>You hear metal clanking...</span>")
			for(var/mob/living/L in viewers(7, user))
				L.face_atom(user)
				L.do_alert_animation()
			playsound(src, 'fulp_modules/lisa/Sounds/guntoss.ogg', 50, FALSE, -5)
			var/mob/living/carbon/C = user
			used_ability = TRUE
			addtimer(CALLBACK(src, .proc/clear_cooldown), 6 SECONDS)
			C.adjustStaminaLoss(-10)
			C.drop_all_held_items()
			return
	..()

/// Gun reveal + Mind Games
/obj/item/gun/ballistic/revolver/joel/AltClick(mob/user)
	if(!used_ability)
		if(HAS_TRAIT(user, TRAIT_GUNFLIP))
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
			addtimer(CALLBACK(src, .proc/clear_cooldown), 10 SECONDS)
			return
		else /// No holster? Use mind games instead
			user.visible_message("<span class='danger'>[user.name] stares deeply around [user.p_them()]selves!</span>",\
			 "<span class='userdanger'>You stare directly into the souls of those around you.</span>",\
			 "<span class='hear'>You hear metal clanking...</span>")
			for(var/mob/living/H in viewers(1, user))
				if(prob(75) && !(H == user) && !(H.stat))
					to_chat(H, "<span class='warning'>You feel terrifyingly spooked by [user.name]!</span>")
					if(!H.mind || !istype(H.mind.martial_art, /datum/martial_art/velvetfu))
						var/throwtarget = get_edge_target_turf(user, get_dir(user, get_step_away(H, user)))
						H.throw_at(throwtarget, 3, 2)
			used_ability = TRUE
			addtimer(CALLBACK(src, .proc/clear_cooldown), 10 SECONDS)
			return
	else
		..()
		spin()

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
		if(!victim.mind || !istype(victim.mind.martial_art, /datum/martial_art/velvetfu))
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
		used_ability = TRUE
		addtimer(CALLBACK(src, .proc/clear_cooldown), 7 SECONDS)
		if(do_after(user, 0.4 SECONDS, target = src, progress = FALSE))
			user.setDir(turn(user.dir, 90))
		if(do_after(user, 0.3 SECONDS, target = src, progress = FALSE))
			user.setDir(turn(user.dir, -90))
		if(do_after(user, 0.3 SECONDS, target = src, progress = FALSE))
			user.setDir(turn(user.dir, 90))
		if(do_after(user, 0.3 SECONDS, target = src, progress = FALSE))
			user.setDir(turn(user.dir, -90))
		if(do_after(user, 0.3 SECONDS, target = src, progress = FALSE))
			user.emote("gasp")
			user.visible_message("<span class='danger'>[user.name] quickly points their gun towards [target]!</span>",\
			 "<span class='userdanger'>You misdirect [src] towards [target]!</span>",\
			 "<span class='hear'>You hear a gasp...</span>")
			for(var/mob/living/H in view(1, target))
				if(!(H == user) && !(H.stat))
					if(!H.mind || !istype(H.mind.martial_art, /datum/martial_art/velvetfu))
						H.visible_message("<span class='danger'>You quickly jump towards [target]!</span>",\
						 "<span class='userdanger'>[H] quickly jumps towards [target]!</span>",\
						 "<span class='hear'>You hear aggressive shuffling!</span>")
						H.Move(target)
			for(var/mob/living/L in viewers(5, target))
				L.face_atom(target)
				L.do_alert_animation()
		return

/obj/item/gun/ballistic/revolver/joel/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	add_fingerprint(user)
	to_chat(user, "<span class='warning'>You don't want to waste [src]'s only bullet!</span>")


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
