
/datum/antagonist/ert/safety_moth/greet()

	to_chat(owner, "<B><font size=3 color=green>You are the [name].</font></B>")
	to_chat(owner, "You are being sent on a mission to [station_name()] by Nanotrasen's Operational Safety Department. Ensure the crew is following all proper safety protocols. Board the shuttle when your team is ready.")


/datum/antagonist/ert/safety_moth/proc/equip_official()
	var/mob/living/carbon/human/H = owner.current
	if(!istype(H))
		return
	H.set_species(/datum/species/moth)

