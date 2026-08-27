/// Override to make the 'kitty ears' hat give brain damage
/obj/item/clothing/head/costume/kitty
	desc = "A pair of kitty ears. Meow! Prone to causing the user to behave more absent-minded."
	equip_delay_other = 20 MINUTES
	equip_delay_self = 5 SECONDS
	clothing_flags = SNUG_FIT
	clothing_traits = list(TRAIT_UNINTELLIGIBLE_SPEECH, TRAIT_CLUMSY, TRAIT_DUMB)

/obj/item/clothing/head/costume/kitty/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_DANGEROUS_EQUIP, INNATE_TRAIT)

/obj/item/clothing/head/costume/kitty/can_throw_equip(atom/hit_atom)
	return FALSE

/obj/item/clothing/head/costume/kitty/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_HEAD)
		return
	user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 100, 199)

/obj/item/clothing/head/costume/kitty/can_mob_unequip(mob/user)
	if(user.get_item_by_slot(slot_flags) == src)
		to_chat(user, span_warning("<b style='color:pink'>You feel unwilling to remove [src].</b>"))
		return FALSE
	return ..()
