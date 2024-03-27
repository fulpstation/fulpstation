/datum/status_effect/eldritch/beef
	effect_icon_state = "emark1"

/datum/status_effect/eldritch/beef/on_effect()
	if(iscarbon(owner))
		var/mob/living/carbon/carbon_victim = owner
		var/datum/dna/victim_dna = carbon_victim.has_dna()
		if(victim_dna)
			if(!istype(victim_dna.species, /datum/species/beefman))
				carbon_victim.set_species(/datum/species/beefman)
				to_chat(owner, span_warning("Congratulations! You've become a beefman."))
				owner.add_mood_event("became beefman", /datum/mood_event/beef_blessing)
				return ..()

	//make meat tiles around
	for(var/turf/affected_turf in range(1, get_turf(owner)))
		var/datum/dimension_theme/theme = new /datum/dimension_theme/meat/fool_heretic()
		theme.apply_theme(affected_turf, show_effect = FALSE)

	return ..()

/datum/mood_event/beef_blessing
	description = "Oh hell yes. Oh fuck yes."
	mood_change = 6
