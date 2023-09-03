/obj/item/organ/internal/brain/beefman
	name = "minced-meat brain"
	desc = "The inexplicably functional brain of a beefman. Some parts seem beyond any dream of repair though..."

/obj/item/organ/internal/brain/beefman/on_insert(mob/living/carbon/organ_owner, special)
	. = ..()
	if(organ_owner.dna.features["beef_trauma"])
		organ_owner.gain_trauma(organ_owner.dna.features["beef_trauma"], TRAUMA_RESILIENCE_ABSOLUTE)
	organ_owner.gain_trauma(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)

/obj/item/organ/internal/brain/beefman/on_remove(mob/living/carbon/organ_owner, special)
	if(organ_owner.dna.features["beef_trauma"])
		organ_owner.cure_trauma_type(organ_owner.dna.features["beef_trauma"], TRAUMA_RESILIENCE_ABSOLUTE)
	organ_owner.cure_trauma_type(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)
	return ..()
