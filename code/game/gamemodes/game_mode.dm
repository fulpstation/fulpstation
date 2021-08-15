

/*
 * GAMEMODES (by Rastaf0)
 *
 * In the new mode system all special roles are fully supported.
 * You can have proper wizards/traitors/changelings/cultists during any mode.
 * Only two things really depends on gamemode:
 * 1. Starting roles, equipment and preparations
 * 2. Conditions of finishing the round.
 *
 */


/datum/game_mode

///Attempts to select players for special roles the mode might have.
/datum/game_mode/proc/pre_setup()
	return TRUE

///Everyone should now be on the station and have their normal gear.  This is the place to give the special roles extra things
/datum/game_mode/proc/post_setup(report) //Gamemodes can override the intercept report. Passing TRUE as the argument will force a report.
	if(!report)
		report = !CONFIG_GET(flag/no_intercept_report)
	addtimer(CALLBACK(GLOBAL_PROC, .proc/display_roundstart_logout_report), ROUNDSTART_LOGOUT_REPORT_TIME)

	if(CONFIG_GET(flag/reopen_roundstart_suicide_roles))
		var/delay = CONFIG_GET(number/reopen_roundstart_suicide_roles_delay)
		if(delay)
			delay = (delay SECONDS)
		else
			delay = (4 MINUTES) //default to 4 minutes if the delay isn't defined.
		addtimer(CALLBACK(GLOBAL_PROC, .proc/reopen_roundstart_suicide_roles), delay)

	if(SSdbcore.Connect())
		var/list/to_set = list()
		var/arguments = list()
		if(SSticker.mode)
			to_set += "game_mode = :game_mode"
			arguments["game_mode"] = SSticker.mode
		if(GLOB.revdata.originmastercommit)
			to_set += "commit_hash = :commit_hash"
			arguments["commit_hash"] = GLOB.revdata.originmastercommit
		if(to_set.len)
			arguments["round_id"] = GLOB.round_id
			var/datum/db_query/query_round_game_mode = SSdbcore.NewQuery(
				"UPDATE [format_table_name("round")] SET [to_set.Join(", ")] WHERE id = :round_id",
				arguments
			)
			query_round_game_mode.Execute()
			qdel(query_round_game_mode)
	generate_station_goals()
	return TRUE


///Handles late-join antag assignments
/datum/game_mode/proc/make_antag_chance(mob/living/carbon/human/character)
	return

/datum/game_mode/proc/check_finished(force_ending) //to be called by SSticker
	if(!SSticker.setup_done)
		return FALSE
	if(SSshuttle.emergency && (SSshuttle.emergency.mode == SHUTTLE_ENDGAME))
		return TRUE
	if(GLOB.station_was_nuked)
		return TRUE
	if(force_ending)
		return TRUE

/*
 * Generate a list of station goals available to purchase to report to the crew.
 *
 * Returns a formatted string all station goals that are available to the station.
 */
/datum/game_mode/proc/generate_station_goal_report()
	if(!GLOB.station_goals.len)
		return
	. = "<hr><b>Special Orders for [station_name()]:</b><BR>"
	for(var/datum/station_goal/station_goal as anything in GLOB.station_goals)
		station_goal.on_report()
		. += station_goal.get_report()
	return

/*
 * Generate a list of active station traits to report to the crew.
 *
 * Returns a formatted string of all station traits (that are shown) affecting the station.
 */
/datum/game_mode/proc/generate_station_trait_report()
	if(!SSstation.station_traits.len)
		return
	. = "<hr><b>Identified shift divergencies:</b><BR>"
	for(var/datum/station_trait/station_trait as anything in SSstation.station_traits)
		if(!station_trait.show_in_report)
			continue
		. += "[station_trait.get_report()]<BR>"
	return

