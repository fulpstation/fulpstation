/obj/item/organ/internal/heart/cybernetic/earth
	name = "pure heart"
	desc = "A pure, undying heart that beats in time with the Earth's."
	icon = 'fulp_modules/features/sect/earth-cult.dmi'
	icon_state = "heart-on"
	organ_flags = ORGAN_SYNTHETIC
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	dose_available = FALSE
	emp_vulnerability = 0



/obj/item/organ/internal/heart/cybernetic/earth/Insert(mob/living/carbon/heart_owner, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	ADD_TRAIT(heart_owner, TRAIT_SPIRITUAL, ORGAN_TRAIT)
	ADD_TRAIT(heart_owner, TRAIT_VIRUSIMMUNE, ORGAN_TRAIT)
	RegisterSignal(GLOB.great_aurochs, COMSIG_LIVING_DEATH, PROC_REF(aurochs_death))
	owner.faction |= "earth"


/obj/item/organ/internal/heart/cybernetic/earth/Remove(mob/living/carbon/heart_owner, special = FALSE)
	REMOVE_TRAIT(heart_owner, TRAIT_SPIRITUAL, ORGAN_TRAIT)
	REMOVE_TRAIT(heart_owner, TRAIT_VIRUSIMMUNE, ORGAN_TRAIT)
	UnregisterSignal(GLOB.great_aurochs, COMSIG_LIVING_DEATH, PROC_REF(aurochs_death))
	owner.faction -= "earth"
	return ..()

/obj/item/organ/internal/heart/cybernetic/earth/on_life(mob/living/carbon/heart_owner, )
	if(istype(get_turf(owner), /turf/open/floor/grass))
		owner.set_timed_status_effect(2 SECONDS, /datum/status_effect/speed_boost, only_if_higher = TRUE)
	return ..()

/obj/item/organ/internal/heart/cybernetic/earth/Insert(mob/living/carbon/brain_owner, special, drop_if_replaced, no_id_transfer)
    . = ..()
    if(!ishuman(brain_owner))
        return
    var/mob/living/carbon/human/human_receiver = brain_owner
    var/datum/species/rec_species = human_receiver.dna.species
    rec_species.update_no_equip_flags(brain_owner, rec_species.no_equip_flags | ITEM_SLOT_FEET)

/obj/item/organ/internal/heart/cybernetic/earth/Remove(mob/living/carbon/brain_owner, special, no_id_transfer)
    . = ..()
    if(!ishuman(brain_owner))
        return
    var/mob/living/carbon/human/human_receiver = brain_owner
    var/datum/species/rec_species = human_receiver.dna.species
    rec_species.update_no_equip_flags(brain_owner, initial(rec_species.no_equip_flags))
    return ..()
