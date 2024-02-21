// Admin Tab - Event Verbs

/client/proc/cmd_admin_subtle_message(mob/M in GLOB.mob_list)
	set category = "Admin.Events"
	set name = "Subtle Message"

	if(!ismob(M))
		return
	if(!check_rights(R_ADMIN))
		return

	message_admins("[key_name_admin(src)] has started answering [ADMIN_LOOKUPFLW(M)]'s prayer.")
	var/msg = input("Message:", "Subtle PM to [M.key]") as text|null

	if(!msg)
		message_admins("[key_name_admin(src)] decided not to answer [ADMIN_LOOKUPFLW(M)]'s prayer")
		return
	if(usr)
		if (usr.client)
			if(usr.client.holder)
				M.balloon_alert(M, "you hear a voice")
				to_chat(M, "<i>You hear a voice in your head... <b>[msg]</i></b>", confidential = TRUE)

	log_admin("SubtlePM: [key_name(usr)] -> [key_name(M)] : [msg]")
	msg = span_adminnotice("<b> SubtleMessage: [key_name_admin(usr)] -> [key_name_admin(M)] :</b> [msg]")
	message_admins(msg)
	admin_ticket_log(M, msg)
	BLACKBOX_LOG_ADMIN_VERB("Subtle Message")

/client/proc/cmd_admin_headset_message(mob/M in GLOB.mob_list)
	set category = "Admin.Events"
	set name = "Headset Message"

	admin_headset_message(M)

/client/proc/admin_headset_message(mob/target in GLOB.mob_list, sender = null)
	var/mob/living/carbon/human/human_recipient
	var/mob/living/silicon/silicon_recipient

	if(!check_rights(R_ADMIN))
		return


	if(ishuman(target))
		human_recipient = target
		if(!istype(human_recipient.ears, /obj/item/radio/headset))
			to_chat(usr, "The person you are trying to contact is not wearing a headset.", confidential = TRUE)
			return
	else if(issilicon(target))
		silicon_recipient = target
		if(!istype(silicon_recipient.radio, /obj/item/radio))
			to_chat(usr, "The silicon you are trying to contact does not have a radio installed.", confidential = TRUE)
			return
	else
		to_chat(usr, "This can only be used on instances of type /mob/living/carbon/human or /mob/living/silicon", confidential = TRUE)
		return

	if (!sender)
		sender = input("Who is the message from?", "Sender") as null|anything in list(RADIO_CHANNEL_CENTCOM,RADIO_CHANNEL_SYNDICATE)
		if(!sender)
			return

	message_admins("[key_name_admin(src)] has started answering [key_name_admin(target)]'s [sender] request.")
	var/input = input("Please enter a message to reply to [key_name(target)] via their headset.","Outgoing message from [sender]", "") as text|null
	if(!input)
		message_admins("[key_name_admin(src)] decided not to answer [key_name_admin(target)]'s [sender] request.")
		return

	log_directed_talk(mob, target, input, LOG_ADMIN, "reply")
	message_admins("[key_name_admin(src)] replied to [key_name_admin(target)]'s [sender] message with: \"[input]\"")
	target.balloon_alert(target, "you hear a voice")
	to_chat(target, span_hear("You hear something crackle in your [human_recipient ? "ears" : "radio receiver"] for a moment before a voice speaks. \"Please stand by for a message from [sender == "Syndicate" ? "your benefactor" : "Central Command"]. Message as follows[sender == "Syndicate" ? ", agent." : ":"] <b>[input].</b> Message ends.\""), confidential = TRUE)

	BLACKBOX_LOG_ADMIN_VERB("Headset Message")

/client/proc/cmd_admin_world_narrate()
	set category = "Admin.Events"
	set name = "Global Narrate"

	if(!check_rights(R_ADMIN))
		return

	var/msg = input("Message:", "Enter the text you wish to appear to everyone:") as text|null

	if (!msg)
		return
	to_chat(world, "[msg]", confidential = TRUE)
	log_admin("GlobalNarrate: [key_name(usr)] : [msg]")
	message_admins(span_adminnotice("[key_name_admin(usr)] Sent a global narrate"))
	BLACKBOX_LOG_ADMIN_VERB("Global Narrate")

