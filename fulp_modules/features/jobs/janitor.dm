/datum/job/janitor/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	ADD_TRAIT(spawned, TRAIT_STRONG_SNIFFER, JOB_JANITOR) // Janies can detect werewolf dens
