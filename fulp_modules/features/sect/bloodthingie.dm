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
	possible_transfer_amounts = 150
	volume = 150
	custom_materials = list(/datum/material/iron=10, /datum/material/glass=20)
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

	if(reagents.total_volume >= reagents.maximum_volume)
		to_chat(user, span_notice("[src] is full."))
		return SECONDARY_ATTACK_CONTINUE_CHAIN

	if(isliving(target))
		var/mob/living/living_target = target
		var/drawn_amount = reagents.maximum_volume - reagents.total_volume
		if(target != user)
			to_chat(user, span_notice("[src] can only be used on yourself."))
			return SECONDARY_ATTACK_CONTINUE_CHAIN
		if(reagents.total_volume >= reagents.maximum_volume)
			return SECONDARY_ATTACK_CONTINUE_CHAIN
		if(living_target.transfer_blood_to(src, drawn_amount))
			user.visible_message(span_notice("[user] takes a blood sample from [living_target]."))
		else
			to_chat(user, span_warning("You are unable to draw any blood from [living_target]!"))
	else
		if(!target.reagents.total_volume)
			to_chat(user, span_warning("[target] is empty!"))
			return SECONDARY_ATTACK_CONTINUE_CHAIN

		if(!target.is_drawable(user))
			to_chat(user, span_warning("You cannot directly remove reagents from [target]!"))
			return SECONDARY_ATTACK_CONTINUE_CHAIN

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user) // transfer from, transfer to - who cares?

		to_chat(user, span_notice("You fill [src] with [trans] units of the solution. It now contains [reagents.total_volume] units."))
		target.update_appearance()

	return SECONDARY_ATTACK_CONTINUE_CHAIN
