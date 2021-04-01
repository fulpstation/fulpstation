
/mob/living/proc/run_armor_check(def_zone = null, attack_flag = MELEE, absorb_text = null, soften_text = null, armour_penetration, penetrated_text, silent=FALSE)
	var/armor = getarmor(def_zone, attack_flag)

	if(armor <= 0)
		return armor
	if(silent)
		return max(0, armor - armour_penetration)

	//the if "armor" check is because this is used for everything on /living, including humans
	if(armour_penetration)
		armor = max(0, armor - armour_penetration)
		if(penetrated_text)
			to_chat(src, "<span class='userdanger'>[penetrated_text]</span>")
		else
			to_chat(src, "<span class='userdanger'>Your armor was penetrated!</span>")
	else if(armor >= 100)
		if(absorb_text)
			to_chat(src, "<span class='notice'>[absorb_text]</span>")
		else
			to_chat(src, "<span class='notice'>Your armor absorbs the blow!</span>")
	else
		if(soften_text)
			to_chat(src, "<span class='warning'>[soften_text]</span>")
		else
			to_chat(src, "<span class='warning'>Your armor softens the blow!</span>")
	return armor

/mob/living/proc/getarmor(def_zone, type)
	return 0

//this returns the mob's protection against eye damage (number between -1 and 2) from bright lights
/mob/living/proc/get_eye_protection()
	return 0

//this returns the mob's protection against ear damage (0:no protection; 1: some ear protection; 2: has no ears)
/mob/living/proc/get_ear_protection()
	return 0

/mob/living/proc/is_mouth_covered(head_only = 0, mask_only = 0)
	return FALSE

/mob/living/proc/is_eyes_covered(check_glasses = 1, check_head = 1, check_mask = 1)
	return FALSE
/mob/living/proc/is_pepper_proof(check_head = TRUE, check_mask = TRUE)
	return FALSE
/mob/living/proc/on_hit(obj/projectile/P)
	return BULLET_ACT_HIT

/mob/living/bullet_act(obj/projectile/P, def_zone, piercing_hit = FALSE)
	var/armor = run_armor_check(def_zone, P.flag, "","",P.armour_penetration)
	var/on_hit_state = P.on_hit(src, armor, piercing_hit)
	if(!P.nodamage && on_hit_state != BULLET_ACT_BLOCK)
		apply_damage(P.damage, P.damage_type, def_zone, armor, wound_bonus=P.wound_bonus, bare_wound_bonus=P.bare_wound_bonus, sharpness = P.sharpness)
		apply_effects(P.stun, P.knockdown, P.unconscious, P.irradiate, P.slur, P.stutter, P.eyeblur, P.drowsy, armor, P.stamina, P.jitter, P.paralyze, P.immobilize)
		if(P.dismemberment)
			check_projectile_dismemberment(P, def_zone)
	return on_hit_state ? BULLET_ACT_HIT : BULLET_ACT_BLOCK

/mob/living/proc/check_projectile_dismemberment(obj/projectile/P, def_zone)
	return 0

/obj/item/proc/get_volume_by_throwforce_and_or_w_class()
		if(throwforce && w_class)
				return clamp((throwforce + w_class) * 5, 30, 100)// Add the item's throwforce to its weight class and multiply by 5, then clamp the value between 30 and 100
		else if(w_class)
				return clamp(w_class * 8, 20, 100) // Multiply the item's weight class by 8, then clamp the value between 20 and 100
		else
				return 0

/mob/living/proc/set_combat_mode(new_mode, silent = TRUE)
	if(combat_mode == new_mode)
		return
	. = combat_mode
	combat_mode = new_mode
	if(hud_used?.action_intent)
		hud_used.action_intent.update_appearance()
	if(silent || !(client?.prefs.toggles & SOUND_COMBATMODE))
		return
	if(combat_mode)
		playsound_local(src, 'sound/misc/ui_togglecombat.ogg', 25, FALSE, pressure_affected = FALSE) //Sound from interbay!
	else
		playsound_local(src, 'sound/misc/ui_toggleoffcombat.ogg', 25, FALSE, pressure_affected = FALSE) //Slightly modified version of the above

