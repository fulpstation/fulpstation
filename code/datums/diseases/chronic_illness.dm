/datum/disease/chronic_illness
	name = "Hereditary Manifold Sickness"
	max_stages = 5
	spread_text = "Unspread Illness"
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	disease_flags = CHRONIC
	process_dead = TRUE
	stage_prob = 0.25
	cure_text = "Sansufentanyl"
	cures = list(/datum/reagent/medicine/sansufentanyl)
	infectivity = 0
	agent = "Quantum Entanglement"
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = "A disease discovered in an Interdyne laboratory caused by subjection to timesteam correction technology."
	severity = DISEASE_SEVERITY_UNCURABLE
	var/heartswap = TRUE

/datum/disease/chronic_illness/stage_act(seconds_per_tick, times_fired)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(1)
			carrier = FALSE // Go fuck yourself
		if(2)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_warning("You feel dizzy."))
				affected_mob.adjust_confusion(6 SECONDS)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_notice("You look at your hand. Your vision blurs."))
				affected_mob.set_eye_blur_if_lower(10 SECONDS)
		if(3)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("You feel a very sharp pain in your chest!"))
				if(prob(45))
					affected_mob.vomit(20,TRUE)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_userdanger("[pick("You feel your heart slowing...", "You relax and slow your heartbeat.")]"))
				affected_mob.adjustStaminaLoss(70, FALSE)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("You feel a buzzing in your brain."))
				SEND_SOUND(affected_mob, sound('sound/weapons/flash_ring.ogg'))
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.adjustBruteLoss(1)
		if(4)
			if(prob(30))
				affected_mob.playsound_local(affected_mob, 'sound/effects/singlebeat.ogg', 100, FALSE, use_reverb = FALSE)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("You feel a gruesome pain in your chest!"))
				if(prob(75))
					affected_mob.vomit(45,TRUE)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.adjustStaminaLoss(100, FALSE)
				affected_mob.visible_message(span_warning("[affected_mob] collapses!"))
				if(prob(30))
					to_chat(affected_mob, span_danger("Your vision blurs as you faint!"))
					affected_mob.AdjustSleeping(10)
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("[pick("You feel as though your atoms are accelerating in place.", "You feel like you're being torn apart!")]"))
				affected_mob.emote("scream")
				affected_mob.adjustBruteLoss(10)
		if(5)
			switch(rand(1,2))
				if(1)
					to_chat(affected_mob, span_notice("You feel your atoms begin to realign. You're safe. For now."))
					stage = 1
				if(2)
					to_chat(affected_mob, span_boldwarning("There is no place for you in this timeline."))
					affected_mob.adjustStaminaLoss(100, forced = TRUE)
					playsound(affected_mob.loc, 'sound/magic/repulse.ogg', 100, FALSE)
					affected_mob.emote("scream")
					for(var/mob/living/viewers in viewers(3, affected_mob.loc))
						viewers.flash_act()
					new /obj/effect/decal/cleanable/plasma(affected_mob.loc)
					new /obj/effect/decal/cleanable/ash(affected_mob.loc)
					affected_mob.visible_message(span_warning("[affected_mob] is erased from the timeline!"), span_userdanger("You are ripped from the timeline!"))
					affected_mob.investigate_log("has been dusted / deleted by [name].", INVESTIGATE_DEATHS)
					affected_mob.ghostize(can_reenter_corpse = FALSE)
					qdel(affected_mob)
