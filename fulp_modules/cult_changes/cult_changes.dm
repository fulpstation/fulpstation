/// Cult stun
/obj/item/melee/blood_magic/stun/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!isliving(target) || !proximity)
		return
	var/mob/living/L = target
	if(iscultist(target))
		return
	if(iscultist(user))
		user.visible_message("<span class='warning'>[user] holds up [user.p_their()] hand, which explodes in a flash of red light!</span>", \
							"<span class='cultitalic'>You attempt to stun [L] with the spell!</span>")

		user.mob_light(_color = LIGHT_COLOR_BLOOD_MAGIC, _range = 3, _duration = 2)

		var/anti_magic_source = L.anti_magic_check()
		if(anti_magic_source)

			L.mob_light(_color = LIGHT_COLOR_HOLY_MAGIC, _range = 2, _duration = 100)
			var/mutable_appearance/forbearance = mutable_appearance('icons/effects/genetics.dmi', "servitude", -MUTATIONS_LAYER)
			L.add_overlay(forbearance)
			addtimer(CALLBACK(L, /atom/proc/cut_overlay, forbearance), 100)

			if(istype(anti_magic_source, /obj/item))
				var/obj/item/ams_object = anti_magic_source
				target.visible_message("<span class='warning'>[L] starts to glow in a halo of light!</span>", \
									   "<span class='userdanger'>Your [ams_object.name] begins to glow, emitting a blanket of holy light which surrounds you and protects you from the flash of light!</span>")
			else
				target.visible_message("<span class='warning'>[L] starts to glow in a halo of light!</span>", \
									   "<span class='userdanger'>A feeling of warmth washes over you, rays of holy light surround your body and protect you from the flash of light!</span>")

		else
			if(HAS_TRAIT(target, TRAIT_MINDSHIELD))
				var/mob/living/carbon/C = L
				to_chat(user, "<span class='cultitalic'>Their mind is too strong, resisting the spell, but it damaged them nonetheless!</span>")
				C.stuttering += 8
				C.dizziness += 20
				C.Jitter(6)
				C.bleed(30)
				C.apply_damage(60, STAMINA, BODY_ZONE_CHEST)
			else
				to_chat(user, "<span class='cultitalic'>In a brilliant flash of red, [L] falls to the ground!</span>")
				L.Paralyze(160)
				L.flash_act(1,1)
				if(issilicon(target))
					var/mob/living/silicon/S = L
					S.emp_act(EMP_HEAVY)
				else if(iscarbon(target))
					var/mob/living/carbon/C = L
					C.silent += 6
					C.stuttering += 15
					C.cultslurring += 15
					C.Jitter(15)
		uses--
	..()

/// Cult blind
/obj/item/clothing/glasses/hud/health/night/cultblind/equipped(mob/living/user, slot)
	..()
	if(!iscultist(user) && slot == ITEM_SLOT_EYES))
		to_chat(user, "<span class='cultlarge'>\"You want to be blind, do you?\"</span>")
		user.dropItemToGround(src, TRUE)
		user.Dizzy(30)
		user.Paralyze(100)
		user.blind_eyes(30)
	if(slot != ITEM_SLOT_EYES)
		return
	ADD_TRAIT(user, TRAIT_SECURITY_HUD, HELMET_TRAIT)
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	H.add_hud_to(user)

/obj/item/clothing/glasses/hud/health/night/cultblind/dropped(mob/living/user)
	..()
	REMOVE_TRAIT(user, TRAIT_SECURITY_HUD, HELMET_TRAIT)
	var/datum/atom_hud/H = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	H.remove_hud_from(user)