/mob/living/hitby(atom/movable/AM, skipcatch, hitpush = TRUE, blocked = FALSE, datum/thrownthing/throwingdatum)
	if(isitem(AM))
		var/obj/item/thrown_item = AM
		var/zone = ran_zone(BODY_ZONE_CHEST, 65)//Hits a random part of the body, geared towards the chest
		var/nosell_hit = SEND_SIGNAL(thrown_item, COMSIG_MOVABLE_IMPACT_ZONE, src, zone, throwingdatum) // TODO: find a better way to handle hitpush and skipcatch for humans
		if(nosell_hit)
			skipcatch = TRUE
			hitpush = FALSE

		if(blocked)
			return TRUE

		if(thrown_item.thrownby)
			log_combat(thrown_item.thrownby, src, "threw and hit", thrown_item)
		if(nosell_hit)
			return ..()
		visible_message("<span class='danger'>[src] is hit by [thrown_item]!</span>", \
						"<span class='userdanger'>You're hit by [thrown_item]!</span>")
		if(!thrown_item.throwforce)
			return
		var/armor = run_armor_check(zone, MELEE, "Your armor has protected your [parse_zone(zone)].", "Your armor has softened hit to your [parse_zone(zone)].", thrown_item.armour_penetration)
		apply_damage(thrown_item.throwforce, thrown_item.damtype, zone, armor, sharpness = thrown_item.get_sharpness(), wound_bonus = (nosell_hit * CANT_WOUND))
		if(QDELETED(src)) //Damage can delete the mob.
			return
		return ..()

	playsound(loc, 'sound/weapons/genhit.ogg', 50, TRUE, -1) //Item sounds are handled in the item itself
	return ..()

/mob/living/fire_act()
	adjust_fire_stacks(3)
	IgniteMob()

/mob/living/proc/grabbedby(mob/living/carbon/user, supress_message = FALSE)
	if(user == src || anchored || !isturf(user.loc))
		return FALSE
	if(!user.pulling || user.pulling != src)
		user.start_pulling(src, supress_message = supress_message)
		return

	if(!(status_flags & CANPUSH) || HAS_TRAIT(src, TRAIT_PUSHIMMUNE))
		to_chat(user, "<span class='warning'>[src] can't be grabbed more aggressively!</span>")
		return FALSE

	if(user.grab_state >= GRAB_AGGRESSIVE && HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, "<span class='warning'>You don't want to risk hurting [src]!</span>")
		return FALSE
	grippedby(user)

//proc to upgrade a simple pull into a more aggressive grab.
/mob/living/proc/grippedby(mob/living/carbon/user, instant = FALSE)
	if(user.grab_state < GRAB_KILL)
		user.changeNext_move(CLICK_CD_GRABBING)
		var/sound_to_play = 'sound/weapons/thudswoosh.ogg'
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(H.dna.species.grab_sound)
				sound_to_play = H.dna.species.grab_sound
		playsound(src.loc, sound_to_play, 50, TRUE, -1)

		if(user.grab_state) //only the first upgrade is instantaneous
			var/old_grab_state = user.grab_state
			var/grab_upgrade_time = instant ? 0 : 30
			visible_message("<span class='danger'>[user] starts to tighten [user.p_their()] grip on [src]!</span>", \
							"<span class='userdanger'>[user] starts to tighten [user.p_their()] grip on you!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", null, user)
			to_chat(user, "<span class='danger'>You start to tighten your grip on [src]!</span>")
			switch(user.grab_state)
				if(GRAB_AGGRESSIVE)
					log_combat(user, src, "attempted to neck grab", addition="neck grab")
				if(GRAB_NECK)
					log_combat(user, src, "attempted to strangle", addition="kill grab")
			if(!do_mob(user, src, grab_upgrade_time))
				return FALSE
			if(!user.pulling || user.pulling != src || user.grab_state != old_grab_state)
				return FALSE
		user.setGrabState(user.grab_state + 1)
		switch(user.grab_state)
			if(GRAB_AGGRESSIVE)
				var/add_log = ""
				if(HAS_TRAIT(user, TRAIT_PACIFISM))
					visible_message("<span class='danger'>[user] firmly grips [src]!</span>",
									"<span class='danger'>[user] firmly grips you!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", null, user)
					to_chat(user, "<span class='danger'>You firmly grip [src]!</span>")
					add_log = " (pacifist)"
				else
					visible_message("<span class='danger'>[user] grabs [src] aggressively!</span>", \
									"<span class='userdanger'>[user] grabs you aggressively!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", null, user)
					to_chat(user, "<span class='danger'>You grab [src] aggressively!</span>")
				drop_all_held_items()
				stop_pulling()
				log_combat(user, src, "grabbed", addition="aggressive grab[add_log]")
			if(GRAB_NECK)
				log_combat(user, src, "grabbed", addition="neck grab")
				visible_message("<span class='danger'>[user] grabs [src] by the neck!</span>",\
								"<span class='userdanger'>[user] grabs you by the neck!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", null, user)
				to_chat(user, "<span class='danger'>You grab [src] by the neck!</span>")
				if(!buckled && !density)
					Move(user.loc)
			if(GRAB_KILL)
				log_combat(user, src, "strangled", addition="kill grab")
				visible_message("<span class='danger'>[user] is strangling [src]!</span>", \
								"<span class='userdanger'>[user] is strangling you!</span>", "<span class='hear'>You hear aggressive shuffling!</span>", null, user)
				to_chat(user, "<span class='danger'>You're strangling [src]!</span>")
				if(!buckled && !density)
					Move(user.loc)
		user.set_pull_offsets(src, grab_state)
		return TRUE


