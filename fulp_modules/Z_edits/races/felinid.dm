/datum/reagent/water/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if((methods & TOUCH) && isfelinid(exposed_mob))
		var/mob/living/carbon/human/catperson = exposed_mob
		if(catperson.can_inject(catperson, BODY_ZONE_HEAD))
			exposed_mob.Stun(1)
			SEND_SIGNAL(exposed_mob, COMSIG_ADD_MOOD_EVENT, "watersprayed", /datum/mood_event/felinid_watersprayed)

/datum/mood_event/felinid_watersprayed
	description = "<span class='boldwarning'>I hate being sprayed with water!</span>\n"
	mood_change = -2
	timeout = 1 MINUTES
