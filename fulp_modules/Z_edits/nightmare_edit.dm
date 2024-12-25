/obj/item/organ/brain/shadow/nightmare/on_mob_insert(mob/living/carbon/brain_owner)
	if(brain_owner.mind?.has_antag_datum(/datum/antagonist/nightmare)) //Only affect actual nightmares.
		//removes the nightmare's literacy, advanvedtooluser, and adds primitive.
		organ_traits = list(TRAIT_CAN_STRIP, TRAIT_PRIMITIVE)
	return ..()
