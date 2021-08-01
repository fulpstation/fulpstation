/// We're loading Mentors from here
/world/New()
	. = ..()
	load_mentors()

/// Redirect of update_status to use our own via not calling parent.
/world/update_status()
	// DON'T CALL PARENT, we don't want to use TG's update_status here, only ours!
	var/s = ""
	var/server_name = CONFIG_GET(string/servername)
	var/server_caption = CONFIG_GET(string/servercaption)
	s += "<b>[server_name]</b>\] &#8212; "
	s += "<b>[server_caption]</b>"
	s += " ("
	s += "<a href=\"[CONFIG_GET(string/discordurl)]\">"
	s += "Discord"
	s += "</a>"
	s += ")<br>"

	s += "<br>Beginner Friendly: <b>Learn to play SS13!</b>"
	s += "<br>Roleplay: \[<b>Medium</b>\]"
	if(SSmapping.config)
		s += "<br>Map: \[<b>[SSmapping.config.map_name]</b>"//\] // Since this is the last line, the ] is done automatically for us.

/* //Removed: Why would we ever want this?
	var/players = GLOB.clients.len

	var/popcaptext = ""
	var/popcap = max(CONFIG_GET(number/extreme_popcap), CONFIG_GET(number/hard_popcap), CONFIG_GET(number/soft_popcap))
	if(popcap)
		popcaptext = "/[popcap]"

	game_state = (CONFIG_GET(number/extreme_popcap) && players >= CONFIG_GET(number/extreme_popcap)) //Tells the hub if we are full
*/

	status = s
	return s
