/*
 *	This file is overwriting TG's cult stun
 *	> 'code/modules/antagonists/cult/blood_magic.dm'
 */

/datum/action/innate/cult/blood_spell/stun
	name = "Stun"
	desc = "Empowers your hand to stun and mute a weak-minded victim on contact."
	button_icon_state = "hand"
	magic_path = "/obj/item/melee/blood_magic/fulpstun"
	health_cost = 10

/obj/item/melee/blood_magic/fulpstun/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!isliving(target) || !proximity)
		return
	var/mob/living/victim = target
	if(IS_CULTIST(victim))
		return
	if(IS_CULTIST(user))
		user.visible_message(
			span_warning("[user] holds up [user.p_their()] hand, which explodes in a flash of red light!"),
			span_cultitalic("You attempt to stun [victim] with the spell!"),
		)

		user.mob_light(_color = LIGHT_COLOR_BLOOD_MAGIC, _range = 3, _duration = 2)

		var/anti_magic_source = victim.anti_magic_check()
		if(anti_magic_source)

			victim.mob_light(_color = LIGHT_COLOR_HOLY_MAGIC, _range = 2, _duration = 100)
			var/mutable_appearance/forbearance = mutable_appearance('icons/effects/genetics.dmi', "servitude", -MUTATIONS_LAYER)
			victim.add_overlay(forbearance)
			addtimer(CALLBACK(victim, /atom.proc/cut_overlay, forbearance), 100)

			if(istype(anti_magic_source, /obj/item))
				var/obj/item/ams_object = anti_magic_source
				target.visible_message(
					span_warning("[victim] starts to glow in a halo of light!"),
					span_userdanger("Your [ams_object.name] begins to glow, emitting a blanket of holy light which surrounds you and protects you from the flash of light!"),
				)
			else
				target.visible_message(
					span_warning("[victim] starts to glow in a halo of light!"),
					span_userdanger("A feeling of warmth washes over you, rays of holy light surround your body and protect you from the flash of light!"),
				)

		else
			if(HAS_TRAIT(target, TRAIT_MINDSHIELD)) // Mindshield just re-directs the stun's spell from their brain to their body.
				var/mob/living/carbon/carbon_target = victim
				to_chat(user, span_cultitalic("Our spell fails to brainwash their strong mind, tearing their skull open!"))
				carbon_target.stuttering += 8
				carbon_target.Jitter(6)
				carbon_target.bleed(30)
				var/obj/item/bodypart/head = carbon_target.get_bodypart(BODY_ZONE_HEAD)
				var/datum/wound/slash/moderate/crit_wound = new
				crit_wound.apply_wound(head)
				carbon_target.apply_damage(12, BRUTE)
			else
				to_chat(user, span_cultitalic("In a brilliant flash of red, [victim] falls to the ground!"))
				victim.Paralyze(160)
				victim.flash_act(1,1)
				if(issilicon(target))
					var/mob/living/silicon/silicon_victim = victim
					silicon_victim.emp_act(EMP_HEAVY)
				else if(iscarbon(target))
					var/mob/living/carbon/carbon_target = victim
					carbon_target.silent += 6
					carbon_target.stuttering += 15
					carbon_target.cultslurring += 15
					carbon_target.Jitter(15)
		uses--
	. = ..()
