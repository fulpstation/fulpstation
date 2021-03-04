// Overwrites the update_overlays on cards.dm to ensure fulp jobs get their icons.

/* /obj/item/card/id/update_overlays()
	. = ..()
	if(!uses_overlays)
		return
	cached_flat_icon = null
	var/job = assignment ? ckey(GetJobName()) : null
	if(registered_name && registered_name != "Captain")
		. += mutable_appearance(icon, "assigned")
	if(job)
		. += mutable_appearance(return_icon_job(), "id[job]") // Using a return proc that points to your job's icon. Was "job_icon", but this is moved to the job itself as "id_icon" */
