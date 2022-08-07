/obj/item/adv_mulligan
	name = "advanced mulligan"
	desc = "A one use autoinjector with a toxin that permanently changes your DNA to the DNA of a previously injected person. Use it on the victim to extract their DNA then inject it into yourself!"
	icon = 'icons/obj/syringe.dmi'
	icon_state = "dnainjector0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	var/used = FALSE ///determines wether the injector is used up or nah
	var/datum/weakref/store  ///the mob currently stored in the injector

/obj/item/adv_mulligan/afterattack(atom/movable/victim, mob/living/carbon/human/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(!istype(user))
		return
	if(used)
		to_chat(user, span_warning("[src] has been already used, you can't activate it again!"))
		return
	if(ishuman(victim))
		var/mob/living/carbon/human/target = victim
		if(user.real_name != target.dna.real_name)
			store = WEAKREF(target)
			to_chat(user, span_notice("You stealthly stab [target.name] with [src]."))
			icon_state = "dnainjector"
		else
			if(store)
				mutate(user)
			else
				to_chat(user, span_notice("You can't stab yourself with [src]!"))

/obj/item/adv_mulligan/attack_self(mob/living/carbon/user)
	mutate(user)

/obj/item/adv_mulligan/proc/mutate(mob/living/carbon/user)
	if(used)
		to_chat(user, span_notice("[src] has been already used, you can't activate it again!"))
		return
	if(!store)
		to_chat(user, span_notice("[src] doesn't have any DNA loaded in it!"))
		return

	if(!do_after(user, 2 SECONDS))
		return

	var/mob/living/carbon/human/stored = store.resolve()

	user.visible_message(span_warning("[user.name] shivers in pain and soon transforms into [stored.dna.real_name]!"), \
		span_notice("You inject yourself with [src] and suddenly become a copy of [stored.dna.real_name]."))

	user.real_name = stored.real_name
	stored.dna.transfer_identity(user, transfer_SE=1)
	user.updateappearance(mutcolor_update=1)
	user.domutcheck()
	used = TRUE

	icon_state = "dnainjector0"
	store = null

/obj/item/adv_mulligan/examine(mob/user)
	. = ..()
	if (used)
		. += "This one is all used up."


/obj/item/infiltrator_radio
	name = "Infiltrator Radio"
	desc = "How is this thing running without a battery?"
	icon = 'fulp_modules/features/antagonists/infiltrators/icons/infils.dmi'
	icon_state = "infiltrator_radio"
	w_class = WEIGHT_CLASS_SMALL
	///has the player claimed all his objectives' rewards?
	var/objectives_complete = FALSE
	///List of objectives we have already checked
	var/list/checked_objectives = list()
	///Pool of rewards
	var/reward_items = list(
		/obj/item/card/emag,
		/obj/item/card/emag/doorjack,
		/obj/item/grenade/syndieminibomb,
		/obj/item/grenade/c4/x4,
		/obj/item/pen/edagger,
		/obj/item/guardiancreator/tech/choose/traitor,
		/obj/item/jammer,
		/obj/item/reagent_containers/hypospray/medipen/stimulants,
		/obj/item/storage/box/syndie_kit/imp_stealth,
	)
	///determines wether the final objective is a dagd or not
	var/dagd = FALSE

/obj/item/infiltrator_radio/Initialize(mapload)
	. = ..()
	add_overlay("infiltrator_radio_overlay")

/obj/item/infiltrator_radio/proc/check_reward_status(mob/living/user)
	for(var/datum/objective/goal in user.mind.get_all_objectives())
		if(goal.check_completion() && !(goal.explanation_text in checked_objectives))
			return goal
	return FALSE

/obj/item/infiltrator_radio/proc/give_reward(mob/living/user)
	var/datum/objective/addobj = check_reward_status(user)
	checked_objectives += addobj.explanation_text
	var/reward = pick(reward_items)
	podspawn(list(
		"target" = get_turf(user),
		"style" = STYLE_SYNDICATE,
		"spawn" = reward,
		))
	log_uplink("[key_name(user)] received \a [reward] through [src].")
	reward_items -= reward //cant get duplicate rewards
	var/list/bitch = user.mind.get_all_objectives()
	if(checked_objectives.len == bitch.len)
		objectives_complete = TRUE
		var/datum/objective/reward_obj
		if(prob(60))
			reward_obj = new /datum/objective/hijack
		else
			reward_obj = new /datum/objective/martyr
			dagd = TRUE
		reward_obj.owner = user.mind
		for(var/datum/antagonist/traitor/infiltrator/antag_datum in user.mind.antag_datums)
			antag_datum.objectives += reward_obj


/obj/item/infiltrator_radio/ui_interact(mob/user, datum/tgui/ui)
	if(!user.mind?.has_antag_datum(/datum/antagonist/traitor/infiltrator))
		to_chat(user, span_warning("The interface is covered with strange unintelligible encrypted symbols."))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "InfilRadio", name)
		ui.open()


