/datum/action/cooldown/spell/pointed/collect_soul
	name = "Collect Soul"
	desc = "This ranged spell allows you to take the soul out of someone indebted to you.."

	background_icon_state = "bg_demon"
	overlay_icon_state = "ab_goldborder"

	button_icon = 'fulp_modules/features/antagonists/infernal_affairs/icons/actions_devil.dmi'
	button_icon_state = "soulcollect"

	school = SCHOOL_TRANSMUTATION
	invocation = "P'y y'ur de'ts"
	invocation_type = INVOCATION_WHISPER

	active_msg = span_notice("You prepare to collect a soul...")
	cooldown_time = 1 MINUTES
	spell_requirements = NONE

/datum/action/cooldown/spell/pointed/collect_soul/is_valid_target(mob/living/target)
	. = ..()
	if(!.)
		return FALSE
	var/datum/antagonist/devil/devil_datum = owner.mind.has_antag_datum(/datum/antagonist/devil)
	if(!devil_datum)
		return FALSE
	if(!target || !istype(target) || !target.mind)
		return FALSE
	if(target.stat != DEAD)
		target.balloon_alert(owner, "target has to be dead!")
		return FALSE
	var/datum/antagonist/infernal_affairs/agent_datum = target.mind.has_antag_datum(/datum/antagonist/infernal_affairs)
	if(!agent_datum)
		target.balloon_alert(owner, "not an agent!")
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/collect_soul/before_cast(mob/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
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

	for(var/obj/item/paper/devil_calling_card/card in cast_on.get_all_contents())
		var/datum/antagonist/infernal_affairs/hunter_datum = card.signed_by_ref?.resolve()
		if(!hunter_datum)
			continue
		//Ensures that the card holder is actually a target.
		var/datum/antagonist/infernal_affairs/agent_datum = cast_on.mind.has_antag_datum(/datum/antagonist/infernal_affairs)
		if(hunter_datum.active_objective.target != agent_datum.owner)
			continue
		if(!do_after(owner, 10 SECONDS, cast_on))
			cast_on.balloon_alert(owner, "interrupted!")
			return FALSE
		cast_on.balloon_alert(owner, "soul ripped!")
		agent_datum.soul_harvested(hunter_datum)
		qdel(card)
		return TRUE

	cast_on.balloon_alert(owner, "no card on target...")
	return FALSE
