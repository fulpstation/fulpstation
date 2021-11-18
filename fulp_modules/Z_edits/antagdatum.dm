/datum/antagonist/on_removal()
	addtimer(CALLBACK(owner, /datum/mind.proc/fix_bloodsucker_huds, owner.current), 5 SECONDS)
	. = ..()

/datum/mind/proc/fix_bloodsucker_huds(mob/living/user)
	// Update Bloodsucker HUDs
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = has_antag_datum(/datum/antagonist/bloodsucker)
	bloodsuckerdatum?.update_bloodsucker_icons_added(src, automatic = TRUE)
	// Update Vassal HUDs
	var/datum/antagonist/vassal/vassaldatum = has_antag_datum(/datum/antagonist/vassal)
	vassaldatum?.update_vassal_icons_added(src, automatic = TRUE)