/client/proc/cmd_admin_local_narrate(atom/A)
	set category = "Admin.Events"
	set name = "Local Narrate"

	if(!check_rights(R_ADMIN))
		return
	if(!A)
		return
	var/range = input("Range:", "Narrate to mobs within how many tiles:", 7) as num|null
	if(!range)
		return
	var/msg = input("Message:", "Enter the text you wish to appear to everyone within view:") as text|null
	if (!msg)
		return
	for(var/mob/M in view(range,A))
		to_chat(M, msg, confidential = TRUE)

	log_admin("LocalNarrate: [key_name(usr)] at [AREACOORD(A)]: [msg]")
	message_admins(span_adminnotice("<b> LocalNarrate: [key_name_admin(usr)] at [ADMIN_VERBOSEJMP(A)]:</b> [msg]<BR>"))
	BLACKBOX_LOG_ADMIN_VERB("Local Narrate")

/client/proc/cmd_admin_direct_narrate(mob/M)
	set category = "Admin.Events"
	set name = "Direct Narrate"

	if(!check_rights(R_ADMIN))
		return

	if(!M)
		M = input("Direct narrate to whom?", "Active Players") as null|anything in GLOB.player_list

	if(!M)
		return

	var/msg = input("Message:", "Enter the text you wish to appear to your target:") as text|null

	if( !msg )
		return

	to_chat(M, msg, confidential = TRUE)
	log_admin("DirectNarrate: [key_name(usr)] to ([M.name]/[M.key]): [msg]")
	msg = span_adminnotice("<b> DirectNarrate: [key_name(usr)] to ([M.name]/[M.key]):</b> [msg]<BR>")
	message_admins(msg)
	admin_ticket_log(M, msg)
	BLACKBOX_LOG_ADMIN_VERB("Direct Narrate")

/client/proc/cmd_admin_add_freeform_ai_law()
	set category = "Admin.Events"
	set name = "Add Custom AI law"

	if(!check_rights(R_ADMIN))
		return

	var/input = input(usr, "Please enter anything you want the AI to do. Anything. Serious.", "What?", "") as text|null
	if(!input)
		return

	log_admin("Admin [key_name(usr)] has added a new AI law - [input]")
	message_admins("Admin [key_name_admin(usr)] has added a new AI law - [input]")

	var/show_log = tgui_alert(usr, "Show ion message?", "Message", list("Yes", "No"))
	var/announce_ion_laws = (show_log == "Yes" ? 100 : 0)

	var/datum/round_event/ion_storm/add_law_only/ion = new()
	ion.announce_chance = announce_ion_laws
	ion.ionMessage = input

	BLACKBOX_LOG_ADMIN_VERB("Add Custom AI Law")

/client/proc/admin_call_shuttle()
	set category = "Admin.Events"
	set name = "Call Shuttle"

	if(EMERGENCY_AT_LEAST_DOCKED)
		return

	if(!check_rights(R_ADMIN))
		return

	var/confirm = tgui_alert(usr, "You sure?", "Confirm", list("Yes", "Yes (No Recall)", "No"))
	switch(confirm)
		if(null, "No")
			return
		if("Yes (No Recall)")
			SSshuttle.admin_emergency_no_recall = TRUE
			SSshuttle.emergency.mode = SHUTTLE_IDLE

	SSshuttle.emergency.request()
	BLACKBOX_LOG_ADMIN_VERB("Call Shuttle")
	log_admin("[key_name(usr)] admin-called the emergency shuttle.")
	message_admins(span_adminnotice("[key_name_admin(usr)] admin-called the emergency shuttle[confirm == "Yes (No Recall)" ? " (non-recallable)" : ""]."))
	return

/client/proc/admin_cancel_shuttle()
	set category = "Admin.Events"
	set name = "Cancel Shuttle"
	if(!check_rights(0))
		return
	if(tgui_alert(usr, "You sure?", "Confirm", list("Yes", "No")) != "Yes")
		return

	if(SSshuttle.admin_emergency_no_recall)
		SSshuttle.admin_emergency_no_recall = FALSE

	if(EMERGENCY_AT_LEAST_DOCKED)
		return

	SSshuttle.emergency.cancel()
	BLACKBOX_LOG_ADMIN_VERB("Cancel Shuttle")
	log_admin("[key_name(usr)] admin-recalled the emergency shuttle.")
	message_admins(span_adminnotice("[key_name_admin(usr)] admin-recalled the emergency shuttle."))

	return

