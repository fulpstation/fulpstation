/*
 *	This file is overwriting TG's cult stun
 *	> 'code/modules/antagonists/cult/blood_magic.dm'
 */

/datum/action/innate/cult/blood_spell/stun
	desc = "Empowers your hand to stun and mute a weak-minded victim on contact."
	magic_path = "/obj/item/melee/blood_magic/fulpstun"

/obj/item/melee/blood_magic/fulpstun/afterattack(mob/living/target, mob/living/carbon/user, proximity)
	if(!isliving(target) || !proximity)
		return
	if(IS_CULTIST(target))
		return
	if(IS_CULTIST(user))
		user.visible_message(span_warning("[user] holds up [user.p_their()] hand, which explodes in a flash of red light!"), \
							span_cultitalic("You attempt to stun [target] with the spell!"))
		user.mob_light(range = 3, color = LIGHT_COLOR_BLOOD_MAGIC, duration = 0.2 SECONDS)
		if(IS_HERETIC(target))
			to_chat(user, span_warning("Some force greater than you intervenes! [target] is protected by the Forgotten Gods!"))
			to_chat(target, span_warning("You are protected by your faith to the Forgotten Gods."))
			var/old_color = target.color
			target.color = rgb(0, 128, 0)
			animate(target, color = old_color, time = 1 SECONDS, easing = EASE_IN)
		else if(target.can_block_magic())
			to_chat(user, span_warning("The spell had no effect!"))
		else if(HAS_TRAIT(target, TRAIT_MINDSHIELD)) // Mindshield just re-directs the stun's spell from their brain to their body.
			var/mob/living/carbon/carbon_target = target
			to_chat(user, span_cultitalic("Our spell fails to brainwash their strong mind, tearing their skull open!"))
			carbon_target.adjust_timed_status_effect(10 SECONDS, /datum/status_effect/speech/stutter)
			carbon_target.set_timed_status_effect(1 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
			carbon_target.bleed(30)
			var/obj/item/bodypart/head = carbon_target.get_bodypart(BODY_ZONE_HEAD)
			var/datum/wound/slash/flesh/moderate/crit_wound = new
			crit_wound.apply_wound(head)
		else
			to_chat(user, span_cultitalic("In a brilliant flash of red, [target] falls to the ground!"))
			target.Paralyze(16 SECONDS)
			target.flash_act(1, TRUE)
			if(issilicon(target))
				var/mob/living/silicon/silicon_target = target
				silicon_target.emp_act(EMP_HEAVY)
			else if(iscarbon(target))
				var/mob/living/carbon/carbon_target = target
				carbon_target.adjust_silence(12 SECONDS)
				carbon_target.adjust_stutter(30 SECONDS)
				carbon_target.adjust_timed_status_effect(30 SECONDS, /datum/status_effect/speech/slurring/cult)
				carbon_target.set_jitter_if_lower(30 SECONDS)
		uses--
	..()
