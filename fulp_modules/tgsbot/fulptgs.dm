// Beefman
/datum/tgs_chat_command/beefman
	name = "beefman"
	help_text = "beefman"

/datum/tgs_chat_command/beefman/Run(datum/tgs_chat_user/sender, params)
	return new /datum/tgs_message_content("https://wiki.fulp.gg/images/b/be/Beefmanstanding.png")


// Status

/datum/tgs_chat_command/status
	name = "status"
	help_text = "get status of current round. like check but fancier."
	admin_only = FALSE

/datum/tgs_chat_command/status/Run(datum/tgs_chat_user/sender, params)
	//unbridled shitcode but you can kiss my ass
	var/datum/tgs_chat_embed/structure/embed_object = new /datum/tgs_chat_embed/structure
	embed_object.title = "Status Report - Round " + GLOB.round_id
	var/datum/tgs_chat_embed/footer/embed_object_footer = new ("Brought to you by the admin cabal.")

	var/list/embed_object_fields = list()
	// field/New(name, value)
	var/time = SSticker ? num2text(round((world.time-SSticker.round_start_time)/10)) : "0"
	// will this work? fuck if i know but its the same-ish logic i used in the old bot.
	var/datum/tgs_chat_embed/field/embed_round_duration = new("Round Duration", num2text(round(time/3600))+ ":"+num2text(round((time%3600)/60))+":"+num2text(round(time%60)) )
	embed_round_duration.is_inline = 1
	var/datum/tgs_chat_embed/field/embed_players = new("Active Players", num2text(GLOB.clients.len))
	embed_players.is_inline = 1
	var/datum/tgs_chat_embed/field/embed_security = new("Security Level", SSsecurity_level.get_current_level_as_text())
	embed_security.is_inline = 1
	var/datum/tgs_chat_embed/field/embed_map = new("Map", SSmapping.current_map.map_name || "Loading...")
	embed_map.is_inline = 1
	var/datum/tgs_chat_embed/field/embed_shuttle_mode = new("Shuttle Mode", SSshuttle.emergency ? SSshuttle.emergency.mode : "Not loaded yet...")
	embed_shuttle_mode.is_inline = 1
	var/datum/tgs_chat_embed/field/embed_time_dilation = new("Time Dilation", num2text(round(SStime_track.time_dilation_avg,1)+"%"))
	embed_time_dilation.is_inline = 1
	var/list/adm = get_admin_counts()
	var/list/presentmins = adm["present"]
	var/list/afkmins = adm["afk"]
	var/datum/tgs_chat_embed/field/embed_admins = new("Admins", num2text(presentmins + afkmins))
	embed_admins.is_inline = 1
	embed_object_fields.Add(embed_round_duration, embed_players, embed_security, embed_map, embed_shuttle_mode, embed_time_dilation, embed_admins)
	embed_object.fields = embed_object_fields
	embed_object.footer = embed_object_footer

	var/datum/tgs_message_content/message_draft = new("")
	message_draft.embed = embed_object

	return message_draft
