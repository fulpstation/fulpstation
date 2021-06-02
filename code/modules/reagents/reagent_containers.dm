/obj/item/reagent_containers
	name = "Container"
	desc = "..."
	icon = 'icons/obj/chemical.dmi'
	icon_state = null
	w_class = WEIGHT_CLASS_TINY
	var/amount_per_transfer_from_this = 5
	var/list/possible_transfer_amounts = list(5,10,15,20,25,30)
	var/volume = 30
	var/reagent_flags
	var/list/list_reagents = null
	var/spawned_disease = null
	var/disease_amount = 20
	var/spillable = FALSE
	var/list/fill_icon_thresholds = null
	var/fill_icon_state = null // Optional custom name for reagent fill icon_state prefix

/obj/item/reagent_containers/Initialize(mapload, vol)
	. = ..()
	if(isnum(vol) && vol > 0)
		volume = vol
	create_reagents(volume, reagent_flags)
	if(spawned_disease)
		var/datum/disease/F = new spawned_disease()
		var/list/data = list("viruses"= list(F))
		reagents.add_reagent(/datum/reagent/blood, disease_amount, data)

	add_initial_reagents()

/obj/item/reagent_containers/create_reagents(max_vol, flags)
	. = ..()
	RegisterSignal(reagents, list(COMSIG_REAGENTS_NEW_REAGENT, COMSIG_REAGENTS_ADD_REAGENT, COMSIG_REAGENTS_DEL_REAGENT, COMSIG_REAGENTS_REM_REAGENT), .proc/on_reagent_change)
	RegisterSignal(reagents, COMSIG_PARENT_QDELETING, .proc/on_reagents_del)

/obj/item/reagent_containers/attack(mob/living/M, mob/living/user, params)
	if (!user.combat_mode)
		return
	return ..()

/obj/item/reagent_containers/proc/on_reagents_del(datum/reagents/reagents)
	SIGNAL_HANDLER
	UnregisterSignal(reagents, list(COMSIG_REAGENTS_NEW_REAGENT, COMSIG_REAGENTS_ADD_REAGENT, COMSIG_REAGENTS_DEL_REAGENT, COMSIG_REAGENTS_REM_REAGENT, COMSIG_PARENT_QDELETING))
	return NONE

/obj/item/reagent_containers/proc/add_initial_reagents()
	if(list_reagents)
		reagents.add_reagent_list(list_reagents)

/obj/item/reagent_containers/attack_self(mob/user)
	if(possible_transfer_amounts.len)
		var/i=0
		for(var/A in possible_transfer_amounts)
			i++
			if(A == amount_per_transfer_from_this)
				if(i<possible_transfer_amounts.len)
					amount_per_transfer_from_this = possible_transfer_amounts[i+1]
				else
					amount_per_transfer_from_this = possible_transfer_amounts[1]
				balloon_alert(user, "Transferring [amount_per_transfer_from_this]u")
				return

/obj/item/reagent_containers/pre_attack_secondary(atom/target, mob/living/user, params)
	if(HAS_TRAIT(target, DO_NOT_SPLASH))
		return ..()
	if (try_splash(user, target))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	return ..()

/// Tries to splash the target. Used on both right-click and normal click when in combat mode.
/obj/item/reagent_containers/proc/try_splash(mob/user, atom/target)
	if (!spillable)
		return FALSE

	if (!reagents?.total_volume)
		return FALSE

	var/punctuation = ismob(target) ? "!" : "."

	var/reagent_text
	user.visible_message(
		"<span class='danger'>[user] splashes the contents of [src] onto [target][punctuation]</span>",
		"<span class='danger'>You splash the contents of [src] onto [target][punctuation]</span>",
		ignored_mobs = target,
	)

	if (ismob(target))
		var/mob/target_mob = target
		target_mob.show_message(
			"<span class='userdanger'>[user] splash the contents of [src] onto you!</span>",
			MSG_VISUAL,
			"<span class='userdanger'>You feel drenched!</span>",
		)

	for(var/datum/reagent/reagent as anything in reagents.reagent_list)
		reagent_text += "[reagent] ([num2text(reagent.volume)]),"

	if(isturf(target) && reagents.reagent_list.len && thrownby)
		log_combat(thrownby, target, "splashed (thrown) [english_list(reagents.reagent_list)]")
		message_admins("[ADMIN_LOOKUPFLW(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] at [ADMIN_VERBOSEJMP(target)].")

	reagents.expose(target, TOUCH)
	log_combat(user, target, "splashed", reagent_text)
	reagents.clear_reagents()

	return TRUE

