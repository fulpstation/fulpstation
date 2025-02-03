/**
 * Basically all of this is copied from adminwho with everything
 * renamed to mentor instead.
 * Please keep parity with that if possible.
 */

/client/verb/mentorwho()
	set category = "Mentor"
	set name = "Mentorwho"

	var/list/lines = list()
	var/payload_string = generate_mentorwho_string()
	var/header = "Current Mentors:"

	lines += span_bold(header)
	lines += payload_string

	var/finalized_string = boxed_message(jointext(lines, "\n"))
	to_chat(src, finalized_string)

/// Proc that returns a list of cliented mentors. Remember that this list can contain nulls!
/// Also, will return null if we don't have any mentors.
/proc/get_list_of_mentors()
	var/returnable_list = list()

	for(var/client/mentor_clients in GLOB.mentors)
		returnable_list += mentor_clients

	if(length(returnable_list) == 0)
		return null

	return returnable_list


/// Proc that generates the applicable string to dispatch to the client for mentorwho.
/client/proc/generate_mentorwho_string()
	var/list/list_of_mentors = get_list_of_mentors()
	if(isnull(list_of_mentors))
		return

	var/list/message_strings = list()
	if(isnull(holder))
		message_strings += get_general_mentorwho_information(list_of_mentors)
	else
		message_strings += get_sensitive_mentorwho_information(list_of_mentors)

	return jointext(message_strings, "\n")

/// Proc that gathers mentorwho information for a general player, which will only give information if an admin isn't AFK, and handles potential fakekeying.
/// Will return a list of strings.
/proc/get_general_mentorwho_information(list/checkable_mentors)
	var/returnable_list = list()

	for(var/client/mentor_client in checkable_mentors)
		//AFK people don't show up
		if(mentor_client.is_afk())
			continue
		//Deadmins don't show up unless it's the pseudostaff cause they are generally expected to be.
		if(GLOB.deadmins[mentor_client.ckey] && !(mentor_client.key == "[CONFIG_GET(string/headofpseudostaff)]"))
			continue

		if(mentor_client.mentor_datum.is_contributor)
			returnable_list += "• [mentor_client] is a Contributor"
		else
			returnable_list += "• [mentor_client] is a Mentor"

	return returnable_list

/// Proc that gathers mentorwho information for mentors, which will contain information on if the admin is AFK, readied to join, etc. Only arg is a list of clients to use.
/// Will return a list of strings.
/proc/get_sensitive_mentorwho_information(list/checkable_mentors)
	var/returnable_list = list()

	for(var/client/mentor_client in checkable_mentors)
		var/list/mentor_strings = list()

		if(GLOB.deadmins[mentor_client.ckey])
			mentor_strings += "\t[mentor_client] is a Deadmin"
		else if(mentor_client.mentor_datum.is_contributor)
			mentor_strings += "\t[mentor_client] is a Contributor"
		else
			mentor_strings += "\t[mentor_client] is a Mentor"

		if(isobserver(mentor_client.mob))
			mentor_strings += "- Observing"
		else if(isnewplayer(mentor_client.mob))
			mentor_strings += "- Lobby"
		else
			mentor_strings += "- Playing"

		if(mentor_client.is_afk())
			mentor_strings += "(AFK)"

		returnable_list += jointext(mentor_strings, " ")

	return returnable_list
