/datum/reagent/saltpetre/on_mob_metabolize(mob/living/carbon/affected_mob)
	if(isbeefman(affected_mob))
		var/datum/species/beefman/beef_species = affected_mob.dna.species
		if(!beef_species.dehydrated || prob(10))
			to_chat(affected_mob, span_alert("Your beefy mouth tastes dry."))
		beef_species.dehydrated++
	return ..()

/datum/reagent/consumable/salt/on_mob_metabolize(mob/living/carbon/affected_mob)
	if(isbeefman(affected_mob))
		var/datum/species/beefman/beef_species = affected_mob.dna.species
		if(!beef_species.dehydrated || prob(10))
			to_chat(affected_mob, span_alert("Your beefy mouth tastes dry."))
		beef_species.dehydrated++
	return ..()
