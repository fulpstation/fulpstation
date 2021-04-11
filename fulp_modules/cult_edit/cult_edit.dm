/*
 *	This file is overwriting TG's cult stun
 *	> 'code/modules/antagonists/cult/blood_magic.dm'
 */

/datum/action/innate/cult/blood_spell/stun
	name = "Stun"
	desc = "Empowers your hand to stun and mute a victim on contact."
	button_icon_state = "hand"
	magic_path = "/obj/item/melee/blood_magic/fulpstun"
	health_cost = 10

/obj/item/melee/blood_magic/fulpstun/afterattack(atom/target, mob/living/carbon/user, proximity)
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
			if(HAS_TRAIT(target, TRAIT_MINDSHIELD)) // Mindshield just re-directs the stun's spell from their brain to their body.
				var/mob/living/carbon/C = L
				to_chat(user, "<span class='cultitalic'>Our spell fails to brainwash their strong mind, tearing their skull open!</span>")
				C.stuttering += 8
				C.Jitter(6)
				C.bleed(30)
				var/obj/item/bodypart/head = C.get_bodypart(BODY_ZONE_HEAD)
				var/datum/wound/slash/moderate/crit_wound = new
				crit_wound.apply_wound(head)
				C.apply_damage(12, BRUTE)
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
