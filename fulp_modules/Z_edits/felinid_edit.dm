/// Override to make the 'kitty ears' hat give brain damage
/obj/item/clothing/head/costume/kitty
	desc = "A pair of kitty ears. Meow! Prone to causing the user to behave more absent-minded."
	equip_delay_other = 20 MINUTES
	equip_delay_self = 5 SECONDS
	clothing_flags = SNUG_FIT | ANTI_TINFOIL_MANEUVER | DANGEROUS_OBJECT
	clothing_traits = list(TRAIT_UNINTELLIGIBLE_SPEECH, TRAIT_CLUMSY, TRAIT_DUMB)

/obj/item/clothing/head/costume/kitty/proc/at_peace_check(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/carbon_user = user
		if(src == carbon_user.head)
			to_chat(user, span_warning("<b style='color:pink'>You feel unwilling to remove [src].</b>"))
			return TRUE
	return FALSE

/obj/item/clothing/head/costume/kitty/attack_hand(mob/user, list/modifiers)
	if(at_peace_check(user))
		return
	return ..()

/obj/item/clothing/head/costume/kitty/mouse_drop_dragged(atom/over_object, mob/user, src_location, over_location, params)
	if(at_peace_check(user))
		return
	return ..()

/obj/item/clothing/head/costume/kitty/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_HEAD)
		return
	user.adjustOrganLoss(ORGAN_SLOT_BRAIN, 100, 199)
