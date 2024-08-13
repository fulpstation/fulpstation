/datum/species/human/felinid
	changesource_flags = MIRROR_BADMIN | MIRROR_PRIDE | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	var/brain_damage_to_give = 199
	var/give_traumas = TRUE

/datum/species/human/felinid/nobraindamage
	name = "Felinid Good Brain"
	id = "felinid-nobraindamage"
	changesource_flags = MIRROR_BADMIN | MIRROR_MAGIC | ERT_SPAWN
	brain_damage_to_give = 0
	give_traumas = FALSE

/datum/species/human/felinid/on_species_gain(mob/living/carbon/felifriend, datum/species/old_species, pref_load)
	. = ..()
	if(istype(felifriend, /mob/living/carbon/human/consistent) || isdummy(felifriend))
		return
	if(brain_damage_to_give)
		felifriend.setOrganLoss(ORGAN_SLOT_BRAIN, brain_damage_to_give) //Fuck you
	if(give_traumas)
		felifriend.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY) //Fuck you even more
		felifriend.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_LOBOTOMY)

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

/obj/item/clothing/head/costume/kitty/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)
	if(at_peace_check(usr))
		return
	return ..()

/obj/item/clothing/head/costume/kitty/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_HEAD)
		return
	user.adjustOrganLoss(ORGAN_SLOT_BRAIN, 100, 199)

/mob/living/carbon/human/species/felinid
	race = /datum/species/human/felinid/nobraindamage
