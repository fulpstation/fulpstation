/datum/religion_sect/earth
	name = "Earthen God"
	quote = "From the earth you came, to the earth you shall return."
	desc = "Bibles now recharge cyborgs and heal robotic limbs if targeted, but they \
	do not heal organic limbs. You can now sacrifice cells, with favor depending on their charge."
	tgui_icon = "robot"
	alignment = ALIGNMENT_NEUT
	desired_items = list(/obj/item/stock_parts/cell = "with battery charge")
	rites_list = list(/datum/religion_rites/synthconversion, /datum/religion_rites/machine_blessing)
	altar_icon_state = "convertaltar-blue"
	max_favor = 2500

/obj/item/organ/internal/heart/cybernetic/earth
	name = "pure heart"
	desc = "Lorem Ipsum."
	icon_state = "heart-c-u"
	organ_flags = ORGAN_SYNTHETIC
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	dose_available = FALSE
	emp_vulnerability = 0




//obj/item/organ/internal/heart/cybernetic/earth/Insert(mob/living/carbon/brain_owner, special, drop_if_replaced, no_id_transfer)
    //. = ..()
    //if(!ishuman(brain_owner))
   //     return
   // var/mob/living/carbon/human/human_receiver = brain_owner
   // var/datum/species/rec_species = human_receiver.dna.species
  //  rec_species.update_no_equip_flags(brain_owner, rec_species.no_equip_flags | ITEM_SLOT_FEET)

//obj/item/organ/internal/heart/cybernetic/earth/Remove(mob/living/carbon/brain_owner, special, no_id_transfer)
    //. = ..()
   // UnregisterSignal(brain_owner)
   // if(!ishuman(brain_owner))
   //     return
   // var/mob/living/carbon/human/human_receiver = brain_owner
   // var/datum/species/rec_species = human_receiver.dna.species
   // rec_species.update_no_equip_flags(brain_owner, initial(rec_species.no_equip_flags))
   // return ..()

/obj/effect/decal/cleanable/earthsblood
    name = "earthsblood"
    desc = "Life giving and warm."

/obj/effect/decal/cleanable/earthsblood/ex_act()
    return FALSE

/obj/effect/decal/cleanable/earthsblood/filled
    decal_reagent = /datum/reagent/medicine/earthsblood
    reagent_amount = 5