/mob/living/attack_slime(mob/living/simple_animal/slime/M)
	if(!SSticker.HasRoundStarted())
		to_chat(M, "You cannot attack people before the game has started.")
		return

	if(M.buckled)
		if(M in buckled_mobs)
			M.Feedstop()
		return // can't attack while eating!

	if(HAS_TRAIT(src, TRAIT_PACIFISM))
		to_chat(M, "<span class='warning'>You don't want to hurt anyone!</span>")
		return FALSE

	if (stat != DEAD)
		log_combat(M, src, "attacked")
		M.do_attack_animation(src)
		visible_message("<span class='danger'>\The [M.name] glomps [src]!</span>", \
						"<span class='userdanger'>\The [M.name] glomps you!</span>", "<span class='hear'>You hear a sickening sound of flesh hitting flesh!</span>", COMBAT_MESSAGE_RANGE, M)
		to_chat(M, "<span class='danger'>You glomp [src]!</span>")
		return TRUE

/mob/living/attack_animal(mob/living/simple_animal/user, list/modifiers)
	user.face_atom(src)
	if(user.melee_damage_upper == 0)
		visible_message("<span class='notice'>\The [user] [user.friendly_verb_continuous] [src]!</span>", \
						"<span class='notice'>\The [user] [user.friendly_verb_continuous] you!</span>", null, COMBAT_MESSAGE_RANGE, user)
		to_chat(user, "<span class='notice'>You [user.friendly_verb_simple] [src]!</span>")
		return FALSE
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, "<span class='warning'>You don't want to hurt anyone!</span>")
		return FALSE

	if(user.attack_sound)
		playsound(loc, user.attack_sound, 50, TRUE, TRUE)
	user.do_attack_animation(src)
	visible_message("<span class='danger'>\The [user] [user.attack_verb_continuous] [src]!</span>", \
					"<span class='userdanger'>\The [user] [user.attack_verb_continuous] you!</span>", null, COMBAT_MESSAGE_RANGE, user)
	to_chat(user, "<span class='danger'>You [user.attack_verb_simple] [src]!</span>")
	log_combat(user, src, "attacked")
	return TRUE

/mob/living/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	var/martial_result = user.apply_martial_art(src, modifiers)
	if (martial_result != MARTIAL_ATTACK_INVALID)
		return martial_result

/mob/living/attack_paw(mob/living/carbon/human/user, list/modifiers)
	if(isturf(loc) && istype(loc.loc, /area/start))
		to_chat(user, "No attacking people at spawn, you jackass.")
		return FALSE

	var/martial_result = user.apply_martial_art(src, modifiers)
	if (martial_result != MARTIAL_ATTACK_INVALID)
		return martial_result

	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if (user != src)
			user.disarm(src)
			return TRUE
	if (!user.combat_mode)
		return FALSE
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, "<span class='warning'>You don't want to hurt anyone!</span>")
		return FALSE

	if(user.is_muzzled() || user.is_mouth_covered(FALSE, TRUE))
		to_chat(user, "<span class='warning'>You can't bite with your mouth covered!</span>")
		return FALSE
	user.do_attack_animation(src, ATTACK_EFFECT_BITE)
	if (prob(75))
		log_combat(user, src, "attacked")
		playsound(loc, 'sound/weapons/bite.ogg', 50, TRUE, -1)
		visible_message("<span class='danger'>[user.name] bites [src]!</span>", \
						"<span class='userdanger'>[user.name] bites you!</span>", "<span class='hear'>You hear a chomp!</span>", COMBAT_MESSAGE_RANGE, user)
		to_chat(user, "<span class='danger'>You bite [src]!</span>")
		return TRUE
	else
		visible_message("<span class='danger'>[user.name]'s bite misses [src]!</span>", \
						"<span class='danger'>You avoid [user.name]'s bite!</span>", "<span class='hear'>You hear the sound of jaws snapping shut!</span>", COMBAT_MESSAGE_RANGE, user)
		to_chat(user, "<span class='warning'>Your bite misses [src]!</span>")

	return FALSE

