/obj/item/organ/brain/beefman
	name = "minced-meat brain"
	desc = "The inexplicably functional brain of a beefman. Some parts seem beyond any dream of repair though..."

/obj/item/organ/brain/beefman/on_mob_insert(mob/living/carbon/organ_owner, special)
	. = ..()
	organ_owner.gain_trauma(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)

/obj/item/organ/brain/beefman/on_mob_remove(mob/living/carbon/organ_owner, special)
	organ_owner.gain_trauma(/datum/brain_trauma/special/bluespace_prophet/phobetor, TRAUMA_RESILIENCE_ABSOLUTE)
	return ..()

/obj/item/organ/tongue/beefman
	name = "meaty tongue"
	desc = "A meaty and thick muscle typically found in Beefmen."
	icon = 'fulp_modules/icons/species/mob/beef_tongue.dmi'
	icon_state = "beef_tongue"
	say_mod = "gurgles"
	taste_sensitivity = 15
	languages_native = list(/datum/language/russian)
	disliked_foodtypes = VEGETABLES | FRUIT | CLOTH
	liked_foodtypes = RAW | MEAT | FRIED
	toxic_foodtypes = DAIRY | PINEAPPLE
