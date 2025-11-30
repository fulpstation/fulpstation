// HELPERS
// override default field constructor to accept inline bool because why the hell doesnt the default constructor
/datum/tgs_chat_embed/field/New(name, value, inline)
	. = ..(name,value)
	is_inline = inline



// Beefman
/datum/tgs_chat_command/beefman
	name = "beefman"
	help_text = "beefman"

/datum/tgs_chat_command/beefman/Run(datum/tgs_chat_user/sender, params)
	return new /datum/tgs_message_content("https://wiki.fulp.gg/images/b/be/Beefmanstanding.png")


// updog
/datum/tgs_chat_command/updog
	name = "updog"
	help_text = "get status of current round. like check but fancier."
	admin_only = FALSE

/datum/tgs_chat_command/updog/Run(datum/tgs_chat_user/sender, params)
	// ask me how this works in discord if you want a throttling
	var/datum/tgs_chat_embed/structure/embed_object = new
	embed_object.title = "Status Report - Round " + GLOB.round_id
	var/datum/tgs_chat_embed/footer/embed_object_footer = new("Brought to you by the admin cabal.")

	var/list/embed_object_fields = list()

	var/time = SSticker ? round((world.time-SSticker.round_start_time)/10) : 0
	time = time > 0 ? time : 0 //dont show negative time

	var/datum/tgs_chat_embed/field/embed_round_duration = new("Round Duration", add_leading(num2text(round(time/3600)), 2, "0")+ ":"+add_leading(num2text(round((time%3600)/60)), 2, "0")+":"+add_leading(num2text(round(time%60)), 2, "0"), TRUE )
	var/datum/tgs_chat_embed/field/embed_players = new("Active Players", num2text(GLOB.clients.len), TRUE)
	var/datum/tgs_chat_embed/field/embed_security = new("Security Level", SSsecurity_level.get_current_level_as_text(), TRUE)
	var/datum/tgs_chat_embed/field/embed_map = new("Map", SSmapping.current_map.map_name || "Loading...", TRUE)

	var/emergency_shuttle = SSshuttle.emergency
	var/shuttle_mode = "Not loaded yet..."
	var/ETA_mode = "\u200b"
	var/ETA_time = "\u200b"
	if(emergency_shuttle)
		shuttle_mode = SSshuttle.emergency.mode
		var/ETA = SSshuttle.emergency.getModeStr()
		if(ETA)
			ETA_mode = ETA
			ETA_time = SSshuttle.emergency.getTimerStr()

	var/datum/tgs_chat_embed/field/embed_shuttle_mode = new("Shuttle Mode", shuttle_mode, TRUE)
	var/datum/tgs_chat_embed/field/embed_shuttle_timer = new(ETA_mode, ETA_time, TRUE)

	var/datum/tgs_chat_embed/field/embed_time_dilation = new("Time Dilation", num2text(round(SStime_track.time_dilation_current,1))+"%", TRUE)
	var/list/adm = get_admin_counts()
	var/list/presentmins = adm["present"]
	var/list/afkmins = adm["afk"]
	var/datum/tgs_chat_embed/field/embed_admins = new("Admins", num2text(presentmins + afkmins), TRUE)

	embed_object_fields.Add(embed_round_duration, embed_players, embed_security, embed_map, embed_shuttle_mode, embed_shuttle_timer,  embed_time_dilation, embed_admins)
	embed_object.fields = embed_object_fields
	embed_object.footer = embed_object_footer

	var/datum/tgs_message_content/message_draft = new("")
	message_draft.embed = embed_object

	return message_draft