/mob/living/attack_larva(mob/living/carbon/alien/larva/L)
	if(L.combat_mode)
		if(HAS_TRAIT(L, TRAIT_PACIFISM))
			to_chat(L, "<span class='warning'>You don't want to hurt anyone!</span>")
			return

		L.do_attack_animation(src)
		if(prob(90))
			log_combat(L, src, "attacked")
			visible_message("<span class='danger'>[L.name] bites [src]!</span>", \
							"<span class='userdanger'>[L.name] bites you!</span>", "<span class='hear'>You hear a chomp!</span>", COMBAT_MESSAGE_RANGE, L)
			to_chat(L, "<span class='danger'>You bite [src]!</span>")
			playsound(loc, 'sound/weapons/bite.ogg', 50, TRUE, -1)
			return TRUE
		else
			visible_message("<span class='danger'>[L.name]'s bite misses [src]!</span>", \
							"<span class='danger'>You avoid [L.name]'s bite!</span>", "<span class='hear'>You hear the sound of jaws snapping shut!</span>", COMBAT_MESSAGE_RANGE, L)
			to_chat(L, "<span class='warning'>Your bite misses [src]!</span>")
	else
		visible_message("<span class='notice'>[L.name] rubs its head against [src].</span>", \
						"<span class='notice'>[L.name] rubs its head against you.</span>", null, null, L)
		to_chat(L, "<span class='notice'>You rub your head against [src].</span>")
		return FALSE
	return FALSE

/mob/living/attack_alien(mob/living/carbon/alien/humanoid/user, list/modifiers)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		user.do_attack_animation(src, ATTACK_EFFECT_DISARM)
		return TRUE
	if(user.combat_mode)
		if(HAS_TRAIT(user, TRAIT_PACIFISM))
			to_chat(user, "<span class='warning'>You don't want to hurt anyone!</span>")
			return FALSE
		user.do_attack_animation(src)
		return TRUE
	else
		visible_message("<span class='notice'>[user] caresses [src] with its scythe-like arm.</span>", \
						"<span class='notice'>[user] caresses you with its scythe-like arm.</span>", null, null, user)
		to_chat(user, "<span class='notice'>You caress [src] with your scythe-like arm.</span>")
		return FALSE

/mob/living/attack_hulk(mob/living/carbon/human/user)
	..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, "<span class='warning'>You don't want to hurt [src]!</span>")
		return FALSE
	return TRUE

/mob/living/ex_act(severity, target, origin)
	if(origin && istype(origin, /datum/spacevine_mutation) && isvineimmune(src))
		return FALSE
	return ..()

//Looking for irradiate()? It's been moved to radiation.dm under the rad_act() for mobs.

/mob/living/acid_act(acidpwr, acid_volume)
	take_bodypart_damage(acidpwr * min(1, acid_volume * 0.1))
	return TRUE

///As the name suggests, this should be called to apply electric shocks.
/mob/living/proc/electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE)
	SEND_SIGNAL(src, COMSIG_LIVING_ELECTROCUTE_ACT, shock_damage, source, siemens_coeff, flags)
	shock_damage *= siemens_coeff
	if((flags & SHOCK_TESLA) && HAS_TRAIT(src, TRAIT_TESLA_SHOCKIMMUNE))
		return FALSE
	if(HAS_TRAIT(src, TRAIT_SHOCKIMMUNE))
		return FALSE
	if(shock_damage < 1)
		return FALSE
	if(!(flags & SHOCK_ILLUSION))
		adjustFireLoss(shock_damage)
	else
		adjustStaminaLoss(shock_damage)
	visible_message(
		"<span class='danger'>[src] was shocked by \the [source]!</span>", \
		"<span class='userdanger'>You feel a powerful shock coursing through your body!</span>", \
		"<span class='hear'>You hear a heavy electrical crack.</span>" \
	)
	return shock_damage

/mob/living/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_CONTENTS)
		return
	for(var/obj/O in contents)
		O.emp_act(severity)

