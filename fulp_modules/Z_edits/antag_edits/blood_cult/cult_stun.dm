/*
 *	This file is overwriting TG's cult stun
 *	> 'code/modules/antagonists/cult/blood_magic.dm'
 */

/datum/action/innate/cult/blood_spell/stun
	desc = "Empowers your hand to stun and mute a weak-minded victim on contact."
	magic_path = "/obj/item/melee/blood_magic/fulpstun"

/obj/item/melee/blood_magic/fulpstun/cast_spell(mob/living/target, mob/living/carbon/user)
	if(!istype(target) || IS_CULTIST(target))
		return
	var/datum/antagonist/cult/cultist = IS_CULTIST(user)
	var/datum/team/cult/cult_team = cultist.get_team()
	var/effect_coef = 1
	if(cult_team.cult_ascendent)
		effect_coef = 0.1
	else if(cult_team.cult_risen)
		effect_coef = 0.4
	user.visible_message(
		span_warning("[user] holds up [user.p_their()] hand, which explodes in a flash of red light!"),
		span_cult_italic("You attempt to stun [target] with the spell!"),
		visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
	)
	user.mob_light(range = 1.1, power = 2, color = LIGHT_COLOR_BLOOD_MAGIC, duration = 0.2 SECONDS)
	// Heretics are momentarily disoriented by the stunning aura. Enough for both parties to go 'oh shit' but only a mild combat ability.
	// Heretics have an identical effect on their grasp. The cultist's worse spell preparation is offset by their extra gear and teammates.
	if(IS_HERETIC(target))
		target.AdjustKnockdown(0.5 SECONDS)
		target.adjust_confusion_up_to(1.5 SECONDS, 3 SECONDS)
		target.adjust_dizzy_up_to(1.5 SECONDS, 3 SECONDS)
		ADD_TRAIT(target, TRAIT_NO_SIDE_KICK, REF(src)) // We don't want this to be a good stunning tool, just minor disorientation
		addtimer(TRAIT_CALLBACK_REMOVE(target, TRAIT_NO_SIDE_KICK, REF(src)), 1 SECONDS)

		var/old_color = target.color
		target.color = COLOR_HERETIC_GREEN
		animate(target, color = old_color, time = 4 SECONDS, easing = EASE_IN)
		target.mob_light(range = 1.5, power = 2.5, color = COLOR_HERETIC_GREEN, duration = 0.5 SECONDS)
		playsound(target, 'sound/effects/magic/magic_block_mind.ogg', 150, TRUE) // insanely quiet

		to_chat(user, span_warning("An eldritch force intervenes as you touch [target], absorbing most of the effects!"))
		to_chat(target, span_warning("As [user] touches you with vile magicks, the Mansus absorbs most of the effects!"))
		target.balloon_alert_to_viewers("absorbed!")
	else if(target.can_block_magic())
		to_chat(user, span_warning("The spell had no effect!"))
	else if(HAS_TRAIT(target, TRAIT_MINDSHIELD)) // Mindshield just re-directs the stun's spell from their brain to their body.
		var/mob/living/carbon/carbon_target = target
		to_chat(user, span_cult_italic("Our spell fails to penetrate their guarded mind, tearing their skull open!"))
		carbon_target.adjust_timed_status_effect(10 SECONDS*effect_coef, /datum/status_effect/speech/stutter)
		carbon_target.set_timed_status_effect(1 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
		carbon_target.bleed(30)
		var/obj/item/bodypart/head = carbon_target.get_bodypart(BODY_ZONE_HEAD)
		var/datum/wound/slash/flesh/moderate/crit_wound = new
		crit_wound.apply_wound(head)
	else
		to_chat(user, span_cult_italic("In a brilliant flash of red, [target] falls to the ground!"))
		target.Paralyze(16 SECONDS * effect_coef)
		target.flash_act(1, TRUE)
		if(issilicon(target))
			var/mob/living/silicon/silicon_target = target
			silicon_target.emp_act(EMP_HEAVY)
		else if(iscarbon(target))
			var/mob/living/carbon/carbon_target = target
			carbon_target.adjust_silence(12 SECONDS * effect_coef)
			carbon_target.adjust_stutter(30 SECONDS * effect_coef)
			carbon_target.adjust_timed_status_effect(30 SECONDS * effect_coef, /datum/status_effect/speech/slurring/cult)
			carbon_target.set_jitter_if_lower(30 SECONDS * effect_coef)
	uses--
	return ..()
