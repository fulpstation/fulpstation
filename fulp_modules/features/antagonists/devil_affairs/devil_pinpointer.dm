/atom/movable/screen/alert/status_effect/agent_pinpointer/devil_affairs
	name = "Internal Affairs Integrated Pinpointer"
	desc = "Even stealthier than a normal implant."
	icon = 'icons/obj/device.dmi'
	icon_state = "pinon"

/datum/status_effect/agent_pinpointer/devil_affairs
	alert_type = /atom/movable/screen/alert/status_effect/agent_pinpointer/devil_affairs

/datum/status_effect/agent_pinpointer/devil_affairs/scan_for_target()
	scan_target = null
	if(!owner && !owner.mind)
		return
	for(var/datum/objective/assassinate/internal/objective_datums as anything in owner.mind.get_all_objectives())
		if(!objective_datums.target || !objective_datums.target.current || objective_datums.target.current.stat == DEAD)
			continue
		var/mob/tracked_target = objective_datums.target.current
		//JUUUST in case.
		if(!tracked_target)
			continue

		//Catch the first one we find, then stop. We want to point to the most recent one we've got.
		scan_target = tracked_target
		break