/client/proc/admin_disable_shuttle()
	set category = "Admin.Events"
	set name = "Disable Shuttle"

	if(!check_rights(R_ADMIN))
		return

	if(SSshuttle.emergency.mode == SHUTTLE_DISABLED)
		to_chat(usr, span_warning("Error, shuttle is already disabled."))
		return

	if(tgui_alert(usr, "You sure?", "Confirm", list("Yes", "No")) != "Yes")
		return

	message_admins(span_adminnotice("[key_name_admin(usr)] disabled the shuttle."))

	SSshuttle.last_mode = SSshuttle.emergency.mode
	SSshuttle.last_call_time = SSshuttle.emergency.timeLeft(1)
	SSshuttle.admin_emergency_no_recall = TRUE
	SSshuttle.emergency.setTimer(0)
	SSshuttle.emergency.mode = SHUTTLE_DISABLED
	priority_announce(
		text = "Emergency Shuttle uplink failure, shuttle disabled until further notice.",
		title = "Uplink Failure",
		sound = 'sound/misc/announce_dig.ogg',
		sender_override = "Emergency Shuttle Uplink Alert",
		color_override = "grey",
	)

/client/proc/admin_enable_shuttle()
	set category = "Admin.Events"
	set name = "Enable Shuttle"

	if(!check_rights(R_ADMIN))
		return

	if(SSshuttle.emergency.mode != SHUTTLE_DISABLED)
		to_chat(usr, span_warning("Error, shuttle not disabled."))
		return

	if(tgui_alert(usr, "You sure?", "Confirm", list("Yes", "No")) != "Yes")
		return

	message_admins(span_adminnotice("[key_name_admin(usr)] enabled the emergency shuttle."))
	SSshuttle.admin_emergency_no_recall = FALSE
	SSshuttle.emergency_no_recall = FALSE
	if(SSshuttle.last_mode == SHUTTLE_DISABLED) //If everything goes to shit, fix it.
		SSshuttle.last_mode = SHUTTLE_IDLE

	SSshuttle.emergency.mode = SSshuttle.last_mode
	if(SSshuttle.last_call_time < 10 SECONDS && SSshuttle.last_mode != SHUTTLE_IDLE)
		SSshuttle.last_call_time = 10 SECONDS //Make sure no insta departures.
	SSshuttle.emergency.setTimer(SSshuttle.last_call_time)
	priority_announce(
		text = "Emergency Shuttle uplink reestablished, shuttle enabled.",
		title = "Uplink Restored",
		sound = 'sound/misc/announce_dig.ogg',
		sender_override = "Emergency Shuttle Uplink Alert",
		color_override = "green",
	)

/client/proc/admin_hostile_environment()
	set category = "Admin.Events"
	set name = "Hostile Environment"

	if(!check_rights(R_ADMIN))
		return

	switch(tgui_alert(usr, "Select an Option", "Hostile Environment Manager", list("Enable", "Disable", "Clear All")))
		if("Enable")
			if (SSshuttle.hostile_environments["Admin"] == TRUE)
				to_chat(usr, span_warning("Error, admin hostile environment already enabled."))
			else
				message_admins(span_adminnotice("[key_name_admin(usr)] Enabled an admin hostile environment"))
				SSshuttle.registerHostileEnvironment("Admin")
		if("Disable")
			if (!SSshuttle.hostile_environments["Admin"])
				to_chat(usr, span_warning("Error, no admin hostile environment found."))
			else
				message_admins(span_adminnotice("[key_name_admin(usr)] Disabled the admin hostile environment"))
				SSshuttle.clearHostileEnvironment("Admin")
		if("Clear All")
			message_admins(span_adminnotice("[key_name_admin(usr)] Disabled all current hostile environment sources"))
			SSshuttle.hostile_environments.Cut()
			SSshuttle.checkHostileEnvironment()

/client/proc/toggle_nuke(obj/machinery/nuclearbomb/N in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/nuclearbomb))
	set category = "Admin.Events"
	set name = "Toggle Nuke"
	set popup_menu = FALSE
	if(!check_rights(R_DEBUG))
		return

	if(!N.timing)
		var/newtime = input(usr, "Set activation timer.", "Activate Nuke", "[N.timer_set]") as num|null
		if(!newtime)
			return
		N.timer_set = newtime
	N.toggle_nuke_safety()
	N.toggle_nuke_armed()

	log_admin("[key_name(usr)] [N.timing ? "activated" : "deactivated"] a nuke at [AREACOORD(N)].")
	message_admins("[ADMIN_LOOKUPFLW(usr)] [N.timing ? "activated" : "deactivated"] a nuke at [ADMIN_VERBOSEJMP(N)].")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Nuke", "[N.timing]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

