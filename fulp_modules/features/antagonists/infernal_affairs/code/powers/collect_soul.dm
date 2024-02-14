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

	if(HAS_TRAIT(cast_on, TRAIT_HELLBOUND))
		cast_on.balloon_alert(owner, "soul already ripped!")
		return SPELL_CANCEL_CAST
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

	var/datum/antagonist/infernal_affairs/agent_datum = cast_on.mind.has_antag_datum(/datum/antagonist/infernal_affairs)
	for(var/obj/item/paper/devil_calling_card/card in cast_on.get_all_contents())
		var/datum/antagonist/infernal_affairs/hunter_datum = card.signed_by_ref?.resolve()
		if(!hunter_datum)
			continue
		//Ensures that the card holder is actually a target.
		if(hunter_datum.active_objective.target != agent_datum.owner)
			continue
		INVOKE_ASYNC(src, PROC_REF(harvest), cast_on, agent_datum, card, hunter_datum)
		return TRUE

	cast_on.balloon_alert(owner, "no calling card!")
	return FALSE

/datum/action/cooldown/spell/pointed/collect_soul/proc/harvest(mob/target, datum/antagonist/infernal_affairs/target_datum, obj/item/paper/devil_calling_card/card, datum/antagonist/infernal_affairs/hunter_datum)
	if(!do_after(owner, 10 SECONDS, target))
		target.balloon_alert(owner, "interrupted!")
		return
	target.balloon_alert(owner, "soul ripped!")
	target_datum.soul_harvested(hunter_datum)
	qdel(card)
