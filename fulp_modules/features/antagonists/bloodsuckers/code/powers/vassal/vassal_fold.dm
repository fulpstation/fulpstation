/datum/action/bloodsucker/vassal_blood
	name = "Help Vassal"
	desc = "Bring an ex-Vassal back into the fold. RMB: Check Vassal status."
	button_icon_state = "power_torpor"
	power_explanation = "Help Vassal:\n\
		Use this power while you have an ex-Vassal grabbed to bring them back into the fold. \
		Right-Click will show the status of all Vassals."
	power_flags = NONE
	check_flags = NONE
	purchase_flags = NONE
	bloodcost = 10
	cooldown = 10 SECONDS

	///Bloodbag we have in our hands.
	var/obj/item/reagent_containers/blood/bloodbag
	///Weakref to a target we're bringing into the fold.
	var/datum/weakref/target_ref

/datum/action/bloodsucker/vassal_blood/CheckCanUse(mob/living/carbon/user, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/datum/antagonist/vassal/revenge/revenge_vassal = owner.mind.has_antag_datum(/datum/antagonist/ex_vassal)
	if(revenge_vassal)
		return FALSE

	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		return TRUE

	if(owner.pulling && isliving(owner.pulling))
		var/mob/living/pulled_target = owner.pulling
		var/datum/antagonist/ex_vassal/former_vassal = pulled_target.mind.has_antag_datum(/datum/antagonist/ex_vassal)
		if(former_vassal)
			owner.balloon_alert(owner, "not a former vassal!")
		target_ref = WEAKREF(owner.pulling)
		return TRUE

	var/blood_bag = locate(/obj/item/reagent_containers/blood) in user.held_items
	if(!blood_bag)
		owner.balloon_alert(owner, "blood bag needed!")
		return FALSE

	bloodbag = blood_bag
	return TRUE

/datum/action/bloodsucker/vassal_blood/ActivatePower(trigger_flags)
	. = ..()
	var/datum/antagonist/vassal/revenge/revenge_vassal = owner.mind.has_antag_datum(/datum/antagonist/ex_vassal)
	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		var/list/all_information = list()
		for(var/datum/antagonist/ex_vassal/former_vassals as anything in revenge_vassal.ex_vassals)
			var/information = "[former_vassals.owner.current]"
			information += " [round(COOLDOWN_TIMELEFT(former_vassals, blood_timer))] minutes left."
			if(former_vassals.owner.current.stat >= DEAD)
				information += " - DEAD."

			all_information += information

		to_chat(owner, "[all_information]")
		return

	if(target_ref)
		var/mob/living/target = target_ref.resolve()
		var/datum/antagonist/ex_vassal/former_vassal = target.mind.has_antag_datum(/datum/antagonist/ex_vassal)
		if(!former_vassal || former_vassal.revenge_vassal)
			target_ref = null
			return
		former_vassal.return_to_fold(revenge_vassal)
		target_ref = null
		return

	if(bloodbag)
		var/mob/living/living_owner = owner
		living_owner.blood_volume -= 150
		QDEL_NULL(bloodbag)
		var/obj/item/reagent_containers/blood/o_minus/bloodsucker/new_bag = new()
		owner.put_in_hand(new_bag)

///The bloodbag we make
/obj/item/reagent_containers/blood/o_minus/bloodsucker
	name = "blood pack"
	unique_blood = /datum/reagent/blood/bloodsucker
