/datum/component/tackler/werewolf

/datum/component/tackler/werewolf/sack(mob/living/carbon/user, atom/hit)
	// Because of a bug with the tackler component, stun immunity needs to be removed
	// in order for the grab to work. Janky, but it is what it is.
	// https://github.com/tgstation/tgstation/issues/78441
	REMOVE_TRAIT(parent, TRAIT_STUNIMMUNE, WEREWOLF_TRAIT)
	. = ..()
	// If we revert mid-tackle, don't re-apply stun immunity
	if(HAS_TRAIT(parent, TRAIT_WEREWOLF_TRANSFORMED))
		ADD_TRAIT(parent, TRAIT_STUNIMMUNE, WEREWOLF_TRAIT)
