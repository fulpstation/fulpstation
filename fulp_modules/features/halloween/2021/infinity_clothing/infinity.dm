/**
 * Infinity Suit
 * From: Lisa: The Pointless
 * By: BoltonsHead
 */

///Jersey
/obj/item/clothing/suit/costume_2021/infinity_jersey
	name = "infinity jersey"
	desc = "A jersey labelled '88', somehow leaving a threatening aura around it."
	icon_state = "infinity_jersey"

///Shorts
/obj/item/clothing/under/costume_2021/infinity_shorts
	name = "infinity shorts"
	desc = "Though usually covered up by a jersey, these are it's on own level of threatening."
	icon_state = "infinity_shorts"
	body_parts_covered = CHEST|GROIN|LEGS
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE

///Wristbands - Makes you punch slightly better, nothing worth going out of your way to get.
/obj/item/clothing/gloves/costume_2021/infinity_wristbands
	name = "infinity wristbands"
	desc = "After being used in many, many fist fights, these bands somehow are still usable."
	icon_state = "infinity_wrist"

/obj/item/clothing/gloves/costume_2021/infinity_wristbands/equipped(mob/living/carbon/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot == ITEM_SLOT_GLOVES)
		user.dna.species.punchdamagelow += 0.2
		user.dna.species.punchdamagehigh += 0.1

/obj/item/clothing/gloves/costume_2021/infinity_wristbands/dropped(mob/living/carbon/user)
	. = ..()
	if(!ishuman(user))
		return
	if(user.get_item_by_slot(ITEM_SLOT_GLOVES) == src)
		user.dna.species.punchdamagelow -= 0.2
		user.dna.species.punchdamagehigh -= 0.1

///Shoes
/obj/item/clothing/shoes/costume_2021/infinity_shoes
	name = "infinity shoes"
	desc = "Shoes made for walking over the blood of your enemies."
	icon_state = "infinity_shoes"

/obj/item/storage/box/halloween/edition_21/infinity
	theme_name = "2021's Infinity"
	costume_contents = list(
		/obj/item/clothing/suit/costume_2021/infinity_jersey,
		/obj/item/clothing/under/costume_2021/infinity_shorts,
		/obj/item/clothing/gloves/costume_2021/infinity_wristbands,
		/obj/item/clothing/shoes/costume_2021/infinity_shoes,
	)
