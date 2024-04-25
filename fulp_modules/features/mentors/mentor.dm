GLOBAL_LIST_EMPTY(mentor_datums)
GLOBAL_PROTECT(mentor_datums)

GLOBAL_VAR_INIT(mentor_href_token, GenerateToken())
GLOBAL_PROTECT(mentor_href_token)

/datum/mentors
	var/name = "someone's mentor datum"
	/// The Mentor's Client
	var/client/owner
	/// the Mentor's Ckey
	var/target
	/// href token for Mentor commands, uses the same token used by Admins.
	var/href_token
	///The mob currently being followed with mfollow.
	var/mob/following
	/// Are we a Contributor?
	var/is_contributor = FALSE
	///List of all contributors for special MSAY text.
	var/static/list/contributor_list = world.file2list("[global.config.directory]/contributors.txt")

/datum/mentors/New(ckey)
	if(!ckey)
		QDEL_IN(src, 0)
		throw EXCEPTION("Mentor datum created without a ckey")
		return
	link_mentor_datum(ckey)

/datum/mentors/proc/link_mentor_datum(ckey)
	target = ckey(ckey)
	name = "[ckey]'s mentor datum"
	href_token = GenerateToken()
	GLOB.mentor_datums[target] = src
	/// Set the owner var and load commands
	owner = GLOB.directory[ckey]
	if(owner)
		owner.mentor_datum = src
		owner.add_mentor_verbs()
		GLOB.mentors += owner
	if(ckey in contributor_list)
		is_contributor = TRUE

/proc/RawMentorHrefToken(forceGlobal = FALSE)
	var/tok = GLOB.mentor_href_token
	if(!forceGlobal && usr)
		var/client/all_clients = usr.client
		to_chat(world, all_clients)
		to_chat(world, usr)
		if(!all_clients)
			CRASH("No client for HrefToken()!")
		var/datum/mentors/holder = all_clients.mentor_datum
		if(holder)
			tok = holder.href_token
	return tok

/proc/MentorHrefToken(forceGlobal = FALSE)
	return "mentor_token=[RawMentorHrefToken(forceGlobal)]"

///Loads all mentors from the mentors.txt file, setting admins as mentors as well.
/proc/load_mentors()
	GLOB.mentor_datums.Cut()
	for(var/client/mentor_clients in GLOB.mentors)
		mentor_clients.remove_mentor_verbs()
		mentor_clients.mentor_datum = null
	GLOB.mentors.Cut()
	var/list/lines = world.file2list("[global.config.directory]/mentors.txt")
	for(var/line in lines)
		if(!length(line))
			continue
		if(findtextEx(line, "#", 1, 2))
			continue
		new /datum/mentors(line)
	for(var/client/admin in GLOB.admins)
		//not a mentor, let's add them.
		if(!GLOB.mentor_datums[admin.ckey])
			new /datum/mentors(admin.ckey)

ADMIN_VERB(reload_mentors, R_ADMIN, "Reload Mentors", "Reload all mentors", "Mentor")
	if(!user)
		return

	var/confirm = tgui_alert(usr, "Are you sure you want to reload all mentors?", "Confirm", list("Yes", "No"))
	if(confirm != "Yes")
		return

	load_mentors()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Reload All Mentors") // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!
	message_admins("[key_name_admin(usr)] manually reloaded mentors")
