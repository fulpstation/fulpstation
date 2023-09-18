/// Start the sol system when the first bloodsucker or werewolf is created
/datum/antagonist/werewolf/proc/check_start_sol()
	var/list/existing_monsters = (get_antag_minds(/datum/antagonist/bloodsucker) + get_antag_minds(/datum/antagonist/werewolf)) - owner
	if(!length(existing_monsters))
		message_admins("New Sol has been created due to Bloodsucker or Werewolf assignment.")
		SSsunlight.can_fire = TRUE

/// End Sol when there are no remaining bloodsuckers or werewolves
/datum/antagonist/werewolf/proc/check_cancel_sol()
	var/list/existing_monsters = (get_antag_minds(/datum/antagonist/bloodsucker) + get_antag_minds(/datum/antagonist/werewolf)) - owner
	if(!length(existing_monsters))
		message_admins("Sol has been deleted due to the lack of Bloodsuckers or Werewolves")
		SSsunlight.can_fire = FALSE

/datum/antagonist/werewolf/proc/handle_lun_warnings(atom/source, warning_level, werewolf_warning_message)
	SIGNAL_HANDLER
	if(!owner)
		return
	to_chat(owner, werewolf_warning_message)

/datum/antagonist/werewolf/proc/handle_lun_start(atom/source)
	SIGNAL_HANDLER
	apply_transformation()

/datum/antagonist/werewolf/proc/handle_lun_end(atom/source)
	SIGNAL_HANDLER
	revert_transformation()