/obj/item/infiltrator_radio/ui_data(mob/user)
	var/list/data = list()
	data["check"] = check_reward_status(user)
	data["completed"] = objectives_complete
	data["dagd"] = dagd
	return data

/obj/item/infiltrator_radio/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("claim_reward")
			if(check_reward_status(usr))
				give_reward(usr)
	return

/obj/item/gorilla_serum
	name = "Gorilla Serum"
	desc = "Allows one to unleash the beast within."
	icon = 'icons/obj/syringe.dmi'
	icon_state = "dnainjector0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	///the target mob
	var/datum/weakref/target
	var/used = FALSE ///determines wether the injector is used up or nah

/obj/item/gorilla_serum/proc/set_objective(datum/antagonist/traitor/infiltrator/criminal)
	if(!criminal)
		return
	var/datum/objective/gorillize/objective = locate() in criminal.objectives
	if(!objective)
		return
	if(objective.target)
		target = WEAKREF(objective.target.current)

/obj/item/gorilla_serum/afterattack(atom/movable/victim, mob/living/carbon/human/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(used)
		to_chat(user, span_notice("[src] has been already used, you can't activate it again!"))
		return
	var/datum/antagonist/traitor/infiltrator/criminal = user.mind.has_antag_datum(/datum/antagonist/traitor/infiltrator)
	if(!criminal)
		to_chat(user, span_notice("You don't understand how this injector works."))
		return
	if(!ishuman(victim))
		return
	var/mob/living/carbon/human/man = victim
	if(man != target.resolve())
		to_chat(user, span_notice("The serum is not compatible with this entity."))
		return
	if(!do_after(user, 15 SECONDS))
		return
	var/mob/living/simple_animal/hostile/gorilla/albino/ape
	var/mob/dead/observer/chosen_ghost
	chosen_ghost = man.grab_ghost(TRUE,TRUE)
	if(!chosen_ghost)
		var/list/consenting_candidates = poll_ghost_candidates("Would you like to play as a Syndicate Gorilla?", "Syndicate", ROLE_TRAITOR , 5 SECONDS, POLL_IGNORE_SHADE)
		if(length(consenting_candidates))
			chosen_ghost = pick(consenting_candidates)
	ape = new /mob/living/simple_animal/hostile/gorilla/albino(get_turf(man))
	if(chosen_ghost)
		ape.key = chosen_ghost.key
	man.gib()
	ape.mind?.enslave_mind_to_creator(user)
	used = TRUE
	target = null
	var/datum/objective/gorillize/crime = locate() in criminal.objectives
	if(!crime)
		return
	crime.completed = TRUE

/obj/item/card/emag/silicon_hack
	name = "single-use silicon cryptographic sequencer"
	desc = "A specialized cryptographic sequencer used to free cyborgs. Will become voided after a one time use."
	icon = 'fulp_modules/features/antagonists/infiltrators/icons/infils.dmi'
	icon_state = "cyborg_hack"
    //whether we have successfully emagged a borg
	var/used = FALSE

/obj/item/card/emag/silicon_hack/proc/use_charge(mob/user)
    used = TRUE
    to_chat(user, span_boldwarning("You use [src], and it interfaces with the cyborg's panel."))

/obj/item/card/emag/silicon_hack/examine(mob/user)
    . = ..()
    . += span_notice("It can only be used on cyborgs.")

/obj/item/card/emag/silicon_hack/can_emag(atom/target, mob/user)
    if(used)
        to_chat(user, span_warning("[src] is used up."))
        return FALSE
    if(!istype(target, /mob/living/silicon/robot))
        to_chat(user, span_warning("[src] is unable to interface with this. It only seems to interface with cyborg panels."))
        return FALSE
    return TRUE

/mob/living/silicon/robot/emag_act(mob/user, obj/item/card/emag/emag_card)
    . = ..()
    if(istype(emag_card, /obj/item/card/emag/silicon_hack))
        var/obj/item/card/emag/silicon_hack/hack_card = emag_card
        hack_card.use_charge(user)
        playsound(src, 'sound/machines/beep.ogg', 50, FALSE)
        return
