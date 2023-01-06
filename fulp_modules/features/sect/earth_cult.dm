/datum/religion_sect/earth
	name = "Earthen God"
	quote = "From the earth you came; to the earth you shall return."
	desc = "The Earth is alive and loves her children. Even here you can feel her heartbeat under your feet."
	tgui_icon = "robot"
	alignment = ALIGNMENT_NEUT
	desired_items = list(/obj/item/reagent_containers = "holding blood", /mob/living/basic/bull)
	rites_list = list(/datum/religion_rites/pure_heart, /datum/religion_rites/big_cow, /datum/religion_rites/bull_sacrifice)
	altar_icon_state = "convertaltar-blue"
	max_favor = 10000

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
	owner.faction |= "earth"


/obj/item/organ/internal/heart/cybernetic/earth/Remove(mob/living/carbon/heart_owner, special = FALSE)
	REMOVE_TRAIT(heart_owner, TRAIT_SPIRITUAL, ORGAN_TRAIT)
	REMOVE_TRAIT(heart_owner, TRAIT_VIRUSIMMUNE, ORGAN_TRAIT)
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
    UnregisterSignal(brain_owner)
    if(!ishuman(brain_owner))
        return
    var/mob/living/carbon/human/human_receiver = brain_owner
    var/datum/species/rec_species = human_receiver.dna.species
    rec_species.update_no_equip_flags(brain_owner, initial(rec_species.no_equip_flags))
    return ..()

/obj/effect/decal/cleanable/earthsblood
    name = "earthsblood"
    desc = "Life giving and warm."

/obj/effect/decal/cleanable/earthsblood/ex_act()
    return FALSE

/obj/effect/decal/cleanable/earthsblood/filled
    decal_reagent = /datum/reagent/medicine/earthsblood
    reagent_amount = 5

/datum/religion_sect/earth/sect_bless(mob/living/target, mob/living/chap)
	return TRUE

/datum/religion_sect/earth/on_sacrifice(obj/item/reagent_containers/offering, mob/living/user)
	if(!istype(offering))
		return
	//var/datum/reagent/blood/wanted_blood = offering.reagents.has_reagent(/datum/reagent/blood)
	var/favor_earned = offering.reagents.get_reagent_amount(/datum/reagent/blood)
	to_chat(user, span_notice("[GLOB.deity] appreciates your blood offering."))
	adjust_favor(favor_earned, user)
	playsound(get_turf(offering), 'sound/items/drink.ogg', 50, TRUE)
	offering.reagents.clear_reagents()
	return TRUE

/datum/religion_rites/pure_heart
	name = "Trade hearts with Mother Earth."
	desc = "Summons a pure heart. Replace your corrupted heart with it to become one with the Earth."
	invoke_msg = "Let us trade hearts, Mother Earth."
	favor_cost = 150

/datum/religion_rites/pure_heart/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	var/altar_turf = get_turf(religious_tool)
	new /obj/item/organ/internal/heart/cybernetic/earth(altar_turf)
	//playsound(get_turf(religious_tool), 'sound/effects/cashregister.ogg', 60, TRUE)
	return TRUE

/datum/religion_rites/bull_sacrifice
	name = "Bull sacrifice"
	desc = "put a fucking cow on the altar."
	ritual_length = 5 SECONDS
	ritual_invocations = list("This fearless bull ...",
	"... blood for the earth  ...",
	"... sacred cuts ...")
	invoke_msg = "... nourish our Mother "
	var/mob/living/basic/bull/chosen_sacrifice

/datum/religion_rites/bull_sacrifice/perform_rite(mob/living/user, atom/religious_tool)
	if(!ismovable(religious_tool))
		to_chat(user, span_warning("This rite requires a religious device that individuals can be buckled to."))
		return FALSE
	var/atom/movable/movable_reltool = religious_tool
	if(!movable_reltool)
		return FALSE
	if(!LAZYLEN(movable_reltool.buckled_mobs))
		to_chat(user, span_warning("Nothing is buckled to the altar!"))
		return FALSE
	for(var/mob/living/basic/bull/alleged_cow in movable_reltool.buckled_mobs)
		if(alleged_cow.stat != DEAD)
			to_chat(user, span_warning("You can only sacrifice dead bulls. This one is still alive!"))
			return FALSE
		chosen_sacrifice = alleged_cow
		return ..()

/datum/religion_rites/bull_sacrifice/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	if(!(chosen_sacrifice in religious_tool.buckled_mobs))
		to_chat(user, span_warning("The right sacrifice is no longer on the altar!"))
		chosen_sacrifice = null
		return FALSE
	if(chosen_sacrifice.stat != DEAD)
		to_chat(user, span_warning("The sacrifice has to stay dead for the rite to work!"))
		chosen_sacrifice = null
		return FALSE
	var/favor_gained = 1000
	GLOB.religious_sect.adjust_favor(favor_gained, user)
	to_chat(user, span_notice("[GLOB.deity] absorbs the burning corpse and any trace of fire with it. [GLOB.deity] rewards you with [favor_gained] favor."))
	chosen_sacrifice.dust(force = TRUE)
	playsound(get_turf(religious_tool), 'sound/effects/supermatter.ogg', 50, TRUE)
	chosen_sacrifice = null
	return TRUE

/datum/religion_rites/big_cow
	name = "Big cow time."
	desc = "Summons a mother fucking cow"
	invoke_msg = "big beefy boy"
	favor_cost = 8000

/datum/religion_rites/big_cow/invoke_effect(mob/living/user, atom/movable/religious_tool)
	..()
	var/altar_turf = get_turf(religious_tool)
	new /mob/living/basic/bull(altar_turf)
	//playsound(get_turf(religious_tool), 'sound/effects/cashregister.ogg', 60, TRUE)
	return TRUE

