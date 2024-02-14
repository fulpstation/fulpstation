/datum/action/cooldown/spell/pointed/collect_soul
	name = "Soul Manipulate"
	desc = "LMB: Collect the soul if indebted to you. RMB: Mesmerize someone into becoming an Agent."

	background_icon_state = "bg_demon"
	overlay_icon_state = "ab_goldborder"

	button_icon = 'fulp_modules/features/antagonists/infernal_affairs/icons/actions_devil.dmi'
	button_icon_state = "soulcollect"

	school = SCHOOL_FORBIDDEN
	invocation = "P'y y'ur de'ts"
	invocation_type = INVOCATION_WHISPER

	active_msg = span_notice("You prepare to collect a soul...")
	cooldown_time = 1 MINUTES
	spell_requirements = NONE

	var/mesmerize_invocation = "W'c'me t' th' f'mily"
	///Boolean on whether we have triggered this button with RMB to turn someone into an agent.
	var/mesmerize_mode = FALSE

/datum/action/cooldown/spell/pointed/collect_soul/InterceptClickOn(mob/user, params, atom/object)
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		mesmerize_mode = TRUE
		invocation = mesmerize_invocation
	else if(LAZYACCESS(modifiers, LEFT_CLICK))
		mesmerize_mode = FALSE
		invocation = initial(invocation)
	return ..()

/datum/action/cooldown/spell/pointed/collect_soul/is_valid_target(mob/living/target)
	. = ..()
	if(!.)
		return FALSE
	var/datum/antagonist/devil/devil_datum = owner.mind.has_antag_datum(/datum/antagonist/devil)
	if(!devil_datum)
		return FALSE
	if(!target || !istype(target))
		return FALSE
	if(!target.mind)
		target.balloon_alert(owner, "no mind!")
		return FALSE
	if(mesmerize_mode)
		if(GLOB.infernal_affair_manager.agent_datums.len >= DEVIL_SOULS_TO_ASCEND)
			target.balloon_alert(owner, "too many agents!")
			return FALSE
		if(target.stat != CONSCIOUS)
			target.balloon_alert(owner, "has to be conscious!")
			return FALSE
		if(IS_INFERNAL_AGENT(target))
			target.balloon_alert(owner, "already an agent!")
			return FALSE
	else
		if(target.stat != DEAD)
			target.balloon_alert(owner, "has to be dead!")
			return FALSE
		if(!IS_INFERNAL_AGENT(target))
			target.balloon_alert(owner, "not an agent!")
			return FALSE
	return TRUE

/datum/action/cooldown/spell/pointed/collect_soul/before_cast(mob/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return .
	if(mesmerize_mode)
		return .

	for(var/obj/item/paper/devil_calling_card/card in cast_on.get_all_contents())
		var/datum/antagonist/infernal_affairs/hunter_datum = card.signed_by_ref?.resolve()
		var/datum/antagonist/infernal_affairs/agent_datum = cast_on.mind.has_antag_datum(/datum/antagonist/infernal_affairs)
		if(hunter_datum.active_objective.target != agent_datum.owner)
			continue
		return .
	cast_on.balloon_alert(owner, "no card on target...")
	return SPELL_CANCEL_CAST

/datum/action/cooldown/spell/pointed/collect_soul/cast(mob/cast_on)
	. = ..()

	if(mesmerize_mode)
		INVOKE_ASYNC(src, PROC_REF(mesmerize_target), cast_on)
		return
	INVOKE_ASYNC(src, PROC_REF(harvest_soul), cast_on)

///Freezes the person in place and starts the conversion process.
/datum/action/cooldown/spell/pointed/collect_soul/proc/mesmerize_target(mob/living/target)
	ADD_TRAIT(target, TRAIT_IMMOBILIZED, DEVIL_TRAIT)
	target.adjust_temp_blindness(10 SECONDS)
	var/image/cloak_image = image(icon = 'icons/effects/effects.dmi', loc = target, icon_state = "the_freezer", layer = ABOVE_MOB_LAYER, dir = owner.dir)
	cloak_image.override = TRUE
	target.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/everyone, "collect_soul", cloak_image)
	if(!do_after(owner, 30 SECONDS, target))
		target.remove_alt_appearance("collect_soul")
		REMOVE_TRAIT(target, TRAIT_IMMOBILIZED, DEVIL_TRAIT)
		target.balloon_alert(owner, "interrupted!")
		return
	target.remove_alt_appearance("collect_soul")
	REMOVE_TRAIT(target, TRAIT_IMMOBILIZED, DEVIL_TRAIT)
	target.mind.add_antag_datum(/datum/antagonist/infernal_affairs)
	GLOB.infernal_affair_manager.update_objective_datums()

///Collects the soul of the target and rewards its killer.
/datum/action/cooldown/spell/pointed/collect_soul/proc/harvest_soul(mob/living/target)
	var/datum/antagonist/infernal_affairs/agent_datum = target.mind.has_antag_datum(/datum/antagonist/infernal_affairs)
	for(var/obj/item/paper/devil_calling_card/card in target.get_all_contents())
		var/datum/antagonist/infernal_affairs/hunter_datum = card.signed_by_ref?.resolve()
		if(!hunter_datum)
			continue
		//Ensures that the card holder is actually a target.
		if(hunter_datum.active_objective.target != agent_datum.owner)
			continue
		if(!do_after(owner, 10 SECONDS, target))
			target.balloon_alert(owner, "interrupted!")
			return
		agent_datum.soul_harvested(hunter_datum)
		qdel(card)
		return TRUE
	target.balloon_alert(owner, "no calling card!")
	return FALSE