/proc/reopen_roundstart_suicide_roles()
	var/list/valid_positions = list()
	valid_positions += GLOB.engineering_positions
	valid_positions += GLOB.medical_positions
	valid_positions += GLOB.science_positions
	valid_positions += GLOB.supply_positions
	valid_positions += GLOB.service_positions
	valid_positions += GLOB.security_positions
	if(CONFIG_GET(flag/reopen_roundstart_suicide_roles_command_positions))
		valid_positions += GLOB.command_positions //add any remaining command positions
	else
		valid_positions -= GLOB.command_positions //remove all command positions that were added from their respective department positions lists.

	var/list/reopened_jobs = list()
	for(var/X in GLOB.suicided_mob_list)
		if(!isliving(X))
			continue
		var/mob/living/L = X
		if(L.job in valid_positions)
			var/datum/job/J = SSjob.GetJob(L.job)
			if(!J)
				continue
			J.current_positions = max(J.current_positions-1, 0)
			reopened_jobs += L.job

	if(CONFIG_GET(flag/reopen_roundstart_suicide_roles_command_report))
		if(reopened_jobs.len)
			var/reopened_job_report_positions
			for(var/dead_dudes_job in reopened_jobs)
				reopened_job_report_positions = "[reopened_job_report_positions ? "[reopened_job_report_positions]\n":""][dead_dudes_job]"

			var/suicide_command_report = "<font size = 3><b>Central Command Human Resources Board</b><br>\
								Notice of Personnel Change</font><hr>\
								To personnel management staff aboard [station_name()]:<br><br>\
								Our medical staff have detected a series of anomalies in the vital sensors \
								of some of the staff aboard your station.<br><br>\
								Further investigation into the situation on our end resulted in us discovering \
								a series of rather... unforturnate decisions that were made on the part of said staff.<br><br>\
								As such, we have taken the liberty to automatically reopen employment opportunities for the positions of the crew members \
								who have decided not to partake in our research. We will be forwarding their cases to our employment review board \
								to determine their eligibility for continued service with the company (and of course the \
								continued storage of cloning records within the central medical backup server.)<br><br>\
								<i>The following positions have been reopened on our behalf:<br><br>\
								[reopened_job_report_positions]</i>"

			print_command_report(suicide_command_report, "Central Command Personnel Update")

//////////////////////////
//Reports player logouts//
//////////////////////////
/proc/display_roundstart_logout_report()
	var/list/msg = list("[span_boldnotice("Roundstart logout report")]\n\n")
	for(var/i in GLOB.mob_living_list)
		var/mob/living/L = i
		var/mob/living/carbon/C = L
		if (istype(C) && !C.last_mind)
			continue  // never had a client

		if(L.ckey && !GLOB.directory[L.ckey])
			msg += "<b>[L.name]</b> ([L.key]), the [L.job] (<font color='#ffcc00'><b>Disconnected</b></font>)\n"


		if(L.ckey && L.client)
			var/failed = FALSE
			if(L.client.inactivity >= (ROUNDSTART_LOGOUT_REPORT_TIME / 2)) //Connected, but inactive (alt+tabbed or something)
				msg += "<b>[L.name]</b> ([L.key]), the [L.job] (<font color='#ffcc00'><b>Connected, Inactive</b></font>)\n"
				failed = TRUE //AFK client
			if(!failed && L.stat)
				if(L.suiciding) //Suicider
					msg += "<b>[L.name]</b> ([L.key]), the [L.job] ([span_boldannounce("Suicide")])\n"
					failed = TRUE //Disconnected client
				if(!failed && (L.stat == UNCONSCIOUS || L.stat == HARD_CRIT))
					msg += "<b>[L.name]</b> ([L.key]), the [L.job] (Dying)\n"
					failed = TRUE //Unconscious
				if(!failed && L.stat == DEAD)
					msg += "<b>[L.name]</b> ([L.key]), the [L.job] (Dead)\n"
					failed = TRUE //Dead

			continue //Happy connected client
		for(var/mob/dead/observer/D in GLOB.dead_mob_list)
			if(D.mind && D.mind.current == L)
				if(L.stat == DEAD)
					if(L.suiciding) //Suicider
						msg += "<b>[L.name]</b> ([ckey(D.mind.key)]), the [L.job] ([span_boldannounce("Suicide")])\n"
						continue //Disconnected client
					else
						msg += "<b>[L.name]</b> ([ckey(D.mind.key)]), the [L.job] (Dead)\n"
						continue //Dead mob, ghost abandoned
				else
					if(D.can_reenter_corpse)
						continue //Adminghost, or cult/wizard ghost
					else
						msg += "<b>[L.name]</b> ([ckey(D.mind.key)]), the [L.job] ([span_boldannounce("Ghosted")])\n"
						continue //Ghosted while alive


	for (var/C in GLOB.admins)
		to_chat(C, msg.Join())

/datum/game_mode/proc/generate_station_goals()
	var/list/possible = subtypesof(/datum/station_goal)
	var/goal_weights = 0
	while(possible.len && goal_weights < STATION_GOAL_BUDGET)
		var/datum/station_goal/picked = pick_n_take(possible)
		goal_weights += initial(picked.weight)
		GLOB.station_goals += new picked

//Set result and news report here
/datum/game_mode/proc/set_round_result()
	SSticker.mode_result = "undefined"
	if(GLOB.station_was_nuked)
		SSticker.news_report = STATION_DESTROYED_NUKE
	if(EMERGENCY_ESCAPED_OR_ENDGAMED)
		SSticker.news_report = STATION_EVACUATED
		if(SSshuttle.emergency.is_hijacked())
			SSticker.news_report = SHUTTLE_HIJACK

/// Mode specific admin panel.
/datum/game_mode/proc/admin_panel()
	return
