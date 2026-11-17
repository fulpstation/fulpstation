//Editing Cybernetic Revolution to include cybernetics for our jobs.
/datum/station_trait/cybernetic_revolution/New()
	job_to_cybernetic |= list(/datum/job/signal_technician = /obj/item/organ/cyberimp/eyes/hud/diagnostic)
	return ..()