/client/proc/admin_change_sec_level()
	set category = "Admin.Events"
	set name = "Set Security Level"
	set desc = "Changes the security level. Announcement only, i.e. setting to Delta won't activate nuke"

	if(!check_rights(R_ADMIN))
		return

	var/level = tgui_input_list(usr, "Select Security Level:", "Set Security Level", SSsecurity_level.available_levels)

	if(!level)
		return

	SSsecurity_level.set_level(level)

	log_admin("[key_name(usr)] changed the security level to [level]")
	message_admins("[key_name_admin(usr)] changed the security level to [level]")
	BLACKBOX_LOG_ADMIN_VERB("Set Security Level [capitalize(level)]")

/client/proc/run_weather()
	set category = "Admin.Events"
	set name = "Run Weather"
	set desc = "Triggers a weather on the z-level you choose."

	if(!holder)
		return

	var/weather_type = input("Choose a weather", "Weather")  as null|anything in sort_list(subtypesof(/datum/weather), GLOBAL_PROC_REF(cmp_typepaths_asc))
	if(!weather_type)
		return

	var/turf/T = get_turf(mob)
	var/z_level = input("Z-Level to target?", "Z-Level", T?.z) as num|null
	if(!isnum(z_level))
		return

	SSweather.run_weather(weather_type, z_level)

	message_admins("[key_name_admin(usr)] started weather of type [weather_type] on the z-level [z_level].")
	log_admin("[key_name(usr)] started weather of type [weather_type] on the z-level [z_level].")
	BLACKBOX_LOG_ADMIN_VERB("Run Weather")

/client/proc/add_marked_mob_ability()
	set category = "Admin.Events"
	set name = "Add Mob Ability (Marked Mob)"
	set desc = "Adds an ability to a marked mob."

	if(!holder)
		return

	if(!isliving(holder.marked_datum))
		to_chat(usr, span_warning("Error: Please mark a mob to add actions to it."))
		return
	give_mob_action(holder.marked_datum)

/client/proc/remove_marked_mob_ability()
	set category = "Admin.Events"
	set name = "Remove Mob Ability (Marked Mob)"
	set desc = "Removes an ability from marked mob."

	if(!holder)
		return

	if(!isliving(holder.marked_datum))
		to_chat(usr, span_warning("Error: Please mark a mob to remove actions from it."))
		return
	remove_mob_action(holder.marked_datum)

/client/proc/command_report_footnote()
	set category = "Admin.Events"
	set name = "Command Report Footnote"
	set desc = "Adds a footnote to the roundstart command report."

	if(!check_rights(R_ADMIN))
		return

	var/datum/command_footnote/command_report_footnote = new /datum/command_footnote()
	SScommunications.block_command_report++ //Add a blocking condition to the counter until the inputs are done.

	command_report_footnote.message = tgui_input_text(usr, "This message will be attached to the bottom of the roundstart threat report. Be sure to delay the roundstart report if you need extra time.", "P.S.")

	if(!command_report_footnote.message)
		return

	command_report_footnote.signature = tgui_input_text(usr, "Whose signature will appear on this footnote?", "Also sign here, here, aaand here.")

	if(!command_report_footnote.signature)
		command_report_footnote.signature = "Classified"

	SScommunications.command_report_footnotes += command_report_footnote
	SScommunications.block_command_report--

	message_admins("[usr] has added a footnote to the command report: [command_report_footnote.message], signed [command_report_footnote.signature]")

/datum/command_footnote
	var/message
	var/signature

/client/proc/delay_command_report()
	set category = "Admin.Events"
	set name = "Delay Command Report"
	set desc = "Prevents the roundstart command report from being sent until toggled."

	if(!check_rights(R_ADMIN))
		return

	if(SScommunications.block_command_report) //If it's anything other than 0, decrease. If 0, increase.
		SScommunications.block_command_report--
		message_admins("[usr] has enabled the roundstart command report.")
	else
		SScommunications.block_command_report++
		message_admins("[usr] has delayed the roundstart command report.")
