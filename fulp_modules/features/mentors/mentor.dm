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

/datum/mentors/proc/mentor_follow(mob/living/followed_guy)
	if(isnull(followed_guy))
		return
	owner.mob.reset_perspective(followed_guy)
	to_chat(GLOB.admins, span_adminooc("<span class='prefix'>MENTOR:</span> <EM>[key_name(owner.mob)]</EM> is now following <EM>[key_name(followed_guy)]</span>"))
	to_chat(owner.mob, span_info("Use \"Escape\" to stop following [key_name(followed_guy)]."))
	log_mentor("[key_name(owner.mob)] began following [key_name(followed_guy)]")
	RegisterSignal(owner.mob, COMSIG_MOB_KEYDOWN, PROC_REF(mentor_unfollow))

/datum/mentors/proc/mentor_unfollow(mob/source, key)
	SIGNAL_HANDLER

	if(key != "Escape")
		return
	var/mob/old_eye = owner.eye
	UnregisterSignal(owner.mob, COMSIG_MOB_KEYDOWN)
	owner.mob.reset_perspective()
	to_chat(GLOB.admins, span_adminooc("<span class='prefix'>MENTOR:</span> <EM>[key_name(owner.mob)]</EM> stopped mentorfollowing [key_name(old_eye)].</span>"))
	log_mentor("[key_name(owner.mob)] stopped mentorfollowing [key_name(old_eye)].")


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

ADMIN_VERB(reload_mentors, R_ADMIN, "Reload Mentors", "Reload all mentors", ADMIN_CATEGORY_MENTOR)
	if(!user)
		return

	var/confirm = tgui_alert(user, "Are you sure you want to reload all mentors?", "Confirm", list("Yes", "No"))
	if(confirm != "Yes")
		return

	load_mentors()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Reload All Mentors") // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!
	message_admins("[key_name_admin(user)] manually reloaded mentors")
