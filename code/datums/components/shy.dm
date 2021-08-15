#define SHY_COMPONENT_CACHE_TIME 0.5 SECONDS

/// You can't use items on anyone other than yourself if there are other living mobs around you
/datum/component/shy
	can_transfer = TRUE
	/// How close you are before you get shy
	var/shy_range = 4
	/// Typecache of mob types you are okay around
	var/list/whitelist
	/// Message shown when you are is_shy
	var/message = "You find yourself too shy to do that around %TARGET!"
	/// Are you shy around a dead body?
	var/dead_shy = FALSE
	/// Invalidate last_result at this time
	COOLDOWN_DECLARE(result_cooldown)
	/// What was our last result?
	var/last_result = FALSE

/datum/component/shy/Initialize(whitelist, shy_range, message, dead_shy)
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	src.whitelist = whitelist
	if(shy_range)
		src.shy_range = shy_range
	if(message)
		src.message = message
	if(dead_shy)
		src.dead_shy = dead_shy

/datum/component/shy/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOB_CLICKON, .proc/on_clickon)
	RegisterSignal(parent, COMSIG_LIVING_TRY_PULL, .proc/on_try_pull)
	RegisterSignal(parent, list(COMSIG_LIVING_UNARMED_ATTACK, COMSIG_HUMAN_EARLY_UNARMED_ATTACK), .proc/on_unarmed_attack)
	RegisterSignal(parent, COMSIG_TRY_STRIP, .proc/on_try_strip)
	RegisterSignal(parent, COMSIG_TRY_ALT_ACTION, .proc/on_try_alt_action)

/datum/component/shy/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_MOB_CLICKON,
		COMSIG_LIVING_TRY_PULL,
		COMSIG_LIVING_UNARMED_ATTACK, COMSIG_HUMAN_EARLY_UNARMED_ATTACK,
		COMSIG_TRY_STRIP,
		COMSIG_TRY_ALT_ACTION,
	))

/datum/component/shy/PostTransfer()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/shy/InheritComponent(datum/component/shy/friend, i_am_original, list/arguments)
	if(i_am_original)
		shy_range = friend.shy_range
		whitelist = friend.whitelist
		message = friend.message

/// Returns TRUE or FALSE if you are within shy_range tiles from a /mob/living
/datum/component/shy/proc/is_shy(atom/target)
	var/result = FALSE
	var/mob/owner = parent

	if(target in owner.DirectAccess())
		return

	if(!COOLDOWN_FINISHED(src, result_cooldown))
		return last_result

	var/list/strangers = view(shy_range, get_turf(owner))

	if(length(strangers) && locate(/mob/living) in strangers)
		for(var/mob/living/person in strangers)
			if(person != owner && !is_type_in_typecache(person, whitelist) && (person.stat != DEAD || dead_shy))
				to_chat(owner, span_warning("[replacetext(message, "%TARGET", person)]"))
				result = TRUE
				break

	last_result = result
	COOLDOWN_START(src, result_cooldown, SHY_COMPONENT_CACHE_TIME)
	return result



/datum/component/shy/proc/on_clickon(datum/source, atom/target, params)
	SIGNAL_HANDLER
	return is_shy(target) && COMSIG_MOB_CANCEL_CLICKON

/datum/component/shy/proc/on_try_pull(datum/source, atom/movable/target, force)
	SIGNAL_HANDLER
	return is_shy(target) && COMSIG_LIVING_CANCEL_PULL

/datum/component/shy/proc/on_unarmed_attack(datum/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER
	return is_shy(target) && COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/shy/proc/on_try_strip(datum/source, atom/target, obj/item/equipping)
	SIGNAL_HANDLER
	return is_shy(target) && COMPONENT_CANT_STRIP

/datum/component/shy/proc/on_try_alt_action(datum/source, atom/target)
	SIGNAL_HANDLER
	return is_shy(target) && COMPONENT_CANT_ALT_ACTION

#undef SHY_COMPONENT_CACHE_TIME

