/obj/item/organ/internal/brain/Insert(mob/living/carbon/C, special, drop_if_replaced, no_id_transfer)
	if(is_species(C, /datum/species/beefman))
		special = TRUE
	..(C, special, drop_if_replaced, no_id_transfer)