/obj/item/reagent_containers/proc/canconsume(mob/eater, mob/user)
	if(!iscarbon(eater))
		return FALSE
	var/mob/living/carbon/C = eater
	var/covered = ""
	if(C.is_mouth_covered(head_only = 1))
		covered = "headgear"
	else if(C.is_mouth_covered(mask_only = 1))
		covered = "mask"
	if(covered)
		var/who = (isnull(user) || eater == user) ? "your" : "[eater.p_their()]"
		to_chat(user, "<span class='warning'>You have to remove [who] [covered] first!</span>")
		return FALSE
	return TRUE

/*
 * On accidental consumption, transfer a portion of the reagents to the eater and the item it's in, then continue to the base proc (to deal with shattering glass containers)
 */
/obj/item/reagent_containers/on_accidental_consumption(mob/living/carbon/M, mob/living/carbon/user, obj/item/source_item,  discover_after = TRUE)
	M.losebreath += 2
	reagents?.trans_to(M, min(15, reagents.total_volume / rand(5,10)), transfered_by = user, methods = INGEST)
	if(source_item?.reagents)
		reagents.trans_to(source_item, min(source_item.reagents.total_volume / 2, reagents.total_volume / 5), transfered_by = user, methods = TOUCH)

	return ..()

/obj/item/reagent_containers/ex_act(severity)
	if(reagents)
		for(var/datum/reagent/R in reagents.reagent_list)
			R.on_ex_act(severity)
	if(!QDELETED(src))
		return ..()

/obj/item/reagent_containers/fire_act(exposed_temperature, exposed_volume)
	reagents.expose_temperature(exposed_temperature)
	..()

/obj/item/reagent_containers/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	SplashReagents(hit_atom, TRUE)

/obj/item/reagent_containers/proc/bartender_check(atom/target)
	. = FALSE
	if(target.CanPass(src, get_turf(src)) && thrownby && HAS_TRAIT(thrownby, TRAIT_BOOZE_SLIDER))
		. = TRUE

/obj/item/reagent_containers/proc/SplashReagents(atom/target, thrown = FALSE, override_spillable = FALSE)
	if(!reagents || !reagents.total_volume || (!spillable && !override_spillable))
		return

	if(ismob(target) && target.reagents)
		if(thrown)
			reagents.total_volume *= rand(5,10) * 0.1 //Not all of it makes contact with the target
		var/mob/M = target
		var/R
		target.visible_message("<span class='danger'>[M] is splashed with something!</span>", \
						"<span class='userdanger'>[M] is splashed with something!</span>")
		for(var/datum/reagent/A in reagents.reagent_list)
			R += "[A.type]  ([num2text(A.volume)]),"

		if(thrownby)
			log_combat(thrownby, M, "splashed", R)
		reagents.expose(target, TOUCH)

	else if(bartender_check(target) && thrown)
		visible_message("<span class='notice'>[src] lands onto the [target.name] without spilling a single drop.</span>")
		return

	else
		if(isturf(target) && reagents.reagent_list.len && thrownby)
			log_combat(thrownby, target, "splashed (thrown) [english_list(reagents.reagent_list)]", "in [AREACOORD(target)]")
			log_game("[key_name(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] in [AREACOORD(target)].")
			message_admins("[ADMIN_LOOKUPFLW(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] in [ADMIN_VERBOSEJMP(target)].")
		visible_message("<span class='notice'>[src] spills its contents all over [target].</span>")
		reagents.expose(target, TOUCH)
		if(QDELETED(src))
			return

	reagents.clear_reagents()

/obj/item/reagent_containers/microwave_act(obj/machinery/microwave/M)
	reagents.expose_temperature(1000)
	..()

/obj/item/reagent_containers/fire_act(temperature, volume)
	reagents.expose_temperature(temperature)

/// Updates the icon of the container when the reagents change. Eats signal args
/obj/item/reagent_containers/proc/on_reagent_change(datum/reagents/holder, ...)
	SIGNAL_HANDLER
	update_appearance()
	return NONE

/obj/item/reagent_containers/update_overlays()
	. = ..()
	if(!fill_icon_thresholds)
		return
	if(!reagents.total_volume)
		return

	var/fill_name = fill_icon_state? fill_icon_state : icon_state
	var/mutable_appearance/filling = mutable_appearance('icons/obj/reagentfillings.dmi', "[fill_name][fill_icon_thresholds[1]]")

	var/percent = round((reagents.total_volume / volume) * 100)
	for(var/i in 1 to fill_icon_thresholds.len)
		var/threshold = fill_icon_thresholds[i]
		var/threshold_end = (i == fill_icon_thresholds.len)? INFINITY : fill_icon_thresholds[i+1]
		if(threshold <= percent && percent < threshold_end)
			filling.icon_state = "[fill_name][fill_icon_thresholds[i]]"

	filling.color = mix_color_from_reagents(reagents.reagent_list)
	. += filling