///Logs, gibs and returns point values of whatever mob is unfortunate enough to get eaten.
/mob/living/singularity_act()
	investigate_log("([key_name(src)]) has been consumed by the singularity.", INVESTIGATE_SINGULO) //Oh that's where the clown ended up!
	gib()
	return 20

/mob/living/narsie_act()
	if(status_flags & GODMODE || QDELETED(src))
		return

	if(GLOB.cult_narsie && GLOB.cult_narsie.souls_needed[src])
		GLOB.cult_narsie.souls_needed -= src
		GLOB.cult_narsie.souls += 1
		if((GLOB.cult_narsie.souls == GLOB.cult_narsie.soul_goal) && (GLOB.cult_narsie.resolved == FALSE))
			GLOB.cult_narsie.resolved = TRUE
			sound_to_playing_players('sound/machines/alarm.ogg')
			addtimer(CALLBACK(GLOBAL_PROC, .proc/cult_ending_helper, 1), 120)
			addtimer(CALLBACK(GLOBAL_PROC, .proc/ending_helper), 270)
	if(client)
		makeNewConstruct(/mob/living/simple_animal/hostile/construct/harvester, src, cultoverride = TRUE)
	else
		switch(rand(1, 4))
			if(1)
				new /mob/living/simple_animal/hostile/construct/juggernaut/hostile(get_turf(src))
			if(2)
				new /mob/living/simple_animal/hostile/construct/wraith/hostile(get_turf(src))
			if(3)
				new /mob/living/simple_animal/hostile/construct/artificer/hostile(get_turf(src))
			if(4)
				new /mob/living/simple_animal/hostile/construct/proteon/hostile(get_turf(src))
	spawn_dust()
	gib()
	return TRUE

//called when the mob receives a bright flash
/mob/living/proc/flash_act(intensity = 1, override_blindness_check = 0, affect_silicon = 0, visual = 0, type = /atom/movable/screen/fullscreen/flash, length = 25)
	if(HAS_TRAIT(src, TRAIT_NOFLASH))
		return FALSE
	if(get_eye_protection() < intensity && (override_blindness_check || !is_blind()))
		overlay_fullscreen("flash", type)
		addtimer(CALLBACK(src, .proc/clear_fullscreen, "flash", length), length)
		return TRUE
	return FALSE

//called when the mob receives a loud bang
/mob/living/proc/soundbang_act()
	return FALSE

//to damage the clothes worn by a mob
/mob/living/proc/damage_clothes(damage_amount, damage_type = BRUTE, damage_flag = 0, def_zone)
	return


/mob/living/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(!used_item)
		used_item = get_active_held_item()
	..()

/**
 * Does a slap animation on an atom
 *
 * Uses do_attack_animation to animate the attacker attacking
 * then draws a hand moving across the top half of the target(where a mobs head would usually be) to look like a slap
 * Arguments:
 * * atom/A - atom being slapped
 */
/mob/living/proc/do_slap_animation(atom/slapped)
	do_attack_animation(slapped, no_effect=TRUE)
	var/image/gloveimg = image('icons/effects/effects.dmi', slapped, "slapglove", slapped.layer + 0.1)
	gloveimg.pixel_y = 10 // should line up with head
	gloveimg.pixel_x = 10
	flick_overlay(gloveimg, GLOB.clients, 10)

	// And animate the attack!
	animate(gloveimg, alpha = 175, transform = matrix() * 0.75, pixel_x = 0, pixel_y = 10, pixel_z = 0, time = 3)
	animate(time = 1)
	animate(alpha = 0, time = 3, easing = CIRCULAR_EASING|EASE_OUT)

/** Handles exposing a mob to reagents.
 *
 * If the methods include INGEST the mob tastes the reagents.
 * If the methods include VAPOR it incorporates permiability protection.
 */
/mob/living/expose_reagents(list/reagents, datum/reagents/source, methods=TOUCH, volume_modifier=1, show_message=TRUE)
	. = ..()
	if(. & COMPONENT_NO_EXPOSE_REAGENTS)
		return

	if(methods & INGEST)
		taste(source)

	var/touch_protection = (methods & VAPOR) ? get_permeability_protection() : 0
	SEND_SIGNAL(source, COMSIG_REAGENTS_EXPOSE_MOB, src, reagents, methods, volume_modifier, show_message, touch_protection)
	for(var/reagent in reagents)
		var/datum/reagent/R = reagent
		. |= R.expose_mob(src, methods, reagents[R], show_message, touch_protection)
