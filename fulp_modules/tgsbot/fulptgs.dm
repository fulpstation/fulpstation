// Beefman
/datum/tgs_chat_command/beefman
	name = "beefman"
	help_text = "beefman"

/datum/tgs_chat_command/beefman/Run(datum/tgs_chat_user/sender, params)
	return new /datum/tgs_message_content("https://wiki.fulp.gg/images/b/be/Beefmanstanding.png")
