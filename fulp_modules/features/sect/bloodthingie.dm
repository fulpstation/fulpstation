/obj/item/reagent_containers/syringe/earth
	name = "knife thing"
	desc = "A syringe that can hold up to 150 units."
	icon = 'icons/obj/medical/syringe.dmi'
	base_icon_state = "syringe"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "syringe_0"
	inhand_icon_state = "syringe_0"
	worn_icon_state = "pen"
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(5, 10, 15)
	volume = 15
	custom_materials = list(/datum/material/iron=10, /datum/material/glass=20)
	reagent_flags = TRANSPARENT
	custom_price = PAYCHECK_CREW * 0.5
	sharpness = SHARP_POINTY
	/// Flags used by the injection


/obj/item/reagent_containers/syringe/earth/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/reagent_containers/syringe/earth/attackby(obj/item/I, mob/user, params)
	return

/obj/item/reagent_containers/syringe/earth/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	if (!try_syringe(target, user, proximity_flag))
		return SECONDARY_ATTACK_CONTINUE_CHAIN
	if(target != user)
		to_chat(user, span_notice("[src] can only be used on yourself."))
		return SECONDARY_ATTACK_CONTINUE_CHAIN
	if(reagents.total_volume >= reagents.maximum_volume)
		to_chat(user, span_notice("[src] is full."))
		return SECONDARY_ATTACK_CONTINUE_CHAIN

	return SECONDARY_ATTACK_CONTINUE_CHAIN
