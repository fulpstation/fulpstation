/*
 *	# Kiss Emote overwrite
 *
 *	This is removing the ability to use the *kiss command.
 *	This leaves the kiss of death in, it should only affect the regular kiss.
 */

/datum/emote/living/kiss/run_emote(mob/living/user, params, type_override, intentional)
	return
