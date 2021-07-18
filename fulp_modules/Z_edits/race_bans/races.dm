/datum/species/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	//if(is_banned_from(C.ckey, src.id))
	if(src.id != SPECIES_HUMAN)
		addtimer(CALLBACK(C, /mob/living/carbon/proc/banned_species_revert), 5 SECONDS)
		return
	. = ..()

/// Made into an individual proc to ensure that the to_chat message would always show to users. Sometimes it would not appear during roundstart as it would be sent too soon.
/mob/living/carbon/proc/banned_species_revert()
	to_chat(src, span_alert("You are currently banned from playing this race. Please review any ban messages you have received, and contact admins if you believe this is a mistake."))
	src.set_species(/datum/species/human)
