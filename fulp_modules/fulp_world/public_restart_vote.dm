#define CHOICE_RESTART "Call the shuttle"
#define CHOICE_CONTINUE "Continue Playing"

/datum/vote/public_shuttle_vote
	name = "Shuttle call"
	default_choices = list(
		CHOICE_RESTART,
		CHOICE_CONTINUE,
	)
	default_message = "Vote to call the shuttle and end the ongoing round."
	var/last_held = 0

/datum/vote/public_shuttle_vote/toggle_votable()
	var/datum/config_entry/CE = /datum/config_entry/number/public_shuttle_vote
	if(CONFIG_GET(number/public_shuttle_vote) == -1)
		var/time_requirement = input(usr, "How many minutes should the round last before the vote can be called?", "Enabling restart vote", initial(CE.default)) as num
		CONFIG_SET(number/public_shuttle_vote, time_requirement)
	else
		CONFIG_SET(number/public_shuttle_vote, -1)

/datum/vote/public_shuttle_vote/is_config_enabled()
	return  CONFIG_GET(number/public_shuttle_vote) != -1

/datum/vote/public_shuttle_vote/create_vote()
	last_held = world.time
	. = ..()

/datum/vote/public_shuttle_vote/get_vote_result()
	. = ..()

/datum/vote/public_shuttle_vote/can_be_initiated(forced)
	var/time_remaining = CONFIG_GET(number/public_shuttle_vote) MINUTES - (world.time - SSticker.round_start_time)
	var/can_evac = SSshuttle.canEvac()
	var/cooldown = last_held ? (last_held + 20 MINUTES) - world.time : 0 // Always 0 if we haven't had a vote yet

	. = ..()
	if(. != VOTE_AVAILABLE)
		return .
	if(can_evac != TRUE)
		return can_evac // Despite the name, it's either 'TRUE' OR a string describing why the shuttle can't be called.
	if(forced)
		return VOTE_AVAILABLE
	if(time_remaining > 0)
		return "Cannot be called until [DisplayTimeText(CONFIG_GET(number/public_shuttle_vote) MINUTES)] after the start of the round.\n\
				([DisplayTimeText(time_remaining)] left)"
	if(cooldown > 0)
		return "A shuttle vote has already been called. Another will be available in [DisplayTimeText(cooldown)]."
	return VOTE_AVAILABLE

/datum/vote/public_shuttle_vote/finalize_vote(winning_option)
	if(winning_option == CHOICE_CONTINUE)
		return

	if(winning_option == CHOICE_RESTART)
		SSshuttle.emergency.request(reason = "\n\
		\n\
		Biometrics data shows morale has decayed beyond profitable limits. A mandatory crew rotation will now take place. \
		Crew remaining on site after the end of their shift may expect recovery in approximately six business weeks \
		and are encouraged to apply for a Nanowage Overtime Plan Acclimated Yearly.\n\
		\nGlory to Nanotrasen")
		SSshuttle.emergency_no_recall = TRUE
		log_game("Shuttle call forced by successful public vote.")
		return

	CRASH("[type] wasn't passed a valid winning choice. (Got: [winning_option || "null"])")

#undef CHOICE_RESTART
#undef CHOICE_CONTINUE
