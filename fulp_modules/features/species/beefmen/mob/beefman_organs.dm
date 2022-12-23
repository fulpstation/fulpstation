/obj/item/organ/internal/brain/beefman
	name = "Minced-meat brain"
	desc = "The inexplicably functional brain of a beefman. Some sections are damaged beyond any dreams of repair..."

/obj/item/organ/internal/brain/beefman/Insert(mob/living/carbon/C, special, drop_if_replaced, no_id_transfer)
	..()
	if(C.dna.features["beef_trauma"])
		var/datum/brain_trauma/preference = C.dna.features["beef_trauma"]
		preference.resilience = TRAUMA_RESILIENCE_ABSOLUTE
		add_trauma_to_traumas(preference)
	var/datum/brain_trauma/tears = new /datum/brain_trauma/special/bluespace_prophet
	tears.resilience = TRAUMA_RESILIENCE_ABSOLUTE
	add_trauma_to_traumas(tears)

