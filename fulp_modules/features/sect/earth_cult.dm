/datum/religion_sect/earth
	name = "Earthen God"
	quote = "From the earth you came; to the earth you shall return."
	desc = "The Earth is alive and loves her children. Even here you can feel her heartbeat under your feet."
	tgui_icon = "robot"
	alignment = ALIGNMENT_NEUT
	desired_items = list(/obj/item/reagent_containers = "holding blood", /mob/living/basic/cow/bull,)
	rites_list = list(/datum/religion_rites/pure_heart, /datum/religion_rites/big_cow, /datum/religion_rites/bull_sacrifice)
	altar_icon_state = "convertaltar-blue"
	max_favor = 10000

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
	var/mob/living/basic/cow/bull/chosen_sacrifice

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
	for(var/mob/living/basic/cow/bull/alleged_cow in movable_reltool.buckled_mobs)
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
	to_chat(user, span_notice("[GLOB.deity] consumes the bull and is nourished by its blood. [GLOB.deity] rewards you with [favor_gained] favor."))
	chosen_sacrifice.dust(force = TRUE)
	playsound(get_turf(religious_tool), 'sound/items/drink.ogg', 50, TRUE)
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
	new /mob/living/basic/cow/bull(altar_turf)
	//playsound(get_turf(religious_tool), 'sound/effects/cashregister.ogg', 60, TRUE)
	return TRUE
