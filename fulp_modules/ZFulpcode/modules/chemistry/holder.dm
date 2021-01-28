/datum/reagents/metabolize(mob/living/carbon/C, can_overdose = FALSE, liverless = FALSE)
	var/list/cached_reagents = reagent_list
	var/list/cached_addictions = addiction_list
	if(C)
		expose_temperature(C.bodytemperature, 0.25)
	var/need_mob_update = 0
	for(var/reagent in cached_reagents)
		var/datum/reagent/R = reagent
		if(QDELETED(R.holder))
			continue

		if(!C)
			C = R.holder.my_atom

		//FULP EDIT ADDITION BEGIN
		if(ishuman(C))
			var/mob/living/carbon/human/H = C
			//Check if this mob's species is set and can process this type of reagent
			var/can_process = FALSE
			//If we somehow avoided getting a species or reagent_flags set, we'll assume we aren't meant to process ANY reagents
			if(H.dna && H.dna.species.reagent_flags)
				var/owner_flags = H.dna.species.reagent_flags
				if((R.process_flags & REAGENT_SYNTHETIC) && (owner_flags & PROCESS_SYNTHETIC))		//SYNTHETIC-oriented reagents require PROCESS_SYNTHETIC
					can_process = TRUE
				if((R.process_flags & REAGENT_ORGANIC) && (owner_flags & PROCESS_ORGANIC))		//ORGANIC-oriented reagents require PROCESS_ORGANIC
					can_process = TRUE

			//If the mob can't process it, remove the reagent at it's normal rate without doing any addictions, overdoses, or on_mob_life() for the reagent
			if(!can_process)
				R.holder.remove_reagent(R.type, R.metabolization_rate)
				continue
		//We'll assume that non-human mobs lack the ability to process synthetic-oriented reagents (adjust this if we need to change that assumption)
		else
			if(R.process_flags == REAGENT_SYNTHETIC)
				R.holder.remove_reagent(R.type, R.metabolization_rate)
				continue
		//FULP EDIT ADDITION END

		if(C && R)
			if(C.reagent_check(R) != TRUE)
				if(liverless && !R.self_consuming) //need to be metabolized
					continue
				if(!R.metabolizing)
					R.metabolizing = TRUE
					R.on_mob_metabolize(C)
				if(can_overdose)
					if(R.overdose_threshold)
						if(R.volume >= R.overdose_threshold && !R.overdosed)
							R.overdosed = TRUE
							need_mob_update += R.overdose_start(C)
							log_game("[key_name(C)] has started overdosing on [R.name] at [R.volume] units.")
					var/is_addicted_to = cached_addictions && is_type_in_list(R, cached_addictions)
					if(R.addiction_threshold)
						if(R.volume >= R.addiction_threshold && !is_addicted_to)
							var/datum/reagent/new_reagent = new R.addiction_type()
							LAZYADD(cached_addictions, new_reagent)
							is_addicted_to = TRUE
							log_game("[key_name(C)] has become addicted to [R.name] at [R.volume] units.")
					if(R.overdosed)
						need_mob_update += R.overdose_process(C)
					var/datum/reagent/addiction_type = new R.addiction_type()
					if(is_addicted_to)
						for(var/addiction in cached_addictions)
							var/datum/reagent/A = addiction
							if(istype(addiction_type, A))
								A.addiction_stage = -15 // you're satisfied for a good while.
				need_mob_update += R.on_mob_life(C)

	if(can_overdose)
		if(addiction_tick == 6)
			addiction_tick = 1
			for(var/addiction in cached_addictions)
				var/datum/reagent/R = addiction
				if(!C)
					break
				R.addiction_stage++
				switch(R.addiction_stage)
					if(1 to 10)
						need_mob_update += R.addiction_act_stage1(C)
					if(10 to 20)
						need_mob_update += R.addiction_act_stage2(C)
					if(20 to 30)
						need_mob_update += R.addiction_act_stage3(C)
					if(30 to 40)
						need_mob_update += R.addiction_act_stage4(C)
					if(40 to INFINITY)
						remove_addiction(R)
					else
						SEND_SIGNAL(C, COMSIG_CLEAR_MOOD_EVENT, "[R.type]_overdose")
		addiction_tick++
	if(C && need_mob_update) //some of the metabolized reagents had effects on the mob that requires some updates.
		C.updatehealth()
		C.update_stamina()
	update_total()
