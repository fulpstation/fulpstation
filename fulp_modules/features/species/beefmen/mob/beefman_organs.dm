/obj/item/organ/internal/brain/beefman
	name = "minced-meat brain"
	desc = "The inexplicably functional brain of a beefman. Some parts seem beyond any dream of repair though..."

/obj/item/organ/internal/brain/beefman/Insert(mob/living/carbon/C, special, drop_if_replaced, no_id_transfer)
	var/creating_traumas = TRUE
	for(var/datum/brain_trauma/trauma in traumas)
		if(istype(trauma, /datum/brain_trauma/special/bluespace_prophet/phobetor))
			creating_traumas = FALSE
	if(creating_traumas)
		if(C.dna.features["beef_trauma"])
			C.gain_trauma(C.dna.features["beef_trauma"], TRAUMA_RESILIENCE_ABSOLUTE)
		C.gain_trauma(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)
	. = ..()
